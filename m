Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492750-3-16678513546321208201
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
    t=1520492749; b=wlnjkCkglCZ40Hjlh4WiZh4KKkwgT+vn481qkRq4lufp+mT
    xhvBxEDFyBf7ZdV+XZTzNHvOSPcswrFQeajuj7gtLmWZ5n1owUMhX9GIFYh+N48e
    EYopbMcPAlzaw9XHHWHon97ejPSbnuKGrQ5Pv05I8jHN3xFZnlkTdgzrWj9mkuCa
    xIIy7DmjzIeHm0lmvf+WgD5in6TtlAS0Mx3P2ERj0aLXPPab4L4Sax6QoXkahnQz
    CiMpiDAx7CgvZ++mx4zmjan7DfpC36Rf0Wq5ymA1R/ybr1uArw/YT+c+Qg8q50SC
    abcMBEMXwwJtP3/IWyQ2T6OFsOLKg5oSH3NX2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492749; bh=vgi89p
    L/AKmM8hjyB40D1IuvDo9YybA/v1TS+qSPjz8=; b=Gja8uWPU6dP+FPqqrTXln7
    9tR2jkyMCUNNlJcYmrGxxtbLbO4o1q5vGDI35+jQmBaFIn9SoCP2p9x9hTFWviPy
    0TNq49ItffJ2rYWaCo1CAB508Njm2QWQLk+EpEQysLdt3XVh9SqvbkdpJ/OKvaZ/
    EJo7swnSApHtY7J9B0eHdH5fJJnseF6FM6Iru+wQx7+DcflwaEJ3RPPALa/Yw2Oq
    WjHHzA6KQdxltiKXbFLdGqz9X1+Qdecwu8AT1FfeTnqLPAGMv5Ddc8T0WJDuXj3A
    HxR2yRrFwKIUebo4oEARgnCiqYNaHNxyGPQWMwZa7qb1QSvb9Q06JP+G/e5uXtsw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fjerfio1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fjerfio1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeCHHFd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:05:33 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:1475
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755261AbeCHE4e (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:34 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 29/78] watchdog: Fix kref imbalance seen if
 handle_boot_enabled=0
Thread-Topic: [PATCH AUTOSEL for 4.15 29/78] watchdog: Fix kref imbalance seen
 if handle_boot_enabled=0
Thread-Index: AQHTtpnIvAe/Q+T7n0CIBy1XGLCVgQ==
Date: Thu, 8 Mar 2018 04:56:14 +0000
Message-ID: <20180308045525.7662-29-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:f7tZXdNWR6xbQpd+pE04b1CbZZdV1VGCLhww6SUVV1iV/Dypo0mthvnc+1If5sAAl4qQgEPEJKcH+EeHsGCVTBdHwbnZrZNjxLZQZUDpOBA3f738H25Ez7veYOgj+7peq5witb1CFSsxWABidqf4WA1ye0Z2jlYKxV7X0Z5v1jLX5cWYskr4c8QzF9mZuC/g+IRNXWjUXieUumEG08VExY+eUUQiO2IyZ6D34l+DoDjHadMpDCPgz/NF14EwkF90;20:vrjNxe9dJtaAjnGjU1aKjRfrFJ+8mJge0EOLJXXcJ6jAURs5eJLb89fumNNx/qAp6GnKEvul+Y9KroCft8QAHyjozQNkpkRgVq8FPt1YPcMrot22IbakqACIbcPFY42aYoYiSEcPPcm9BxNx5FBGy6evWviGcys8flt9OzAPZE4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d751a61-1630-4a35-98f9-08d584b0f55b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111CA457A7F6F045151CDADFBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8mzvb3Gljj7ZeDxcjWL6i4mvRVgtYfbVUhHM2/RRHSHs53c7U2bEfo+d/beHg6T85BjJzgneCZUI81d5Hu66VNfSxenIv2A5gRFl1cA9h6VcP8RbPDju8KoXJcZ+djw/dCVoNun2FRtOk8SwWzT5Gighea383Q6PfSgvduZa9/ucSY7/y7OSOsrwnp8ptQtUUceUhhb2qZ7u6hTvCRliTu90njXDGOw7qMTm4L5MNBSZsHsLazMjyKppWqXCMxb5hPxevZGmQngRIdqsJibXTmXoOnyc486tdtUFdACjwAgN26oigJjjGziMwp/TLmo/Akoteim7mtq8Q73D9zm13g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d751a61-1630-4a35-98f9-08d584b0f55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:14.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
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
index 12fe47d8237b..95b96f3cb36f 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -967,14 +967,13 @@ static int watchdog_cdev_register(struct watchdog_dev=
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
