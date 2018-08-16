Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A8EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EB821480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G9ayk57m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EB821480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeHPVRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:17:46 -0400
Received: from mail-eopbgr680066.outbound.protection.outlook.com ([40.107.68.66]:49576
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbeHPVRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w8btVQ1PT4RJBbod6NY5NfhdEF+G0U5irrxHxoZ6cM=;
 b=G9ayk57mfizKMEl4PUPAq7yjpVcWIcZ5PH5l9L7ZuTzH2bzleYinXVW+Mj+a4ZEX/+IuYwSPS1HAX2oD1Hl0nOGev3Am3sBrQZuScE+iZFv/zPS6SAbz4v8Y0Cyh9ASwsTYfUpeFVDFCyS1PFKziG3HU5+j8HPve3ZQGl3X4ODY=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 16 Aug 2018 18:17:43 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96%4]) with mapi id 15.20.1017.020; Thu, 16 Aug 2018
 18:17:43 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Michael Jin <mikhail.jin@gmail.com>, Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH V2] EDAC, amd64: Add Family 17h Model 10h support.
Thread-Topic: [PATCH V2] EDAC, amd64: Add Family 17h Model 10h support.
Thread-Index: AQHUNIzjACRAwj0HZkCccL/9TlZhkqTCrdPQ
Date:   Thu, 16 Aug 2018 18:17:43 +0000
Message-ID: <BN7PR12MB2593B097267132250140FBEAF83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180815114107.29797-1-mikhail.jin@gmail.com>
In-Reply-To: <20180815114107.29797-1-mikhail.jin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:a156:973f:d5f1:b585]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2593;20:SnHQPhw2DOWUa4BIe+ILFiSX05JAE5P5JzByB1DYT0kcr7Jx6BKY94HJ+2BRRXj7EoFl+IO+rCyhfXZaqoRjuUl6Jasjl+lacMHWoAFL+sfbDD4SiwAq03SkZHa0SWdjB9yBiFW/7nsJNzk648m9rAka1FtOOet6gJVb9rxaZUIulK0+ZaQ24OZtS8tGFkhCNIUZ/CId5XoGBBpbuYjmPfTGU0YR0rj0GrCrrBMn1GERFEZ57BaXeuK+1Lf4Iomx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 73425c68-8dfd-4bff-85fc-08d603a48f6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2593;
x-ms-traffictypediagnostic: BN7PR12MB2593:
x-microsoft-antispam-prvs: <BN7PR12MB2593CCBC774F2BDACF59F87CF83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110)(42068640409301);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:BN7PR12MB2593;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2593;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(13464003)(105586002)(316002)(39060400002)(99286004)(33656002)(106356001)(2900100001)(4326008)(97736004)(54906003)(5660300001)(25786009)(110136005)(966005)(14454004)(72206003)(478600001)(53936002)(81156014)(6306002)(6436002)(446003)(7696005)(46003)(81166006)(9686003)(256004)(55016002)(6116002)(186003)(6506007)(76176011)(229853002)(305945005)(486006)(8676002)(6246003)(5250100002)(86362001)(8936002)(68736007)(7736002)(11346002)(476003)(53546011)(102836004)(74316002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2593;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VdHXtHfzkRAGP2its1+5fG4hgX+4sdw5K3bZARk1/YouHpvSyURSrS+BDINDwqiILqbhWv0eqDJFbbKjl6t8stBDJlCFT++CYzOnmGI6VknXy+jee5QRg2OhAJaHk71cL7Y252UGubl/VG63HpkHOkV1B1YPGo3d9hf5y9gReXUjiKD291WFlR+DSWenq57exXlN+etiRyGZug4M2PcDmQHkJdSqgqvEWrru4KtUpfLFcMX7/PFUA+LgFv7flnPlmfU4hbSVbhxTHltZjHG1xIHd4DAta37X0QDoTKYO2bimxXftQO102jbnT776m6PeJ9v/t5yd6bG6IWekhlXF52dPRJBWy3D1FF5+qzxZhMI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73425c68-8dfd-4bff-85fc-08d603a48f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 18:17:43.3236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michael Jin <mikhail.jin@gmail.com>
> Sent: Wednesday, August 15, 2018 6:41 AM
> To: Borislav Petkov <bp@suse.de>; Ghannam, Yazen
> <Yazen.Ghannam@amd.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Jin
> <mikhail.jin@gmail.com>; stable@vger.kernel.org
> Subject: [PATCH V2] EDAC, amd64: Add Family 17h Model 10h support.
>=20
> Add support for ECC error decoding on family 17h models 10h-2fh.
>=20

Can you please make this more specific? Something like "Add PCI device IDs
for Fam17h Models 10h-2Fh so that amd64_edac_mod will load".

> Link: https://lkml.kernel.org/r/20180810193623.24629-1-
> mikhail.jin@gmail.com
> Cc: stable@vger.kernel.org

This won't apply to all stable branches. EDAC support for Fam17h was added
in v4.10.

I'm not sure if the stable tag needs to be modified, or if the stable queue=
s
automatically drop patches that don't apply.

> Signed-off-by: Michael Jin <mikhail.jin@gmail.com>
> ---
>  drivers/edac/amd64_edac.c | 15 +++++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 18aeabb1d5ee..2d7b6d37d6ec 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2200,6 +2200,15 @@ static struct amd64_family_type family_types[] =3D=
 {
>  			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
>  		}
>  	},
> +	[F17_M10H_CPUS] =3D {
> +		.ctl_name =3D "F17h_M10h",
> +		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
> +		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
> +		.ops =3D {
> +			.early_channel_count	=3D f17_early_channel_count,
> +			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
> +		}
> +	},
>  };
>=20
>  /*
> @@ -3188,6 +3197,12 @@ static struct amd64_family_type
> *per_family_init(struct amd64_pvt *pvt)
>  		break;
>=20
>  	case 0x17:
> +		/* Check if CPU model is in range 10h-2fh */

This comment is not needed because it's obvious from the code.

> +		if (pvt->model >=3D 0x10 && pvt->model <=3D 0x2f) {
> +			fam_type =3D &family_types[F17_M10H_CPUS];
> +			pvt->ops =3D &family_types[F17_M10H_CPUS].ops;
> +			break;
> +		}
>  		fam_type	=3D &family_types[F17_CPUS];
>  		pvt->ops	=3D &family_types[F17_CPUS].ops;
>  		break;
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 1d4b74e9a037..4242f8e39c18 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -115,6 +115,8 @@
>  #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F2 0x1582
>  #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
>  #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
> +#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
> +#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
>=20
>  /*
>   * Function 1 - Address Map
> @@ -281,6 +283,7 @@ enum amd_families {
>  	F16_CPUS,
>  	F16_M30H_CPUS,
>  	F17_CPUS,
> +	F17_M10H_CPUS,
>  	NUM_FAMILIES,
>  };
>=20
> --

Other than those few nits this looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
