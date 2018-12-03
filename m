Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B7FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD55B208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD55B208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeLCSIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:08:04 -0500
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:2800
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbeLCSIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45sFo2VV5KbkW4+aCsB6GfVhjUsX8YMI9jNJCAuhhLE=;
 b=P8vBwK4rafQNNEyBB6m+dVCg4AqyCQJk+C7FmwgpsA57hdk92yox8+xE5qN8aAQXolcSDZR/f43NQhcyGZbV9vKJLZ/+qANpB+SZD27XWEKp/yOLHvLCWCwC3kGpiGVqUEUxaKgRcdd0Is7MLX8N8EDo4MN9/M+oBcFyJn+NIm0=
Received: from CO2PR07MB2712.namprd07.prod.outlook.com (10.166.214.13) by
 CO2PR07MB2486.namprd07.prod.outlook.com (10.166.200.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 18:07:58 +0000
Received: from CO2PR07MB2712.namprd07.prod.outlook.com
 ([fe80::499e:aadb:e2af:798a]) by CO2PR07MB2712.namprd07.prod.outlook.com
 ([fe80::499e:aadb:e2af:798a%7]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 18:07:57 +0000
From:   "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
To:     Thomas Meyer <thomas@m3y3r.de>
CC:     Dept-Eng QLA2xxx Upstream <qla2xxx-upstream@cavium.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH] scsi: qla2xxx: NULL check before some freeing
 functions is not needed.
Thread-Topic: [EXT] [PATCH] scsi: qla2xxx: NULL check before some freeing
 functions is not needed.
Thread-Index: AQHUizMeyb+6S5TEJk6ThC5h/iLVGw==
Date:   Mon, 3 Dec 2018 18:07:57 +0000
Message-ID: <E79150BB-BD16-4A01-9938-761303E15B3B@cavium.com>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
 <1543760930052-275330559-13-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930052-275330559-13-diffsplit-thomas@m3y3r.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Himanshu.Madhani@cavium.com; 
x-originating-ip: [198.186.1.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2486;6:Gv92mbDp+QcwVdyHmvUjIWh+FPG21TsrDaCqwy6jzuQQgj6tQ8AWQew5bOcu6zqJv5zINmxtMxH5YRZHzM08WDaG/sIrY4vg9H6Jof3xu3lsYN2CJLO1yOS3n2LrYjv59PsT5teXU9t8E98M6xyRvqM/nuf7DTIHPIaKRmBDSULSHoxWGZ5V+rngP4VDveQRmouwKJ0vf82bbA1pjJbbw+63AdfSlUKoR+dcgCdAqfHmM7gHfK5lPbyElDSFjPHKNFrhBW2AZmENes80ufdwMr5rAWDNvcQdEpYXXgT5Exm/7YbT4Os/VbMYWAWpMbQ5Or+rjZAC/zGeQT6/Tgrj41X+e4RtpZTbzvnfx8AMWIRzS93X7xK19dJUKEzeTf/T/StJf98dvogwfxLbHHA+BnZMLGAvCu1hS2deoIhijrOJR/ELuXcO1rYtEXFtUL1+hezZmczRla4+KFAh1XBrtg==;5:5g9yrhz4QxW8YXvRSMlxx1aJWSiHNT9UCS/UufFbtnQ3Qk+cJwMKA4F0J2lU8vuiGx+E12k6XUV+Rkc+c8NHsGYydG5DVHKMY0lJN2VB9v7TLOPrV/FsSlpr7aHFqJOBeeEYinblRWP3sKHFEg/eHvPKHuMvauBD0EhXv2uKgdk=;7:RaMgHduwSCW2E72dIS8FkZ2l7ag8pc3w/qv0Po/H6IHV2DCPhcJPOVhtMkKuwv2E34+23cESkmAfz2rPk/nZin9WN1Iu3/vzv4oHndV4rQI1ov0SYN6p3c3Yg33lmOTFplJ5o2oMLckbUVD0rEjWRw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 340431f2-db88-4f10-d97b-08d6594a4138
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2486;
x-ms-traffictypediagnostic: CO2PR07MB2486:
x-microsoft-antispam-prvs: <CO2PR07MB2486C944629FF092649C72C8F5AE0@CO2PR07MB2486.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB2486;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2486;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(25786009)(186003)(256004)(6116002)(105586002)(11346002)(54906003)(478600001)(72206003)(97736004)(6512007)(106356001)(486006)(2616005)(316002)(446003)(53936002)(86362001)(2906002)(4326008)(8676002)(6246003)(8936002)(36756003)(3846002)(76176011)(83716004)(81166006)(6506007)(81156014)(6436002)(6916009)(66066001)(7736002)(71200400001)(71190400001)(6486002)(305945005)(99286004)(102836004)(33656002)(14454004)(82746002)(26005)(476003)(68736007)(53546011)(229853002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2486;H:CO2PR07MB2712.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hRGhRRPYM1kJJv5+OS1Nj2urKgyJWD4dklsd2kmRqzTG0SqWD4cDUsCxoY9pjxUNFq51AdO975UpO6xC02c0gwnnHIP681NyoqxbZuwCHYWzN0/ux3CJK4Dp1MyD8r0Jm4r8BJNRBUgaA4eanEgjGrDJPm/KGYjwndJflMvnK2ucRfg8LH8/RIzkGi/BqQ1B7WRHvk3FUalacQ/6fikZMjBhUqsYLaOVYGyUbwk/gfjKuX1vREqHmssOKyAGw3vZP2vzWqCng/ATukTY7VQ1hfjDKz8+UXHh6IcI1/EhcNQXpokY6DGLLZ3hXPyZr58kfFuZrs9cEhWJV3RH+3mfW1MMpe8f0o1ed5b3pK+TJNM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5F60E2152C76D4C8874DB1503106190@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340431f2-db88-4f10-d97b-08d6594a4138
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 18:07:57.4459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 2, 2018, at 12:52 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> External Email
>=20
> NULL check before some freeing functions is not needed.
>=20
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>=20
> diff -u -p a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.=
c
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -4191,12 +4191,10 @@ fail_free_nvram:
>        kfree(ha->nvram);
>        ha->nvram =3D NULL;
> fail_free_ctx_mempool:
> -       if (ha->ctx_mempool)
> -               mempool_destroy(ha->ctx_mempool);
> +       mempool_destroy(ha->ctx_mempool);
>        ha->ctx_mempool =3D NULL;
> fail_free_srb_mempool:
> -       if (ha->srb_mempool)
> -               mempool_destroy(ha->srb_mempool);
> +       mempool_destroy(ha->srb_mempool);
>        ha->srb_mempool =3D NULL;
> fail_free_gid_list:
>        dma_free_coherent(&ha->pdev->dev, qla2x00_gid_list_size(ha),
> @@ -4498,8 +4496,7 @@ qla2x00_mem_free(struct qla_hw_data *ha)
>                dma_free_coherent(&ha->pdev->dev, MCTP_DUMP_SIZE, ha->mctp=
_dump,
>                    ha->mctp_dump_dma);
>=20
> -       if (ha->srb_mempool)
> -               mempool_destroy(ha->srb_mempool);
> +       mempool_destroy(ha->srb_mempool);
>=20
>        if (ha->dcbx_tlv)
>                dma_free_coherent(&ha->pdev->dev, DCBX_TLV_DATA_SIZE,
> @@ -4531,8 +4528,7 @@ qla2x00_mem_free(struct qla_hw_data *ha)
>        if (ha->async_pd)
>                dma_pool_free(ha->s_dma_pool, ha->async_pd, ha->async_pd_d=
ma);
>=20
> -       if (ha->s_dma_pool)
> -               dma_pool_destroy(ha->s_dma_pool);
> +       dma_pool_destroy(ha->s_dma_pool);
>=20
>        if (ha->gid_list)
>                dma_free_coherent(&ha->pdev->dev, qla2x00_gid_list_size(ha=
),
> @@ -4553,14 +4549,11 @@ qla2x00_mem_free(struct qla_hw_data *ha)
>                }
>        }
>=20
> -       if (ha->dl_dma_pool)
> -               dma_pool_destroy(ha->dl_dma_pool);
> +       dma_pool_destroy(ha->dl_dma_pool);
>=20
> -       if (ha->fcp_cmnd_dma_pool)
> -               dma_pool_destroy(ha->fcp_cmnd_dma_pool);
> +       dma_pool_destroy(ha->fcp_cmnd_dma_pool);
>=20
> -       if (ha->ctx_mempool)
> -               mempool_destroy(ha->ctx_mempool);
> +       mempool_destroy(ha->ctx_mempool);
>=20
>        qlt_mem_free(ha);
>=20
> @@ -7106,8 +7099,7 @@ qla2x00_module_exit(void)
>        qla2x00_release_firmware();
>        kmem_cache_destroy(srb_cachep);
>        qlt_exit();
> -       if (ctx_cachep)
> -               kmem_cache_destroy(ctx_cachep);
> +       kmem_cache_destroy(ctx_cachep);
>        fc_release_transport(qla2xxx_transport_template);
>        fc_release_transport(qla2xxx_transport_vport_template);
> }

Looks good.=20

Acked-by: Himanshu Madhani <hmadhani@marvell.com>

Thanks,
- Himanshu

