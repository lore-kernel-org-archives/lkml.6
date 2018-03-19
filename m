Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482391-2-12069417653385434193
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
    t=1521482390; b=E2y3jTLBJnDTjMXnbJPacmOf/A6IXkvME0KkV0Of4HQ6+QG
    ERsJbRmmj4giEgHnUv7+OKH34y/uWuP8dfaJI5QKhKNze7tITlJ9npDGCkQ6c8ih
    t0vLiAUghW2A5Kw+Zrk4byzNJFhYwo4vN2jXYuONiD1kE7z4p9C2Mi6eHP603els
    gNQxdPjgr0kbzaW1nebma9PRbXu5k62PynrBYsoicfnF0YHqtES6WKZo55b3UrbU
    mUrmX2db+IXb4ciLFju4IXhK0Vkm1ELLgnvGGmw216mE+LSevg5xK0T1yI9hswwF
    LJ54efz1cHiEKfFPDTKL1wGmPu4lsdEB7KIEXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482390; bh=J2rp6Q
    P+pWltTOfMNTO7U/BLn6jrncbPGReoOv2VIr0=; b=Oz9n+rUlC4GCLyzWUesexP
    vqA1Ub5fLFd/o8yMkw6aXRuYukPiOjrwmXZGMq5t/m7NH/6889IiN6nsDst1HW4B
    WrsxNvRfbhRGP7muCVIp1at+hPfGq8HhVllu8hs+MOV/SL5ExaOV7HZFHTnVrxSh
    TXf39Dqruk1p0vSRKezIiCYtQ/8kGBreUkinUjcbanEP2Yzd5BB92jirbPbntsX7
    LMbY/ZPxcCQHPRTOJeYMBbDS3LmceRHF1CvlKmT1a3GAs5EsWKb0CObMMImoMI/w
    GXMdO3h8upI6UhNEOfbWyOY0Hzs8WO2ptjSFn8esYb7RspAmSwLqg0XEOt4VChXg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KYwstxC7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtieehheenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KYwstxC7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtieehheenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933550AbeCSQEY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:24 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:39072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935069AbeCSQEO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 203/281] watchdog: f71808e_wdt: Add F71868
 support
Thread-Topic: [PATCH AUTOSEL for 4.9 203/281] watchdog: f71808e_wdt: Add
 F71868 support
Thread-Index: AQHTv5uZdQxUl4u1S0excsB9qVB9eg==
Date: Mon, 19 Mar 2018 16:01:54 +0000
Message-ID: <20180319155742.13731-203-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:qSMalO5VcSMqyeSUGI/vtr80/ch5Ksz/uCp7DsG56oOkpbvaqA2ZFPelwX/alXcGefXOr23dtJXSWJJNFSDxIMmT0m5XaqC+wZcG+XcqpxDzVWpIEamacx/kDcVCoF3U06JDg/o/y/wE72ELXFNBlGWeSGD+CGkmFRoSAYbxZd3ATNco1rtbNZsO2FnblVkPOnMBaoLI0kCOgBMQxgJGa2TeQCVypXCEbT1OaBUueQVAwzpJbbJn32LMnUlMx9lF;20:OBmVUDJ1Q7/y23IELCirnde8rMOsChDdLxS/a9BdDXynNw7bYTGPgfnGQ3YT4vrLDCf2rha03H5tHDUNFQz2sZc9r5znbgkImdd4zMdhmwKrwYz0MlP4vyt0szXbdtbFsgGfwo5r8R9lYHtTK246P7/Vtkf1u8cFsfSnNBxCF7Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 551e9ec0-68fd-4ded-19c0-08d58db306be
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727DE746BC8A1A9E43B9BB0FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +bYjYSFhFRxJc13OmBhNwN6tx9NngACuJh5lycFkL8H/kRZuKAc3gHlexW2aiF4PWMCisQUybwRtHIR0ABcjo7efH7R5iWRr47p0dcbkNZ7ML1av4rcP+InnJPGnxJeVASyl6PCQ1maBnfU0hswZe5u8bPXeGc8boryq8zSNvCHtt6qZmLouOOzq+bay3Uaqp8SfH7oFivnhI2rMbbQdzrCDJ95KeIfQHvvWyb0bnlEbNr3GGgNCCNe8SubM/Dz+e8Xt9dkzfbxQPSaqaRNKLJ12ggugwHKyT3impDyjt9fWvFgOdSUXNdIhLr8stkX0t2nUCf16wbQ9hti8O8YwZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551e9ec0-68fd-4ded-19c0-08d58db306be
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:54.3457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

[ Upstream commit 166fbcf88fdafa02f784ec25ac64745c716b2de0 ]

This adds support for watchdog part of Fintek F71868 Super I/O chip to
f71808e_wdt driver.

The F71868 chip is, in general, very similar to a F71869, however it has
slightly different set of available reset pulse widths.

Tested on MSI A55M-P33 motherboard.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/watchdog/Kconfig       |  7 ++++---
 drivers/watchdog/f71808e_wdt.c | 27 ++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3eb58cb51e56..8f8909a668d7 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -799,11 +799,12 @@ config EBC_C384_WDT
 	  the timeout module parameter.
=20
 config F71808E_WDT
-	tristate "Fintek F71808E, F71862FG, F71869, F71882FG and F71889FG Watchdo=
g"
+	tristate "Fintek F718xx, F818xx Super I/O Watchdog"
 	depends on X86
 	help
-	  This is the driver for the hardware watchdog on the Fintek
-	  F71808E, F71862FG, F71869, F71882FG and F71889FG Super I/O controllers.
+	  This is the driver for the hardware watchdog on the Fintek F71808E,
+	  F71862FG, F71868, F71869, F71882FG, F71889FG, F81865 and F81866
+	  Super I/O controllers.
=20
 	  You can compile this driver directly into the kernel, or use
 	  it as a module.  The module will be called f71808e_wdt.
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.=
c
index 1b7e9169072f..8658dba21768 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -57,6 +57,7 @@
 #define SIO_F71808_ID		0x0901	/* Chipset ID */
 #define SIO_F71858_ID		0x0507	/* Chipset ID */
 #define SIO_F71862_ID		0x0601	/* Chipset ID */
+#define SIO_F71868_ID		0x1106	/* Chipset ID */
 #define SIO_F71869_ID		0x0814	/* Chipset ID */
 #define SIO_F71869A_ID		0x1007	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
@@ -101,7 +102,7 @@ MODULE_PARM_DESC(timeout,
 static unsigned int pulse_width =3D WATCHDOG_PULSE_WIDTH;
 module_param(pulse_width, uint, 0);
 MODULE_PARM_DESC(pulse_width,
-	"Watchdog signal pulse width. 0(=3Dlevel), 1 ms, 25 ms, 125 ms or 5000 ms=
"
+	"Watchdog signal pulse width. 0(=3Dlevel), 1, 25, 30, 125, 150, 5000 or 6=
000 ms"
 			" (default=3D" __MODULE_STRING(WATCHDOG_PULSE_WIDTH) ")");
=20
 static unsigned int f71862fg_pin =3D WATCHDOG_F71862FG_PIN;
@@ -119,13 +120,14 @@ module_param(start_withtimeout, uint, 0);
 MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load w=
ith"
 	" given initial timeout. Zero (default) disables this feature.");
=20
-enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81=
865,
-	     f81866};
+enum chips { f71808fg, f71858fg, f71862fg, f71868, f71869, f71882fg, f7188=
9fg,
+	     f81865, f81866};
=20
 static const char *f71808e_names[] =3D {
 	"f71808fg",
 	"f71858fg",
 	"f71862fg",
+	"f71868",
 	"f71869",
 	"f71882fg",
 	"f71889fg",
@@ -252,16 +254,23 @@ static int watchdog_set_timeout(int timeout)
 static int watchdog_set_pulse_width(unsigned int pw)
 {
 	int err =3D 0;
+	unsigned int t1 =3D 25, t2 =3D 125, t3 =3D 5000;
+
+	if (watchdog.type =3D=3D f71868) {
+		t1 =3D 30;
+		t2 =3D 150;
+		t3 =3D 6000;
+	}
=20
 	mutex_lock(&watchdog.lock);
=20
-	if        (pw <=3D    1) {
+	if        (pw <=3D  1) {
 		watchdog.pulse_val =3D 0;
-	} else if (pw <=3D   25) {
+	} else if (pw <=3D t1) {
 		watchdog.pulse_val =3D 1;
-	} else if (pw <=3D  125) {
+	} else if (pw <=3D t2) {
 		watchdog.pulse_val =3D 2;
-	} else if (pw <=3D 5000) {
+	} else if (pw <=3D t3) {
 		watchdog.pulse_val =3D 3;
 	} else {
 		pr_err("pulse width out of range\n");
@@ -354,6 +363,7 @@ static int watchdog_start(void)
 			goto exit_superio;
 		break;
=20
+	case f71868:
 	case f71869:
 		/* GPIO14 --> WDTRST# */
 		superio_clear_bit(watchdog.sioaddr, SIO_REG_MFUNCT1, 4);
@@ -792,6 +802,9 @@ static int __init f71808e_find(int sioaddr)
 		watchdog.type =3D f71862fg;
 		err =3D f71862fg_pin_configure(0); /* validate module parameter */
 		break;
+	case SIO_F71868_ID:
+		watchdog.type =3D f71868;
+		break;
 	case SIO_F71869_ID:
 	case SIO_F71869A_ID:
 		watchdog.type =3D f71869;
--=20
2.14.1
