Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E0AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C1B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlUlgAe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C1B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeILPF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:05:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39034 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:05:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so1693958wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AVTd3+sOUffq5l2eCKhCNGCE+5dC36t/L7Q3RqjEPvk=;
        b=OlUlgAe9nhblb95uIjo0JDQoBX1Uq5I880VVMZCLpQQvi2FkXDI3Jh9R2l3Q+n3IEU
         PigHLgXjp5A+uLA4Tc3roABmp2OhMPsRYiQG5fUqQcUTUFZEQZHCVcvZhPqowl+uJ3qQ
         LTT3OlEM0B8wYHdzGN+Q/Uct352/Ywunf+RUrTaz4Owt0WkubEZJadci5MhMFCRLeMDP
         B8jdKcoynVkjsodug7MK890z+i/AmXRlhm90oiSaCc+9jaw0QUq5Q/G41Wit26APQypL
         eKtGAz0OGFBR/FeffIX81QfEZQ66mRh25b3RHReM2bmPwXJMp/KbTWFcwDehvmHGFR5e
         Lt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVTd3+sOUffq5l2eCKhCNGCE+5dC36t/L7Q3RqjEPvk=;
        b=KZmB2iuX+fv9v9aREfQLTgzvCR+loFBkuebKXyWZLnmvJU4iHl6r3df35OH7PWq511
         wGVIgrzBmjRc3ATUIAf85GgPWQdDcB8PkB0Vx3UkY0FEaC4lrW+nEn8wf7pfAZm8oXx6
         0E3duGV3QokpHnXBa8mXAWT1/85LXNKWcvkVsWhbls8c5I9lpzu4gtwz0m3+adJWwPTX
         tog92cK28t5kGBRwYAzkjdmrhy5dJz1QOOHmUm9RPSTBqvGUig9ZzxsgTBOWeE3wJf9z
         jb9iwCh8uL/u5X4d2NS0xpKH/o7WUEsU5dwZ5EhCjx6oVFlFUhn6DDUwywvOyhgUNzbQ
         XdpQ==
X-Gm-Message-State: APzg51A3vXYUIBHeCBv0wODz5nTFjZpVis0i1J7wUABMZU6Wav7ewN1Y
        c6bEsHpRLFJ9EvRTvkU2ka4=
X-Google-Smtp-Source: ANB0VdaSTFfVjmjWVwQ4oLBbb/xQltLK2Gb7R3clFi3/XgcnCfFn1yWSo2Gh2zrTR6qpkQjHNqBisQ==
X-Received: by 2002:a1c:7412:: with SMTP id p18-v6mr1100397wmc.49.1536746498212;
        Wed, 12 Sep 2018 03:01:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 185-v6sm1301382wmy.38.2018.09.12.03.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 03:01:37 -0700 (PDT)
Date:   Wed, 12 Sep 2018 12:01:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/3] x86/mm/KASLR: Calculate the actual size of
 vmemmap region
Message-ID: <20180912100135.GB3333@gmail.com>
References: <20180909124946.17988-2-bhe@redhat.com>
 <20180910061151.GA85199@gmail.com>
 <20180911073057.GW1740@192.168.1.3>
 <20180911075946.GA97454@gmail.com>
 <20180911081811.GY1740@192.168.1.3>
 <20180911092829.GA9079@gmail.com>
 <20180911120803.GZ1740@192.168.1.3>
 <20180912031808.GC1740@192.168.1.3>
 <20180912063152.GA33500@gmail.com>
 <20180912094118.GD1740@192.168.1.3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912094118.GD1740@192.168.1.3>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> > BTW., isn't that 'vaddr_end for KASLR' entry position inaccurate? In the typical case it could 
> > very well be that by chance all 3 areas end up being randomized into the first 64 TB region, 
> > right?
> 
> Hmm, I think it means the whole space where KASLR can be allowed to
> randomize. [vaddr_start, vaddr_end] is a scope, KASLR algorithm can
> only move memory regions inside this area. It doesn't mean the final
> result of KASLR, or any typical case of them.
> 
> vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
> vaddr_end = CPU_ENTRY_AREA_BASE;

Ok.

> > > With this superfluous address space as well as changing the starting address
> > > of each memory region to be PUD level, namely 1 GB aligned, we can have
> > > thousands of candidate position to locate those three memory regions.
> > 
> > Would be nice provide the number of bits randomized, maximum, from which the number of GBs of 
> > physical RAM has to be subtracted.
> > 
> > Because 'thousands' of randomization targets is *excessively* poor randomization - caused by 
> > the ridiculously high rounding to 1GB. It would be _very_ nice to extend randomization to at 
> > least 2MB boundaries instead. (If the half cacheline of PTE entries possibly 'wasted' is an 
> > issue we could increase that to 128 MB, but should start with 2MB first.)
> > 
> > That would instantly multiply the randomization selection by 512 ...
> 
> This may involve critical code changes. E.g in below commit, when we
> copy page table, we just need go deep into PUD level since PAGE_OFFSET
> is PUD_SIZE aligned, now if 2M aligned, we need deep into PMD level. I
> can only think of this about this issue. Surely, I can do more
> investigation and see what need be done to achieve the goal.

Yeah, would be nice to do, it would also test the robustness of all this code.
Obviously done after the cleanups, fixes and simpler changes.

It would be a _really_ nice feature adding about 9 bits of absolute randomization and 3x9 bits 
of relative randomization between the ranges.

> Sure, will do according to your suggestion.

Thanks!!

	Ingo
