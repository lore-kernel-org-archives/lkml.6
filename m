Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DEEECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1229214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AE1vtr5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1229214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbeGMC3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:29:22 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:37411
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387972AbeGMC3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbQDNcjxkM43ZwbhXlhM02nmDa2G77GQXX4Zu3DAWVo=;
 b=AE1vtr5s4fmLtVnDnVPnmvLe9M9SFhC73RQGak/xFufSk5sf5HrqrlCGGGcoW6asLTF+/Wyj70OWepGrKUiFJ9ccVXxA7vI5BNBeYgCxRyMnJzO3trRywwWpZ7a/e7GS4rAmu2QJUENMuX29FhHPLWDh7Z9GWN0uyTVaTtW+Stg=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1505.eurprd04.prod.outlook.com (10.163.186.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 02:16:56 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0930.022; Fri, 13 Jul 2018
 02:16:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] ARM: dts: make pfuze switch always-on for imx
 platforms
Thread-Topic: [PATCH V2] ARM: dts: make pfuze switch always-on for imx
 platforms
Thread-Index: AQHUDbcZMvTL1IEwfUOjZQPLqqLNYqSMgkng
Date:   Fri, 13 Jul 2018 02:16:55 +0000
Message-ID: <AM3PR04MB1315B66212D928D7EAF27557F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530063055-25914-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1530063055-25914-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1505;7:6GiKnqHbeVOWmCE7p2UoSzmmDjElRrpFfK/utFZvta9S6/nwHSziVZLX7eTlR++orAi0lW0G3vA3D3U3ejf6ws5m41doEATGmMPT9KBQ6TWQupZu7s0d0mmrm4KAibVy6BimiNwi75AqtOr6pnGtYtTM13zN17UXuvBHjCOlH1BWWFibA6tXwVCj8LC7Gbo1DDUYXx2fFb3PXyYyi0y/ZH7z7mWpDAu5NLpyEAC/Cq3PmYxNpvopcbBjE6kXn060
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 11081478-7ee9-467d-03bc-08d5e866b4c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1505;
x-ms-traffictypediagnostic: AM3PR04MB1505:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <AM3PR04MB1505D0A57D86DCBF07BB7AFBF5580@AM3PR04MB1505.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1505;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1505;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39860400002)(346002)(199004)(189003)(13464003)(476003)(11346002)(9686003)(86362001)(55016002)(486006)(478600001)(66066001)(186003)(2201001)(53936002)(229853002)(97736004)(106356001)(44832011)(105586002)(7736002)(446003)(6436002)(2900100001)(54906003)(316002)(110136005)(305945005)(8676002)(68736007)(14444005)(99286004)(33656002)(74316002)(14454004)(5660300001)(6116002)(3846002)(256004)(53546011)(4326008)(25786009)(6506007)(5250100002)(102836004)(2906002)(2501003)(26005)(6246003)(8936002)(7696005)(81156014)(81166006)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1505;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nTze/GLoCB0e33wuGVkDWaA1F0WT3OHNbXnl0Rl/ZpLy8tSO1UF/l6Z2hATnnhOlBvMm8TYhtglXi4pKLZDPKwrXWe/BOKH3i/2XieoBCXOg+9PqO2MnFBBp8GF3W9i0etlJJdcyrqI+3Tptt7L2pJqJSx3iHny2zy1bZQv/zljawnpatU9zD7RRzfgFYrP/bRkK9ERhdW4jE/LNIsYIJXZ38TigZhkMyqzx6CcdV7KZtsKk4+/8gBwp3w+24REq6q+VZQb7HvvdqcIN6Rz6IcJQIa+wsA4Xxi95o9hOaxyrhAlJtjhNQreJTnxwKswJD0EuJg/MjLkexI1WHVHn4OA7tLAwy6gX/vSCUgc9CT8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11081478-7ee9-467d-03bc-08d5e866b4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 02:16:55.8960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn
	Although the commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable=
 for switch") is reverted to avoid the boot failure on some i.MX platforms,=
 but adding the "regulator-always-on" property for those pfuze's critical s=
witches are the right way and making sense, no matter how the pfuze regulat=
or's switch ON/OFF function will be implemented, below patches should can b=
e applied anyway?

ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
ARM: dts: make pfuze switch always-on for imx platforms
ARM: dts: imx6sl-evk: keep sw4 always on

	Let me know your thoughts, thanks!

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Wednesday, June 27, 2018 9:31 AM
> To: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> Fabio Estevam <fabio.estevam@nxp.com>; robh+dt@kernel.org;
> mark.rutland@arm.com
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.or=
g;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH V2] ARM: dts: make pfuze switch always-on for imx platfor=
ms
>=20
> commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch"=
)
> will cause those unreferenced switches being turned off if
> "regulator-always-on" is NOT present, as pfuze switches are normally used=
 by
> critical modules which must be always ON or shared by many peripherals wh=
ich
> do NOT implement power domain control, so just make sure all switches
> always ON to avoid any system issue caused by unexpectedly turning off
> switches.
>=20
> Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch"=
)
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> changes since V1:
> 	improve the way of referencing commit, and add fix tag.
>  arch/arm/boot/dts/imx6q-display5.dtsi  | 1 +
>  arch/arm/boot/dts/imx6q-mccmon6.dts    | 1 +
>  arch/arm/boot/dts/imx6q-novena.dts     | 1 +
>  arch/arm/boot/dts/imx6q-pistachio.dts  | 1 +
> arch/arm/boot/dts/imx6qdl-gw54xx.dtsi  | 1 +
> arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
> arch/arm/boot/dts/imx6sx-sdb-reva.dts  | 1 +
>  7 files changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi
> b/arch/arm/boot/dts/imx6q-display5.dtsi
> index 85232c7..33d266f 100644
> --- a/arch/arm/boot/dts/imx6q-display5.dtsi
> +++ b/arch/arm/boot/dts/imx6q-display5.dtsi
> @@ -326,6 +326,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt =3D <800000>;
>  				regulator-max-microvolt =3D <3300000>;
> +				regulator-always-on;
>  			};
>=20
>  			swbst_reg: swbst {
> diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts
> b/arch/arm/boot/dts/imx6q-mccmon6.dts
> index b7e9f38..e6429c5 100644
> --- a/arch/arm/boot/dts/imx6q-mccmon6.dts
> +++ b/arch/arm/boot/dts/imx6q-mccmon6.dts
> @@ -166,6 +166,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt =3D <800000>;
>  				regulator-max-microvolt =3D <3300000>;
> +				regulator-always-on;
>  			};
>=20
>  			swbst_reg: swbst {
> diff --git a/arch/arm/boot/dts/imx6q-novena.dts
> b/arch/arm/boot/dts/imx6q-novena.dts
> index fcd824d..0b3c651 100644
> --- a/arch/arm/boot/dts/imx6q-novena.dts
> +++ b/arch/arm/boot/dts/imx6q-novena.dts
> @@ -341,6 +341,7 @@
>  			reg_sw4: sw4 {
>  				regulator-min-microvolt =3D <800000>;
>  				regulator-max-microvolt =3D <3300000>;
> +				regulator-always-on;
>  			};
>=20
>  			reg_swbst: swbst {
> diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts
> b/arch/arm/boot/dts/imx6q-pistachio.dts
> index a31e83c..6ea09f9 100644
> --- a/arch/arm/boot/dts/imx6q-pistachio.dts
> +++ b/arch/arm/boot/dts/imx6q-pistachio.dts
> @@ -253,6 +253,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt =3D <800000>;
>  				regulator-max-microvolt =3D <3300000>;
> +				regulator-always-on;
>  			};
>=20
>  			swbst_reg: swbst {
> diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> index a1a6fb5..281cae5 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> @@ -268,6 +268,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt =3D <800000>;
>  				regulator-max-microvolt =3D <3300000>;
> +				regulator-always-on;
>  			};
>=20
>  			swbst_reg: swbst {
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 15744ad..6e46a19 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -341,6 +341,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt =3D <800000>;
>  				regulator-max-microvolt =3D <3300000>;
> +				regulator-always-on;
>  			};
>=20
>  			swbst_reg: swbst {
> diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> index e3533e7..9cc6ff2 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> @@ -63,6 +63,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt =3D <800000>;
>  				regulator-max-microvolt =3D <3300000>;
> +				regulator-always-on;
>  			};
>=20
>  			swbst_reg: swbst {
> --
> 2.7.4

