Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E1C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7452021903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kcuENunP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeLWJOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:14:44 -0500
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:54811
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbeLWJOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo9o1+4coZxW9vGX64Qb49ldl8SjPQ0kY30GT0Wl1QQ=;
 b=kcuENunPAmkgxay16sdtUmiBgtOYKpwcjl41xEjnnS3Jd+Gw66cGTXwoUPhgt6Q3nQGP2954/JS/j0pc09/wRr4n94/TGxR/P+jbfAPVBMuah3TsX2xqQIwRwy8XRt+Q2NqOh0EMdc9G/RNIiJnIXfTkrnyg4T+UXDUKuxdPbpQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5059.eurprd04.prod.outlook.com (20.177.40.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.26; Sun, 23 Dec 2018 09:14:36 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:14:36 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Topic: [PATCH] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Index: AQHUmo0ZxZkW3cAPxEypasRMKtmrGKWMCRmQ
Date:   Sun, 23 Dec 2018 09:14:36 +0000
Message-ID: <AM0PR04MB4211F4CAC02A1ECA6939960380BA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545548380-17399-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1545548380-17399-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5059;6:NYusrPLJESuwLhZ3JxD7V8/xvSDNw+jVlTRZLxIQqMp0ihoING9ub2XWKIKKplgyQ1gL2YrEgT9+YPKAHJaHyKbCh/bh2EkoWFlc9R/ZxRINA7jeo6TfyGAilyahHqcDV4YSLv1DYUvfQXSoRWi/Jl1KR/6LcJ+NaSSXL6vyP8/PF3mvhBcjHuPTpDv84/9oBKnTJ1CZhkUXmagvU5mtYNMeM2J+rPN2V/YIRf7uBORo9zGC2FmYu7QHCpiXABUFHz3i7O8t0I+Nb/ktDxyH84TrvH6x7dEojxrUL5hYWQB8kaAHLytP0xNqyrSnHTWhvS3cW5nPfkpdeGZHLZFvwukINQ8CG/HfKuEvKHbzAfcpqPg9XASQF1qQDTxEHvJawrRVQdqW4dP6myYMnUSBC7Yalu9IxdNDfaV9hTRGKOxuppqwXtoe6qQRKTh0d3aey4X+xnQmcApmkymq8GZyoA==;5:GrUm5vHoC72ih+TXzo5+gLeqEg5eSpACYeTHLwJO0X+MhbJPQpD9KxhZPVAC/gVzoCgkvsJjp1aPWrKxAotSsaKVTVBvLOcaAbjdcmiix68KOpq1SjvcRCA5No1tvLVheMBz19SBbyS0SrCfecy8JK8e94M2Q303zz7PmfdSM98=;7:ss5qPFcMQYj7apQcRV6jDBPKLJegHHXxRqEiiOgJkvCqRm895ID3wigxgfQ8Cb9qgiAOmSbus1QVaJqYoH6vU8BN/JMcgo6hzsoc8uS/d4yT1E82dgntEuADEoWwlaS35OuOY4Ay7GTfcUqRufu5hQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e666d3f3-a0fd-40ce-f713-08d668b70f5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5059;
x-ms-traffictypediagnostic: AM0PR04MB5059:
x-microsoft-antispam-prvs: <AM0PR04MB5059B1D6F0460D379C7F3A1180BA0@AM0PR04MB5059.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5059;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5059;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(13464003)(81166006)(102836004)(81156014)(86362001)(14454004)(476003)(486006)(11346002)(478600001)(5660300001)(25786009)(8676002)(186003)(446003)(76176011)(2906002)(33656002)(6436002)(105586002)(106356001)(44832011)(316002)(4326008)(8936002)(53936002)(74316002)(66066001)(55016002)(229853002)(26005)(9686003)(71190400001)(71200400001)(97736004)(14444005)(256004)(68736007)(54906003)(7696005)(99286004)(6246003)(6116002)(305945005)(7736002)(110136005)(53546011)(6636002)(3846002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5059;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OxJ5bk98zNl+qTy4HJk2dxEfQSc0YKUKm2OzfcMA+TSgDIr2s2z7WF4Z1zax81udnXwa693hL/20LNa3gbv6Rwnl2WBhIlogaff18ptdwkae2MP/kMvNvbQqERPRH0ZJSKYt40sCnnbsitrWj3HZ7+YPHBkozrvaoaaB7xY8fxCja/to28sP/agrOLyXkta5ic3jQPVdLa5FVCK+o47LlPQf9cL6QyJo5T4qUuoc2Z9FrhI1JWRrN5zLXLsqOMfrXlIUzsgyVpYDqzSG9myH60fTw1Dny4gBJuKSqED753FL3yuzvGi4MhvI4VwOs/Bc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e666d3f3-a0fd-40ce-f713-08d668b70f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:14:36.5079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Abel Vesa
> Sent: Sunday, December 23, 2018 3:00 PM
> To: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.or=
g;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Abel Vesa
> <abel.vesa@nxp.com>
> Subject: [PATCH] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
>=20
> Since this is going to be used on more SoCs than just i.MX8MQ, make the
> dependency here more generic.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/soc/imx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index
> 2112d18..7ffbb6b 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
>=20
>  config IMX_GPCV2_PM_DOMAINS
>  	bool "i.MX GPCv2 PM domains"
> -	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
> +	depends on SOC_IMX7D || ARCH_MXC || (COMPILE_TEST && OF)

Nitpick:
ARCH_MXC already contains SOC_IMX7D, so simply depends on
ARCH_MXC || (COMPILE_TEST && OF) should be enough.

Otherwise:
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

>  	depends on PM
>  	select PM_GENERIC_DOMAINS
>  	default y if SOC_IMX7D
> --
> 2.7.4

