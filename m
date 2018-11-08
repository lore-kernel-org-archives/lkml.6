Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62903C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1429D2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dCGK03IH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1429D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeKHPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:45:50 -0500
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:58977
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbeKHPpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5Aut2nYIJ1JI6X0MRkNF/1Jm3dlehTXJU0RcqKZYQo=;
 b=dCGK03IHTTys/EB1Ak2HWJ0i32VT3RBy+wt5x6B2WLu0ZIRysW1thFIS9TdbE/T+eAp5Pt1ZicFWKx3pf0btdgpOd5tMLcvp2U+SfE1GX6zQpp7eTjJH60Uw8ibgcmny0nvAkkuqmA6CBe4NS78DkAF1fkEOWv4yXRWbulWeIc8=
Received: from BY2PR12MB0040.namprd12.prod.outlook.com (10.160.66.15) by
 BY2PR12MB0353.namprd12.prod.outlook.com (10.162.84.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Thu, 8 Nov 2018 06:11:54 +0000
Received: from BY2PR12MB0040.namprd12.prod.outlook.com
 ([fe80::1146:ddb5:347a:da]) by BY2PR12MB0040.namprd12.prod.outlook.com
 ([fe80::1146:ddb5:347a:da%3]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 06:11:51 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next] drm/ttm: remove set but not used variable 'driver'
Thread-Topic: [PATCH -next] drm/ttm: remove set but not used variable 'driver'
Thread-Index: AQHUdweEMzWuSL3jNEGVwg6h9QxOfKVFZbJQ
Date:   Thu, 8 Nov 2018 06:11:51 +0000
Message-ID: <BY2PR12MB0040B73B02AD39434F410677ECC50@BY2PR12MB0040.namprd12.prod.outlook.com>
References: <1541643300-109641-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1541643300-109641-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR12MB0353;20:UWLvDaT72NOFS3qJ+If85nA1T9mPkB/u5rUoR+A2oz12EBG2kElfH/ibtoUVxUGZpM0iZhGkIEVzRb0DzO1pAGVppnt1GybBXTubUH5S3r3hKPkcHFbEXQkieQdcDTgvoZIqDJeaSkmcopFilZrrq4Art2IaEePSXLKNSDlcC16xoNeRq3Q4pf5qn0war/DouVAzjR+XOjjj03yZ1aSYG59gAtsv9q7/Nd9vataQMKpzAVoRR5QfK6Dc5/I8QDLO
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(13464003)(189003)(199004)(229853002)(6246003)(33656002)(186003)(256004)(105586002)(74316002)(6116002)(97736004)(106356001)(55016002)(7736002)(3846002)(53546011)(7696005)(478600001)(81156014)(6436002)(26005)(8676002)(81166006)(25786009)(76176011)(72206003)(14454004)(9686003)(8936002)(4326008)(71190400001)(53936002)(2906002)(305945005)(6506007)(102836004)(110136005)(316002)(11346002)(54906003)(86362001)(5660300001)(476003)(68736007)(446003)(99286004)(66066001)(71200400001)(14444005)(2900100001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0353;H:BY2PR12MB0040.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 12b3c515-acbe-43da-20db-08d645411305
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0353;
x-ms-traffictypediagnostic: BY2PR12MB0353:
x-microsoft-antispam-prvs: <BY2PR12MB03531C5BADB4830F95F6F8BAECC50@BY2PR12MB0353.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(217544274631240)(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR12MB0353;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0353;
x-forefront-prvs: 0850800A29
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FmM8fbeLPQV+aeG6vnpbw1fTqapRKbYZud/fJTgoNvGsU223/k7VHHYrUlkc8ZlR35TLEr1Q9iu/sFclHjUoAzSXW724lyOCpfeatQdI582X0eqY0T+u9pqUVH7dZbLntYefzDJVvCB8HbgKSJn/W533wMuLqGrsuGd9QsWR+Y9Q/sOS6drntjXyWFFTWCn7A+yDPw9s2zCQGSIMaAUtPKxB/RIhVm/fi+6PfR7+fuwfOCOGlVRBAMMGjOeGc43rxvKp/VAW6ZjJnfIMWU1zhnQKKPWXxgO0wo82BYYIUUzJNmgWSiGA033JK64xP7LvVoLLorhFiFcLyk/C2qcM+SzlFVvmPzHFNbO1dwODxk8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b3c515-acbe-43da-20db-08d645411305
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 06:11:51.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: YueHaibing [mailto:yuehaibing@huawei.com]
> Sent: Thursday, November 08, 2018 10:15 AM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Zhang, Jerry <Jerry.Zhang@amd.com>; David Airlie
> <airlied@linux.ie>
> Cc: YueHaibing <yuehaibing@huawei.com>; dri-devel@lists.freedesktop.org;
> linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH -next] drm/ttm: remove set but not used variable 'driver'
>=20
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/gpu/drm/ttm/ttm_execbuf_util.c: In function
> 'ttm_eu_fence_buffer_objects':
> drivers/gpu/drm/ttm/ttm_execbuf_util.c:190:24: warning:
>  variable 'driver' set but not used [-Wunused-but-set-variable]
>=20
> It not used any more after
> commit f2c24b83ae90 ("drm/ttm: flip the switch, and convert to dma_fence"=
)
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/ttm/ttm_execbuf_util.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> index e493edb..efa005a 100644
> --- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> @@ -187,14 +187,12 @@ void ttm_eu_fence_buffer_objects(struct
> ww_acquire_ctx *ticket,
>  	struct ttm_buffer_object *bo;
>  	struct ttm_bo_global *glob;
>  	struct ttm_bo_device *bdev;
> -	struct ttm_bo_driver *driver;
>=20
>  	if (list_empty(list))
>  		return;
>=20
>  	bo =3D list_first_entry(list, struct ttm_validate_buffer, head)->bo;
>  	bdev =3D bo->bdev;
> -	driver =3D bdev->driver;
>  	glob =3D bo->bdev->glob;
>=20
>  	spin_lock(&glob->lru_lock);
>=20
>=20

