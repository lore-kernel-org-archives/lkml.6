Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491668-2-16332182595585982637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491668; b=W3QijqBzFbjeGfZAV1Vh+FNmQBTh15e8cKswJZpKnR9RFVq
    Y9RLHU6pm5R/wLtxcpwnSIVeOgyrZHWLTBOrnqrv2mm7QQjfXVzCCtU2DOJwt16w
    Nq7lNrJmb6j0FwRYZCTaLQntFdIK7+iBwavthztvQqSHbu/zS5pgb3byj/fJ6gaP
    TnpZY/KKmkEE1chxlTVCa38+CMkcdcj2JQ9RMQ+M70hmS2h+atn2T5l/uNH/Fzp1
    MdoxHj/2gK002ZOY3NC979iXYVjXXKxiBiUyPa/4rmQlsFOQidU0pWtXO4bqzLNl
    PXUwxoBtFwD0H1dag4eo0lwMItMX8fTC5iNVBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491668; bh=/ZzQOg
    A7qO6mUkRORquUSqmlFiKZkqekmixb6lFJQyQ=; b=hSd4VJN2OvjPSZnGn99S1L
    9yhhbEaAQaLmMMkRKqvkVFB0W6TzIPPM9s3M67lxIfb1s9t9wWBndJYqTexxFYqP
    vW1j4UfxnwCygwn6Q3byUGfF71qaABTosbvPHSg/o5euHQ48IFLbph8i3cFU+wMh
    UOkD5IkEMi+CJpqEaXOiPfYLduiQzEmDnkiOUdZwHBTFQAkIXnAVsp0CzlyqKV6J
    yTlP5QWMrZtXPA/36D7dRVMAhQUJi2+0AdQt9bXbfzY3a44eq7TM+y88hC2FEn5s
    e+lzW0ISFPje1oELdhmNUqEpz9z4K2Th3JYO2kmMLQ2inviaPM1tEHDqNNc1xNuQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lTjUN9yT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lTjUN9yT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935041AbeCHGrQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:47:16 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:17968
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965050AbeCHE6W (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 24/67] watchdog: Fix kref imbalance seen if
 handle_boot_enabled=0
Thread-Topic: [PATCH AUTOSEL for 4.14 24/67] watchdog: Fix kref imbalance seen
 if handle_boot_enabled=0
Thread-Index: AQHTtpn9/Ze5cS2EiUWuXPD32on+yw==
Date: Thu, 8 Mar 2018 04:57:41 +0000
Message-ID: <20180308045641.7814-24-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;7:KDn6x63rUPCdf/mVLeclrkQuhm0uKCP0xTEdvuJgGnFmXFEHpZe4/n3XQ5PIAYBskxg4g9eOut7ro+OHrOkLxxlBJnqc43UELnVjpyRCru3rl62EBzrDBB3NnJePuQhMtyR+PBQPfsoi2jexL1zz3gbVK94IttTyH1g1kTVr7J//zlc4WvQoMtYx/R0V8qSRHcdAyGFG1CwzTog3SRbrAZ+NmxUcBbZpW7yqBun60wtrOufAt1Ku+J4q8svN+xgm;20:Di7WHWoPedGcfqkv6+sRIF2bq41qg1jpU4DXEBQ4cLIRm++9nGWN8i9M73uRHudZkCh3EnEhxqi/d3w0ZHEnefQJXGpEqWXlvXXfpMds4KUF9f3pJH3S2bKE0V6xL4jrHDQH6pqRfMfFvMnnXR8PV6zmLowR/v98crSYwVeV26o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9125bf63-ad31-4f7f-33b9-08d584b13398
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0808127B6B8E8804BBDB9AE9FBDF0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(22452003)(99286004)(76176011)(2906002)(105586002)(3846002)(86612001)(478600001)(72206003)(14454004)(2900100001)(8676002)(102836004)(68736007)(5660300001)(316002)(6116002)(54906003)(26005)(6506007)(59450400001)(1076002)(86362001)(36756003)(186003)(10090500001)(110136005)(106356001)(4326008)(6512007)(6486002)(7736002)(5250100002)(3280700002)(3660700001)(2501003)(6666003)(81166006)(2950100002)(305945005)(53936002)(107886003)(8936002)(6436002)(81156014)(66066001)(25786009)(10290500003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: VL3g+4Crjnrb6ilwMIMwIRvV3TAY31W6kxv1Gcd7jZzQF1JEUP0ugjMQfZ0fAoZ/2S+umU03y4IHRUJ0LQIwZUz9MlcdOix1q42CSndaarqrKdnANnFgGhAbtO8zGAGlGwDbOUv5n81J0rvNiCMv5VMbIS9lrZaL7yjh3Oiiyz7Ldm7OxgL8Pm4zI1FEXxDKSr+aoKNtV91qPwXYO6r+S7Cj9OJSIOk0UGOHQPTcaAZLK1859yg+YiBwgrobAnta39AVX4F64HClNnYHGEx6whxDoX89m+pfYL3fS9fkCsvb7Rl9qIx86yibnNc5AH3fowpzrU+qGgGIYUW0TLHf1Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9125bf63-ad31-4f7f-33b9-08d584b13398
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:41.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 914d65f3f013ba2556c7beec5d3baac7b3292504 ]

If handle_boot_enabled is set to 0, the watchdog driver module use
counter will not be increased and kref_get() will not be called when
registering the watchdog. Subsequently, on open, this does not happen
either because the code believes that it was already done because the
hardware watchdog is marked as running.

We could introduce a state variable to indicate this state, but let's
just increase the module use counter and call kref_get() unconditionally
if the hardware watchdog is running when a driver is registering itself
to keep the code simple.

Fixes: 2501b015313fe ("watchdog: core: add option to avoid early ...")
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/watchdog/watchdog_dev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index e6edf3737ea7..b30fb637ae94 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -966,14 +966,13 @@ static int watchdog_cdev_register(struct watchdog_dev=
ice *wdd, dev_t devno)
 	 * and schedule an immediate ping.
 	 */
 	if (watchdog_hw_running(wdd)) {
-		if (handle_boot_enabled) {
-			__module_get(wdd->ops->owner);
-			kref_get(&wd_data->kref);
+		__module_get(wdd->ops->owner);
+		kref_get(&wd_data->kref);
+		if (handle_boot_enabled)
 			queue_delayed_work(watchdog_wq, &wd_data->work, 0);
-		} else {
+		else
 			pr_info("watchdog%d running and kernel based pre-userspace handler disa=
bled\n",
-					wdd->id);
-		}
+				wdd->id);
 	}
=20
 	return 0;
--=20
2.14.1
