Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B34BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F48222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TrQk11sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407640AbfBNP6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:58:36 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:33806 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfBNP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:58:35 -0500
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; 
   d="scan'208";a="26282615"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 08:58:30 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 08:54:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jCBcqsRwjIM07nNLPQYFr06+xQGEPsUG7q4ai/eXgg=;
 b=TrQk11sgoOpcV/GXccrqc59+j3RDUx6LbBwu1n3kBLIC+it8fft0uUheH9ODgKmO5ixd1D3vwe3CjN6ifRZvNdMdhvYu09kmoSrEdOZo78zEvF5qM3mErjckO9hoXrOWt4mvP74fPOnpKD+TUiGhUmG4itlhskBe2taww8t7NtQ=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2031.namprd11.prod.outlook.com (10.169.236.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 15:54:57 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:54:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 6/8] ARM: at91: pm: add ULP1 support for SAM9X60
Thread-Topic: [PATCH 6/8] ARM: at91: pm: add ULP1 support for SAM9X60
Thread-Index: AQHUxH2i/1SZGNr49EScTe5mg81JaQ==
Date:   Thu, 14 Feb 2019 15:54:57 +0000
Message-ID: <1550159642-26878-7-git-send-email-claudiu.beznea@microchip.com>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0098.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::24) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d35de275-e0bb-4c03-9143-08d69294c452
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2031;
x-ms-traffictypediagnostic: MWHPR11MB2031:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB2031;23:oqxcaEAIHh2yjkRpqmh0XzsKsT9uAQ/dtYCh48V?=
 =?iso-8859-1?Q?hIQ6Nk6uM2cIYRsQ2VFQIYHfG0Qz6r/pUjxO4IJDLhahgyVbqR18GaPJGw?=
 =?iso-8859-1?Q?FvMSbZmyNc3+vo1zYBs5BXzpSCsRKbHyPrlrs5bqQCsFrzcw3/53ppXV4c?=
 =?iso-8859-1?Q?PPyC2fd+bzdI1iW7RQ+EEuh+Pl8qZprf6yyHQ321rzrKcObx1NppneQWbN?=
 =?iso-8859-1?Q?LyrQz9BET8fw1TMr0hDGglrp8XFlvngLPuC/JYzj6JZQ2kraB8y/i21D74?=
 =?iso-8859-1?Q?8CnU8BgoGtRmKDD5DZDso+0l1AHplQxSHOaEcGUFBIXfOCxSHLcg6zih3x?=
 =?iso-8859-1?Q?0X5FPIf/nyTsWWd9BeDXa0gWclLVmuhcnTEa04OW4SH5sKXSMG0mJL7W/3?=
 =?iso-8859-1?Q?jVeScoI/fTPosDKi8uug2jqunoToUSnzMe9xM0iUyW8Pcy44xLjbfOANm7?=
 =?iso-8859-1?Q?Fdgjdu3Fi0oQhcaSR/7rox0cOz2Ut+N8rjALhOJNERMJjarJbpA5jxkoaH?=
 =?iso-8859-1?Q?8lylYVj39dbTJbv+52TV2RjmlgyZArHBBlQ88sI7bdMTI1ItJQcrOONxXs?=
 =?iso-8859-1?Q?XoaijiosLo1n5qKb8a8DWwdHb7jXlAUzYGK1FcePeOUtDtkPTBfASKJS++?=
 =?iso-8859-1?Q?tmRJ+IMykh5IarGsTOmLDL3Q35hMxL4ljHpFD6l6IkB6NlYZeSbHuUgFcN?=
 =?iso-8859-1?Q?ADOe8H8g3wiJt3P3pRJrlIC64/r+IisNyU9qItfhjwujQqiUK0RFvjaiy7?=
 =?iso-8859-1?Q?B8a0k9nq5LDZwPXLksJcAMfLnV/2QgV/KiMzv7fi/NlenNnW9U1FRdTnFL?=
 =?iso-8859-1?Q?yWtgSzFQiOKeXAoiWbyrBsCJnuJ0QU8PzB0rGKxq/TcR83jTMQ+Tm8fZRG?=
 =?iso-8859-1?Q?SRwR70RaHZ2vlUKRmN6EaIVSudwDQjcJ+EL1A7KAskDpwlESIa9euCKmBw?=
 =?iso-8859-1?Q?IgyfXInRI90CQWm/24BT4mhfaf3sZD3F2xC38ZKZSexF8GsE6VxY7vd306?=
 =?iso-8859-1?Q?NcuFEv3ZPZ6Txcry6rMXdfINkf9Tc/cBKOPHeBMfSKsShcebQy95U21IeQ?=
 =?iso-8859-1?Q?daNZhAGAocEAgNb46+dTw81NJQZ0644qhF2r0obwRzilslEZdSHhV3AIzY?=
 =?iso-8859-1?Q?naq8vPcrl09xjAudHRFCtVJGc8i18lMh0SzjZBkyLRpejfNbDk0Cd3Yb0w?=
 =?iso-8859-1?Q?Arjg88WdmNoak0ygWfSf99b5NIatVouEi0tSrJUadGyw/fvzAeZto4MvSr?=
 =?iso-8859-1?Q?3T5lLiVgeyjN93vxEVnZhYXOoWb2PA84nLOmhThpNUCMSCXtUBfWjZOL4j?=
 =?iso-8859-1?Q?mlDnuL7hq0Fgy1G1XrZXMY+2TTgg98jv5/CNLYQJBaNM/0qzAneonRWLjC?=
 =?iso-8859-1?Q?HkyyNe2c=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB2031802BE93A44EFBAD359A187670@MWHPR11MB2031.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(366004)(189003)(199004)(97736004)(6486002)(2906002)(72206003)(14454004)(478600001)(81156014)(36756003)(2501003)(71190400001)(71200400001)(316002)(81166006)(7416002)(110136005)(54906003)(6436002)(76176011)(66066001)(50226002)(14444005)(256004)(6512007)(106356001)(8936002)(68736007)(52116002)(2201001)(26005)(186003)(446003)(53936002)(11346002)(6116002)(7736002)(3846002)(25786009)(107886003)(4326008)(305945005)(99286004)(8676002)(105586002)(486006)(86362001)(386003)(476003)(6506007)(102836004)(2616005)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2031;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aHV6p3dJPsztkezn3d/jvqsYXLcuoSAP4vrycL3gO3Y4eCLNGgQdUb3rajV4fzuyruBukY6HEWty1lUtoWoRIGSU8VcHpIshIl93EiKDRBKmIdB26uMh03r2rR5k3G3RPlUlj82nyg+p//+kXFSacBj4ORz3dbQatKN4j1Nm2MyhsvKTL6Z6EK8Wr1rxwKLSjbnGNKvM9V/ep5Cf3yXkjt51mumJeqVV4SwxItvCEIAYZmLF7Ehs3k9+G3b2YJWyiTnEZ2w0QHGzp5pypbo3iLT5m+skwme12oozfWXBnfDnCMTQijJDCi6dNWdK4K+ptI6SHjrPDv5FMNgr62EJHuYiWv2CAkIgZUw2IRG4q79y6/AgfPw03wftsFFIEKE29eJuaXbdU6W0OuoCS8Jzd9xuv1W4UBMO1u9LTjPaM8Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d35de275-e0bb-4c03-9143-08d69294c452
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:54:52.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2031
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add ULP1 support for SAM9X60. In pm_suspend.S enable RC oscillator in
PMC if it is not enabled. At resume the state before suspend is
restored.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c         | 24 ++++++++++++++++++++++++
 arch/arm/mach-at91/pm_suspend.S | 41 +++++++++++++++++++++++++++++++++++++=
+++-
 include/linux/clk/at91_pmc.h    |  1 +
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 27264caa4ec6..5571658b3c46 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -100,6 +100,8 @@ static const struct wakeup_source_info ws_info[] =3D {
 	{ .pmc_fsmr_bit =3D AT91_PMC_RTCAL,	.shdwc_mr_bit =3D BIT(17) },
 	{ .pmc_fsmr_bit =3D AT91_PMC_USBAL },
 	{ .pmc_fsmr_bit =3D AT91_PMC_SDMMC_CD },
+	{ .pmc_fsmr_bit =3D AT91_PMC_RTTAL },
+	{ .pmc_fsmr_bit =3D AT91_PMC_RXLP_MCE },
 };
=20
 static const struct of_device_id sama5d2_ws_ids[] =3D {
@@ -114,6 +116,17 @@ static const struct of_device_id sama5d2_ws_ids[] =3D =
{
 	{ /* sentinel */ }
 };
=20
+static const struct of_device_id sam9x60_ws_ids[] =3D {
+	{ .compatible =3D "atmel,at91sam9x5-rtc",		.data =3D &ws_info[1] },
+	{ .compatible =3D "atmel,at91rm9200-ohci",	.data =3D &ws_info[2] },
+	{ .compatible =3D "usb-ohci",			.data =3D &ws_info[2] },
+	{ .compatible =3D "atmel,at91sam9g45-ehci",	.data =3D &ws_info[2] },
+	{ .compatible =3D "usb-ehci",			.data =3D &ws_info[2] },
+	{ .compatible =3D "atmel,at91sam9260-rtt",	.data =3D &ws_info[4] },
+	{ .compatible =3D "cdns,sam9x60-macb",		.data =3D &ws_info[5] },
+	{ /* sentinel */ }
+};
+
 static int at91_pm_config_ws(unsigned int pm_mode, bool set)
 {
 	const struct wakeup_source_info *wsi;
@@ -192,6 +205,13 @@ static int at91_sama5d2_config_pmc_ws(void __iomem *pm=
c, u32 mode, u32 polarity)
 	return 0;
 }
=20
+static int at91_sam9x60_config_pmc_ws(void __iomem *pmc, u32 mode, u32 pol=
arity)
+{
+	writel(mode, pmc + AT91_PMC_FSMR);
+
+	return 0;
+}
+
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
@@ -789,8 +809,12 @@ void __init sam9x60_pm_init(void)
 	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
 		return;
=20
+	at91_pm_modes_init();
 	at91_dt_ramc();
 	at91_pm_init(at91sam9x60_idle);
+
+	soc_pm.ws_ids =3D sam9x60_ws_ids;
+	soc_pm.config_pmc_ws =3D at91_sam9x60_config_pmc_ws;
 }
=20
 void __init at91sam9_pm_init(void)
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspen=
d.S
index bfe1c4d06901..8b18cad1dcf5 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -197,8 +197,26 @@ ENDPROC(at91_backup_mode)
 .macro at91_pm_ulp1_mode
 	ldr	pmc, .pmc_base
=20
-	/* Switch the main clock source to 12-MHz RC oscillator */
+	/* Save RC oscillator state and check if it is enabled. */
+	ldr	tmp1, [pmc, #AT91_PMC_SR]
+	str	tmp1, .saved_osc_status
+	tst	tmp1, #AT91_PMC_MOSCRCS
+	bne	2f
+
+	/* Enable RC oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCRCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	/* Wait main RC stabilization */
+1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
+	tst	tmp1, #AT91_PMC_MOSCRCS
+	beq	1b
+
+	/* Switch the main clock source to 12-MHz RC oscillator */
+2:	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	bic	tmp1, tmp1, #AT91_PMC_MOSCSEL
 	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
 	orr	tmp1, tmp1, #AT91_PMC_KEY
@@ -262,6 +280,25 @@ ENDPROC(at91_backup_mode)
 	str	tmp1, [pmc, #AT91_PMC_MCKR]
=20
 	wait_mckrdy
+
+	/* Restore RC oscillator state */
+	ldr	tmp1, .saved_osc_status
+	tst	tmp1, #AT91_PMC_MOSCRCS
+	bne	3f
+
+	/* Disable RC oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCRCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	/* Wait RC oscillator disable done */
+4:	ldr	tmp1, [pmc, #AT91_PMC_SR]
+	tst	tmp1, #AT91_PMC_MOSCRCS
+	bne	4b
+
+3:
 .endm
=20
 ENTRY(at91_ulp_mode)
@@ -475,6 +512,8 @@ ENDPROC(at91_sramc_self_refresh)
 	.word 0
 .saved_sam9_mdr1:
 	.word 0
+.saved_osc_status:
+	.word 0
=20
 ENTRY(at91_pm_suspend_in_sram_sz)
 	.word .-at91_pm_suspend_in_sram
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 931ab05f771d..bd3a65c0bad3 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -159,6 +159,7 @@
=20
 #define AT91_PMC_FSMR		0x70		/* Fast Startup Mode Register */
 #define AT91_PMC_FSTT(n)	BIT(n)
+#define AT91_PMC_RTTAL		BIT(16)
 #define AT91_PMC_RTCAL		BIT(17)		/* RTC Alarm Enable */
 #define AT91_PMC_USBAL		BIT(18)		/* USB Resume Enable */
 #define AT91_PMC_SDMMC_CD	BIT(19)		/* SDMMC Card Detect Enable */
--=20
2.7.4

