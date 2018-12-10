Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02381C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4572082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p8DIaTwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4572082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeLJCtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:49:43 -0500
Received: from mail-eopbgr720067.outbound.protection.outlook.com ([40.107.72.67]:15968
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbeLJCtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 21:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXK/MQq8X8yiLZ1JFyRZYvflfDjI62b4F2rGTT6XF+w=;
 b=p8DIaTwaE3w6clWTqoKkVAhldjeYNrp82a3nkFKGgeOaSfKiCGwA4br2t+opsv6tn6W3PHfHkdoJXXVJJwCB+paWg5v1mrfy7YZPvW94e9Agkvw7QjcUdYMK6mmIdECW0a+nN/B3p24dn6hDTUR67izh7sGgjJ4LZUv9Og2SDdQ=
Received: from BY1PR12MB0502.namprd12.prod.outlook.com (10.162.147.154) by
 BY1PR12MB0437.namprd12.prod.outlook.com (10.162.147.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Mon, 10 Dec 2018 02:48:59 +0000
Received: from BY1PR12MB0502.namprd12.prod.outlook.com
 ([fe80::c5af:77ee:6794:cf8d]) by BY1PR12MB0502.namprd12.prod.outlook.com
 ([fe80::c5af:77ee:6794:cf8d%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 02:48:54 +0000
From:   "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Liu, Leo" <Leo.Liu@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
        "Panariti, David" <David.Panariti@amd.com>,
        "S, Shirish" <Shirish.S@amd.com>, "Zhu, Rex" <Rex.Zhu@amd.com>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next] drm/amdgpu: remove set but not used variable
 'grbm_soft_reset'
Thread-Topic: [PATCH -next] drm/amdgpu: remove set but not used variable
 'grbm_soft_reset'
Thread-Index: AQHUjwXDkuFPcePe0UW6yGLn1g/ryKV3R4dA
Date:   Mon, 10 Dec 2018 02:48:53 +0000
Message-ID: <BY1PR12MB0502FCF4962034F06F9576DAB4A50@BY1PR12MB0502.namprd12.prod.outlook.com>
References: <1544281273-73940-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1544281273-73940-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR12MB0437;20:Sgjwf4AY5Zd+CFXUkZ673ND6mDlh6pQYJmN1uWkVIw6uu9oYxqdxY1GCBFrDV6JG9TuaoFP7N4BjTOVg4HZuKyzJsunc2HEdfKU8naWdP4+QUj3AdrypWuJOwMDx47vkIuA/XF7VbiLqfO1cLSdSdNIYAtFGy8gCHuplIj3qgQDC65uYrpHnCLpiZs/xjtufy+2gA8jHUQAOEL3oGfK+zmIzZcyxon/Yr5hRntl4hTBeeAifwNm5J4mOwwLUVyl5
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(346002)(136003)(199004)(189003)(13464003)(102836004)(55016002)(97736004)(33656002)(66066001)(25786009)(316002)(53936002)(2906002)(3846002)(68736007)(6116002)(74316002)(54906003)(478600001)(110136005)(6506007)(305945005)(7696005)(7736002)(4326008)(72206003)(6436002)(53546011)(8676002)(81156014)(9686003)(8936002)(81166006)(71200400001)(6246003)(229853002)(99286004)(575784001)(6636002)(71190400001)(446003)(86362001)(476003)(186003)(14454004)(106356001)(26005)(5660300001)(76176011)(105586002)(486006)(2501003)(256004)(14444005)(11346002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR12MB0437;H:BY1PR12MB0502.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 97f8205a-a07d-4b2b-d5fd-08d65e4a0607
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY1PR12MB0437;
x-ms-traffictypediagnostic: BY1PR12MB0437:
x-microsoft-antispam-prvs: <BY1PR12MB04379DC0A139FC746B71E704B4A50@BY1PR12MB0437.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR12MB0437;BCL:0;PCL:0;RULEID:;SRVR:BY1PR12MB0437;
x-forefront-prvs: 08828D20BC
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zD0btrbEz5hBZf24AHWW0wCsqGIMkDxeqbAQ3bYkco4B70H1DWRTn+cxOhjYrGMSXgKCZQd7w1HVpAHFzRNFPAly4Js1smy3n3A/RGDg/FIHBWjYYYSSVT4O7pign6w3Z2Tvi0Ntl0J905vHo0yD6qAQjpnKK84LQ0tY0eLDzy1IjKpoCmdqyMZPIJPj536gvVEGrLStRDFmEW8+8AWerQToyEd/Og5NX04adjvbX7IQ7Fescup0YuJiFAlFJ2lCh/ccklHbL/yVyJ9r5mygHpa3RHIFJ2SS6Xe8pq8AjQIIaZcDWUCipzyIhSxQ8inI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f8205a-a07d-4b2b-d5fd-08d65e4a0607
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 02:48:53.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB0437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Saturday, December 08, 2018 11:01 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>; airlied@linux.ie; Liu, Leo <Leo.Liu@amd.com>;
> Gao, Likun <Likun.Gao@amd.com>; Panariti, David
> <David.Panariti@amd.com>; S, Shirish <Shirish.S@amd.com>; Zhu, Rex
> <Rex.Zhu@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Cc: YueHaibing <yuehaibing@huawei.com>; amd-gfx@lists.freedesktop.org;
> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: [PATCH -next] drm/amdgpu: remove set but not used variable
> 'grbm_soft_reset'
>=20
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function
> 'gfx_v8_0_pre_soft_reset':
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:4950:27: warning:
>  variable 'srbm_soft_reset' set but not used [-Wunused-but-set-variable]
>=20
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function
> 'gfx_v8_0_post_soft_reset':
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:5054:27: warning:
>  variable 'srbm_soft_reset' set but not used [-Wunused-but-set-variable]
>=20
> It never used since introduction in commit d31a501ead7f ("drm/amdgpu: add
> pre_soft_reset ip func") and e4ae0fc33631 ("drm/amdgpu: implement
> gfx8 post_soft_reset")
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Chunming Zhou <david1.zhou@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 1454fc3..8c1ba79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4947,14 +4947,13 @@ static bool gfx_v8_0_check_soft_reset(void
> *handle)  static int gfx_v8_0_pre_soft_reset(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -	u32 grbm_soft_reset =3D 0, srbm_soft_reset =3D 0;
> +	u32 grbm_soft_reset =3D 0;
>=20
>  	if ((!adev->gfx.grbm_soft_reset) &&
>  	    (!adev->gfx.srbm_soft_reset))
>  		return 0;
>=20
>  	grbm_soft_reset =3D adev->gfx.grbm_soft_reset;
> -	srbm_soft_reset =3D adev->gfx.srbm_soft_reset;
>=20
>  	/* stop the rlc */
>  	adev->gfx.rlc.funcs->stop(adev);
> @@ -5051,14 +5050,13 @@ static int gfx_v8_0_soft_reset(void *handle)
> static int gfx_v8_0_post_soft_reset(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -	u32 grbm_soft_reset =3D 0, srbm_soft_reset =3D 0;
> +	u32 grbm_soft_reset =3D 0;
>=20
>  	if ((!adev->gfx.grbm_soft_reset) &&
>  	    (!adev->gfx.srbm_soft_reset))
>  		return 0;
>=20
>  	grbm_soft_reset =3D adev->gfx.grbm_soft_reset;
> -	srbm_soft_reset =3D adev->gfx.srbm_soft_reset;
>=20
>  	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET,
> SOFT_RESET_CP) ||
>  	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET,
> SOFT_RESET_CPF) ||
>=20
>=20

