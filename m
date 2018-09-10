Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0B0C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F38420866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuliwhOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F38420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeIKCCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:02:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33955 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeIKCCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:02:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so11103130pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPQR67NdyQKnqIZr9gvPIBSUU0W6URiGya58QVUyOXU=;
        b=PuliwhOjIS0tX2+7xa1p3fI3rdVvIeeRq+Dipqqz0diGVkze3xOFnws6EDPaHrc3vW
         4IuLG7R1jb5omj0MF2et4QrmugG8yt7HnsDBD8J8FrdZU1uFgC8iNqEV+dO7sWXcXALW
         eTZtJNEvh1eBKHA+UQFIpvfn8Fn0/tyGEWW27sP+15UqXao7KixkC4HEXxbPpgye65TB
         /VZMzdZ9WCT5k6t+XICq/pja/QEUz2wj/xaVjB9vgh1dGhxOO0c3VEVAyQkx6ctz5lsy
         rAynjLb8CIjvaEK0dvTaQP+pMKii9NblyCovNtbtL1mDau7/QXhILxPIqRbekkQz13ro
         yj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPQR67NdyQKnqIZr9gvPIBSUU0W6URiGya58QVUyOXU=;
        b=UnqH0rZ2wlZclUWS9jN35Jp1ZJ69eyCO3ZzopqhrPdFCwZ39kc4jDstt75Bo+B8kFd
         QRvOVTOvTIlEoUlL8bUia0gMc+FNUV3NeM+P6riKTRYptJ/Kz1+xvSvHZOIvCsb2Ma1D
         QEIur3vAAV9UgQQRSLo+tYHcbkj/cC0AACJvCkEnaxwUKWPGrMxDqIkKsngC2Ui/bqLy
         p4osATRUpZsIGc0niE7PcrjS1LIKmkaNIkyBFJHU8ijgEcF7DivY42K15Xkg3lKoN/Sx
         Tzt6X5luF4GJCWEDAPneAZL3QOY/AGO3AEUXfUfNEb5xxRVGMEIKuawlULIp9tvLnCKM
         VnYA==
X-Gm-Message-State: APzg51A5wPtGXKGURpEK+U2VzzK84eQKvtmocWlI78o/XgpunsgS87ur
        pnKis55A0nCUz7XfkBLOxxlW+BQd
X-Google-Smtp-Source: ANB0VdbSjb/1IQ/Whl13kq6Z+r7o/dTUPupWThTFx8SxBcO3NecFBiWzjz3Aur6B31BN+rP0k2KReg==
X-Received: by 2002:a62:9992:: with SMTP id t18-v6mr25600269pfk.239.1536613614660;
        Mon, 10 Sep 2018 14:06:54 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (115-64-249-220.tpgi.com.au. [115.64.249.220])
        by smtp.gmail.com with ESMTPSA id j5-v6sm20683691pff.139.2018.09.10.14.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 14:06:53 -0700 (PDT)
Date:   Tue, 11 Sep 2018 07:06:45 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to handle PTE tables with non contiguous entries ?
Message-ID: <20180911070645.239aef8a@roar.ozlabs.ibm.com>
In-Reply-To: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
References: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 14:34:37 +0000
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Hi,
> 
> I'm having a hard time figuring out the best way to handle the following 
> situation:
> 
> On the powerpc8xx, handling 16k size pages requires to have page tables 
> with 4 identical entries.
> 
> Initially I was thinking about handling this by simply modifying 
> pte_index() which changing pte_t type in order to have one entry every 
> 16 bytes, then replicate the PTE value at *ptep, *ptep+1,*ptep+2 and 
> *ptep+3 both in set_pte_at() and pte_update().
> 
> However, this doesn't work because many many places in the mm core part 
> of the kernel use loops on ptep with single ptep++ increment.
> 
> Therefore did it with the following hack:
> 
>   /* PTE level */
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
> +#else
>   typedef struct { pte_basic_t pte; } pte_t;
> +#endif
> 
> @@ -181,7 +192,13 @@ static inline unsigned long pte_update(pte_t *p,
>          : "cc" );
>   #else /* PTE_ATOMIC_UPDATES */
>          unsigned long old = pte_val(*p);
> -       *p = __pte((old & ~clr) | set);
> +       unsigned long new = (old & ~clr) | set;
> +
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +       p->pte = p->pte1 = p->pte2 = p->pte3 = new;
> +#else
> +       *p = __pte(new);
> +#endif
>   #endif /* !PTE_ATOMIC_UPDATES */
> 
>   #ifdef CONFIG_44x
> 
> 
> @@ -161,7 +161,11 @@ static inline void __set_pte_at(struct mm_struct 
> *mm, unsigned long addr,
>          /* Anything else just stores the PTE normally. That covers all 
> 64-bit
>           * cases, and 32-bit non-hash with 32-bit PTEs.
>           */
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +       ptep->pte = ptep->pte1 = ptep->pte2 = ptep->pte3 = pte_val(pte);
> +#else
>          *ptep = pte;
> +#endif
> 
> 
> 
> But I'm not too happy with it as it means pte_t is not a single type 
> anymore so passing it from one function to the other is quite heavy.
> 
> 
> Would someone have an idea of an elegent way to handle that ?

I can't think of anything better. Do we pass pte by value to a lot of
non inlined functions? Possible to inline the important ones?

Other option, try to get an iterator like pte = pte_next(pte) into core
code.

Thanks,
Nick
