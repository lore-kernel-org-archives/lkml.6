Return-Path: <sivanich@hpe.com>
X-Google-Smtp-Source: AB8JxZp+mc2479+oFyQQfxzT01LduwZgg6bbtGGYQ5fwL1n3qg0VmK3wAwM8iBa4UyszDdhtfS7O
ARC-Seal: i=1; a=rsa-sha256; t=1525895218; cv=none;
        d=google.com; s=arc-20160816;
        b=SpTRtWbQJDF0ioMCwtBD6R7e97lQxJOhBWPYxOyuupckzxoZrPeXRYUBKZv7NoQ5Hf
         +NR31Mw2mFD5dY8lP5Ak+yYr4QO1bD72/bLF2cFiVNv8uB5/gx01Mc4dX0HXPSTS/moU
         wCh1Eg4XfyLT2KcxkyiV9ekthDaLbMqN5QvmcNeVn/RRnXkh2/dACi40EP9XxvIyKOuH
         QWC2vw9+4sY6TQR5IF8za3GLUrfMWgnQ/kNEpavjv86eRT8axP9VB/ig2Sno5+QmdpxN
         byRmI86mVdrJ7CwuaCEqhDCR1Mdho9EfI4iea+Qv6ATa7QLdyzbpArPiBwElMTCG7X2D
         CRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=la3m9DKTXyHnD2gHVC46pOI2AvnTFCSQEZzqZEWzWu8=;
        b=HLDfPM3gbBxIIZqmQcUPjOxwyuPlDdrhShI7Ud3Zb4m2HzbOcNOBKyRYH8yL0MNYgP
         XEWYW3oafxCc3HHcpIwJpTczYTL+WgySEPmCJV0WwwIzCyh6+UNMi7YCZKJikfbAS4Hl
         U7x7KTjJotXsTjXSbzvQrFRcqnIOukXhoa1FaNlYWwzs8oXb+WsCyT5YZ/Rn8uxCqhCh
         0PHgOWfl4OhUjORhhyP5vTsfuuRlYOktHVvTsUK+sbwN+J4CgX+rV/x8IcYjXDHXd0bt
         oDb3UX62wT6xfn/B7ikXtb/rCyKxnXLidTB6LAo8W3XDugu5cdQiAokpbdOmxRpvGfhi
         UsKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sivanich@hpe.com designates 15.241.48.72 as permitted sender) smtp.mailfrom=sivanich@hpe.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sivanich@hpe.com designates 15.241.48.72 as permitted sender) smtp.mailfrom=sivanich@hpe.com
Date: Wed, 9 May 2018 14:46:57 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: sivanich@sgi.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: sgi-gru: Change return type to vm_fault_t
Message-ID: <20180509194657.GA7219@hpe.com>
References: <20180425045044.GA21558@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425045044.GA21558@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598692241975703394?=
X-GMAIL-MSGID: =?utf-8?q?1600017104407130479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Acked-by: Dimitri Sivanich <sivanich@hpe.com>

On Wed, Apr 25, 2018 at 10:20:44AM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
> v2: Updated the change log
> 
>  drivers/misc/sgi-gru/grumain.c   | 2 +-
>  drivers/misc/sgi-gru/grutables.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
> index 3641f13..ab174f28 100644
> --- a/drivers/misc/sgi-gru/grumain.c
> +++ b/drivers/misc/sgi-gru/grumain.c
> @@ -926,7 +926,7 @@ struct gru_state *gru_assign_gru_context(struct gru_thread_state *gts)
>   *
>   * 	Note: gru segments alway mmaped on GRU_GSEG_PAGESIZE boundaries.
>   */
> -int gru_fault(struct vm_fault *vmf)
> +vm_fault_t gru_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct gru_thread_state *gts;
> diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
> index b5e308b..3e041b6 100644
> --- a/drivers/misc/sgi-gru/grutables.h
> +++ b/drivers/misc/sgi-gru/grutables.h
> @@ -147,6 +147,7 @@
>  #include <linux/mutex.h>
>  #include <linux/wait.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/mm_types.h>
>  #include "gru.h"
>  #include "grulib.h"
>  #include "gruhandles.h"
> @@ -665,7 +666,7 @@ extern unsigned long gru_reserve_cb_resources(struct gru_state *gru,
>  		int cbr_au_count, char *cbmap);
>  extern unsigned long gru_reserve_ds_resources(struct gru_state *gru,
>  		int dsr_au_count, char *dsmap);
> -extern int gru_fault(struct vm_fault *vmf);
> +extern vm_fault_t gru_fault(struct vm_fault *vmf);
>  extern struct gru_mm_struct *gru_register_mmu_notifier(void);
>  extern void gru_drop_mmu_notifier(struct gru_mm_struct *gms);
>  
> -- 
> 1.9.1
> 
