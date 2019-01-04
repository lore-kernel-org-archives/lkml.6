Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1539AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C762E21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="YC2NDNh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfADQki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:40:38 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33735 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfADQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:40:38 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so23026184vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 08:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yt25EvumAxGBXY77K0QUdaShW7J/la+GpdwlOdqECMk=;
        b=YC2NDNh6Z7e+SWDV/xAu9CWk6F5xYYWQrLajC8zjCRaZLFX9DQikC/h4ODU+jt+3jY
         O36rE6TWRvJPSX/kAUZnWMOPyWr7Ngnjc/QgH7TwhAhXYqaZ7DE6hsb8MpX56HXbENle
         Wt0Bv/5RbRBZSqmitFMl1NgH4wf31rIJ73MoOljOdc0+cdmckCdsknAVDIjzbmo62Uku
         nK1kJyOrCCiiC05lXtHN5TrUsEPKOtXRRV9CvYLvHEre3cDuzv9vPyCcwhdAQL4VNWJy
         EcytYBbR/R7bWbWu12J0EhH5X0Y+2/RQScS+PmSDMnsEwJgh6cpqVvVMIegRIw0jjIlV
         rWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yt25EvumAxGBXY77K0QUdaShW7J/la+GpdwlOdqECMk=;
        b=GkoStkhzE/SGi0/bFCOo2f7A+BRkt+o8MoIV19PhmKlrZOoQBDhnyTM/UAPBvRQ30z
         /X4qxIi1kMbp0DBSxURsY912uPdlf1iT0Q3sezASFW3jhX2tmE13fllG7PEP5jGUxWE/
         BFoZBk4fQD1fxqiqY9iUsaOpV9Yyn/LgwJl16gtq7Lg3XO1iOwBescvv3fP0DRgmRrxW
         c3xxB+NBTveYmWYZsgfqCig7o2uwlRlhjA6o/hkzILfiHhZb7k6k1UZKdYdmzkD+u9K7
         eDysq/J50i+PYzLo8sTidSvR4huFMoma5es7IRvh60n/JRUASQ/DPLsLiOD8nneiF27f
         1r+Q==
X-Gm-Message-State: AA+aEWb4R4Sxt3gXH7unmz079Anh2mLE9Nk5tw+4/FhK1e8c8upD+0AI
        lmgfxLuhDOUQBGCZMsoHodZHfar5iP9pqQFj8sdnRA==
X-Google-Smtp-Source: AFSGD/Wf2Bis0AvG/ZIo/SscZRqoNUyMt8qH8cwL8i+oad74jYPRs+sCc9cRA0ISn0QQW2c7VpVJm1qt7ZFlZ6UDmYo=
X-Received: by 2002:a67:ff02:: with SMTP id v2mr20876316vsp.176.1546620036715;
 Fri, 04 Jan 2019 08:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20190103200146.GA26442@embeddedor>
In-Reply-To: <20190103200146.GA26442@embeddedor>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 4 Jan 2019 13:40:24 -0300
Message-ID: <CAAEAJfA_1tLk0nk-WOtwdpF3W70keyaT=YPQHzXo5+nvWiZR=A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu_vm: fix boolean expressions
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Gustavo,

On Thu, 3 Jan 2019 at 17:25, Gustavo A. R. Silva <gustavo@embeddedor.com> w=
rote:
>
> Fix boolean expressions by using logical AND operator '&&'
> instead of bitwise operator '&'.
>
> This issue was detected with the help of Coccinelle.
>
> Fixes: 9a4b7d4c769e ("drm/amdgpu: Add vm context module param")
> Cc: stable@vger.kernel.org
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Update Fixes tag.
>

This just fixes a user warning that would be wrongly reported, but
doesn't fix any other issue.

Why stable?

Thanks,
Eze

>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index e73d152659a2..4cc0d1079935 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3006,7 +3006,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
>         }
>         DRM_DEBUG_DRIVER("VM update mode is %s\n",
>                          vm->use_cpu_for_update ? "CPU" : "SDMA");
> -       WARN_ONCE((vm->use_cpu_for_update & !amdgpu_gmc_vram_full_visible=
(&adev->gmc)),
> +       WARN_ONCE((vm->use_cpu_for_update && !amdgpu_gmc_vram_full_visibl=
e(&adev->gmc)),
>                   "CPU update of VM recommended only for large BAR system=
\n");
>         vm->last_update =3D NULL;
>
> @@ -3136,7 +3136,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm, uns
>         vm->pte_support_ats =3D pte_support_ats;
>         DRM_DEBUG_DRIVER("VM update mode is %s\n",
>                          vm->use_cpu_for_update ? "CPU" : "SDMA");
> -       WARN_ONCE((vm->use_cpu_for_update & !amdgpu_gmc_vram_full_visible=
(&adev->gmc)),
> +       WARN_ONCE((vm->use_cpu_for_update && !amdgpu_gmc_vram_full_visibl=
e(&adev->gmc)),
>                   "CPU update of VM recommended only for large BAR system=
\n");
>
>         if (vm->pasid) {
> --
> 2.20.1
>


--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
