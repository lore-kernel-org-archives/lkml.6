Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A53C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 10:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF8E21877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 10:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JLwizHd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF8E21877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeHRNTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 09:19:12 -0400
Received: from mail-cys01nam02on0057.outbound.protection.outlook.com ([104.47.37.57]:48712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbeHRNTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 09:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PePke+pYaUGXEPGJ8oleLnqg/DM36qWzRGx7ZtdS+Lo=;
 b=JLwizHd5pQYTkpcZB29IYvMKHRckNQQ+bYcPWw0lx77u/WsJyj4i+5SJAHT0rNY441VUVywL67sKrN0icQUvFTbiSaGMOXirfWti71f+OZocAmQ06H5ono3DkaFWjQseJ6O9HAfLfpySEatAtQ1t6K8jzgDcmL01jdXYsYZRScs=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6SPR01MB10.namprd02.prod.outlook.com (20.176.73.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Sat, 18 Aug 2018 10:11:54 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644%3]) with mapi id 15.20.1059.023; Sat, 18 Aug 2018
 10:11:54 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        Edgar Iglesias <edgari@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "stefan.krsmanovic@aggios.com" <stefan.krsmanovic@aggios.com>
CC:     Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v4 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Topic: [PATCH v4 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Index: AQHUK9Uq/N7OkeV4PkSv3s73kY/ZqKTFX/kg
Date:   Sat, 18 Aug 2018 10:11:54 +0000
Message-ID: <DM6PR02MB5227CBDE0742DB55F26F014CC13C0@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-2-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1533374735-16662-2-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6SPR01MB10;6:nAxMgZnvtqV7HuHJbk1vR0J6LneZ2+4MxGd5+L4Jng6VDsPhV5vrzfG8svmaw6AeN9bY1QrEfLDAbnLKu9dNbFlF1ArrccU8U+vCzMyxjQvnt20MH0ua8S3XivNGWKtZZY1YyttJuPP/DYprg8IsixEEuC35d1nevZmT0Ehk/EbYQO8OxT4YhXGr/BEf+qKZn8m2FHFIGd9qgqeVVI1HkQlW4VYIHzzluRYK9cVi5x/ItmwEl/98oT6+iu/TN9zkYEvIK2b1dkYDgLeEnPLzY1Ig6yKtiAEUD0DnpAPLtAmLcCZSKBuHOcZXNrO8Z/woGvWMN0sc99gtSNlylZgqJI102dwms+sse0jrfozb40wFc+IH35HjxBp1sNojcYR8TkKa5JyxIJBu5FBPNjQ2XN1w74fMm50v5erIeRSDJkK1gY61z3oy0asqqfbDuMlQtSJG8CJykAAuQB7kSXF2RQ==;5:5DzMqvYDCA+oqlaTYTZ4hs/37A+DPZabSgzsclVEzH9Ip3ji1J9bkhbw3a4nvTl9GQ9OGX4N3jpano+HsarTwgOVkBvwhUq+m6jY0aGaZ4FqBU+SbMInQJ3N7fCGuyS3Y+b2Tpl4eWwqwcSwIcd4/Hz049QTFomTUQWjuJBC0mM=;7:u6nJQIBSI1tHYUEYOxhCEUag7ENPQvS9L6V69wHZjttzjd02TBVTF7LpuerdhjDuUhrnmcBUh9VponQ9yhU7D4ihlx6NMspgDrGbEdWQPm46sOXRcHFWUkOU/H+n0wC3Y+yp3ltSwjtMU6DbodJmcZ+W/vzhCcGr43LxtAUh7ESMnznfxapX4cl1/bBT3LZgDUDavD/d0dWqYXgPA50aY721hxzZGp7pCmXIn8GQ30ZNrsxSORFh5d/oydrLg8iy
x-ms-office365-filtering-correlation-id: 8daf9e0a-97a7-4ee7-6666-08d604f3060c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6SPR01MB10;
x-ms-traffictypediagnostic: DM6SPR01MB10:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6SPR01MB100B4A6D1AEB1D6531B366C13C0@DM6SPR01MB10.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6SPR01MB10;BCL:0;PCL:0;RULEID:;SRVR:DM6SPR01MB10;
x-forefront-prvs: 076804FE30
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(39860400002)(396003)(13464003)(199004)(189003)(6246003)(2201001)(53546011)(7696005)(68736007)(2501003)(106356001)(86362001)(256004)(76176011)(9686003)(8936002)(5250100002)(72206003)(55016002)(54906003)(110136005)(105586002)(14454004)(2900100001)(53936002)(478600001)(316002)(25786009)(8676002)(81156014)(6116002)(486006)(81166006)(229853002)(97736004)(74316002)(66066001)(2906002)(3846002)(5660300001)(446003)(102836004)(4326008)(33656002)(305945005)(6506007)(7736002)(11346002)(7416002)(476003)(99286004)(26005)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6SPR01MB10;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XfSWhCqjKvdGgLiIjQuOxXoxTkU88EExiL7kh3dNOwfgpaEYjvruGea1/BqYIEELPzVs1PwpUbpmYm52YifszJmBstAiBpUdP3c/xAox6Ug5bTR7E6rcPoZtucqHB1ej6dXRFquu1kiGCg4aiqTlHnJfSgl4sIhuaFVBoLVNC16yMZu1SUAlgkqnyYwcGX4RmEGIHA9YNTi0rK2vhdmrsiFYqrIemshJ+G7lqrdTenD7C5vGfQppUjctrvRkSa79HC/65FBmu3eqqs4dMIySE9I4JhvyOV4EaTy1Awm0aSJb2kdmUmCvbF0znwWa1AzYoujc50RsX/fw5dpsi+jo21frBsp6QfZW2EtLH4h3W3s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daf9e0a-97a7-4ee7-6666-08d604f3060c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2018 10:11:54.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.
=20
> -----Original Message-----
> From: Manish Narani [mailto:manish.narani@xilinx.com]
> Sent: Saturday, August 4, 2018 2:56 PM
> To: robh+dt@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> will.deacon@arm.com; Michal Simek <michals@xilinx.com>; bp@alien8.de;
> mchehab@kernel.org; mdf@kernel.org; Edgar Iglesias <edgari@xilinx.com>;
> Shubhrajyoti Datta <shubhraj@xilinx.com>; Naga Sureshkumar Relli
> <nagasure@xilinx.com>; Bharat Kumar Gogada <bharatku@xilinx.com>;
> stefan.krsmanovic@aggios.com
> Cc: Srinivas Goud <sgoud@xilinx.com>; Anirudha Sarangi
> <anirudh@xilinx.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> edac@vger.kernel.org; Manish Narani <MNARANI@xilinx.com>
> Subject: [PATCH v4 1/4] edac: synps: Add platform specific structures for=
 ddrc
> controller
>=20
> Add platform specific structures, so that we can add different IP support=
 later
> using quirks.
>=20
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 83 ++++++++++++++++++++++++++++++++++--
> --------
>  1 file changed, 65 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c =
index
> 0c9c59e..b3c54e7 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -22,6 +22,7 @@
>  #include <linux/edac.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
>=20
>  #include "edac_module.h"
>=20
> @@ -130,6 +131,7 @@ struct synps_ecc_status {
>   * @baseaddr:	Base address of the DDR controller
>   * @message:	Buffer for framing the event specific info
>   * @stat:	ECC status information
> + * @p_data:	Pointer to platform data
>   * @ce_cnt:	Correctable Error count
>   * @ue_cnt:	Uncorrectable Error count
>   */
> @@ -137,24 +139,47 @@ struct synps_edac_priv {
>  	void __iomem *baseaddr;
>  	char message[SYNPS_EDAC_MSG_SIZE];
>  	struct synps_ecc_status stat;
> +	const struct synps_platform_data *p_data;
>  	u32 ce_cnt;
>  	u32 ue_cnt;
>  };
>=20
>  /**
> + * struct synps_platform_data -  synps platform data structure
> + * @edac_geterror_info:	function pointer to synps edac error info
> + * @edac_get_mtype:	function pointer to synps edac mtype
> + * @edac_get_dtype:	function pointer to synps edac dtype
> + * @edac_get_eccstate:	function pointer to synps edac eccstate
> + * @quirks:		to differentiate IPs
> + */
> +struct synps_platform_data {
> +	int (*edac_geterror_info)(struct synps_edac_priv *priv);
> +	enum mem_type (*edac_get_mtype)(const void __iomem *base);
> +	enum dev_type (*edac_get_dtype)(const void __iomem *base);
> +	bool (*edac_get_eccstate)(void __iomem *base);
> +	int quirks;
> +};
> +
> +/**
>   * synps_edac_geterror_info - Get the current ecc error info
> - * @base:	Pointer to the base address of the ddr memory controller
> - * @p:		Pointer to the synopsys ecc status structure
> + * @priv:	Pointer to DDR memory controller private instance data
>   *
>   * Determines there is any ecc error or not
>   *
>   * Return: one if there is no error otherwise returns zero
>   */
> -static int synps_edac_geterror_info(void __iomem *base,
> -				    struct synps_ecc_status *p)
> +static int synps_edac_geterror_info(struct synps_edac_priv *priv)
>  {
> +	void __iomem *base;
> +	struct synps_ecc_status *p;
>  	u32 regval, clearval =3D 0;
>=20
> +	if (!priv)
> +		return 1;
> +
> +	base =3D priv->baseaddr;
> +	p =3D &priv->stat;
> +
>  	regval =3D readl(base + STAT_OFST);
>  	if (!regval)
>  		return 1;
> @@ -240,9 +265,10 @@ static void synps_edac_handle_error(struct
> mem_ctl_info *mci,  static void synps_edac_check(struct mem_ctl_info *mci=
)  {
>  	struct synps_edac_priv *priv =3D mci->pvt_info;
> +	const struct synps_platform_data *p_data =3D priv->p_data;
>  	int status;
>=20
> -	status =3D synps_edac_geterror_info(priv->baseaddr, &priv->stat);
> +	status =3D p_data->edac_geterror_info(priv);
>  	if (status)
>  		return;
>=20
> @@ -362,6 +388,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info
> *mci)
>  	struct csrow_info *csi;
>  	struct dimm_info *dimm;
>  	struct synps_edac_priv *priv =3D mci->pvt_info;
> +	const struct synps_platform_data *p_data =3D priv->p_data;
>  	u32 size;
>  	int row, j;
>=20
> @@ -370,12 +397,13 @@ static int synps_edac_init_csrows(struct
> mem_ctl_info *mci)
>  		size =3D synps_edac_get_memsize();
>=20
>  		for (j =3D 0; j < csi->nr_channels; j++) {
> -			dimm            =3D csi->channels[j]->dimm;
> +			dimm =3D csi->channels[j]->dimm;
>  			dimm->edac_mode =3D EDAC_FLAG_SECDED;
> -			dimm->mtype     =3D synps_edac_get_mtype(priv-
> >baseaddr);
> -			dimm->nr_pages  =3D (size >> PAGE_SHIFT) / csi-
> >nr_channels;
> -			dimm->grain     =3D SYNPS_EDAC_ERR_GRAIN;
> -			dimm->dtype     =3D synps_edac_get_dtype(priv-
> >baseaddr);
> +			dimm->mtype =3D p_data->edac_get_mtype(priv-
> >baseaddr);
> +			dimm->nr_pages =3D (size >> PAGE_SHIFT) /
> +						csi->nr_channels;
> +			dimm->grain =3D SYNPS_EDAC_ERR_GRAIN;
> +			dimm->dtype =3D p_data->edac_get_dtype(priv-
> >baseaddr);
>  		}
>  	}
>=20
> @@ -423,6 +451,21 @@ static int synps_edac_mc_init(struct mem_ctl_info
> *mci,
>  	return status;
>  }
>=20
> +static const struct synps_platform_data zynq_edac_def =3D {
> +	.edac_geterror_info	=3D synps_edac_geterror_info,
> +	.edac_get_mtype		=3D synps_edac_get_mtype,
> +	.edac_get_dtype		=3D synps_edac_get_dtype,
> +	.edac_get_eccstate	=3D synps_edac_get_eccstate,
> +	.quirks			=3D 0,
> +};
> +
> +static const struct of_device_id synps_edac_match[] =3D {
> +	{ .compatible =3D "xlnx,zynq-ddrc-a05", .data =3D (void *)&zynq_edac_de=
f },
> +	{ /* end of table */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, synps_edac_match);
> +
>  /**
>   * synps_edac_mc_probe - Check controller and bind driver
>   * @pdev:	Pointer to the platform_device struct
> @@ -440,13 +483,22 @@ static int synps_edac_mc_probe(struct
> platform_device *pdev)
>  	int rc;
>  	struct resource *res;
>  	void __iomem *baseaddr;
> +	const struct of_device_id *match;
> +	const struct synps_platform_data *p_data;
>=20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	baseaddr =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(baseaddr))
>  		return PTR_ERR(baseaddr);
>=20
> -	if (!synps_edac_get_eccstate(baseaddr)) {
> +	match =3D of_match_node(synps_edac_match, pdev->dev.of_node);
> +	if (!match && !match->data) {
> +		dev_err(&pdev->dev, "of_match_node() failed\n");
> +		return -EINVAL;
> +	}
> +
> +	p_data =3D (struct synps_platform_data *)match->data;
> +	if (!(p_data->edac_get_eccstate(baseaddr))) {
>  		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
>  		return -ENXIO;
>  	}
> @@ -468,6 +520,8 @@ static int synps_edac_mc_probe(struct platform_device
> *pdev)
>=20
>  	priv =3D mci->pvt_info;
>  	priv->baseaddr =3D baseaddr;
> +	priv->p_data =3D match->data;
> +
>  	rc =3D synps_edac_mc_init(mci, pdev);
>  	if (rc) {
>  		edac_printk(KERN_ERR, EDAC_MC,
> @@ -511,13 +565,6 @@ static int synps_edac_mc_remove(struct
> platform_device *pdev)
>  	return 0;
>  }
>=20
> -static const struct of_device_id synps_edac_match[] =3D {
> -	{ .compatible =3D "xlnx,zynq-ddrc-a05", },
> -	{ /* end of table */ }
> -};
> -
> -MODULE_DEVICE_TABLE(of, synps_edac_match);
> -
>  static struct platform_driver synps_edac_mc_driver =3D {
>  	.driver =3D {
>  		   .name =3D "synopsys-edac",
> --
> 2.1.1

