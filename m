Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9873C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5623723C40
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpe+EJ7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5623723C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933972AbeFVCPY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:15:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43411 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbeFVCPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:15:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so2427100pfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0M8i5k1DqiL6hanBImyyWKZU8OCOQojZq7QNR0yujs=;
        b=Mpe+EJ7fRyj6U0mvMuW86eYdonue/sl1U69GpE9Xzyjj69tOdpgvhM1qCIgTnvKvRQ
         ePNzzH8apbiXpCZ3X8oGJ9jVCO5K7AV+UlkGUrHcV443tdNvhmsPLRuJ/6UTO2AkkoTq
         jAXglwbKBpDmrWX/YGZPQJ1tjAE2Nn7ZmIn8sz7wpWbfxChiHUc3kxRLSGg3rFSQEUG2
         ge6CRpAkk/+DnrPVky1DWMKyD0dp8oaVjVp9NWv/SgBufdRXsd7vNOPIsPEQ8Bx9564j
         fR43ApGVOYl7J5mA4EQDBSjL9KY78pp7adEj/dGnOpfgQYrtCP9YIbjitivxbNVvIlXU
         uI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0M8i5k1DqiL6hanBImyyWKZU8OCOQojZq7QNR0yujs=;
        b=sNVq/qgrHkBIlDsJnpdn5MfNXjVqo6g4ArYghEGIF/UEiWlZ90mYAjyVISA+Hff6lB
         wyM1+9DoQIyFOJc5DDHTpEfuYj9KH9tYDDb6YKrhlYLHcooWptUd1e/WyYzqeccb0iBe
         pgJe6Pm2mRl9mekN4kZvi9jn/gKxy75MI9dEbvWf2AAHkZSJWmEeYPZdzgOaI87W2TPp
         0ak8Hd13z5AqePfoy237QQZt+MnTOi6TLSPyyGXfRXavBEX/oAp3yjdBQx/zTKo77NPY
         +WvDyGvQ63UBOUbFNmzl2crvgTvNH68j5d/waJa05oHYQLnMK0Okj5+hEOHrUDseGR+n
         oaZg==
X-Gm-Message-State: APt69E08WPV0Lz630hZokKA3N8Je6MzHF/UVnPhPcii81NfuHE8du6Un
        3rz6a8iAax2jGiidAt8CuxI60A==
X-Google-Smtp-Source: ADUXVKKgGQCpuoNY0sd/Ek6Q4yBOtenNFURND5YH9Eg5tx5pyBPIBeqeVz1nhpV40lOjsM2sgy9uIg==
X-Received: by 2002:a63:62c4:: with SMTP id w187-v6mr3829555pgb.55.1529633722613;
        Thu, 21 Jun 2018 19:15:22 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (s169.156.222.122.fls.vectant.ne.jp. [122.222.156.169])
        by smtp.gmail.com with ESMTPSA id q207-v6sm7409500pgq.11.2018.06.21.19.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 19:15:21 -0700 (PDT)
Date:   Fri, 22 Jun 2018 12:15:11 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/26] ppc: Convert mmu context allocation to new IDA
 API
Message-ID: <20180622121511.00ae9d00@roar.ozlabs.ibm.com>
In-Reply-To: <20180621212835.5636-14-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
        <20180621212835.5636-14-willy@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 14:28:22 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> ida_alloc_range is the perfect fit for this use case.  Eliminates
> a custom spinlock, a call to ida_pre_get and a local check for the
> allocated ID exceeding a maximum.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  arch/powerpc/mm/mmu_context_book3s64.c | 44 +++-----------------------
>  1 file changed, 4 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index f3d4b4a0e561..5a0cf2cc8ba0 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -26,48 +26,16 @@
>  #include <asm/mmu_context.h>
>  #include <asm/pgalloc.h>
>  
> -static DEFINE_SPINLOCK(mmu_context_lock);
>  static DEFINE_IDA(mmu_context_ida);
>  
>  static int alloc_context_id(int min_id, int max_id)
>  {
> -	int index, err;
> -
> -again:
> -	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	spin_lock(&mmu_context_lock);
> -	err = ida_get_new_above(&mmu_context_ida, min_id, &index);
> -	spin_unlock(&mmu_context_lock);
> -
> -	if (err == -EAGAIN)
> -		goto again;
> -	else if (err)
> -		return err;
> -
> -	if (index > max_id) {
> -		spin_lock(&mmu_context_lock);
> -		ida_remove(&mmu_context_ida, index);
> -		spin_unlock(&mmu_context_lock);
> -		return -ENOMEM;
> -	}
> -
> -	return index;
> +	return ida_alloc_range(&mmu_context_ida, min_id, max_id, GFP_KERNEL);
>  }
>  
>  void hash__reserve_context_id(int id)
>  {
> -	int rc, result = 0;
> -
> -	do {
> -		if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
> -			break;
> -
> -		spin_lock(&mmu_context_lock);
> -		rc = ida_get_new_above(&mmu_context_ida, id, &result);
> -		spin_unlock(&mmu_context_lock);
> -	} while (rc == -EAGAIN);
> +	int result = ida_alloc_range(&mmu_context_ida, id, id, GFP_KERNEL);
>  
>  	WARN(result != id, "mmu: Failed to reserve context id %d (rc %d)\n", id, result);
>  }
> @@ -172,9 +140,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  
>  void __destroy_context(int context_id)
>  {
> -	spin_lock(&mmu_context_lock);
> -	ida_remove(&mmu_context_ida, context_id);
> -	spin_unlock(&mmu_context_lock);
> +	ida_free(&mmu_context_ida, context_id);
>  }
>  EXPORT_SYMBOL_GPL(__destroy_context);
>  
> @@ -182,13 +148,11 @@ static void destroy_contexts(mm_context_t *ctx)
>  {
>  	int index, context_id;
>  
> -	spin_lock(&mmu_context_lock);
>  	for (index = 0; index < ARRAY_SIZE(ctx->extended_id); index++) {
>  		context_id = ctx->extended_id[index];
>  		if (context_id)
> -			ida_remove(&mmu_context_ida, context_id);
> +			ida_free(&mmu_context_ida, context_id);
>  	}
> -	spin_unlock(&mmu_context_lock);
>  }
>  
>  static void pte_frag_destroy(void *pte_frag)

This hunk should be okay because the mmu_context_lock does not protect
the extended_id array, right Aneesh?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
