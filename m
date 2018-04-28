Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759784AbeD1Jpl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 05:45:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759622AbeD1Jpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 05:45:40 -0400
Date: Sat, 28 Apr 2018 17:45:26 +0800
From: Dave Young <dyoung@redhat.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 02/11] kexec_file: make
 kexec_image_post_load_cleanup_default() global
Message-ID: <20180428094526.GA2854@dhcp-128-65.nay.redhat.com>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-3-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425062629.29404-3-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/18 at 03:26pm, AKASHI Takahiro wrote:
> Change this function from static to global so that arm64 can implement
> its own arch_kimage_file_post_load_cleanup() later using
> kexec_image_post_load_cleanup_default().
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kexec.h | 1 +
>  kernel/kexec_file.c   | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 9e4e638fb505..49ab758f4d91 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -143,6 +143,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
>  
>  int kexec_image_probe_default(struct kimage *image, void *buf,
>  			      unsigned long buf_len);
> +int kexec_image_post_load_cleanup_default(struct kimage *image);
>  
>  /**
>   * struct kexec_buf - parameters for finding a place for a buffer in memory
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 75d8e7cf040e..eef89d9b1f03 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -78,7 +78,7 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image)
>  	return kexec_image_load_default(image);
>  }
>  
> -static int kexec_image_post_load_cleanup_default(struct kimage *image)
> +int kexec_image_post_load_cleanup_default(struct kimage *image)
>  {
>  	if (!image->fops || !image->fops->cleanup)
>  		return 0;
> -- 
> 2.17.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
