Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754396AbeDXJdA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:33:00 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:45673 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeDXJc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:32:56 -0400
X-Google-Smtp-Source: AIpwx4/iNdxgP8OLPxHDfSO+DdA93ApBOT17fSL7VYpdny990RswvxlL6AHhQVcfhCDUzTpmz8zDF1vafXmn/GLCAUs=
MIME-Version: 1.0
In-Reply-To: <20180405042655.GA13233@altlinux.org>
References: <20180405042655.GA13233@altlinux.org>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 24 Apr 2018 12:32:24 +0300
Message-ID: <CAFCwf114E=JV--VuNGEcrgDYVYMF1H+5Qe-ukiWYcfjq9ie0Qw@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix linux/kfd_ioctl.h userspace compilation errors
To: Felix Kuehling <Felix.Kuehling@amd.com>,
        "Shaoyun.liu" <shaoyun.liu@amd.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, but already fixed in latest upstream tree

Oded

On Thu, Apr 5, 2018 at 7:26 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> Consistently use types provided by <linux/types.h> via <drm/drm.h>
> to fix the following linux/kfd_ioctl.h userspace compilation errors:
>
> /usr/include/linux/kfd_ioctl.h:266:2: error: unknown type name 'uint64_t'
>   uint64_t tba_addr;  /* to KFD */
> /usr/include/linux/kfd_ioctl.h:267:2: error: unknown type name 'uint64_t'
>   uint64_t tma_addr;  /* to KFD */
> /usr/include/linux/kfd_ioctl.h:268:2: error: unknown type name 'uint32_t'
>   uint32_t gpu_id;  /* to KFD */
> /usr/include/linux/kfd_ioctl.h:269:2: error: unknown type name 'uint32_t'
>   uint32_t pad;
>
> Fixes: d7b9bd2248d79 ("drm/amdkfd: Add support for user-mode trap handlers")
> Cc: <stable@vger.kernel.org> # v4.16
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  include/uapi/linux/kfd_ioctl.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index f4cab5b3ba9a..111d73ba2d96 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -263,10 +263,10 @@ struct kfd_ioctl_get_tile_config_args {
>  };
>
>  struct kfd_ioctl_set_trap_handler_args {
> -       uint64_t tba_addr;              /* to KFD */
> -       uint64_t tma_addr;              /* to KFD */
> -       uint32_t gpu_id;                /* to KFD */
> -       uint32_t pad;
> +       __u64 tba_addr;         /* to KFD */
> +       __u64 tma_addr;         /* to KFD */
> +       __u32 gpu_id;           /* to KFD */
> +       __u32 pad;
>  };
>
>  #define AMDKFD_IOCTL_BASE 'K'
> --
> ldv
