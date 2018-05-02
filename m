Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeEBFow (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 01:44:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39272 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeEBFov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 01:44:51 -0400
X-Google-Smtp-Source: AB8JxZryuf2GA2wyD8XndKhGW3/WxFn6ex+ZYmgddaXmfT9jh7IzQk8M7EU1gRtXbdYR9iuw5/f8UvK3i2TbwHAItJw=
MIME-Version: 1.0
In-Reply-To: <20180417141547.GA30799@jordon-HP-15-Notebook-PC>
References: <20180417141547.GA30799@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 2 May 2018 11:14:48 +0530
Message-ID: <CAFqt6zYFxJPMbcyLbJp6qrRDmcy4A+KAk9NhEvy-kVMBL2dySg@mail.gmail.com>
Subject: Re: [PATCH] hwtracing: intel_th: Change return type to vm_fault_t
To: alexander.shishkin@linux.intel.com
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comment for this patch ?

On Tue, Apr 17, 2018 at 7:45 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
>
> Reference id -> 1c8f422059ae ("mm: change return type to
> vm_fault_t")
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/hwtracing/intel_th/msu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
> index dfb57ea..0ac84eb 100644
> --- a/drivers/hwtracing/intel_th/msu.c
> +++ b/drivers/hwtracing/intel_th/msu.c
> @@ -1190,7 +1190,7 @@ static void msc_mmap_close(struct vm_area_struct *vma)
>         mutex_unlock(&msc->buf_mutex);
>  }
>
> -static int msc_mmap_fault(struct vm_fault *vmf)
> +static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
>  {
>         struct msc_iter *iter = vmf->vma->vm_file->private_data;
>         struct msc *msc = iter->msc;
> --
> 1.9.1
>
