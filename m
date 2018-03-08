Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491742-2-10712409536157287064
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
    t=1520491742; b=ri9WzayeQoihksA1cY21zlVOZPDcvm+PbIHHCS7yRP1ZwKm
    e+t+pPXHlnSfGB0cwJKeR7PAwM7XsRLI/unx6JkL2BKHrQCULdQDMC32zMh+SGLO
    djzGGPzf2h7D9jiwwXQhfL7lzETAuAuq2RoVtH/9CgWHsqjWT6a6Ra3H8mAODUHs
    7jbDPBt7A00dBGt47id7yRgehM++1FCZmZeCBiBiNsSm4u4e3frTbMqR4A2Q/ZGG
    8aH+eFOMQeBV5gpcJT1LTx9sD8l4vDF6puyrrnH4qbuk4VUyQOfUOUENWOfFbkV0
    yCvDUbqcdNVMrpzYNV8xYAbzwp5cvTJUTx6U6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491742; bh=IN3Gyq
    S+Bz0Co5VAR8xgn9ZUMcIi/hp1iFNQDHFK4EU=; b=O8hdvN5opToBKAllThaycx
    YFsQslh+kcfcir4YiGbQ67ITdK1+T5xZkZvHTjpwDMoL3aCjq2duWnpt3IU2PLNj
    RkbZ5FGHmtsiak0NV3cS6v6S8a2ekF/1udjuSOUc6i1x9J0+Qz7a03CtLxqJ9+sB
    xO/NmQz7jY9eWKiuX8urzIkG4V2RiaNV/fvLOFGlUm16Anql06EZZxMT+ZF01s6N
    wsInDKyGXPxCGa9i2SVONkLeKsek7gt4JVxA4lxkuFiP+9huQY6lHj3fs3nXVMwP
    1YNbq95r5Mk7LZOpFMSP34dv0dKS7SeSvs/3zjhB2oj7pUSxPYapu/tIcgv6R/gw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FiRtHnfj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FiRtHnfj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965150AbeCHGsa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:48:30 -0500
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:51511
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965100AbeCHE6R (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 23/67] watchdog: Fix potential kref imbalance
 when opening watchdog
Thread-Topic: [PATCH AUTOSEL for 4.14 23/67] watchdog: Fix potential kref
 imbalance when opening watchdog
Thread-Index: AQHTtpn8Nbn7kW0uOkCZ1JJewHPLdA==
Date: Thu, 8 Mar 2018 04:57:41 +0000
Message-ID: <20180308045641.7814-23-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:1QZU0PI0pc+awjrUsECWGLhCchBk3hvoNAguZjrdzsMndWxcjk3vgqyJqs0EQ9KO2embV1tJOSOs+5ZUrImASb+lRBPwYRilchLgzmUQT9/tgsnrRZzx4N3wvuy88xvpCgTscKyRdk2fet2wyMdk78ulVBtj0XnLzH2xX4NpzEsnwMcJkemp3u3ve2GWc93Y8GrSB/PvP+4wQ8Srzi0WYdQSVaTTMVyZdFjKRxcCknrJ7+8/5UCjN5O8NRp65SIr;20:0Yd1sHWfY3Sw7Cp+EyPuW7QSnerF0IHf0Tju4LgSBfYr+qIFf5ASi4XENbPGEc58rzfc9KgOuxRgyLhkNO6DTkDYpEdoz9ISaIkhu1l7mLzF6sHF8Di9NkEe+l/QFS8yEcdHCubXxWQXzZGcRPCqABnX0W3ZuAYtLmYm5st7AYk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f82df2e9-e7ea-4334-7d55-08d584b13353
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10808D2B242E4E2DF6AA3610FBDF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(6116002)(1076002)(5250100002)(26005)(102836004)(2501003)(3846002)(59450400001)(186003)(6506007)(25786009)(3280700002)(4326008)(2906002)(68736007)(66066001)(86612001)(3660700001)(22452003)(6486002)(6436002)(14454004)(8676002)(81166006)(2900100001)(72206003)(81156014)(8936002)(478600001)(10090500001)(105586002)(10290500003)(53936002)(6512007)(6666003)(107886003)(2950100002)(106356001)(76176011)(316002)(7736002)(86362001)(575784001)(36756003)(97736004)(54906003)(110136005)(5660300001)(99286004)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YcGPAkdNnFV1MdG3c1SZleOuHG/SKEEJN0r67b4V7PVLAdcTcpnHe88YnxH9vnHplaZJrkGXsuTcBEY4xJG5x/rMOcs927vfQJKBF1vKoOI3c2Lb+0US43Vw1WpoKJcPpPLl3+RBZv+ai83NzQymPUHO6jGZxS/KQi8eI7APYRzRkhvd5jV7hAai8XfPNByGAaC77PPfJu41v1JPxNO5XImA5xyljg8XwHGG08PtBy0es/SQHOMMtP2KbWwy8CXlHS1nUqGbcDQRJWZ4JSVq7uJvVu7WLu3ptsqK8V4UZvgrgyZVKK8b3/K+ZeywehjcEh54rIivsasS1MGlJEcxXg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82df2e9-e7ea-4334-7d55-08d584b13353
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:41.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
index 0826e663bd5a..e6edf3737ea7 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -768,6 +768,7 @@ static int watchdog_open(struct inode *inode, struct fi=
le *file)
 {
 	struct watchdog_core_data *wd_data;
 	struct watchdog_device *wdd;
+	bool hw_running;
 	int err;
=20
 	/* Get the corresponding watchdog device */
@@ -787,7 +788,8 @@ static int watchdog_open(struct inode *inode, struct fi=
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
@@ -798,7 +800,7 @@ static int watchdog_open(struct inode *inode, struct fi=
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
