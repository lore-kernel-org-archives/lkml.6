Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B374C46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B69214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YOr1GbR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B69214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeKUGzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:55:02 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35220 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeKUGzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:55:02 -0500
Received: by mail-io1-f68.google.com with SMTP id u19so2392934ioc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 12:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6eCFBLyx2YBtW0Xwd+MenPFeG8RuMaNPvxTPRsck55E=;
        b=YOr1GbR9r8v9+j5cu7UtEOIhaEc0jHsSNm73mLis/4PC2DER2RThsFKygp8ZutSpVD
         6Tp63uQ7fpPn4FfUxiVY/pipP7DbqGwIaXkSYzMUIgkA8t3tu3OMhnGJdseAbzVWNxyl
         uwDraseUqGiyQ40oRc39zALM4G3qhhir//VGM0QWm9Un59sEkJyadWMJIw1hsTqNp7bq
         i/UuH5tYaGcXXrMYPuw9YKs1ONMFhQ9RBlASa1XbPfFtMO4ex7RV+U4hh02pSHv3hmg7
         4eeNfqD4Fn3F9+iQfQmYu4ERkiHSYeAfTiTyFYzhHRs1zaTVW7lDgYlA6HvhY6C3OJ+u
         TtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6eCFBLyx2YBtW0Xwd+MenPFeG8RuMaNPvxTPRsck55E=;
        b=GIlMmloDIW2XBvC7gMX9ZK3dw1GMY5LmU8xrJ3e0avudU30S7fPL1gT0T7//lk+awn
         VRwW68mf7c0PJXAsCXT86pQB9rdR9gaAobhSEjuh8lZyA0T4XBgIESnF05HCTZnRoP7c
         D4Pcr1n2CWko7YsqDrqhjP9TSEKCxfBdQDaE80BZHZBa1mGYEDVqP4Ls+eqJ1aHw72Bb
         iUvssLtFZs/jfQk/EAn7Sj5Jwcmzi+zeJTMXn9XtUUeTrGDy3B5ffMJJLA1HnoJ9JqnZ
         f+1b09zzUEPerMuQDGDwNwSas+BOuK3RyS088P8CP97oLAaeITH5T/jnwkU+AWdVm0PE
         X0pA==
X-Gm-Message-State: AA+aEWaV+olKKRwxIWEN2AK9jTeHrqVvG/WGh6r0agrJ2IpXTKu/VuzF
        HqDgPo3bOBLomSdE+sYMVMxlTZwxfBk=
X-Google-Smtp-Source: AFSGD/Xd0Zb5bd30jYTSIilks271ka5ycUJsxPPeVlucqGY1PxIM94qi03m66WaXHD5XGy7hqts7Ng==
X-Received: by 2002:a6b:1786:: with SMTP id 128-v6mr2899034iox.58.1542745444503;
        Tue, 20 Nov 2018 12:24:04 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c10-v6sm16703555itc.2.2018.11.20.12.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:24:03 -0800 (PST)
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
From:   Jens Axboe <axboe@kernel.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
Message-ID: <5bdf8b35-0378-7a1b-74d0-90c0b8d77477@kernel.dk>
Date:   Tue, 20 Nov 2018 13:24:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to CC the mailing list...


On 11/20/18 1:18 PM, Jens Axboe wrote:
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
> 


-- 
Jens Axboe

