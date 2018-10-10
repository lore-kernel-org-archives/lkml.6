Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D578C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DFD2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ/mdT8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DFD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJKChp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:37:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40122 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeJKChp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:37:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so6968623wro.7;
        Wed, 10 Oct 2018 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kk66WKvrB1bH26PYcaLXPVSQlyWIi/QeDETFk9Gm9sY=;
        b=SZ/mdT8Iig9/CML8CpUT7Gn7dtDvIioS54hfthOYo4ljgL83rgRPsPmh3ittg8GFEa
         GkJt/MkSzWvljVH8En2WAAfD0zciNUrei2pFVX8kcj4oX6z9Y72YUuwtsSvhIcKsYiFh
         EKWp/QmTaPHs7A+lt2GgiGzJ3q6cAR382R4d4Mw+rs2p2ofWw8Pj8YWS3r39H4X0Zhez
         0LJ8FBDdWMaI4JT6tYgFHPDHAYzOhei2pPRX4AqgCwxcAQi/0UBcN0wsOAzCaxSxRxeL
         AyVr0D/+oUHIEoIIw+MK450DLR9/LmWpt5rtGpPoYcYo2E1R1W3qZY1x41s4KELlnohQ
         Yxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kk66WKvrB1bH26PYcaLXPVSQlyWIi/QeDETFk9Gm9sY=;
        b=c8KjVE5oaDfj4uaNOXjNKdb4aBmCAN6ThBdBfJ61Bh4ENGWFb2uQ2clwCnGgIxVY88
         DR7LPknHQ5/sdU1BpJuGypukCMcGG7gDgrybh91/TxDEXuPAe4fQIESpRMpXMGWqpW3M
         ZBq6dBe4vTHnTzRMidsVT5ulEWmj0utYJB5eYWOLqkODJ0685BO45qE2qsNVa9l50VXO
         AK8Ub0nbsX9eu48+ShOX9NtfgsFAmHkT27Xwh2RYWJYpRdZixwPS0x6bJk9nehO67EwK
         UTSs01O32MYIFQfFZ8Cfd47yULjQNEW7MjKrA56kleMquHrR/7APC67AT5Ewz+kP2+i1
         KsXQ==
X-Gm-Message-State: ABuFfohKzAx7vxTTLLP39q2JCEMvPehlH0n5nsvE1bEHKYtQn67unVpR
        9/Y/vDI8yI3fOJ1/smQeWdaQBUUuxuJJ7WI1nFULztfd
X-Google-Smtp-Source: ACcGV60IIMu/ciiD9nDvbRw+cAn/6vP8HwYZCnaqyPft7ANjR/bI/vYVY3lk7oNA+v/E8xpLX14hfOqAECkHXUdeaGI=
X-Received: by 2002:adf:ec83:: with SMTP id z3-v6mr6112817wrn.125.1539198851776;
 Wed, 10 Oct 2018 12:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <1538221154-49213-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1538221154-49213-1-git-send-email-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Oct 2018 15:13:59 -0400
Message-ID: <CADnq5_MeA5VXnxVwUDfR0eKptf8hxCg0oVUDwLgnFUSKqKDEHA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'ring'
 in psp_v11_0_ring_stop
To:     yuehaibing@huawei.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>,
        "Wang, Ken" <Ken.Wang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>, kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 3:26 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/psp_v11_0.c: In function 'psp_v11_0_ring_stop':
> drivers/gpu/drm/amd/amdgpu/psp_v11_0.c:309:19: warning:
>  variable 'ring' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 9217af0..3f3fac2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -306,11 +306,8 @@ static int psp_v11_0_ring_stop(struct psp_context *psp,
>                               enum psp_ring_type ring_type)
>  {
>         int ret = 0;
> -       struct psp_ring *ring;
>         struct amdgpu_device *adev = psp->adev;
>
> -       ring = &psp->km_ring;
> -
>         /* Write the ring destroy command to C2PMSG_64 */
>         WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_DESTROY_RINGS);
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
