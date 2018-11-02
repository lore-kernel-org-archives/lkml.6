Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E7AC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279802082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZozdUsSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279802082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeKCEg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:36:28 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53810 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKCEg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:36:28 -0400
Received: by mail-it1-f194.google.com with SMTP id r12-v6so1858498ita.3;
        Fri, 02 Nov 2018 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iC3VDb6WFp9Zf4oRN8zLJcW+rc8403LTmcprf1Vhulk=;
        b=ZozdUsSKBBjdTwWah/kjz17GgPiGzL1vdv7eAOGxdRPu6gxVJG7h3/dfivK0HCEXPq
         sTWXV8Siy3p54TSag/jX2095FnHwjy+yfGwdXu2kPNdfHq2HfRawtfwjUoyXG0pZmuC8
         naLeplMRceAooLngUVTZnpcOmeTdnEL/m/mj2+H+qEQmLun3eqQKEg3MHjysaP90eoMb
         m6tPguw9rQaP66NWgSxUnqSn/cTZF7pkwJSmqgcHO5kWo8g/CGoQMFPWlRx08HyACOJg
         Gw4Et+hnrrm2b5ZEahe/PnFQo3m6olK+asDqnnXlqYcoB0Y72qMTgtkdLeNduVq3INaL
         nbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iC3VDb6WFp9Zf4oRN8zLJcW+rc8403LTmcprf1Vhulk=;
        b=G2AX/GtSLsEROmdf3cKqJIYdkAGPRWmQZ9pbmC00V7ixO9QBd7oNpKrqJ3upkNAysg
         Y3EP3h973bXzsRa7usNf3oyVqebC7uH9bCXqUkUURiOoD9pcRmQUPITuUUZfOwVmkT2k
         +IR1wtL+LnZUowiNrpn1sJLwbBWRZoS/hEoLjFN9HTN6uqS0H7L66C7Sp9bXOPwWznyi
         uAseOJOTMAwykVWZijbW+oTjworxDaOJMhYaw3rkc7RN1zreanP+BbR3AEN3i/HkuLO2
         6h90jOQyLt6HdOtb3ekvYab/N6XYw1d3rXjj6aR8PQRF4RXjzJV+L51t3LG8TdhZL3NA
         NAZg==
X-Gm-Message-State: AGRZ1gKM2+G8xuZTMEkZrIroxayKycUGTB0ejlzIzVE8nrJy0uoQOTRy
        JHvzAGNrg4ZwtcPla8gyhcurbjA96qX/X3Sut4M=
X-Google-Smtp-Source: AJdET5fOFFajB9riz5RsQfJXpizxST/nOAxQZViXwm1TlSPcoJEB+SYxxuZ0MzTYEaVzkTn+dixeYHnk4WdZuHq4RU8=
X-Received: by 2002:a02:601c:: with SMTP id i28-v6mr12075369jac.105.1541186882251;
 Fri, 02 Nov 2018 12:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <313542172.8.1541171544337.JavaMail.zimbra@efficios.com>
In-Reply-To: <313542172.8.1541171544337.JavaMail.zimbra@efficios.com>
From:   Andrew Pinski <pinskia@gmail.com>
Date:   Fri, 2 Nov 2018 12:27:49 -0700
Message-ID: <CA+=Sn1=9Sm+A+kdfcHxXVcjY5Zhm=YouGqK6kDjnYg7g5+oddA@mail.gmail.com>
Subject: Re: Supporting core-specific instruction sets (e.g. big.LITTLE) with
 restartable sequences
To:     mathieu.desnoyers@efficios.com
Cc:     Richard Henderson <rth@twiddle.net>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Joseph S. Myers" <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bmaurer@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        boqun.feng@gmail.com, davejwatson@fb.com, pjt@google.com,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 8:12 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hi Richard,
>
> I stumbled on these articles:
>
> - https://medium.com/@jadr2ddude/a-big-little-problem-a-tale-of-big-little-gone-wrong-e7778ce744bb
> - https://www.mono-project.com/news/2016/09/12/arm64-icache/
>
> and discussed them with Will Deacon. He told me you were looking into gcc atomics and it might be
> worthwhile to discuss the possible use of the new rseq system call that has been added in Linux 4.18
> for those use-cases.
>
> Basically, the use-cases targeted are those where some cores on the system support a larger instruction
> set than others. So for instance, some cores could use a faster atomic add instruction than others, which
> should rely on a slower fallback. This is also the same story for reading the performance monitoring
> unit counters from user-space: it depends on the feature-set supported by the CPU on which the instruction
> is issued. Same applies to cores having different cache-line sizes.
>
> The main problem is that the kernel can migrate a thread at any point between user-space reading the
> current cpu number and issuing the instruction. This is where rseq can help.
>
> The core idea to solve the instruction set issue is to set a mask of cpus supporting the new instruction
> in a library constructor, and then load cpu_id, use it with the mask, and branch to either the new or
> old instruction, all with a rseq critical section. If the kernel needs to abort due to preemption or
> signal delivery, the abort behavior would be to issue the fallback (slow) atomic operation, which
> guarantees progress even if single-stepping.
>
> As long as the load, test and branch is faster than the performance delta between the old and new atomic
> instruction, it would be worth it.
>
> In the case of PMU read from user-space, using rseq to figure out how to issue the PMU read enables a
> use-case which is not otherwise possible to do on big.LITTLE. On rseq abort, it would fallback to a
> system call to read the PMU counter. This abort behavior guarantees forward progress.
>
> The second article is about cache line size discrepancy between CPUs. Here again, doing the cacheline
> flushing in a rseq critical section could allow tuning it to characteristics of the actual core it is
> running on. The fast-path would use a stride fitting the current core characteristics, and if rseq
> needs to abort, the slow-path would fall-back to a conservative value which would fit all cores (smaller
> cache line size on the overall system). Once again, this abort behavior guarantees forward progress.
> This would only work, of course, if cacheline invalidation done on a big core end up being propagated
> to other cores in a way that clears all the cache lines corresponding to the one targeted on the big
> core.

Cache flusing is only one thing that deals with cache line sizes
difference.  Another thing which either needs to be emulated in the
software or disable is the "dc ZVA" instruction which is used in
memset.
There are most likely eithers too.  For an example, dealing with dmb/dsb sizes.

Thanks,
Andrew

>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
