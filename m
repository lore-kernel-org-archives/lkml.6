Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67726C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1AD222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="bBJQU9h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391686AbfBMPVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:21:12 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:1311 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390550AbfBMPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1550071270; x=1581607270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WGgVQqf2Z0/WlGp5qRuvv4NGSOkHZr3aTFHgAqJsxTU=;
  b=bBJQU9h1ZKSxjUPKHiBpWLsfluGqCzdVpcghh1kNIJaTovjqBfbErek6
   8oPcqpj5X7EPCW9dr2A+gtvb2Y5VCOC8gU4kqh7g1AT5shRS0N6rAGorn
   pTaSbZJNck6510tGFbMiKd0iCO3IdrKFLAHB+eOuj70Aee+lRGjKk2Qr8
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EEAABINWRchiWd50NjGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUwMBAQEBCwGCWRGBAycKjHSLFIINmBMUgWcLAQEjC4Q+AoN?=
 =?us-ascii?q?aIjYHDQEDAQECAQECAQECEAEBAQoJCwgpIwyCOgwyTWsBAQEBAQEjAg0aSQE?=
 =?us-ascii?q?BAQECARIVEz8FBwQCAQgRBAEBHxBPCAIEAQ0FCBqDAgGBaQMNCA+dND0CbYE?=
 =?us-ascii?q?BiQcBAQGBazMdhBIBg1IkggIFjESCFoERgxKDHgICGIEUARIBAxGFawKjJwc?=
 =?us-ascii?q?ChzqLESGSby2KCIIKgzeMJwIEAgQFAhSBTAGBF3FwgzwfggkOCROCTYRcgSO?=
 =?us-ascii?q?FP0ABMQEBFgGNKYEfgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EEAABINWRchiWd50NjGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?wMBAQEBCwGCWRGBAycKjHSLFIINmBMUgWcLAQEjC4Q+AoNaIjYHDQEDAQECA?=
 =?us-ascii?q?QECAQECEAEBAQoJCwgpIwyCOgwyTWsBAQEBAQEjAg0aSQEBAQECARIVEz8FB?=
 =?us-ascii?q?wQCAQgRBAEBHxBPCAIEAQ0FCBqDAgGBaQMNCA+dND0CbYEBiQcBAQGBazMdh?=
 =?us-ascii?q?BIBg1IkggIFjESCFoERgxKDHgICGIEUARIBAxGFawKjJwcChzqLESGSby2KC?=
 =?us-ascii?q?IIKgzeMJwIEAgQFAhSBTAGBF3FwgzwfggkOCROCTYRcgSOFP0ABMQEBFgGNK?=
 =?us-ascii?q?YEfgR8BAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Feb 2019 09:21:07 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DF93i4167267;
        Wed, 13 Feb 2019 10:21:07 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0b-00154901.pphosted.com with ESMTP id 2qmfjnj5jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 10:21:07 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps301.us.dell.com ([143.166.148.223])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Feb 2019 21:21:04 +0600
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.58,365,1544508000"; 
   d="scan'208";a="298516938"
To:     <rajneesh.bhardwaj@linux.intel.com>,
        <platform-driver-x86@vger.kernel.org>
CC:     <dvhart@infradead.org>, <andy@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 10/10] platform/x86: intel_pmc_core: Quirk to ignore
 XTAL shutdown
Thread-Topic: [PATCH v2 10/10] platform/x86: intel_pmc_core: Quirk to ignore
 XTAL shutdown
Thread-Index: AQHUw65YJewVHsujtECWgZKIfqaASKXd13Yg
Date:   Wed, 13 Feb 2019 15:21:03 +0000
Message-ID: <939c9bf7f0f3443b8cea8b1af7418158@ausx13mpc120.AMER.DELL.COM>
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
 <20190213150810.32750-11-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20190213150810.32750-11-rajneesh.bhardwaj@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Rajneesh Bhardwaj
> Sent: Wednesday, February 13, 2019 9:08 AM
> To: platform-driver-x86@vger.kernel.org
> Cc: dvhart@infradead.org; andy@infradead.org; linux-kernel@vger.kernel.or=
g;
> Rajneesh Bhardwaj
> Subject: [PATCH v2 10/10] platform/x86: intel_pmc_core: Quirk to ignore X=
TAL
> shutdown
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On some platforms such as HP Elite-x2-1013-g3, the platform BIOS
> enforces XTAL to remain off before S0ix state can be achieved. This may
> not be optimum when we want to enable use cases like Low Power Audio,
> Wake on Voice etc which always need 24mhz clock.
>=20
> This introduces a new quirk to allow S0ix entry when all other
> conditions except for XTAL clock are good on a given platform. The extra
> power consumed by XTAL clock is about 2mw but it saves much more
> platform power compared to the system that remains in just PC10.
>=20

I wonder are there really any use cases for 24 mhz clock "needing" to stay
enabled on Linux over a S0ix cycle and factor into the S0ix state decision?

Is it perhaps better to set this as default behavior and quirk situations t=
hat it
may not be needed.

> Link: https://bit.ly/2UmnrFf
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D201579
> Tested-by: "David E. Box" <david.e.box@linux.intel.com>
> Reported-and-tested-by: russianneuromancer <russianneuromancer@ya.ru>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 34 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel_pmc_core.h |  5 ++++
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel_pmc_core.c
> b/drivers/platform/x86/intel_pmc_core.c
> index 4e7aa1711148..a27574e3e868 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -151,6 +152,7 @@ static const struct pmc_reg_map spt_reg_map =3D {
>  	.pm_cfg_offset =3D SPT_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit =3D SPT_PMC_READ_DISABLE_BIT,
>  	.ltr_ignore_max =3D SPT_NUM_IP_IGN_ALLOWED,
> +	.pm_vric1_offset =3D SPT_PMC_VRIC1_OFFSET,
>  };
>=20
>  /* Cannonlake: PGD PFET Enable Ack Status Register(s) bitmap */
> @@ -821,6 +823,37 @@ static const struct pci_device_id pmc_pci_ids[] =3D =
{
>  	{ 0, },
>  };
>=20
> +/*
> + * This quirk can be used on those platforms where
> + * the platform BIOS enforces 24Mhx Crystal to shutdown
> + * before PMC can assert SLP_S0#.
> + */
> +int quirk_xtal_ignore(const struct dmi_system_id *id)
> +{
> +	struct pmc_dev *pmcdev =3D &pmc;
> +	u32 value;
> +
> +	value =3D pmc_core_reg_read(pmcdev, pmcdev->map->pm_vric1_offset);
> +	/* 24MHz Crystal Shutdown Qualification Disable */
> +	value |=3D SPT_PMC_VRIC1_XTALSDQDIS;
> +	/* Low Voltage Mode Enable */
> +	value &=3D ~SPT_PMC_VRIC1_SLPS0LVEN;
> +	pmc_core_reg_write(pmcdev, pmcdev->map->pm_vric1_offset, value);
> +	return 0;
> +}
> +
> +static const struct dmi_system_id pmc_core_dmi_table[]  =3D {
> +	{
> +	.callback =3D quirk_xtal_ignore,
> +	.ident =3D "HP Elite x2 1013 G3",
> +	.matches =3D {
> +		DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite x2 1013 G3"),
> +		},
> +	},
> +	{}
> +};
> +
>  static int __init pmc_core_probe(void)
>  {
>  	struct pmc_dev *pmcdev =3D &pmc;
> @@ -862,6 +895,7 @@ static int __init pmc_core_probe(void)
>  		return err;
>  	}
>=20
> +	dmi_check_system(pmc_core_dmi_table);
>  	pr_info(" initialized\n");
>  	return 0;
>  }
> diff --git a/drivers/platform/x86/intel_pmc_core.h
> b/drivers/platform/x86/intel_pmc_core.h
> index 6f1b64808075..88d9c0653a5f 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -25,6 +25,7 @@
>  #define SPT_PMC_MTPMC_OFFSET			0x20
>  #define SPT_PMC_MFPMC_OFFSET			0x38
>  #define SPT_PMC_LTR_IGNORE_OFFSET		0x30C
> +#define SPT_PMC_VRIC1_OFFSET			0x31c
>  #define SPT_PMC_MPHY_CORE_STS_0			0x1143
>  #define SPT_PMC_MPHY_CORE_STS_1			0x1142
>  #define SPT_PMC_MPHY_COM_STS_0			0x1155
> @@ -136,6 +137,9 @@ enum ppfear_regs {
>  #define SPT_PMC_BIT_MPHY_CMN_LANE2		BIT(2)
>  #define SPT_PMC_BIT_MPHY_CMN_LANE3		BIT(3)
>=20
> +#define SPT_PMC_VRIC1_SLPS0LVEN			BIT(13)
> +#define SPT_PMC_VRIC1_XTALSDQDIS		BIT(22)
> +
>  /* Cannonlake Power Management Controller register offsets */
>  #define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
>  #define CNP_PMC_PM_CFG_OFFSET			0x1818
> @@ -224,6 +228,7 @@ struct pmc_reg_map {
>  	const int pm_read_disable_bit;
>  	const u32 slps0_dbg_offset;
>  	const u32 ltr_ignore_max;
> +	const u32 pm_vric1_offset;
>  };
>=20
>  /**
> --
> 2.17.1

