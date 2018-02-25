Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeBYLLe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 06:11:34 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46333 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeBYLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 06:11:05 -0500
X-Google-Smtp-Source: AG47ELuNvtevyQ7YeK/0KlfMNdYqY8q15qiQ1SoFGvgni4v4CWZDRq1q5bdxKWiDJdcYa6sppviPRa84NF7MOan75k8=
MIME-Version: 1.0
In-Reply-To: <94b486c9-92ce-dae8-3d5e-db1943fc0119@users.sourceforge.net>
References: <94b486c9-92ce-dae8-3d5e-db1943fc0119@users.sourceforge.net>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Sun, 25 Feb 2018 13:10:34 +0200
Message-ID: <CAFCwf131ahZi1VLLzHG189DAGOVm_u8MmLCGAMoALJoBv-2CSg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Delete an error message for a failed memory
 allocation in kfd_topology_init()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 11:33 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 8 Feb 2018 22:23:57 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 19ce59028d6b..610e3d4ac575 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1019,7 +1019,6 @@ int kfd_topology_init(void)
>                 crat_image = kmalloc(image_size, GFP_KERNEL);
>                 if (!crat_image) {
>                         ret = -ENOMEM;
> -                       pr_err("No memory for allocating CRAT image\n");
>                         goto err;
>                 }
>                 ret = kfd_topology_get_crat_acpi(crat_image, &image_size);
> --
> 2.16.1
>

Hi,
Thanks for the patch but this code block is going to be refactored in
the next merge window and the patch will no longer be relevant.

Oded
