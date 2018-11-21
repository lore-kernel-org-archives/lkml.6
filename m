Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F6DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676B42147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mnd5iaf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676B42147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeKVAGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:06:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37187 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeKVAGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:06:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so5587947plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 05:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KCigNGcBiwvCtG61bb44O1ve4E/m+Xvu2uWHxdf3dk=;
        b=Mnd5iaf1/WuexKJEXSokW7dAQs+dScDVkZHSSug6pBg9B3dA5gUX5gMXIsWmjABpfJ
         2afSIlfdlwrckYgEkiYtcVO9Da5bVU4wqecRsoE47aQJcLZBrtKmKTcDwDZmeOLOPVAh
         7XGwkVkLxbxLSN8iPs29VTFgzB//jrwacKM2KcJTztaZ+OE+G2h+dNLyT/bYjM5j+7XX
         J9W0tGPpeOq/h2nTZWB/WokqRO05PA/LeWW+hpkdFBZ7ZSuyXG1GKtfjI3/GfTe3x88C
         shJWlq3AzbNgnqzpzi6ehnc140Hoi1z25FZpjvWPmxdCko+F2eapm4+5wnnKAFj//7Oo
         2hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KCigNGcBiwvCtG61bb44O1ve4E/m+Xvu2uWHxdf3dk=;
        b=YlMMaLoe/k43VGevYYTDW1RXyItJnpVqWe+u4ukC7YurpHDnVkxJHbnJHYW2+XVgNg
         IcPENSdN5SHNzskvydTeBFw+srtzwVQk+m0iITR9C7+qoGyUWNqLCr9WVWusAntdcjpU
         3gcjNnrUeP9VaBKviwwHAb/RS77jpz7F9xf8r6oiUBnWAJzyA9RNhp+9wEhzKYWj05fp
         5ARasaqrm7Qi3SO8G92g6xxW3fwv9CKziV9KQadsTrsxTU23ibRVkL/uxmFVW3Y1pl/m
         rD1R1Oc3YTnIHiIzMZzE/cxnOmQMVJU5ubXWrNGYYw/+oLJpLK6uQcCRbHgaUnfrxrfM
         K3cQ==
X-Gm-Message-State: AA+aEWYamSEOUnI+zc1elnssWpnvZv6/l+0YfVMM8r5YpfY8EjboSMuV
        jkZEQUk/l3ygQcxcFVN26An5Jg==
X-Google-Smtp-Source: AFSGD/UpgsZ3Yh1k47CJ57G/yIkfinZ7m1UOzrOeH19rlhldyHzVgVwspqwDG3QjkvF20F0FWqnX+Q==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr6913889plb.312.1542807149668;
        Wed, 21 Nov 2018 05:32:29 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v5sm70635102pgn.5.2018.11.21.05.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 05:32:28 -0800 (PST)
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        pabeni@redhat.com
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
Date:   Wed, 21 Nov 2018 06:32:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121063609.GA109082@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 11:36 PM, Ingo Molnar wrote:
> 
> [ Cc:-ed a few other gents and lkml. ]
> 
> * Jens Axboe <axboe@kernel.dk> wrote:
> 
>> Hi,
>>
>> So this is a fun one... While I was doing the aio polled work, I noticed
>> that the submitting process spent a substantial amount of time copying
>> data to/from userspace. For aio, that's iocb and io_event, which are 64
>> and 32 bytes respectively. Looking closer at this, and it seems that
>> ERMS rep movsb is SLOWER for smaller copies, due to a higher startup
>> cost.
>>
>> I came up with this hack to test it out, and low and behold, we now cut
>> the time spent in copying in half. 50% less.
>>
>> Since these kinds of patches tend to lend themselves to bike shedding, I
>> also ran a string of kernel compilations out of RAM. Results are as
>> follows:
>>
>> Patched	: 62.86s avg, stddev 0.65s
>> Stock	: 63.73s avg, stddev 0.67s
>>
>> which would also seem to indicate that we're faster punting smaller
>> (< 128 byte) copies.
>>
>> CPU: Intel(R) Xeon(R) CPU E5-2650 v4 @ 2.20GHz
>>
>> Interestingly, text size is smaller with the patch as well?!
>>
>> I'm sure there are smarter ways to do this, but results look fairly
>> conclusive. FWIW, the behaviorial change was introduced by:
>>
>> commit 954e482bde20b0e208fd4d34ef26e10afd194600
>> Author: Fenghua Yu <fenghua.yu@intel.com>
>> Date:   Thu May 24 18:19:45 2012 -0700
>>
>>     x86/copy_user_generic: Optimize copy_user_generic with CPU erms feature
>>
>> which contains nothing in terms of benchmarking or results, just claims
>> that the new hotness is better.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>
>> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
>> index a9d637bc301d..7dbb78827e64 100644
>> --- a/arch/x86/include/asm/uaccess_64.h
>> +++ b/arch/x86/include/asm/uaccess_64.h
>> @@ -29,16 +29,27 @@ copy_user_generic(void *to, const void *from, unsigned len)
>>  {
>>  	unsigned ret;
>>  
>> +	/*
>> +	 * For smaller copies, don't use ERMS as it's slower.
>> +	 */
>> +	if (len < 128) {
>> +		alternative_call(copy_user_generic_unrolled,
>> +				 copy_user_generic_string, X86_FEATURE_REP_GOOD,
>> +				 ASM_OUTPUT2("=a" (ret), "=D" (to), "=S" (from),
>> +					     "=d" (len)),
>> +				 "1" (to), "2" (from), "3" (len)
>> +				 : "memory", "rcx", "r8", "r9", "r10", "r11");
>> +		return ret;
>> +	}
>> +
>>  	/*
>>  	 * If CPU has ERMS feature, use copy_user_enhanced_fast_string.
>>  	 * Otherwise, if CPU has rep_good feature, use copy_user_generic_string.
>>  	 * Otherwise, use copy_user_generic_unrolled.
>>  	 */
>>  	alternative_call_2(copy_user_generic_unrolled,
>> -			 copy_user_generic_string,
>> -			 X86_FEATURE_REP_GOOD,
>> -			 copy_user_enhanced_fast_string,
>> -			 X86_FEATURE_ERMS,
>> +			 copy_user_generic_string, X86_FEATURE_REP_GOOD,
>> +			 copy_user_enhanced_fast_string, X86_FEATURE_ERMS,
>>  			 ASM_OUTPUT2("=a" (ret), "=D" (to), "=S" (from),
>>  				     "=d" (len)),
>>  			 "1" (to), "2" (from), "3" (len)
> 
> So I'm inclined to do something like yours, because clearly the changelog 
> of 954e482bde20 was at least partly false: Intel can say whatever they 
> want, it's a fact that ERMS has high setup costs for low buffer sizes - 
> ERMS is optimized for large size, cache-aligned copies mainly.

I'm actually surprised that something like that was accepted, I guess
2012 was a simpler time :-)

> But the result is counter-intuitive in terms of kernel text footprint, 
> plus the '128' is pretty arbitrary - we should at least try to come up 
> with a break-even point where manual copy is about as fast as ERMS - on 
> at least a single CPU ...

I did some more investigation yesterday, and found this:

commit 236222d39347e0e486010f10c1493e83dbbdfba8
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Thu Jun 29 15:55:58 2017 +0200

    x86/uaccess: Optimize copy_user_enhanced_fast_string() for short strings

which does attempt to rectify it, but only using ERMS for >= 64 byte copies.
At least for me, looks like the break even point is higher than that, which
would mean that something like the below would be more appropriate. Adding
Paolo, in case he actually wrote a test app for this. In terms of test app,
I'm always weary of using microbenchmarking only for this type of thing,
real world testing (if stable enough) is much more useful.


diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index db4e5aa0858b..21c4d68c5fac 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -175,8 +175,8 @@ EXPORT_SYMBOL(copy_user_generic_string)
  */
 ENTRY(copy_user_enhanced_fast_string)
 	ASM_STAC
-	cmpl $64,%edx
-	jb .L_copy_short_string	/* less then 64 bytes, avoid the costly 'rep' */
+	cmpl $128,%edx
+	jb .L_copy_short_string	/* less then 128 bytes, avoid costly 'rep' */
 	movl %edx,%ecx
 1:	rep
 	movsb

-- 
Jens Axboe

