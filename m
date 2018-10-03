Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D180C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB012089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK9y7v1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB012089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeJDAW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:22:59 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55732 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDAW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:22:59 -0400
Received: by mail-wm1-f54.google.com with SMTP id 206-v6so6530080wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JZXTv6LA8C+zkzRu8cAc6B3Kv9WiIyS9UxmZRCW1FU0=;
        b=IK9y7v1FiDSbqyF91icddMXdzdf1i4QYpe1UM2X7GfXdP42+9AbNvmFspG9Y3C2xW4
         5cGbTgzNPAnN+J12Oe9ifVoQjQ/I3UrzcJ0H1481vYbLDEZptwZwkbyxxFUKOrdUxuBf
         7bIh1ldDiDHueCOtJt0+wPyS7XHda86UCi+m1eV3pd4WudiBn1c+8NPR65Wi/xm5zH/X
         9X5FP8Hsl9VuG/zo8VYXaaNgNytS2Ghjll7ZYGe8P5bfTA7llpjHNwXpbfIBaEIAeA4a
         xMRXlGA4cFLAbDSNihdjplyKPYfnDI5FzHt5DkpNoiosXCCys6Ov+VkgZVkHR3yLZ4m4
         gBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZXTv6LA8C+zkzRu8cAc6B3Kv9WiIyS9UxmZRCW1FU0=;
        b=Cwg1EcUrQpWd8ejfQngKh3cQmXSnI7pnofM7ovGRgseUwaXwa1u8nGfXw9hmB+KfyQ
         RHWSlnKIwA3AhjEiejYCUPRtkTcY5aUKU7QWa3gFDoBRNzTguTOToYAFpFmj/IPdTbXV
         VppSfF2OwYtpLnONWCdogXc4vXFSzjR6AwFL7Kizje1En8CACptYEa1Q0LpjOE6af9i5
         Z5w6g7NPD9Hx8dQxhulbERGY64KkBSHAWp87k/V8Io+CY/dkLtn3fRU8PJumxhFSxc7E
         jzoSxYJzmZcfqj8/5lSIA1ILnZ34Kw2iOj1HtVcis/Ur4psZrPHyBEj/kpzAJguJoFsU
         SB3Q==
X-Gm-Message-State: ABuFfojzdzSydgeh43wkygS5oFtNSmaXl5Qv26/s2ULc3TD2O7+GnPup
        kb3QTD6aufXomNZD2Dyypa8=
X-Google-Smtp-Source: ACcGV60/OsccNanZ5bqKrzL8dZADGFqcRnJnSGkBtTlj+6Ns4f/DSPKpey/czz+HB+4rDXnll+E1OA==
X-Received: by 2002:a1c:7ed4:: with SMTP id z203-v6mr2167993wmc.62.1538588015419;
        Wed, 03 Oct 2018 10:33:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v1-v6sm1943951wrd.24.2018.10.03.10.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 10:33:34 -0700 (PDT)
Date:   Wed, 3 Oct 2018 19:33:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: X86-64 uses generic string functions (strlen, strchr, memcmp,
 ...)
Message-ID: <20181003173332.GA4654@gmail.com>
References: <CAG48ez30qnKuWHkzkkxxEhBPjVVnsgA1wSarfvx=U=Jb0maO0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez30qnKuWHkzkkxxEhBPjVVnsgA1wSarfvx=U=Jb0maO0Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jann Horn <jannh@google.com> wrote:

> Hi!
> 
> I noticed that X86-64 is using the generic string functions from
> lib/string.c for things like strlen(), strchr(), memcmp() and so on.
> Is that an intentional omission, because they're not considered worth
> optimizing, or is this an oversight? The kernel doesn't use string
> functions much, but if you e.g. run readlinkat() in a loop on a
> symlink with a 1000-byte target, something around 25%-50% of time are
> spent on strlen(). But that's a microbenchmark that people probably
> don't care about a lot?
> 
> One notable in-kernel user of memcmp() is BPF, which uses it for its
> hash table implementations when walking the linked list of a hash
> bucket. But I don't know whether anyone uses BPF hash tables with keys
> that are sufficiently large to make this noticeable?

One reason we've been resisting this is how hard it is to determine whether a 
micro-optimization truly helps application workloads.

But there's a way:

 - Write a 'perf bench vfs ...' kind of scalability microbenchmark that
   runs in less than 60 seconds, provides stable numeric output, can
   meaningfully measured via 'perf', etc., which does multi-threaded
   or multi-tasked, CPU-bound VFS operations intentionally designed
   to hit these string ops.

 - Use this benchmark to demonstrate that the performance of any of the
   string ops matters.

 - Implement nice assembly speedups.

 - If the functions are out of line then add a kernel patching based method
   to run either the generic string function or the assembly version -
   a static-key based approach would be fine I think. This makes the two
   versions runtime switchable.

 - Use the benchmark again to prove that it indeed helped this particular
   workload. It can be a small speedup but has to be a larger signal than the
   "perf stat --null --repeat 10 ..." stddev.

Then that offers a maintainable way to implement such speedups:

 - The 'perf bench vfs ...' testcase and the kernel-patching debug knobs allows other to 
   replicate and check out other hardware.  Does the assembly function written on contemporary 
   Intel hardware work equally well on AMD hardware? People can help out by running those 
   tests.

 - We can go back and check the difference anytime in the future, once new CPUs arrive,
   or a new variant of the benchmark is written, or a workload is hurting.

If you do it systematically like that then I'd be *very* interested in merging both the tooling 
(benchmarking) and any eventual assembly speedups.

But it's quite some work - much harder than just writing a random assembly variant and using it 
instead of the generic version.

Thanks,

	Ingo
