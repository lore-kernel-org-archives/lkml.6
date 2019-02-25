Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDBC20645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fhoz3kU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfBYC1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:27:24 -0500
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:64320
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbfBYC1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjwUz/U70sRnDx+THWYYVV0eBNubC70U5b13LmhQH8Q=;
 b=fhoz3kU7IMidPziMAUv9yUO8/WHQwroExTxjrYqCuKxxvDfOsP27cmcglUv6vXznBHNsI7xaBQYaQZb1VI1ynFaWUr0NQNFSDTAbdu3chV8CUPV9bbHoeaZxaDhgeYxU4kfkBAgHknAUW6TYEUE9kaPvXRRfvEzk5qH0UwhqVnU=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Mon, 25 Feb 2019 02:27:19 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:27:19 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] usb: chipidea: tegra: Fix missed
 ci_hdrc_remove_device()
Thread-Topic: [PATCH v1] usb: chipidea: tegra: Fix missed
 ci_hdrc_remove_device()
Thread-Index: AQHUzFbRBzry8lnzFUC3W/ZN4MXOSKXvyccA
Date:   Mon, 25 Feb 2019 02:27:19 +0000
Message-ID: <VI1PR04MB5327FE97DC8C68B4D56DE0A98B7A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190224153622.8877-1-digetx@gmail.com>
In-Reply-To: <20190224153622.8877-1-digetx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e84b98d8-790f-4495-7221-08d69ac8c474
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5008;
x-ms-traffictypediagnostic: VI1PR04MB5008:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB5008;23:m4qAxiREeMM9/WICL4AZle6Xa3vzZCI7QdGDtoWiO?=
 =?us-ascii?Q?uoxX4cgt8jh+fa8OoRbPPZSFLzn0qL/pF3A6pEpTQBPFUHo0tLZdccbujLc3?=
 =?us-ascii?Q?m/2VLYHrYRrHydAZs/SK4IGMGaXaQlnDc/fr6a36TLJ8zQSAULexX+T3VCSr?=
 =?us-ascii?Q?oTLjOOGirO4b6EXIWCU+zOuvHzlFx/EfzMhU8z8DztwXchvXXQ0t8Y4IdcHT?=
 =?us-ascii?Q?jVxpnip4/f9ckPUQM2n319Rh6eC2JcnpItC9KCLFM+Ym6fvH7+Th3XEnprLh?=
 =?us-ascii?Q?9gdF+dmbrOLFZbOYEvV702c8zD2a1iLxxxZNSYPA22WKxHUspkSE9VvgYz6L?=
 =?us-ascii?Q?oNDMijztbAlkjjEZpkB3muwy5gdC6D3GoXaT1WTDQK13+2setIJcWBiGoXCz?=
 =?us-ascii?Q?lQkYVoTkarUqZ1WDxI9u81YysVeeA0aOUrFxhC+BDwknpYYKLcL79KVlhOS7?=
 =?us-ascii?Q?Ld3vgbMI+0MOMTB0QpLWA5rkpG2xgK7JHs4xeCXdGzNaJFJgBIPtEj8L1Yp3?=
 =?us-ascii?Q?wJDf1kTauwhtAXs/8Dhq/j7qR+FJEQDn8A6M6Ey1jSktiz/itRMPwx31gos6?=
 =?us-ascii?Q?jEeu/ZulWxmX2IP4BlV0WsfArVQ0z2JMGuIPO6D53j2/cjiusv2BmtFxf4/K?=
 =?us-ascii?Q?ehUsU4ry65G2yCSKPMZPclsKnAV/fKhD49K7IKw7l/R1vUKKiLSQQevWg4o7?=
 =?us-ascii?Q?M8nHd9836b1C1VbXwYZUrqWGXQ4n3przMdAVOn8rNCsBoa1PJkZmhW9V5csv?=
 =?us-ascii?Q?m5E+Ad28klNyyMCH5oAFGO/6o9b17UGgLHEaQxTLP+qivniMz1VyueLysgIN?=
 =?us-ascii?Q?wfpoaMsxhhBwjv7MZHQHvGLknMeEnAT+De1ISy/d2HRilnHtNhhA7NB94BAa?=
 =?us-ascii?Q?xwKCKseOxn6ymdn62Un7jGU0eQppj1eVgVauz2nL9y/eRtDyKNo6E9hnSemr?=
 =?us-ascii?Q?glYLs5C4VLrirYkFrWFII1DtvXHZ6TdGEpFRqs4XBeFzeuGqxEPItRPZuqJ2?=
 =?us-ascii?Q?kqLn3x4GGRGo2pu5Xz9ytxwnoZtO9dwR07AxXLYkomp42RZr7hLzg4iDMbPG?=
 =?us-ascii?Q?weSEVpbtg/eVhKcVl/39N7rYRo3XjBNpEQcsxMM2CZ0Wmn4yRWXpBLEwB5WV?=
 =?us-ascii?Q?h9nb4B8ctXyBoHNAc0eZ2uYXuZS6yJO5ugOBFedpqzKQll61gh+YeFMthRNo?=
 =?us-ascii?Q?doL9u1/bNLu5iOrAvPfnxCLQ1DxD+/D34+vz9xuvNQdC55XSQQAlt+HUPghO?=
 =?us-ascii?Q?RImfA2iFvccCmYEdfAoDOvXuWrkvAnoUBkYx+fb?=
x-microsoft-antispam-prvs: <VI1PR04MB5008A8B2288D085F82ADF00E8B7A0@VI1PR04MB5008.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(110136005)(9686003)(54906003)(74316002)(4326008)(316002)(53936002)(25786009)(6246003)(105586002)(33656002)(305945005)(7736002)(106356001)(5660300002)(4744005)(52536013)(97736004)(71190400001)(81156014)(81166006)(8676002)(71200400001)(2906002)(486006)(86362001)(11346002)(256004)(14444005)(446003)(476003)(44832011)(14454004)(7696005)(26005)(186003)(478600001)(99286004)(66066001)(6506007)(6436002)(102836004)(68736007)(76176011)(6116002)(3846002)(229853002)(55016002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5008;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3wH8/9VOBA9+rg839F9WIgKCast7eYawrf9jiJwllRSXyT++ejf9BTCDi3yRNP6w7WOpZz7evxgD7N5H+tXFo9SZAvISh4rHc2soX6R3gqOHdGPQtg9uChmMIfsVWXIhhtmFI1lZu4cCiRHC1FKbAZ5IGxRnlx1JxbGGPupC9q+WqxnO5nQMaxRW0Drmjo1+43hH0mESCsYp1cKUMbOqm6JTAgEeF/I+nMs7bUgxAlCfG22be+0P5a8QxX2wCjpVGkG+iOaZNA40YD3oD3MjNvD6qg/UDRr9eOWfkC3sfQfe0SwlPbnwZQb0AAl5grltR8ApQh4XABwC5a8ogr2jdOcYxY944ilq8x6wHlTS4g3v6X97rQaYv33oVIbuDMSnLvmjpE4vrPorHG+/PTUPCbyWE3a4ZVvwdJQPvRodIYA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84b98d8-790f-4495-7221-08d69ac8c474
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:27:19.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for Tegra20/30/114/1=
24")

I suppose you need to apply at stable tree too, right?

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_tegra.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c
> b/drivers/usb/chipidea/ci_hdrc_tegra.c
> index 772851bee99b..12025358bb3c 100644
> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> @@ -130,6 +130,7 @@ static int tegra_udc_remove(struct platform_device *p=
dev)
> {
>  	struct tegra_udc *udc =3D platform_get_drvdata(pdev);
>=20
> +	ci_hdrc_remove_device(udc->dev);
>  	usb_phy_set_suspend(udc->phy, 1);
>  	clk_disable_unprepare(udc->clk);
>=20
=20
Acked-by: Peter Chen <peter.chen@nxp.com>

Hi Greg, would you still accept the bug-fix for this release (v5.0)? Or I s=
end you later?

Peter

