Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB12BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7838D21725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OnbCFdHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7838D21725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeHNXPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:15:35 -0400
Received: from mail-sn1nam01on0061.outbound.protection.outlook.com ([104.47.32.61]:6752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728395AbeHNXPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NETDA6cusytInkLEnnpHqQqdzPY/uiCsCDE+jmd/Dm4=;
 b=OnbCFdHePA7P4wDPWOxGiDtUxDsvazYFWeu67CoReI1X+TKNDL++3fU5Hk7Ub+mv9qUCtxCrcgIkOMSoekSeP9oM2TPvrZThyjuzg63Wu3ps9CqyDPySy6O70fQW/qx9zzCG3q4NxTVO3hkHyyUny0Ep4hZdsGJTASNCKcqIMLs=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2658.namprd12.prod.outlook.com (20.176.176.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Tue, 14 Aug 2018 20:26:41 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96%4]) with mapi id 15.20.1017.020; Tue, 14 Aug 2018
 20:26:41 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Michael Jin <mikhail.jin@gmail.com>, Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC, amd64: Add Family 17h Model 11h support.
Thread-Topic: [PATCH] EDAC, amd64: Add Family 17h Model 11h support.
Thread-Index: AQHUMOGKCznn3oYSnESXW9QVdJskBqS/tCyA
Date:   Tue, 14 Aug 2018 20:26:41 +0000
Message-ID: <BN7PR12MB2593F278911BAF74943245F8F8380@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180810193623.24629-1-mikhail.jin@gmail.com>
In-Reply-To: <20180810193623.24629-1-mikhail.jin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2658;20:ttaBCWWkd8eNz10rlWzinFlSOgeu29gMqgbU2YPX6hn+ndKNxZEb8LTYxRlbacEsa6K7qwpYQSkUwcAPG6uCI0+JCNa9u3TlRjgMDCTLRLH0FVzSLAlynJVES68Go75H8sVKblDkTZ0rzNbBtAW1oYywgUwLBJtTVLgmdcRlqgqVPpbk60UGs7pDY0drHiJihRIeB0RcsJz7DPFsNDSitEGVUwQi/cnz32R3kWmjYR2w56P1n+mDfwKp4psUmvAF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 291573ee-9a97-4add-8220-08d602243ecd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2658;
x-ms-traffictypediagnostic: BN7PR12MB2658:
x-microsoft-antispam-prvs: <BN7PR12MB2658D4C762BAA7DE3A083F19F8380@BN7PR12MB2658.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR12MB2658;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2658;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(13464003)(199004)(6116002)(72206003)(97736004)(5660300001)(14454004)(99286004)(54906003)(6246003)(68736007)(478600001)(39060400002)(105586002)(316002)(76176011)(7696005)(106356001)(7736002)(3846002)(74316002)(33656002)(305945005)(110136005)(5250100002)(55016002)(8936002)(26005)(446003)(53936002)(229853002)(53546011)(2900100001)(6506007)(102836004)(6436002)(9686003)(25786009)(8676002)(4326008)(86362001)(14444005)(81156014)(486006)(66066001)(81166006)(256004)(476003)(11346002)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2658;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ewQL/+JUMK0nfGkQobBO5NkcK7vgUXrWcHLK1vshElf7N56KipWJSFwzvsIWwdmEiLIkqrV/gpj2ZdVrLGprQNOUaVhQz+QYrkPDEK04/8eeGa1XYyUocfHhqbOX0tjjieanyeYV25Ljk8fsikXmGnGc40zPyY+8OuTzndd62ctxLO+3tQKgsoDvLHe3ajKZxda0aK3PsfjNUDbwwKhutuX6vKt+hjEfDFNbMC9SIF3q/NYxgVzHRLnl/6dnJpweQCgoRU7JMSFvmzke6kJwSsuyeiYJia9jHHqGoP4Ii8SlrRc3BIPhmWK5sKLqT3VYfKbg7FxrdR7RvBqkP08axfQRnCH6PzLeUo+zWOZEBMw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291573ee-9a97-4add-8220-08d602243ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 20:26:41.2715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michael Jin <mikhail.jin@gmail.com>
> Sent: Friday, August 10, 2018 2:36 PM
> To: Borislav Petkov <bp@suse.de>; Ghannam, Yazen
> <Yazen.Ghannam@amd.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Jin
> <mikhail.jin@gmail.com>
> Subject: [PATCH] EDAC, amd64: Add Family 17h Model 11h support.
>=20
> Add support for ECC error decoding for F17h M11h (Great Horned Owl)
> processors.
>=20
> Signed-off-by: Michael Jin <mikhail.jin@gmail.com>
> ---
>  drivers/edac/amd64_edac.c | 14 ++++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 18aeabb1d5ee..de077c1f5ae3 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2200,6 +2200,15 @@ static struct amd64_family_type family_types[] =3D=
 {
>  			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
>  		}
>  	},
> +	[F17_M11H_CPUS] =3D {
> +		.ctl_name =3D "F17h_M11h",
> +		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M11H_DF_F0,
> +		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M11H_DF_F6,
> +		.ops =3D {
> +			.early_channel_count	=3D f17_early_channel_count,
> +			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
> +		}
> +	},
>  };
>=20
>  /*
> @@ -3188,6 +3197,11 @@ static struct amd64_family_type
> *per_family_init(struct amd64_pvt *pvt)
>  		break;
>=20
>  	case 0x17:
> +		if (pvt->model =3D=3D 0x11) {

I think we can expand this to include more models. Please see comment
below.

There may be some differences between models, but things should generally
work. It's just a matter of whether or not the Platform enables certain thi=
ngs
like DRAM ECC, etc.

Does the amd64_edac_mod module load on your platform with just this patch?

> +			fam_type =3D &family_types[F17_M11H_CPUS];
> +			pvt->ops =3D &family_types[F17_M11H_CPUS].ops;
> +			break;
> +		}
>  		fam_type	=3D &family_types[F17_CPUS];
>  		pvt->ops	=3D &family_types[F17_CPUS].ops;
>  		break;
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 1d4b74e9a037..e50226cd53c6 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -115,6 +115,8 @@
>  #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F2 0x1582
>  #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
>  #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
> +#define PCI_DEVICE_ID_AMD_17H_M11H_DF_F0 0x15e8
> +#define PCI_DEVICE_ID_AMD_17H_M11H_DF_F6 0x15ee
>=20

These IDs are used for Fam17h Models 10h-2Fh. Can you please change
the names here and in the rest of this patch?

The format is to use the first supported model in the name, e.g. M11H -> M1=
0H.

>  /*
>   * Function 1 - Address Map
> @@ -281,6 +283,7 @@ enum amd_families {
>  	F16_CPUS,
>  	F16_M30H_CPUS,
>  	F17_CPUS,
> +	F17_M11H_CPUS,
>  	NUM_FAMILIES,
>  };
>=20

Thanks,
Yazen
