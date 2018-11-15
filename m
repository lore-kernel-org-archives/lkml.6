Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBA2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499AB2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfLvYc99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499AB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbeKPGqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:46:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52409 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKPGqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:46:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so20025578wmb.2;
        Thu, 15 Nov 2018 12:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UQBb1hjBA0aFC42DSABDQw0+Bq1jv3eZJh8SgiqpfP8=;
        b=cfLvYc99OpqIgM1kNpUCxU2ZfOJZK3ZAd06PK4DuVkKXYay9q1lFveAMTSN5PsKrVW
         pGt7TtocZecJr4qH06J9hFQ4c11OKtVs9D2NhTV7MLXSYAF8z1XsRpAXu2ZIg8Jt0lTv
         AFPWcP5a6FQwaDBHBIDmpXXw93EIWduQusJXXBR8ysfwD5hrGlW6xkJaKrkdwrW4eWLE
         c8dEI/KrKHumQYg+OGGLvH9fbAialXboLwbcx+shRsASwP3WcvlWXcLjPV9MSnTeFzCE
         GJb7/1ENa7l4hvUuKs+tRFy04S/9KVsvqmlzE0sq+d48FS287xMV51wib6GFVoiGiGgn
         8bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UQBb1hjBA0aFC42DSABDQw0+Bq1jv3eZJh8SgiqpfP8=;
        b=nm7FxiQjgZk4amFQE7QiirDGh0/O+CXZx68Yzd8G9nJefz+vftRFhDUnMiyb3S6u1U
         yU+rD5iWZdPuAhtQhTVZcdQQ5F+DO+BVeBFeIGDU05sorcAa+1V77WRe2QrD70q1K3Xx
         0X3bIDx5jh9DVGveDOAVhGcHsC4ujaYbBvpdSm9eoZBuYYb3ptsv882C39WHrsRlscpM
         qYLiAdMTktf83nqc0Hff99hY3JOvvUZ4Ik/AwAVOMRyW3fbU5bfqMyigujSB5YH2uh2I
         bqO7kLr3IF54TsNTQUYKJDahBfyrCk5s6kn372EcenJIkSjNSPATu8W3ndRTruYPac9S
         CKFw==
X-Gm-Message-State: AGRZ1gJTTV6DQWJ40fZS2aeYUTKeGhLkFoiycCkothgWtiwgPDfAJRX6
        20Yy9Nxjg1tB1NoVOjeqA4G1AVCKkR4kY3q2S5M=
X-Google-Smtp-Source: AJdET5dLqqi06wjC49m/zjKh76/wQrxIhhSbq4/WSO7ptYviUx2ah4FS2Z/lVkWPkm86/5VfS5sXi2HXq7IBuDm0JWo=
X-Received: by 2002:a1c:ba54:: with SMTP id k81mr395760wmf.153.1542314230872;
 Thu, 15 Nov 2018 12:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20181115120035.4328-1-yuehaibing@huawei.com>
In-Reply-To: <20181115120035.4328-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Nov 2018 15:36:57 -0500
Message-ID: <CADnq5_Ns03NWNzmgnXS-vm9TG_YW-V2HLRmEctJLdMcP3PoqqA@mail.gmail.com>
Subject: Re: [PATCH v2 -next] drm/amdgpu: remove set but not used variable 'ring'
To:     yuehaibing@huawei.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>,
        David Francis <David.Francis@amd.com>,
        Huang Rui <ray.huang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:12 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: In function 'psp_v10_0_ring_stop'=
:
> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c:230:19: warning:
>  variable 'ring' set but not used [-Wunused-but-set-variable]
>
> drivers/gpu/drm/amd/amdgpu/psp_v3_1.c: In function 'psp_v3_1_ring_stop':
> drivers/gpu/drm/amd/amdgpu/psp_v3_1.c:359:19: warning:
>  variable =E2=80=98ring=E2=80=99 set but not used [-Wunused-but-set-varia=
ble]
>
> It not used since commit
> 4ef72453311a ("drm/amdgpu: added api for stopping psp ring (v2)")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>

Applied.  thanks!


> ---
> v2:also remove it in psp_v3_1_ring_stop
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 3 ---
>  drivers/gpu/drm/amd/amdgpu/psp_v3_1.c  | 3 ---
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v10_0.c
> index 295c220..d78b430 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> @@ -240,12 +240,9 @@ static int psp_v10_0_ring_stop(struct psp_context *p=
sp,
>                                enum psp_ring_type ring_type)
>  {
>         int ret =3D 0;
> -       struct psp_ring *ring;
>         unsigned int psp_ring_reg =3D 0;
>         struct amdgpu_device *adev =3D psp->adev;
>
> -       ring =3D &psp->km_ring;
> -
>         /* Write the ring destroy command to C2PMSG_64 */
>         psp_ring_reg =3D 3 << 16;
>         WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/psp_v3_1.c
> index e1ebf77..cc5e3ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> @@ -356,12 +356,9 @@ static int psp_v3_1_ring_stop(struct psp_context *ps=
p,
>                               enum psp_ring_type ring_type)
>  {
>         int ret =3D 0;
> -       struct psp_ring *ring;
>         unsigned int psp_ring_reg =3D 0;
>         struct amdgpu_device *adev =3D psp->adev;
>
> -       ring =3D &psp->km_ring;
> -
>         /* Write the ring destroy command to C2PMSG_64 */
>         psp_ring_reg =3D 3 << 16;
>         WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
> --
> 2.7.0
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
