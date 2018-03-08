Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485455-2-13496692601998137610
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
    t=1520485454; b=TCXMvXDlFvEnNBDkYhuGOppV2CuT09ge7rL99n6o+GmaYKv
    NZHYHgATaBxHEJSwmQnUH+v6lv3xoYwK75E66wm9CggkdsYCGMcCgUJi/bqugZYP
    YSUv0hAMDH6i6aliHeXmGLjwyY0EUZP8WPBOXKy2UKhivHzsy8Z45xQXWTY8H0EF
    UdcMwcUEZT1wTrwkd1r8sdY1FtgKdGyeBkHKnVmcuBnu9jFXgk3fDGEKBqdzkdHw
    thmdoaypYB8XrVfX5h02e0ok1EDM7KqrxK5te128vnrQhSDho2gleKVDtd3hsMPr
    sZ6+yttbtMcARUJ72tu/TvxNwPn1FJOj6X6T60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485454; bh=+qxUJW
    FdYyLANdyT05ziiC3b3mYFoZQ5j6C4456J89k=; b=CyGYjD4j6V4sxNvW8lvew9
    C0He4wN0nkFnszv8jNFvGF56UOtXOdHVQLSubRzBMNOPoUMw7DgOrfSguwApI48K
    4MDq1rmxRUekz0j4fJ+l4ij0bsA86xdJTx0ayrGuYWvhV325iQoY7ZwicvPsQa4U
    r3rRBiWdIZYwumYHQ+M8LUUcHsa7nl0t9MhDj74bCa21qmpmbSTQKoOG2TUlbD7t
    le86yhc+wYn/9Ars9Wjeu1ADc8X2raqpWmibQjARJejT0/ps0GmrSyAzP7/j7ote
    jim2t2ZKJyjPcGcx2nDhCk+dP/NbM2nOJiAKFqGb+/fvBfsG43eXEqABaFAPROzw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hA/Hgfve x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hA/Hgfve x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965771AbeCHFEL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:04:11 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:60007
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966104AbeCHFEE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 165/190] watchdog: Fix potential kref
 imbalance when opening watchdog
Thread-Topic: [PATCH AUTOSEL for 4.9 165/190] watchdog: Fix potential kref
 imbalance when opening watchdog
Thread-Index: AQHTtppSAQhaHRJBCU2+2g69QiMDXQ==
Date: Thu, 8 Mar 2018 05:00:05 +0000
Message-ID: <20180308045810.8041-165-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:EzeNysVkzuZiK9CXCy6Nazjt484DexJJvpyfBlVAh9yLgUKVTNEIIWhD/8ZGIPeGvCoda3Bo4IYp8bI5YbnuYunLmwG2ngPIBkxhYfy20xWdaik2ef5Z1Nf22UZFFrmRn+y1W6ZFFFWqtsYxbVXC+RtgbNn3p9UQTKQqtk4TvaHyaymCAJDZDN512nf3AYIpJ9B3s4R9jAFrS0K9t0KweCS9fjlH+W6/HRxbFMWHSdOVEeCEP3KN7TO+iFAZu5Cm;20:lBVSDeWvltxWJofbw0h+l8576PZHsjSXrY7qD7tue4Ut4MCrCx7eC4P8GT/XMmKI6WLCZCHdY9EIYXCo/nss2EQCFbxPF5iBaRI63AoEtZmPOiY50hzymlF6Y6OYnGXbJNmpaI9+Ym4ActDSVHlPrhmejoZjHnWoxqWl+Zhvm9M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0d70c1a-640e-430b-992a-08d584b20133
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087206B95BB99E55E67E36C5FBDF0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(5660300001)(186003)(5250100002)(26005)(316002)(1076002)(4326008)(2501003)(2906002)(25786009)(76176011)(99286004)(6436002)(6486002)(6116002)(36756003)(3846002)(575784001)(22452003)(3280700002)(2950100002)(86362001)(97736004)(8676002)(10090500001)(305945005)(2900100001)(66066001)(102836004)(68736007)(3660700001)(14454004)(7736002)(53936002)(6512007)(86612001)(110136005)(54906003)(6506007)(106356001)(59450400001)(478600001)(107886003)(105586002)(81156014)(81166006)(72206003)(8936002)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Rn0LgQa1JrF+6oCLPGAacg3tCXZVtlTONHsRtysGSDOcMYlo3u+FTh8eRufD0henmJ+/p/ZwSV+IZZAgoOQdPl6G/xaR1L/UVrGUlA226jEjmlMnTAjgSk9TpUpY8mWm+luF90AmlXGAF5RaeVBBhAq+y6TqV+H15igeNtfTSzDEy33c0xLemBTcAlI2kOgeoykGl/yZZt+l3oaYj+hUi6l8YWM0T4lboPniavrG8HzZLbJM2sGtTruG335ju0kpO5FYvvPMl/44AIRBHiv/gFDCxREmosIofGxXTE2QPHObldKjzzVDbwBeaFBRAcxBD+M8agk5W3CEw/9w9kxdoQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d70c1a-640e-430b-992a-08d584b20133
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:05.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 4bcd615fad6adddc68b058d498b30a9e0e0db77a ]

If a watchdog driver's open function sets WDOG_HW_RUNNING with the
expectation that the watchdog can not be stopped, but then stops the
watchdog anyway in its stop function, kref_get() wil not be called in
watchdog_open(). If the watchdog then stops on close, WDOG_HW_RUNNING
will be cleared and kref_put() will be called, causing a kref imbalance.
As result the character device data structure will be released, which in
turn will cause the system to crash on the next call to watchdog_open().

Fixes: ee142889e32f5 ("watchdog: Introduce WDOG_HW_RUNNING flag")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/watchdog/watchdog_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index 32930a073a12..977fe74e5abe 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -760,6 +760,7 @@ static int watchdog_open(struct inode *inode, struct fi=
le *file)
 {
 	struct watchdog_core_data *wd_data;
 	struct watchdog_device *wdd;
+	bool hw_running;
 	int err;
=20
 	/* Get the corresponding watchdog device */
@@ -779,7 +780,8 @@ static int watchdog_open(struct inode *inode, struct fi=
le *file)
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!watchdog_hw_running(wdd) && !try_module_get(wdd->ops->owner)) {
+	hw_running =3D watchdog_hw_running(wdd);
+	if (!hw_running && !try_module_get(wdd->ops->owner)) {
 		err =3D -EBUSY;
 		goto out_clear;
 	}
@@ -790,7 +792,7 @@ static int watchdog_open(struct inode *inode, struct fi=
le *file)
=20
 	file->private_data =3D wd_data;
=20
-	if (!watchdog_hw_running(wdd))
+	if (!hw_running)
 		kref_get(&wd_data->kref);
=20
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
--=20
2.14.1
