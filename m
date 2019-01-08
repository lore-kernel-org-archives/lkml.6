Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BCBC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20D42087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fZfv2Djn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfAHOQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:16:41 -0500
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:9088
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728306AbfAHOQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULlU0bWJvwHv5RhX41k1/IH5kWvb0nuaSJPWQHDOzP4=;
 b=fZfv2DjnsyMPiM5vDu9R6C0x+m8PMiIgp/NYgo3a4rvWI1mCcxSa3sUr0bLTa1qrHt+vPX4v3Ggse8rU9MKQIL1MNKoCDBdBhUH+/ZhSjs3sCMbc9RepfBtdtaDbL5Ue0QeV0CcIwy09uzn39mPYuIr06u4a1bsXVT7qpwc5jdc=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3856.eurprd04.prod.outlook.com (52.134.16.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 14:16:34 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426%6]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 14:16:34 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>
CC:     Jordan Crouse <jcrouse@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] drm/msm/gpu: fix building without debugfs
Thread-Topic: [PATCH 2/2] drm/msm/gpu: fix building without debugfs
Thread-Index: AQHUM0v426xPSDgH20CdWjQ5ujFQeKWmTTvQ
Date:   Tue, 8 Jan 2019 14:16:34 +0000
Message-ID: <VI1PR0402MB2800858E1E94968F584E6CE8E08A0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <20180813212351.2555757-1-arnd@arndb.de>
 <20180813212351.2555757-2-arnd@arndb.de>
In-Reply-To: <20180813212351.2555757-2-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3856;6:B5w/8b2gC2QfVgKMZyeRefxMQZh/MiABJFTodCd0Se+4HA5mi4XeiZTlQliAyBGPQgKGFcsjlYAhOYbDgnjVv46ZJtI6ygrD1j1RoyetpBF3MAChVRG14jhSPACF5UQhIxVGJo1zGAZcpa3vzNsHOCATb1vON7DyIT4hfd2jJEY6JiWl/ojh7Xy7K/5RXxneFrSxjt0gvGULg7ZOyT+NLnimGMzazjVshpMrdj7j7w4pizHy7jwXn5zyJu7a0HHcAe75LIrPvg8jSv5JmH2pU+jJaxbSxaM15dVavTLoHAgppChwp+Ekmclmop2GU8hhfx1RIyt9wjDd405ymnfst/us3Q9Lx1G1DeMNLjs2OuJnsS1Fm8zvPGQAuZuiOmdgEeDSJK3Ix1SxsQkUa9fsz8fdcbjbUXUyIwkcV/Vb8TPt5mYOsS844lHUmK3uGIV2eTP89xyxJkdfL+W7i9jfnA==;5:NZN3XCmhbkdqNHX0xrSA9rjIZphHE+hmzpKrekm1ZrPgM/T+lK+jyV0pMwa8bpoej3eSOJKzexirJjRB96PKC8OJ+Y9dxZYumaWJZNGXRqtW8KHJvLEyjwM6g+FPXC4LQdIhQ0TwNJLjEFC6HVSvFxnsUhsN3tqQXPuo7yURpEy3eFEFXYXO0SYxkSjfc1IMzSeuXfkiuyA8ylgPFtncoQ==;7:8sXNI9BKh/RkxbJeJvhsbuxOj33ONtIEHoC9ea6/ynJNxPMZ23mzTdDJ9s8bAxwyEP5Rs1cIQ2q8B15OjfX50kcCRaFHHaP2YpgWqPW5I/y2li9X3BlnuCLaRrB7aFOsY0Q13swvuzapoKDU6onrcw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cff36736-7b26-44a1-d4ad-08d67573e531
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3856;
x-ms-traffictypediagnostic: VI1PR0402MB3856:
x-microsoft-antispam-prvs: <VI1PR0402MB3856EBDE534F7B0CCB461EA1E08A0@VI1PR0402MB3856.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3856;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3856;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(346002)(39860400002)(199004)(189003)(5660300001)(11346002)(106356001)(486006)(71200400001)(3846002)(2906002)(86362001)(6436002)(44832011)(476003)(229853002)(14444005)(575784001)(39060400002)(6506007)(446003)(55016002)(105586002)(66066001)(6116002)(99286004)(71190400001)(9686003)(68736007)(76176011)(7736002)(110136005)(8676002)(186003)(81166006)(33656002)(305945005)(54906003)(316002)(102836004)(53936002)(6246003)(25786009)(7696005)(4326008)(97736004)(26005)(14454004)(81156014)(256004)(8936002)(478600001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3856;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mzfs6GiC3pTD72x39jjPgQnU7zeYpI8OJn52ysqqyhSFQMBiLIb4/zJj0a9L9G5b5BciOB8u6JwxpmxqmHpBDonIjRKFj2aE2pEPAReLC3yrPww4uJd9XCdi/uyYAFkzY51fG6JbmJY6QRwGtyrKOKHWtnMmPf4YmF9Vom64RxkDoW1kIrBEEVkV+ajVUxFOQ7UemyjWnn/gVRLw6HdRNIMgh1jj48OqBC42vO1Y8A1MJuc1bjk2L4NkcPVacHd2srso9TYpax1rQD/QaqGqu0XYg4jhogjNGBHxl6W2nw30pOdZL9pSrLYsoHQ+jNGe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff36736-7b26-44a1-d4ad-08d67573e531
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 14:16:34.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: [PATCH 2/2] drm/msm/gpu: fix building without debugfs
>=20
> When debugfs is disabled, but coredump is turned on, the adreno driver fa=
ils to
> build:
>=20
> drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:4: error: 'struct msm_gpu_funcs=
'
> has no member named 'show'
>    .show =3D adreno_show,
>     ^~~~
> drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:11: note: (near initialization =
for
> 'funcs.base')
> drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:11: error: initialization of 'v=
oid
> (*)(struct msm_gpu *, struct msm_gem_submit *, struct msm_file_private *)=
'
> from incompatible pointer type 'void (*)(struct msm_gpu *, struct
> msm_gpu_state *, struct drm_printer *)' [-Werror=3Dincompatible-pointer-t=
ypes]
> drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:11: note: (near initialization =
for
> 'funcs.base.submit')
> drivers/gpu/drm/msm/adreno/a4xx_gpu.c:546:4: error: 'struct msm_gpu_funcs=
'
> has no member named 'show'
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:1460:4: error: 'struct
> msm_gpu_funcs' has no member named 'show'
> drivers/gpu/drm/msm/adreno/a6xx_gpu.c:769:4: error: 'struct msm_gpu_funcs=
'
> has no member named 'show'
> drivers/gpu/drm/msm/msm_gpu.c: In function 'msm_gpu_devcoredump_read':
> drivers/gpu/drm/msm/msm_gpu.c:289:12: error: 'const struct msm_gpu_funcs'
> has no member named 'show'
>=20
> Adjust the #ifdef to make it build again.

Was this patch picked up by someone? I am asking this since the compile err=
or can be still seen in 5.0-rc1.

Ioana

>=20
> Fixes: c0fec7f562ec ("drm/msm/gpu: Capture the GPU state on a GPU hang")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Not sure if this does the right thing, but it does fix the build regressi=
on
> ---
>  drivers/gpu/drm/msm/msm_gpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h
> b/drivers/gpu/drm/msm/msm_gpu.h
> index 9122ee6e55e4..1fe93920fb25 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -63,7 +63,7 @@ struct msm_gpu_funcs {
>  	struct msm_ringbuffer *(*active_ring)(struct msm_gpu *gpu);
>  	void (*recover)(struct msm_gpu *gpu);
>  	void (*destroy)(struct msm_gpu *gpu);
> -#ifdef CONFIG_DEBUG_FS
> +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
>  	/* show GPU status in debugfs: */
>  	void (*show)(struct msm_gpu *gpu, struct msm_gpu_state *state,
>  			struct drm_printer *p);
> --
> 2.18.0

