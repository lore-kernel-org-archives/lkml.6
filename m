Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1214C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F46241BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BS3mdWfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F46241BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeGECkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:40:36 -0400
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:4032
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752962AbeGECke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTyHxfGpOhPVfc+vh0tQpnxFPTthAgZY1rzKzoHI1+0=;
 b=BS3mdWfGaivkMqZXfK7JaQpCH0OR/7xd/XznojAnYi6rDl1LowPziq4UWzlAxD3XtaTWGl4YxunkU4nKuQ5ifw2hi1RBe6pmmC/+v7V4uU1FH4MlOy0XmH+GUvJHytTR2J2OSpT28Pae20D4TTWrI7oEMTzuIJQO3HtiExkuwjg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4769.eurprd04.prod.outlook.com (20.176.215.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Thu, 5 Jul 2018 02:40:31 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0930.016; Thu, 5 Jul 2018
 02:40:31 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
Thread-Topic: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
Thread-Index: AQHUE6jJ1GJfZSdRVketSqQt7CEu16R/5RsQ
Date:   Thu, 5 Jul 2018 02:40:31 +0000
Message-ID: <AM0PR04MB42115AFEC34B115F185C087680400@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180704150745.21003-1-stefan@agner.ch>
In-Reply-To: <20180704150745.21003-1-stefan@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4769;7:zrsjOtFJQWFwhD/n9QTTh8FOxUaYXNchp4nfQrYc+yacG054QiSA7mVEAXIr+ofG9ZtMfivey5bVTFbFGvgczFzS+yiycLMtcJVOOMRhlv79M6G6/RkeGAXUL20Rw8sgpCPx1nNxIChl99oRMzmmnbgFql99mlE9R/jqslinYxoYOk8ah0k8gmv7Zfq5U+3ASq+718vkH+d/2ZlAo0AEyIKOPP5UyxmlZZDZnDa6sfCAb+9lt4Xa+UOcUxOP3vRq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f99bd618-8e3e-4b6d-0a28-08d5e220ad31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4769;
x-ms-traffictypediagnostic: AM0PR04MB4769:
x-microsoft-antispam-prvs: <AM0PR04MB47691BB57ECA5BE814BEEB9780400@AM0PR04MB4769.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(45079756050767)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4769;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4769;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(13464003)(575784001)(86362001)(186003)(2501003)(26005)(102836004)(2201001)(76176011)(6506007)(53546011)(106356001)(105586002)(2906002)(33656002)(97736004)(99286004)(74316002)(7696005)(5660300001)(316002)(54906003)(110136005)(6636002)(66066001)(305945005)(68736007)(229853002)(6436002)(8936002)(81156014)(81166006)(8676002)(14454004)(2900100001)(966005)(45080400002)(478600001)(6246003)(53936002)(6116002)(3846002)(4326008)(25786009)(7736002)(11346002)(55016002)(476003)(446003)(486006)(5250100002)(9686003)(256004)(6306002)(14444005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4769;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nOEI+4V7eT7nLZH/y83hj+0VGJYyQtydcBdbm8t12Cgs6OaPTNvZcXaQzC8PhLED03WVLtUc2RCfhU/cgr2NHlEfNiWEW+PkHzl+vT2OYFfqHhBR7+gQhjZsuwSwCC9BQ/EDYpTn8/Mor5orDwlHPsm4T4T2s+Noeq6CZQ0kkwyiiJ8M7H7mx7A62JPoO4X5T3c7MW3a1Mn7XM4aQcOnDxnyRq1bw9pM5kPvdrVboctBoykWTID6arn2wzOs8R7/tqc6cXKZoCDJPlK/poCWkfWbJWCcMQBdirbyNG5AKkHdji9YhsN08qDEPXJ/aevigGpCxxCwRL/qb5J6I4qtNOfH/8eBru8R33svZMmi3Yw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99bd618-8e3e-4b6d-0a28-08d5e220ad31
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 02:40:31.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Wednesday, July 4, 2018 11:08 PM
> To: adrian.hunter@intel.com; ulf.hansson@linaro.org
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> michael@amarulasolutions.com; rmk+kernel@armlinux.org.uk; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Agner
> <stefan@agner.ch>
> Subject: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
> 100/200MHz pinctrl states
>=20
> If pinctrl nodes for 100/200MHz are missing, the controller should not se=
lect
> any mode which need signal frequencies 100MHz or higher.
> To prevent such speed modes the driver currently uses the quirk flag
> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V signalin=
g
> is required for all faster modes and slower modes use 3.3V signaling only=
.
>=20
> However, there are eMMC modes which use 1.8V signaling and run below
> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply the
> stack has no valid mode to use. In this tenuous situation the kernel
> continuously prints voltage switching errors:
>   mmc1: Switching to 3.3V signalling voltage failed
>=20

From current code, the NO_1_8_V quirk seems like only affect sd card.
The 1.8v timing is still allowed for eMMC 1_8V DDR.
See below:
        if ((mmc->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
                          MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
                          MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR)) ||
            (mmc->caps2 & (MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)))
                host->flags |=3D SDHCI_SIGNALING_180;

Due to i have no board to try that case, can you please help detail more on=
 how the
eMMC DDR52 is blocked due to that quirk?

Regards
Dong Aisheng

> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by altering
> the SDHCI capability register. With that the stack is able to select 1.8V=
 modes
> even if no faster pinctrl states are available:
>   # cat /sys/kernel/debug/mmc1/ios
>   ...
>   timing spec:    8 (mmc DDR52)
>   signal voltage: 1 (1.80 V)
>   ...
>=20
> Link:
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flkml
> .kernel.org%2Fr%2F20180628081331.13051-1-
> stefan%40agner.ch&amp;data=3D02%7C01%7Caisheng.dong%40nxp.com%7Ca
> 32bdbdb4e854ed1a49008d5e1bfeae2%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C636663136759720275&amp;sdata=3D%2F2gJ%2BA0fHCzzUehD7
> 9knsfy3WMj4Okp%2BcxXB70MI5y8%3D&amp;reserved=3D0
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index 20a420b765b3..e96d969ab2c3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -312,6 +312,15 @@ static u32 esdhc_readl_le(struct sdhci_host *host,
> int reg)
>=20
>  			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>  				val |=3D SDHCI_SUPPORT_HS400;
> +
> +			/*
> +			 * Do not advertise faster UHS modes if there are no
> +			 * pinctrl states for 100MHz/200MHz.
> +			 */
> +			if (IS_ERR_OR_NULL(imx_data->pins_100mhz) ||
> +			    IS_ERR_OR_NULL(imx_data->pins_200mhz))
> +				val &=3D ~(SDHCI_SUPPORT_SDR50 |
> SDHCI_SUPPORT_DDR50
> +					 | SDHCI_SUPPORT_SDR104 |
> SDHCI_SUPPORT_HS400);
>  		}
>  	}
>=20
> @@ -1157,18 +1166,6 @@ sdhci_esdhc_imx_probe_dt(struct
> platform_device *pdev,
>=20
> 	ESDHC_PINCTRL_STATE_100MHZ);
>  		imx_data->pins_200mhz =3D pinctrl_lookup_state(imx_data-
> >pinctrl,
>=20
> 	ESDHC_PINCTRL_STATE_200MHZ);
> -		if (IS_ERR(imx_data->pins_100mhz) ||
> -				IS_ERR(imx_data->pins_200mhz)) {
> -			dev_warn(mmc_dev(host->mmc),
> -				"could not get ultra high speed state, work on
> normal mode\n");
> -			/*
> -			 * fall back to not supporting uhs by specifying no
> -			 * 1.8v quirk
> -			 */
> -			host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
> -		}
> -	} else {
> -		host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
>  	}
>=20
>  	/* call to generic mmc_of_parse to support additional capabilities */
> --
> 2.18.0

