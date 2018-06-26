Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0CAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD68924AE6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXFolKHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD68924AE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeFZUFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:05:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34571 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeFZUFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:05:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so16175152wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pv6lexECMMM3oxSXTQ5SSr5EFYRUipJU+boFFIidPxE=;
        b=jXFolKHR8QQtBk0VbulroIc/Al35se7WD3+hC+nj9d6CZu50MN8OE1TiWyluUnkRNA
         BB4HVEru7I/7zf5mny4nga4ed1BpWQ1vexFhnzucNw3+4/K6kdJMTb3Ngv347zSlPhRm
         yLwZcGuqu9UWhpbHvTTNzsYm1JREpRVOUyTbnuk73ppl/LlZcLdSS7RidrqUfstvsKUP
         NWC5K/13ol0l1F1/Ee6KvzWt3wM4UV2227ZQZWhm5ZAVH4q/JiS69aEDu1cvCiX6VaMc
         jMbsfcQUv7wMuaZRJuE0zU73nzvy/zq7XVaq8pAWCaNVWaSTroV0fiUMPKLW+5rsSV6J
         ZMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pv6lexECMMM3oxSXTQ5SSr5EFYRUipJU+boFFIidPxE=;
        b=C7auC7w2oLuC7KZ/qxop/w237PNmeftw3mfyMYGvLfNZs+1I+iI5UOaMYIc2VyymYb
         fXuRLoYqXL9468hN4+v98YpX7rGbAPh1z9fkxx6CWGr56Jfmc7m8sB0kXbqwfgUk742H
         f9oFFKXza1paw0o/OymFvFhqlUt2n0VTNt0SFQ4JT7gvZ15mlZ+rDR5Vm8aKzr7ODD4i
         0J7t3CKhpDOZskmsl1pMuldUNEGCpUGGxAGYJEtSL1gRy0WI+0hg3JG4ENYXxLI4M0nj
         nOI1625HC8NmunrHqLE7aH/SnTpSA136vg4B/l75KCbXsPm2YrY6dya8jYxgLOUqQvRI
         xwsA==
X-Gm-Message-State: APt69E1bx4lPUnnHaZjyqYTzXKylLPaYr+LzovoQf4z9x/FrOwxIPB36
        zaxBfrLhYHNIWYezZ+NWO+qXgA==
X-Google-Smtp-Source: AAOMgpd3OF5Gf3HuxqbPHTx5AU06rnOWDqZsf4j4ejYUhjzaGd2bce3txzEYLujzNB/fa0Lzqb64Sw==
X-Received: by 2002:a1c:a8a:: with SMTP id 132-v6mr2813655wmk.44.1530043532222;
        Tue, 26 Jun 2018 13:05:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x11-v6sm3039478wrm.78.2018.06.26.13.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:05:31 -0700 (PDT)
Date:   Tue, 26 Jun 2018 22:05:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dmitry Vyukov <dvyukov@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, sergey.senozhatsky.work@gmail.com,
        andy.shevchenko@gmail.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v3] arch/x86: get rid of KERN_CONT in show_fault_oops()
Message-ID: <20180626200528.GA29307@gmail.com>
References: <20180626072843.158906-1-dvyukov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626072843.158906-1-dvyukov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dmitry Vyukov <dvyukov@gmail.com> wrote:

> From: Dmitry Vyukov <dvyukov@google.com>
> 
> KERN_CONT leads to split lines in kernel output
> and complicates useful changes to printk like
> printing context before each line.
> 
> Only acceptable use of continuations is basically
> boot-time testing.
> 
> Get rid of it.
> 
> Also tidy up code around as asked by reviewers.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> ---
> 
> Changes since v1:
>  - use pr_alert() instead of printk(KERN_ALERT)
> 
> Changes since v2:
>  - drop unnecessary parenthesis
>  - remove once used nx_warning and smep_warning
> ---
>  arch/x86/mm/fault.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 9a84a0d08727..a73575cacfd9 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -641,11 +641,6 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
>  	return 0;
>  }
>  
> -static const char nx_warning[] = KERN_CRIT
> -"kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n";
> -static const char smep_warning[] = KERN_CRIT
> -"unable to execute userspace code (SMEP?) (uid: %d)\n";
> -
>  static void
>  show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>  		unsigned long address)
> @@ -664,20 +659,18 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>  		pte = lookup_address_in_pgd(pgd, address, &level);
>  
>  		if (pte && pte_present(*pte) && !pte_exec(*pte))
> -			printk(nx_warning, from_kuid(&init_user_ns, current_uid()));
> +			pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
> +				from_kuid(&init_user_ns, current_uid()));
>  		if (pte && pte_present(*pte) && pte_exec(*pte) &&
>  				(pgd_flags(*pgd) & _PAGE_USER) &&
>  				(__read_cr4() & X86_CR4_SMEP))
> -			printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
> +			pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",
> +				from_kuid(&init_user_ns, current_uid()));
>  	}
>  
> -	printk(KERN_ALERT "BUG: unable to handle kernel ");
> -	if (address < PAGE_SIZE)
> -		printk(KERN_CONT "NULL pointer dereference");
> -	else
> -		printk(KERN_CONT "paging request");
> -
> -	printk(KERN_CONT " at %px\n", (void *) address);
> +	pr_alert("BUG: unable to handle kernel %s at %px\n",
> +		address < PAGE_SIZE ? "NULL pointer dereference" :
> +		"paging request", (void *) address);

I already applied the last hunk in a bit different way - could you send the rest 
as a separate clean-up patch please?

Thanks,

	Ingo
