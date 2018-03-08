Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492837-2-1778455883664307702
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
    t=1520492837; b=p1raP+XmiaqR9sfze+2rQpW3ZIhCjt5NX3edhoh8RM8U5da
    Rjq4rncp1En/ZFHAkwzhy40fDZ/lou6m3evjh2Hclb7cdZmRhEWCkFdxawv7H4+W
    h9ZZ1m4ZHLdxRXcaFPxRj2ZqRgO8UZYH0iVw/pc6P2Ci0NtHjaIocmnvuFHYi80t
    jN/cmKag6rtgSAIiyUOJ5M81QUiB0AelsjlPv1U9pFk5rz+4KKzBmU3xB5cXCmgU
    zeWsR62avFcMTAdTP1hTsrevQP8ERcLuDjyrwVDD0RDrJ7i3W0MQzkriumw53yng
    f/Fsg2X4Gx6zwuaQ7sekHvpkrlBx76YOPxwRg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492837; bh=ePylkS
    vA6/j0ehe5D/dAkFqOSqbsttUblXBBuEVaeFs=; b=hci2q4ttMagRlm4bvm89K1
    scA9swU/ueF028mHWP6TfJFvFYQ6DQotwrht+Pp6Tt7wpNZyEhvb2hbpBWX2U/Gv
    owUS5m7WjAVmfcYtdzj1Y/GE7AH45+YTkha8bEL28zLeJCKDoy84xXGjdH9h1Ltr
    +/reUn2ipbvqCY+wt9mTOt8WdTmcM9C0Yd6ynQ1bagn7DTh0XCi8TSx0SBj1mGRz
    gxwI1jX2TfmhrXPPea7riduGPtdEic2O/l5eUz5M3yvp7jMXgm/4NxJUikiOHQ7/
    UpnTxAuR1hfhQzHk7U3eLcJRNpfQQecUpt9+Q7zK7qcibID4CT8DmPSdrkHflr+Q
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a4W7cYLX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a4W7cYLX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbeCHHGr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:06:47 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45246
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755250AbeCHE4d (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:33 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 28/78] watchdog: Fix potential kref imbalance
 when opening watchdog
Thread-Topic: [PATCH AUTOSEL for 4.15 28/78] watchdog: Fix potential kref
 imbalance when opening watchdog
Thread-Index: AQHTtpnIz0Q9bdyCB0uIZmAFLFLXkQ==
Date: Thu, 8 Mar 2018 04:56:13 +0000
Message-ID: <20180308045525.7662-28-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:GydmBaS2LVRYBY4SnFwRggod/Dt3zaWQigv+5IMtQ5ldBBrq8E3fRHhXstUQjIgnI2KKU+xAypscoLBIieLi87Hrga503Yb686s0M5MnE9s23xSs0UyokO7n22eMns2XQPlq3gonEoGn6G5WUNG2cR5crymRJ672ajHZ40R5akynsAkTXZr4cC2i+YxmCvTjQvTcQPwGEqaUDLs7zsmaMNCv24P5+rQGlV96A2H+HKUuVSsa/bjO9373G4nk9R2o;20:JiBtU/ZVuUQRkQldV5aoO6/Od5J3C8ea76nxKdvKlXaD6WkP8cHRbKBmGemDjojXePr0BA08XE1R3/TMjSB0tch7zOtyavDtxZPY3deOFS6LbVAVwYw401bnfzFVBOMnXFXwMqJQTEJZEd02ETp8KhiyYXDwBdrYhHM+SP8pGtk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ea34e08-981a-4921-4262-08d584b0f518
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111DC18E5823CC11AA5AC0FFBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: CumIdDsBiPiaV/hGWLfcgfqAvxbx0jzi1p2lYDYqP1dwKsyEUgXuhGtbmR63Trggxa0c490cxlCHCVbqwPdXUaz2arfb3lxUoUs7AZcm18mpmIf570z4HB5tVFIDayS+uqDmCLxigD832L9Oh6kEkMOOdyeq2BX+9bCg6mlMujyEG4l8sJ55iBj8f/sNW4p8AK8F/vgs+CRFNXS/IsHHzriGuGEmX8oxeJmn4aQCJKtVkSbPlUx1s0OEizK626XZM9ZZqFVQCbPQFCO6J44u2HwO+pXlEPHRupR2kMgZFjXZdRhbSboqnWqCYOhvOsWNX560ZT6VbGx1XuNGvVuscw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea34e08-981a-4921-4262-08d584b0f518
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:13.5603
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
index 1e971a50d7fb..12fe47d8237b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -769,6 +769,7 @@ static int watchdog_open(struct inode *inode, struct fi=
le *file)
 {
 	struct watchdog_core_data *wd_data;
 	struct watchdog_device *wdd;
+	bool hw_running;
 	int err;
=20
 	/* Get the corresponding watchdog device */
@@ -788,7 +789,8 @@ static int watchdog_open(struct inode *inode, struct fi=
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
@@ -799,7 +801,7 @@ static int watchdog_open(struct inode *inode, struct fi=
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
