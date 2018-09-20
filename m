Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F469ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA73C21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GrVvn1Ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA73C21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbeITI2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:47 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387538AbeITI2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WjaiduN0YO3nMk2hyBywSQ/FeLmSGwuX3DWo2ksgfk=;
 b=GrVvn1Ap4q6zzvItQzjG05caXB5ckRhTEN8J883+pxufadmpIjsLpLn1UTFNshYgfZzxRH+IO/skGFo2YgJbmAk6phG0mbUVIjmNCNkF6r1tn47Ckum0Rhc1HrWKq3Iyi7LeRdVxY6ZgQuEDbU0O8YOmq6XiHdVKAsYplJz/jTM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 13/56] ARM: dts: omap4-droid4: fix vibrations on
 Droid 4
Thread-Topic: [PATCH AUTOSEL 4.18 13/56] ARM: dts: omap4-droid4: fix
 vibrations on Droid 4
Thread-Index: AQHUUIxJXT83ILHhOUSEsMINvVjFRw==
Date:   Thu, 20 Sep 2018 02:47:36 +0000
Message-ID: <20180920024716.58490-13-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:TeCRSzQFdrlDJLd4SXVJ1OGApu6LlfKJUdGoHU4XSHxLd/MaCLpPc3s9ox4X2DcZotID2g7rQ8TvO7VG0JvZyVGG9ZfxBDtK4rnNWW0svzctRdJGrOLOohdGG4979eSnGCxCd5/EDg8JEczwyJKm58TD3YCzRY7TEcOY35f3aLtdP8mTiXSbXrXiKdaxkDlEYM31r0LAN1kuT+atPNUKK6gRnomXW1C7Pmh/R5XQkwXUNSJg4s690CgrspzYsDQ9w2BcIRQrsOQvaYxZhiyG+nNvSNqFdfdfO3nRuhg3YLH4k1eprZnmFXmKFIVoH6ukmWb5dvJzaSKqdya/lsrrpQy3rafbL8gxP3YmdUEpQzI0VGFjakNy2b/WGV7yqb/yHHXrIE8aXxeInmQSFwoK9Qr1RBun40yj4FN4s5pYiXkUOtX3jts/c1oWcqAe5zKH6hN5mq/t6Z5kWPrRNI5tDg==;5:TsWIa2CwkUETEpCYAAlKtgWpC+TD3qvQ2grMgxs8lAWhqpFnXvsumOyE1ldwVRAQvFxnlZTO8ToPaLpVSplmhSpgrQiQ1JvkWzoVl8O+jbLKu755mtrTWc1ZyrijtcSMNeKbiXVnpVV57OcIaiPfzp+JMPI1ldYFffXLauy8fhw=;7:7S+k1rtlEOLLnTRiBH4EMtBSsorQPL1W3hq9YOZ6YgK5CM7IB1cE8ZabdfELRbNP9T+iYQGqTleWWE3lkEfyVoGWJ2o6GNAds5JCTi8zO3p3eVFcyfFHv517bnKsBFCsNHous7VuVAQhhGr5ZntWpt1q3HRjH2KQuOr8gK72EIJ7tJ76qqXtKIfg7GGQ3bldtpxWPvaO7Qy9otM8ztPAKfXNnBVo7SjNIvGxql50d+YuLL8FPMKyFBDvQqb+MEwf
x-ms-office365-filtering-correlation-id: c7747744-9d64-42a5-1029-08d61ea36c53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB082220CE54A68E20B913E5EEFB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002)(95444002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: oPGyktTrO4gSJGA6bWwZtc29nw5cTiJzEvCPvJHMPCfI+Kb+n1Bs39M2ACqmk8KnRxzKWx1EXTWs792Q0GpxpTfMoKlFlq3R2AUWBvBBg4pMb6UlczlFHAxVOTGDqS7VsFrOpyI2KEhoADTNWlFBcQLfadlhpaM07n3heuw/z9mFOMzigboxpfALirVUIoAbGo3PsJtp10iYitUFxYWo9mxeQCWpLS4H+gA4J1jFZhu5S30AX6jdJ655xj1/8GXTAz2xBc9qJsny/zKWCaXApquFgoYZlRd57S6lF65o9Lf3/BEX23CJBrk/bjIKCHst8roRmKNIv1tRXsEPV6wrBILMf2K55xdxWjao6Jqa8hU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7747744-9d64-42a5-1029-08d61ea36c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:36.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

[ Upstream commit f4efa74c09a7eddcc12cd13208f78743763f6e7a ]

Vibration GPIOs don't have anything to do with wakeup. Move it to
normal section; this fixes vibrations on Droid 4.

Fixes: a5effd968301 ("ARM: dts: omap4-droid4: Add vibrator")
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/o=
map4-droid4-xt894.dts
index e7c3c563ff8f..edc97f89fae4 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -618,15 +618,6 @@
 		OMAP4_IOPAD(0x10c, PIN_INPUT | MUX_MODE1)	/* abe_mcbsp3_fsx */
 		>;
 	};
-};
-
-&omap4_pmx_wkup {
-	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
-		/* gpio_wk0 */
-		pinctrl-single,pins =3D <
-		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
-		>;
-	};
=20
 	vibrator_direction_pin: pinmux_vibrator_direction_pin {
 		pinctrl-single,pins =3D <
@@ -641,6 +632,15 @@
 	};
 };
=20
+&omap4_pmx_wkup {
+	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
+		/* gpio_wk0 */
+		pinctrl-single,pins =3D <
+		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
+		>;
+	};
+};
+
 /*
  * As uart1 is wired to mdm6600 with rts and cts, we can use the cts pin f=
or
  * uart1 wakeirq.
--=20
2.17.1
