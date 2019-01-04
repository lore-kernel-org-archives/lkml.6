Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462CEC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100BE218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOP0dIQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfADQwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:52:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33828 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfADQwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:52:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so1467205wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 08:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWmSGX+IviZSWFczNs9vBardsrp7kVMhL6HgvLsTCtc=;
        b=tOP0dIQxZGMJPsCcvRBLqe89fDds905AhYiu0lxITIIACdHQ6tUTYza2uwys6WTT0Q
         pY0UsMWI2JS/fhOhOZvXrs90R5nWEMO1jWDyX4YIF4q5AV7kBy676Ir761ND7SLxLWtb
         q/D7mtwzTyvzZpDkknFUC/LM+EU7DI6+TDy1M77PU0vqFA7sDvSZDzulXX2/nyEG/MbO
         C1g8RH+kJbf3ckMa7Ho9Tmy1poPmqJXn81FaUzVCv1qw/tBWo8TFr4Vq9LTKOQFmqeU2
         ffnRQSxOxkqn8PcUMXjMTh9ypkhhIF8fE6GZb5B3E+5mzRh+8vyKjnx2jIBVeBh8R8o4
         CIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWmSGX+IviZSWFczNs9vBardsrp7kVMhL6HgvLsTCtc=;
        b=t5C32iXZp3nL8uhzwlnR/eW8YfocrHhMqvHz4BN5M8rZ8AdZYqVt2ksW627a/2CXPd
         MRNsjb0BDAF/yFpupNtJYjFHOKpjdKlS2h8us5XGZomkzE29WPVKutqLas6GDYHGZ1VI
         oqbpQ/rI+94gu8eZSFSqw5of3MfQmc0rCUjJgNjR6h46PZgDIAxwRqcaqeXNi9wa9ND5
         e6iq9a+ZsAYvKtI/e99z/0ytzYqf/uIbIF6v13TSeK4TRs/mcrvuMljH57GYiD5kQOMl
         zmHo4IJ4SS45ZsG4WWAANyFuRHYRv1HfiZBDOPIuHK6ihZYOIOzmLAUkZJhyQyDNR/RF
         T4Yw==
X-Gm-Message-State: AJcUukfNV9Zhv9SJMD5uzmn303PiO+ckqr4CxTt43O36r58ec8I+aJiq
        GsvduxPGgdR7JdHXb9STNy5XSTcHu3xhEJ31uHA=
X-Google-Smtp-Source: ALg8bN4ZAKombgblay0sRuT/nJULyATpn4P24l5aWyJrKWrdduEQQgio3K8UqFktmjPAuZNxlE9e9vC6Un5UTuyLqy8=
X-Received: by 2002:a1c:6243:: with SMTP id w64mr1814496wmb.153.1546620750538;
 Fri, 04 Jan 2019 08:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20190103200146.GA26442@embeddedor>
In-Reply-To: <20190103200146.GA26442@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Jan 2019 11:52:18 -0500
Message-ID: <CADnq5_PBuCFzqWLBeOd=hcOsnubiY=w8VkiV79pJmBSb+6yFQw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu_vm: fix boolean expressions
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 3:21 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
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

Applied.  thanks!

Alex

> ---
> Changes in v2:
>  - Update Fixes tag.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index e73d152659a2..4cc0d1079935 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3006,7 +3006,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>         }
>         DRM_DEBUG_DRIVER("VM update mode is %s\n",
>                          vm->use_cpu_for_update ? "CPU" : "SDMA");
> -       WARN_ONCE((vm->use_cpu_for_update & !amdgpu_gmc_vram_full_visible(&adev->gmc)),
> +       WARN_ONCE((vm->use_cpu_for_update && !amdgpu_gmc_vram_full_visible(&adev->gmc)),
>                   "CPU update of VM recommended only for large BAR system\n");
>         vm->last_update = NULL;
>
> @@ -3136,7 +3136,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, uns
>         vm->pte_support_ats = pte_support_ats;
>         DRM_DEBUG_DRIVER("VM update mode is %s\n",
>                          vm->use_cpu_for_update ? "CPU" : "SDMA");
> -       WARN_ONCE((vm->use_cpu_for_update & !amdgpu_gmc_vram_full_visible(&adev->gmc)),
> +       WARN_ONCE((vm->use_cpu_for_update && !amdgpu_gmc_vram_full_visible(&adev->gmc)),
>                   "CPU update of VM recommended only for large BAR system\n");
>
>         if (vm->pasid) {
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
