Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519051760; cv=none;
        d=google.com; s=arc-20160816;
        b=px7oOpyLCiJuh7qSXo5okBOzAWkpa5IttSLY8buhqmTG/h9hVMel1oXpXydGRFNjpD
         jVNaC22g0qlXYc6+pJzYfLai+BA4KRDkEJWC9/AreSq7gTDXAPEekwyU3OBF8sU9Sc8e
         9Zcof3RaDrpa1oiM9hiIBNXiw2p0NyzyR6BRUmsSKVy5qivEhqO1jiFyQ9s2mZOW7aCs
         APv9fFnfz2ZqV3ZW2WgGBWLLMANeXiAZW0NQeZKFPqME7ERJNeJyqbhaJifoGtoNYKkZ
         QSV6DDBz9zljp7iT1E9rZpZo6Zgk3PjsiC9rJ/j7Q7BdwUr1RM6OfxVIYyVHN9JFaMLf
         zrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Qy1zTE5MfIrqvJS2dgM4kpef0XZmVrSIbZZQ2IXwa3Q=;
        b=LL1iHrmkXZYuvfqn8VTPtHdENy23ZI6gkAVm0c2XTr71MKc1+qOKex54RtNtNJLp0m
         Xau3mDbQ1V+ZuRfvRSZBY03UuBxTQuOSWJvsaALdpsYaC0uma+tT8/vKn72rLBlRLRUY
         A5dGD1ipip/k0OPYf/6fHfUUkULE4UzhdjEEZDx2Y+Vjqj0jC4hPF+nGDF/npbGVf5Yk
         jqHNNyOfmZE68JBlSBcYcCEAlHdmUgAGmMMpd4j68WhLDF7wUhtcvDUc4HuFwtOs49dJ
         VdTNhWsAa+NF7eRBuG0ap3nwZk/uAbATeEB2EQolcwHpVseu7X5jb4E4tYdpMojrnDAF
         vkMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cGlAsNyb;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cGlAsNyb;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227aZtrOWYPTTCa7Hk4tL4E3qavouPcdR1/p+OOdCl9bYAwKWNUaMKLcGZ4943KbeqXAjrmBbpv7nmJ5zgxgrT4=
MIME-Version: 1.0
In-Reply-To: <20180219140739.24383-1-khandual@linux.vnet.ibm.com>
References: <20180219140739.24383-1-khandual@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Feb 2018 16:49:19 +0200
Message-ID: <CAHp75VeUB_ZB2-7NNK7WCQ62HrSe2WVarS8Bcm1mpyBoVd2FqA@mail.gmail.com>
Subject: Re: [PATCH V3] lib/scatterlist: Add SG_CHAIN and SG_LAST macros for
 LSB encodings
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bart Van Assche <bart.vanassche@wdc.com>,
	Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Chris Wilson <chris@chris-wilson.co.uk>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592838612913137336?=
X-GMAIL-MSGID: =?utf-8?q?1592841219016323175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 4:07 PM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> This replaces scatterlist->page_link LSB encodings with SG_CHAIN and
> SG_LAST definitions without any functional change. While here also
> add macro definitions SG_PAGE_BITS and SG_PAGE_MASK.
>

A nit below, in any case

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Changes in V3:
> - Changed SG_END as SG_LAST due to a build failure
> - Added SG_PAGE_BITS and SG_PAGE_MASK as per Tvrtko
> - Used BIT() macro as per Chris
>
> Changes in V2:
> - Changed SG_EMARK as SG_END as per Johannes and Tvrtko
> - Added 'UL' to the constants as per Bart
>
>  include/linux/scatterlist.h | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 22b2131bcdcd..494b84c7f3c8 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -66,15 +66,20 @@ struct sg_table {
>
>  #define SG_MAGIC       0x87654321
>
> +#define SG_CHAIN       BIT(0)
> +#define SG_LAST                BIT(1)
> +#define SG_PAGE_BITS   (SG_CHAIN | SG_LAST)
> +#define SG_PAGE_MASK   (~SG_PAGE_BITS)
> +
>  /*
>   * We overload the LSB of the page pointer to indicate whether it's
>   * a valid sg entry, or whether it points to the start of a new scatterlist.
>   * Those low bits are there for everyone! (thanks mason :-)
>   */
> -#define sg_is_chain(sg)                ((sg)->page_link & 0x01)
> -#define sg_is_last(sg)         ((sg)->page_link & 0x02)
> +#define sg_is_chain(sg)                ((sg)->page_link & SG_CHAIN)
> +#define sg_is_last(sg)         ((sg)->page_link & SG_LAST)
>  #define sg_chain_ptr(sg)       \
> -       ((struct scatterlist *) ((sg)->page_link & ~0x03))
> +       ((struct scatterlist *) ((sg)->page_link & SG_PAGE_MASK))
>
>  /**
>   * sg_assign_page - Assign a given page to an SG entry
> @@ -88,13 +93,13 @@ struct sg_table {
>   **/
>  static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
>  {
> -       unsigned long page_link = sg->page_link & 0x3;
> +       unsigned long page_link = sg->page_link & SG_PAGE_BITS;
>
>         /*
>          * In order for the low bit stealing approach to work, pages
>          * must be aligned at a 32-bit boundary as a minimum.
>          */
> -       BUG_ON((unsigned long) page & 0x03);
> +       BUG_ON((unsigned long) page & SG_PAGE_BITS);
>  #ifdef CONFIG_DEBUG_SG
>         BUG_ON(sg->sg_magic != SG_MAGIC);
>         BUG_ON(sg_is_chain(sg));
> @@ -130,7 +135,7 @@ static inline struct page *sg_page(struct scatterlist *sg)
>         BUG_ON(sg->sg_magic != SG_MAGIC);
>         BUG_ON(sg_is_chain(sg));
>  #endif
> -       return (struct page *)((sg)->page_link & ~0x3);
> +       return (struct page *)((sg)->page_link & SG_PAGE_MASK);
>  }
>
>  /**
> @@ -178,7 +183,8 @@ static inline void sg_chain(struct scatterlist *prv, unsigned int prv_nents,
>          * Set lowest bit to indicate a link pointer, and make sure to clear
>          * the termination bit if it happens to be set.
>          */
> -       prv[prv_nents - 1].page_link = ((unsigned long) sgl | 0x01) & ~0x02;
> +       prv[prv_nents - 1].page_link = ((unsigned long) sgl | SG_CHAIN)
> +                                       & ~SG_LAST;

If it's ~2-3 characters over 80, I would rather still keep on the same line.

>  }
>
>  /**
> @@ -198,8 +204,8 @@ static inline void sg_mark_end(struct scatterlist *sg)
>         /*
>          * Set termination bit, clear potential chain bit
>          */
> -       sg->page_link |= 0x02;
> -       sg->page_link &= ~0x01;
> +       sg->page_link |= SG_LAST;
> +       sg->page_link &= ~SG_CHAIN;
>  }
>
>  /**
> @@ -215,7 +221,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>  #ifdef CONFIG_DEBUG_SG
>         BUG_ON(sg->sg_magic != SG_MAGIC);
>  #endif
> -       sg->page_link &= ~0x02;
> +       sg->page_link &= ~SG_LAST;
>  }
>
>  /**
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
