Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF498C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9718420663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAeOpClr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9718420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394628AbeKVVwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:52:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34454 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732060AbeKVVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:52:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so8871284wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 03:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H1a/enDQ+EYjA4JQtNCBwGiLZKIAqipP5Ygu5oYRf0A=;
        b=VAeOpClrhXd27NhgWnpMRdbhQ2jRTKB47s+pEGnuXHjGEMCgci27C7WQJHWxNrSR8q
         FQhJZBuiklC1JnHYBO/jQxGZJYT66QOx5laueF1/WcmS4Rwy56WIWVJgwh9xQDMCg8vx
         q/0Y9VvTtXtVCw8PSWJZLyq0oosuXqSLUuPuvs7vlpGzIYCiw8ps+uFhCs16O+YpT5Jv
         NTfPDA5OGWtrMdqFKgHXlnFae2kaUlTcNKmbOSom+7YCwF1BA7jXnPs/hp8Xjd9ECTOu
         I//SS/I6CDRS5j7hLv4YX9UyrckjQY8QHsUI/cNvoZilk8YY/O+gKHxLDOS4Qj5zAzee
         YP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1a/enDQ+EYjA4JQtNCBwGiLZKIAqipP5Ygu5oYRf0A=;
        b=YdOSODNfnHKXFTBqUAXl+ldGMWGjNaQ1uGyxYgckrxfWkJL1loPP94vIC7fGnaKLsB
         267iOvjdCphW0Zp6JT0ivfFaKQFqZIe9mFkPUVoRWAjr0iB79j8c6QQJrH076uoDrVWO
         4obAUVwlYClQiI7lsy+HqmmrYaArBtaRnJZHAZk/gxWevATn422IrCyPhoZq7sCy1yWS
         hk8QFfNXa8aEiSOqfTeoJrKxbkrfIWQEgr6GpT3AdlCR3npf43M9ddwc398A7ZubVzb6
         OsXJiruEZZcTVNnWXzLxLPRLLN//T37ksJMdm0Gfd+0+u5j0ZokGtiaZzEbyy+ZrvDhz
         mIAg==
X-Gm-Message-State: AA+aEWbUxxvPhu34GDapQhZJO34MXc3YnrfRnR1ce1nhKxVCnmi7GRJo
        Spz2fvGtpoP2Fsjr+Uz80QY=
X-Google-Smtp-Source: AFSGD/VAp3ca33P0W5wMBQZ+m0DRlDjte7MFzpSqsiqpnQJoRXY1bRFGVCRC1ms/1MKQgd8NoWbwAw==
X-Received: by 2002:adf:b201:: with SMTP id u1mr1088809wra.165.1542885224504;
        Thu, 22 Nov 2018 03:13:44 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v133sm5098944wmd.4.2018.11.22.03.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 03:13:43 -0800 (PST)
Date:   Thu, 22 Nov 2018 12:13:41 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     pabeni@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
Message-ID: <20181122111341.GA107459@gmail.com>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
 <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
 <CAHk-=wiDLq5CVnTJhFNEEduqYP_VSsQPSNvi=w6a8Y9figuh7g@mail.gmail.com>
 <20181122103231.GA102790@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122103231.GA102790@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> The kernel text size reduction with Jen's patch is small but real:
> 
>  text		data		bss		dec		hex	filename
>  19572694	11516934	19873888	50963516	309a43c	vmlinux.before
>  19572468	11516934	19873888	50963290	309a35a	vmlinux.after
> 
> But I checked the disassembly, and it's not a real win, the new code is 
> actually more complex than the old one, as expected, but GCC (7.3.0) does 
> some particularly stupid things which bloats the generated code.

So I dug into this some more:

1)

Firstly I tracked down GCC bloating the might_fault() checks and the 
related out-of-line code exception handling which bloats the full 
generated function.

2)

But with even that complication eliminated, there's a size reduction when 
Jen's patch is applied, which is puzzling:

19563640	11516790	19882080	50962510	309a04e	vmlinux.before
19563274	11516790	19882080	50962144	3099ee0	vmlinux.after

but this is entirely due to the .altinstructions section being counted as 
'text' part of the vmlinux - while in reality it's not:

3)

The _real_ part of the vmlinux gets bloated by Jen's patch:

 ffffffff81000000 <_stext>:

 before:  ffffffff81b0e5e0 <__clear_user>
 after:   ffffffff81b0e670 <__clear_user>:

I.e. we get a e5e0 => e670 bloat, as expected.

In the config I tested a later section of the kernel image first aligns 
away the bloat:

 before: ffffffff82fa6321 <.altinstr_aux>:
 after:  ffffffff82fa6321 <.altinstr_aux>:

and then artificially debloats the modified kernel via the 
altinstructions section:

  before: Disassembly of section .exit.text: ffffffff83160798 <intel_uncore_exit>
  after:  Disassembly of section .exit.text: ffffffff83160608 <intel_uncore_exit>

Note that there's a third level of obfuscation here: Jen's patch actually 
*adds* a new altinstructions statement:

+       /*
+        * For smaller copies, don't use ERMS as it's slower.
+        */
+       if (len < 128) {
+               alternative_call(copy_user_generic_unrolled,
+                                copy_user_generic_string, X86_FEATURE_REP_GOOD,
+                                ASM_OUTPUT2("=a" (ret), "=D" (to), "=S" (from),
+                                            "=d" (len)),
+                                "1" (to), "2" (from), "3" (len)
+                                : "memory", "rcx", "r8", "r9", "r10", "r11");
+               return ret;
+       }
+
        /*
         * If CPU has ERMS feature, use copy_user_enhanced_fast_string.
         * Otherwise, if CPU has rep_good feature, use copy_user_generic_string.
         * Otherwise, use copy_user_generic_unrolled.
         */
        alternative_call_2(copy_user_generic_unrolled,
-                        copy_user_generic_string,
-                        X86_FEATURE_REP_GOOD,
-                        copy_user_enhanced_fast_string,
-                        X86_FEATURE_ERMS,
+                        copy_user_generic_string, X86_FEATURE_REP_GOOD,
+                        copy_user_enhanced_fast_string, X86_FEATURE_ERMS,
                         ASM_OUTPUT2("=a" (ret), "=D" (to), "=S" (from),
                                     "=d" (len)),
                         "1" (to), "2" (from), "3" (len)

So how can this change possibly result in a *small* altinstructions 
section?

4)

The reason is GCC's somewhat broken __builtin_constant() logic, which 
leaves ~10% of the constant call sites actually active, but which are 
then optimized by GCC's later stages, and the alternative_call_2() gets 
optimized out and replaced with the alternative_call() call.

This is where Jens's patch 'debloats' the vmlinux and confuses the 'size' 
utility and gains its code reduction street cred.

Note to self: watch out for patches that change altinstructions and don't 
make premature vmlinux size impact assumptions. :-)

Thanks,

	Ingo
