Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeDXJLC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:11:02 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36213 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753919AbeDXJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:10:59 -0400
X-Google-Smtp-Source: AIpwx49c1laYH65WAfvpbk0aA5iE7TfzxeYj/qvFqM0XSR0zAS0ZBYg5bU4MF5UwvLLNGDWBSmvh2r80evjwte9QXLI=
MIME-Version: 1.0
In-Reply-To: <1522243256-94061-1-git-send-email-weiyongjun1@huawei.com>
References: <1522243256-94061-1-git-send-email-weiyongjun1@huawei.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 24 Apr 2018 12:10:28 +0300
Message-ID: <CAFCwf12e_JS3qOfq22isPpwy-Hs3mwpv0iLB9NDMxPr=wgYGWw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: fix error return code in amdgpu_amdkfd_gpuvm_create_process_vm()
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 4:20 PM, Wei Yongjun <weiyongjun1@huawei.com> wrote:
> Fix to return error code -ENOMEM from the eviction fence create fail
> error handling case instead of 0, as done elsewhere in this function.
>
> Fixes: a46a2cd103a8 ("drm/amdgpu: Add GPUVM memory management functions for KFD")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a12a165..c5c9c6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -846,6 +846,7 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, void **vm,
>                                                    current->mm);
>                 if (!info->eviction_fence) {
>                         pr_err("Failed to create eviction fence\n");
> +                       ret = -ENOMEM;
>                         goto create_evict_fence_fail;
>                 }
>

Thanks, but not relevant as the code moved to a different function and
it already contains the line you added.

Oded
