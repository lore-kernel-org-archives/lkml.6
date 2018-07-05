Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F4C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D4124075
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SOUE/TGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D4124075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeGECw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:52:28 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:44256
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752965AbeGECw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPsDtwvJRzmhfztWoERZXlaLtdgpUAuXZgARMneRZII=;
 b=SOUE/TGmmgpdrEP5cRsQIbNs77GHIHQxrWlSzPZ3TWlv+qz5MvCr0tiPTwNDCra3fokete/8oeUu7t1kV2NVuqS0gF5OimLoy8d6allE5JH7OF5MQmlnZETOFuGqdHHsxxP2ejuRgk82fCD8FSLjKfhDqV0KgnVP7HQHdhqIbnE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4722.eurprd04.prod.outlook.com (20.176.214.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Thu, 5 Jul 2018 02:52:23 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0930.016; Thu, 5 Jul 2018
 02:52:23 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
Thread-Topic: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
Thread-Index: AQHUDrfrQkhZ2kgwkEOwhVq45jpRW6R/+ExQ
Date:   Thu, 5 Jul 2018 02:52:23 +0000
Message-ID: <AM0PR04MB42119E8C29A48E9CDA0F116F80400@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180628081331.13051-1-stefan@agner.ch>
 <20180628081331.13051-2-stefan@agner.ch>
In-Reply-To: <20180628081331.13051-2-stefan@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4722;7:3kT6JYPeWq0GXHFdzdlR406vuQXfPWg+XNi4HMDYaFhgzh2SmfJBPN7WLmdJbb+Ubf6+L0VH8+Ya7noKINwuYQwSvn6yRLTrwxwHA8QENeXory9pP0Jq1mbZFlSoR1tTgIVXdwFMs6DgkdLtVKhEFwxHwPfwTRI+arQm/GNPxgbvMd6a9AQEWbRM2ebs0I7R5iqW2sFe//dksRwkRnQHeboT5rO/WtPIClIL/AOxy0ydIC4jvEvdiT97m8tlc+uk
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 088dc779-c9d4-426a-bce6-08d5e2225567
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4722;
x-ms-traffictypediagnostic: AM0PR04MB4722:
x-microsoft-antispam-prvs: <AM0PR04MB4722C98EE70108220D61B6F880400@AM0PR04MB4722.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4722;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4722;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(136003)(189003)(199004)(13464003)(99286004)(55016002)(2501003)(54906003)(9686003)(14454004)(316002)(229853002)(110136005)(6436002)(486006)(2201001)(11346002)(476003)(4326008)(66066001)(256004)(25786009)(5250100002)(53936002)(7696005)(446003)(86362001)(14444005)(6246003)(68736007)(97736004)(575784001)(478600001)(2900100001)(106356001)(105586002)(74316002)(186003)(6116002)(5660300001)(2906002)(8676002)(3846002)(7736002)(102836004)(6506007)(53546011)(81156014)(305945005)(26005)(8936002)(81166006)(33656002)(76176011)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4722;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5ubt47yVXp6Edxs1CFgn9Q06QRp/L+0MtsdZTekfq0LuT1QU5ZMbiB0sVIzHImyKSBRn5fw9GIZty6K9+gEMV5FAJETgHtsEcMaQnmBVmf0N3caF6ir8JKuwDVhu+Tiu7ZBdGyweZRhr87jbPY9FIsTN1pjBlWhtDIAnDzFmzgruuY/8FiyOv0LD38A0iUXphP1in/pPz45EHmTVD0zVQCx7pSBPi2NS7bH3bWNviVwaxzty4kS3X51atUGnmXSzjTOjcKtJZvfWCoWzGn3ovt5bFNfNFDOjHpZCybydmy74UjYh6qKKjFMVfbUGkvKzN+/gxHBbn7X+tJ84oZdmsHHHBQCx9W8F+ZrhleESWTE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088dc779-c9d4-426a-bce6-08d5e2225567
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 02:52:23.1559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Thursday, June 28, 2018 4:13 PM
> To: adrian.hunter@intel.com; ulf.hansson@linaro.org
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> michael@amarulasolutions.com; rmk+kernel@armlinux.org.uk; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Agner
> <stefan@agner.ch>
> Subject: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
>=20
> The field support_vsel is currently only used in the device tree case. Ge=
t rid
> of it. No change in behavior.
>=20

I'm not sure if it's quite necessary to remove it as it's used to bypass
100Mhz above pad settings look up which is meaningless if user claims
no 1-8 v support.

If you remove it, probably you still need better check the quirk for
Pad state look up.

Regards
Dong Aisheng

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c          | 8 ++------
>  include/linux/platform_data/mmc-esdhc-imx.h | 2 --
>  2 files changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index 6f444731754d..20a420b765b3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1145,18 +1145,14 @@ sdhci_esdhc_imx_probe_dt(struct
> platform_device *pdev,
>  			     &boarddata->tuning_start_tap);
>=20
>  	if (of_find_property(np, "no-1-8-v", NULL))
> -		boarddata->support_vsel =3D false;
> -	else
> -		boarddata->support_vsel =3D true;
> +		host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
>=20
>  	if (of_property_read_u32(np, "fsl,delay-line", &boarddata-
> >delay_line))
>  		boarddata->delay_line =3D 0;
>=20
>  	mmc_of_parse_voltage(np, &host->ocr_mask);
>=20
> -	/* sdr50 and sdr104 need work on 1.8v signal voltage */
> -	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
> -	    !IS_ERR(imx_data->pins_default)) {
> +	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pins_default))
> {
>  		imx_data->pins_100mhz =3D pinctrl_lookup_state(imx_data-
> >pinctrl,
>=20
> 	ESDHC_PINCTRL_STATE_100MHZ);
>  		imx_data->pins_200mhz =3D pinctrl_lookup_state(imx_data-
> >pinctrl,
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h
> b/include/linux/platform_data/mmc-esdhc-imx.h
> index 7daa78a2f342..640dec8b5b0c 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -34,7 +34,6 @@ enum cd_types {
>   * @cd_gpio:	gpio for card_detect interrupt
>   * @wp_type:	type of write_protect method (see wp_types enum above)
>   * @cd_type:	type of card_detect method (see cd_types enum above)
> - * @support_vsel:  indicate it supports 1.8v switching
>   */
>=20
>  struct esdhc_platform_data {
> @@ -43,7 +42,6 @@ struct esdhc_platform_data {
>  	enum wp_types wp_type;
>  	enum cd_types cd_type;
>  	int max_bus_width;
> -	bool support_vsel;
>  	unsigned int delay_line;
>  	unsigned int tuning_step;       /* The delay cell steps in tuning
> procedure */
>  	unsigned int tuning_start_tap;	/* The start delay cell point in tuning
> procedure */
> --
> 2.18.0

