Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAE820989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xUHO95wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAE820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeK2Cse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:48:34 -0500
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:34896
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbeK2Cse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tBHt2MGfVMF3BeYQAD9T9zikNXgkGOoELXzgF+a4o0=;
 b=xUHO95wlFhD8YHF3vr8EDuBSKviDuvji/+CcYi1xWrrCkgJWqqWkOB5YZiHCFD0zHJMxYrgeMU8/WK2kShk0mfQilWOlcyCnYdlx3smK8NAKyyux+NPW5tSIRt7ldZBZB/J4FkAr72RQnqu3UVAgcHSMMm3ZR6R6Jjj750qS/I0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5985.eurprd04.prod.outlook.com (20.178.114.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 15:46:24 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 15:46:24 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP system controller
 RTC support
Thread-Topic: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP system controller
 RTC support
Thread-Index: AQHUhwDPyxX/IiT5m0W3z6gp9UDfPqVlVMDQ
Date:   Wed, 28 Nov 2018 15:46:24 +0000
Message-ID: <AM0PR04MB42115A31CAE5A72D047BE7B880D10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
 <1543398696-3140-5-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543398696-3140-5-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5985;6:T3mOL9f0QZVcQl4Zt65ME/WGqXFjq8esNNdZsozshM0BBM8n+yjWZwkUas/uHgnlU6Z4qYDfZV3p9ppypK+PuljdXLB0oW9VHI6Uq7ihurK4QBPEWREFtCUTYUWUAKM6fIEohEfOofhsgnR4zPVc/FFO2AM0WJwqRi2XWu+Gomgfb+S53Lk8MaBg+bxx18kM3UglA3Q41v/G0fXZekYeMuIo841hAUM6bX/fuIhgvsXgX8oP7yIcCyoXdXU9as4TKhSu3yoZOwXafSH1Nx0g/KNcMWmEQzPofGJFv9/VsYsfR3cBS2jMJx5lQON7Bo3/5u4zkKCeZeRHhiwuFKas+UoUpV4veKTqTjCmRCdQ4Kl3u/fQaRvqySpLJpRHb0FYD2S9Ot8IubBUNZRIHjDiLSs+isC1Hux0mpSWDid7ed24d0q5OOBXhNbUg+1MULYJKnTnikz9JKU/ObVVQg1DUg==;5:LHd5mPBE34hX/yjs+wkPWRXZz0SKcpreU2cvf7IrsPhQrbYHc63fKzg4q9vj5GQ8cN7AM1ClW90cEwbxdpeUEcLtg1/KBNViUoT8EquyVPzsHpF5/8Nv76NBK9WqEPU7uojpX7b+4Ts3vo37MbGKqbPLKsuRUk2kApDvFO7IH1s=;7:cQWdlpwfUNYhFBBYc1JhG96b90oWdPd33GhOX25lgFeEzQSWCRmE6hABmlfiqXaQpQBdk9onV9j2LCj6m9X9ElZkJGfa/ZIHpG/8/Ey6nkaEhmtXYlCPo91wUVxsiM8hhPxr3cQggef1zVtWT9r4lg==
x-ms-office365-filtering-correlation-id: 3f619191-c4a4-40bc-5c66-08d65548a6d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5985;
x-ms-traffictypediagnostic: AM0PR04MB5985:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB5985796ADE2FB992F241B59F80D10@AM0PR04MB5985.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5985;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5985;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(9686003)(7736002)(71200400001)(305945005)(71190400001)(476003)(102836004)(86362001)(7416002)(4326008)(6506007)(6436002)(446003)(11346002)(256004)(486006)(5660300001)(2201001)(74316002)(26005)(7696005)(76176011)(3846002)(97736004)(478600001)(66066001)(229853002)(110136005)(186003)(316002)(68736007)(6116002)(99286004)(2906002)(81166006)(106356001)(8676002)(53936002)(33656002)(105586002)(14454004)(81156014)(2501003)(55016002)(25786009)(8936002)(6246003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5985;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VqlPMT0p6SN0PehoWsRTC/nQA8TlakOhxRfQxLz0OTSU9MeCCljGs+WT07Bnpy2IURosz5f3d6yBeeVTYEwhy2vWiCaOmH04e/hvNGUlkTM9teRE3fDwi0lhfF9D41OSc6uZOa8VoxflVRw2WPRCMSGHfLiKFs75BYe9x4Yylqr6Ctz7GysIA8yZZArr6wgZev7VXeOwF4Mur+zQ7QeKqDZIxgAqS/0UsV5ESQAJ5OC9i2lXGQuq1pA4A7ufXdP+2Z1zuo6Y8A228oCUnd7TMaDPvWqaAP8JnzjPgHdEwyIB4/GB7taRlAqC9zwRh+1Shnb+TbewlewvvFsvbOKxlYeOAGjTnPyjaBwEvs5zbg0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f619191-c4a4-40bc-5c66-08d65548a6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 15:46:24.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> Subject: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP system controller R=
TC
> support
>=20
> Add i.MX8QXP system controller RTC support.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index da99b6f..5e8b554 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -406,4 +406,8 @@
>  		#size-cells =3D <1>;
>  		ranges =3D <0x5f000000 0x0 0x5f000000 0x1000000>;
>  	};
> +
> +	rtc: rtc {
> +		compatible =3D "nxp,imx8qxp-sc-rtc";

As I replied in patch 1, this belongs to scu node as well.

Regards
Dong Aisheng

> +	};
>  };
> --
> 2.7.4

