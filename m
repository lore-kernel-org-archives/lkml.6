Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74680C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC9421104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSNZrp+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC9421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeKURJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:09:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51269 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeKURJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:09:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so4303185wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 22:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LTb+SpZjVkbY73a+3lavBsk0Cv4BKCrKiUrhtkGkPRo=;
        b=HSNZrp+WHzkU4pzilpQHX7ZitfVUWpGVjw14hOTHqp1buagTkOJ3JFKqK/ST4vZtpp
         YGdkXjUd3WvnBNXpIRUhjci7mXE2i4Zg+Ja/0UWGOcbPfCwdj4JQJdbnFWmdQQSiDUGJ
         m2agoz3rTDM+A6vh1ygsAulBX08onRufnOffOtz5slcd0wCJbWyXzehl5MSw9ccx/P2I
         vtMlw19gy7OQtP7uYbE6sE/yVj/a0eMpR0i40rsX5oIM6oFrp2Kqp1bvWcwl7o+C8fnL
         8tLXeHWXKSRSi3dM6MX3mV1HAUZbHYJj1l0oT7zO8r0F8O0B1+s+x/Wyq3NYTOreNMvo
         Gn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LTb+SpZjVkbY73a+3lavBsk0Cv4BKCrKiUrhtkGkPRo=;
        b=CHIa2JvODUgYK1wIuGmPjJ9CLh9Cg7YI5m+qVUJIweMvmtGWS08oX2O77YEWz8YAJE
         zLAj6rcZlpQoHXEIqaLEApqlwJdE9LCrQ5N9dP0VknGCiDG8ZscGimGio+y7TKo53fb5
         A4V4Fe7NGGcLIGMmSqL7IGbpH8gv+j4VKL5wqG3VlzhP7kE41HxO/j5q9glrkka8D1Se
         7Vjd3a3ei6XAad5Mv5KDIr6PXM/t0bcGHrSqRHhkYajmP1t7m8syiEtLjt2WwMm9Cizm
         zqlfhcvssTTt70JaMwh91T9yQEZEWLuTMTqCOyPYjWxojpcVvkZ+IjDCYhtZ7Wb2yNhP
         UF5A==
X-Gm-Message-State: AA+aEWaf97ICwF1iLG9EBMg8PGhwOTizm3qu8QkzOu3+drmGTMpFvtqX
        0RcGGqTFNHT33KciuZzInuo=
X-Google-Smtp-Source: AJdET5eTxV07hexEFJOHeYQ/bKODz++TTKnLGsbhNvbjlyBy1Um8HRBLGVTHeFe+SahD5tS+1gUvuA==
X-Received: by 2002:a1c:b7c1:: with SMTP id h184-v6mr4562225wmf.33.1542782172622;
        Tue, 20 Nov 2018 22:36:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h127sm11589wmd.31.2018.11.20.22.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 22:36:12 -0800 (PST)
Date:   Wed, 21 Nov 2018 07:36:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
Message-ID: <20181121063609.GA109082@gmail.com>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Cc:-ed a few other gents and lkml. ]

* Jens Axboe <axboe@kernel.dk> wrote:

> Hi,
> 
> So this is a fun one... While I was doing the aio polled work, I noticed
> that the submitting process spent a substantial amount of time copying
> data to/from userspace. For aio, that's iocb and io_event, which are 64
> and 32 bytes respectively. Looking closer at this, and it seems that
> ERMS rep movsb is SLOWER for smaller copies, due to a higher startup
> cost.
> 
> I came up with this hack to test it out, and low and behold, we now cut
> the time spent in copying in half. 50% less.
> 
> Since these kinds of patches tend to lend themselves to bike shedding, I
> also ran a string of kernel compilations out of RAM. Results are as
> follows:
> 
> Patched	: 62.86s avg, stddev 0.65s
> Stock	: 63.73s avg, stddev 0.67s
> 
> which would also seem to indicate that we're faster punting smaller
> (< 128 byte) copies.
> 
> CPU: Intel(R) Xeon(R) CPU E5-2650 v4 @ 2.20GHz
> 
> Interestingly, text size is smaller with the patch as well?!
> 
> I'm sure there are smarter ways to do this, but results look fairly
> conclusive. FWIW, the behaviorial change was introduced by:
> 
> commit 954e482bde20b0e208fd4d34ef26e10afd194600
> Author: Fenghua Yu <fenghua.yu@intel.com>
> Date:   Thu May 24 18:19:45 2012 -0700
> 
>     x86/copy_user_generic: Optimize copy_user_generic with CPU erms feature
> 
> which contains nothing in terms of benchmarking or results, just claims
> that the new hotness is better.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> 
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> index a9d637bc301d..7dbb78827e64 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -29,16 +29,27 @@ copy_user_generic(void *to, const void *from, unsigned len)
>  {
>  	unsigned ret;
>  
> +	/*
> +	 * For smaller copies, don't use ERMS as it's slower.
> +	 */
> +	if (len < 128) {
> +		alternative_call(copy_user_generic_unrolled,
> +				 copy_user_generic_string, X86_FEATURE_REP_GOOD,
> +				 ASM_OUTPUT2("=a" (ret), "=D" (to), "=S" (from),
> +					     "=d" (len)),
> +				 "1" (to), "2" (from), "3" (len)
> +				 : "memory", "rcx", "r8", "r9", "r10", "r11");
> +		return ret;
> +	}
> +
>  	/*
>  	 * If CPU has ERMS feature, use copy_user_enhanced_fast_string.
>  	 * Otherwise, if CPU has rep_good feature, use copy_user_generic_string.
>  	 * Otherwise, use copy_user_generic_unrolled.
>  	 */
>  	alternative_call_2(copy_user_generic_unrolled,
> -			 copy_user_generic_string,
> -			 X86_FEATURE_REP_GOOD,
> -			 copy_user_enhanced_fast_string,
> -			 X86_FEATURE_ERMS,
> +			 copy_user_generic_string, X86_FEATURE_REP_GOOD,
> +			 copy_user_enhanced_fast_string, X86_FEATURE_ERMS,
>  			 ASM_OUTPUT2("=a" (ret), "=D" (to), "=S" (from),
>  				     "=d" (len)),
>  			 "1" (to), "2" (from), "3" (len)

So I'm inclined to do something like yours, because clearly the changelog 
of 954e482bde20 was at least partly false: Intel can say whatever they 
want, it's a fact that ERMS has high setup costs for low buffer sizes - 
ERMS is optimized for large size, cache-aligned copies mainly.

But the result is counter-intuitive in terms of kernel text footprint, 
plus the '128' is pretty arbitrary - we should at least try to come up 
with a break-even point where manual copy is about as fast as ERMS - on 
at least a single CPU ...

Thanks,

	Ingo
