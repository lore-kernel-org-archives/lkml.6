Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B376AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2B72145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBDMtkD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2B72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeIYQAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:00:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37502 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:00:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id x26-v6so822363pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jO8dM8uwcENMj1vQnR71CJt1KUoYYsaILEuvB1k+jFw=;
        b=dBDMtkD0dHgrYGio5/CjqZLDvYYkth0zic3tU8F3LX5CfLfCp5jG51pyMD5wKpCVz2
         xVd8bvm25sr33BVDuFKSM7GQnBDsdsd45rWGfHXa2L2aZUnordN/PGqEQmmJiHt/Tomz
         TAbSQO/qodmxx+PVYbmcuw9Mo9wbQ4Bu3n8Tr+LbmsS52Q588svr5kCPWufirsKmU+4K
         o+WaVaXdN2fTLPyyvu9rVAVxtpHNlsJ5WkPXmGOg1LFEV98I0bnpwTHFVgDbZwJfuGB3
         5RQjhzxMGw0WdWcFAw9HVmnOWrYlk6825EMI1wZqybsiH06Ycl5oGzuBsF8x4COwEdIe
         jfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jO8dM8uwcENMj1vQnR71CJt1KUoYYsaILEuvB1k+jFw=;
        b=BrGdMLvhPdN7CGHCvPAVe52ok1tTHC1evL9Z2aMIGMUes/orHYwPnpSmkjNyDrXJ/D
         59UEXuy4FIPE5y0deP1utbJGgYCOT9OELCWpAkv/CPM6GLjI0yHluDLObGPW2EezBdO7
         h3lgknEkRXJmD7fxPcqXSMuMADYuFqTZkHGWBMKmDsMOIzdND8uD8ZmpYddeO/JMPZNH
         v7f+21RdxAlXe8hgZ9opI+4epzzcDSmp9mb/z0ulCO0zX9MfHmSv+ly2xqf4N9GVEKJN
         Y6mVrwhkT3d7t5cddnbaZF/g9EO4gx0Ri7PVWY32Epzmsz9DmqAc3DHpQBDeEWoKgyKw
         UYUA==
X-Gm-Message-State: ABuFfogVv/REM6mp7pg4Jrg05fh1p2QKbSPaCeXORdcwZhRLoJbrwrPB
        v9H3iRXhkwnXdwwDV1J6gPM=
X-Google-Smtp-Source: ACcGV63QuIY18XZiYb1/wKCrpJdfOXlFZkpJUha2i1AnTENnc6UuduGLc23O1TMy8ioX9WZ4GvoJtg==
X-Received: by 2002:a17:902:bd87:: with SMTP id q7-v6mr292817pls.85.1537869204638;
        Tue, 25 Sep 2018 02:53:24 -0700 (PDT)
Received: from toy ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id b3-v6sm4306219pgm.74.2018.09.25.02.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 02:53:24 -0700 (PDT)
Date:   Tue, 25 Sep 2018 17:53:16 +0800
From:   Jun Yao <yaojun8558363@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
Message-ID: <20180925095316.GA27420@toy>
Mail-Followup-To: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180924171936.q5bfvczzllmm5lpe@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924171936.q5bfvczzllmm5lpe@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Sep 24, 2018 at 06:19:36PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Mon, Sep 17, 2018 at 12:43:27PM +0800, Jun Yao wrote:
> > Version 5 changes:
> > 	1. Correct spelling and indentation errors[1].
> > 	2. Update init_mm.pgd by assembly[2].
> > 	3. Simplify set_p?d() by introducing set_swapper_pgd()[3].
> > 	4. Reduce unnecessary tlbi for every write to swapper_pg_dir
> > 	   during paging_init()[3].
> > 
> > v4: https://www.spinics.net/lists/arm-kernel/msg672195.html
> > v3: https://www.spinics.net/lists/arm-kernel/msg662537.html
> > v2: https://patchwork.kernel.org/patch/10485641/
> > v1: https://patchwork.kernel.org/patch/10476595/
> > 
> > [1] https://www.spinics.net/lists/arm-kernel/msg675189.html
> > [2] https://www.spinics.net/lists/arm-kernel/msg675193.html
> > [3] https://www.spinics.net/lists/arm-kernel/msg675196.html
> > 
> > Jun Yao (6):
> >   arm64/mm: Introduce the init_pg_dir.
> >   arm64/mm: Pass ttbr1 as a parameter to __enable_mmu().
> >   arm64/mm: Create the initial page table in the init_pg_dir.
> >   arm64/mm: Create the final page table directly in swapper_pg_dir.
> >   arm64/mm: Populate the swapper_pg_dir by fixmap.
> >   arm64/mm: Move {idmap_pg_dir .. swapper_pg_dir} to rodata section.
> > 
> >  arch/arm64/include/asm/assembler.h | 29 ++++++++++++++++++
> >  arch/arm64/include/asm/pgtable.h   | 36 ++++++++++++++++++----
> >  arch/arm64/kernel/asm-offsets.c    |  1 +
> >  arch/arm64/kernel/head.S           | 48 ++++++++++++++++++++----------
> >  arch/arm64/kernel/sleep.S          |  1 +
> >  arch/arm64/kernel/vmlinux.lds.S    | 47 +++++++++++++++++++----------
> >  arch/arm64/mm/mmu.c                | 45 +++++++++++++---------------
> >  7 files changed, 147 insertions(+), 60 deletions(-)
> 
> I've pushed a branch with the cleanups I requested [1] folded in.
> 
> I'm still a bit worried about the pgd lock, but otherwise I think this
> is sound. I intend to throw some testing at it, just in case.
> 
> If you're happy with that branch, I'll ask Will and Catalin to consider
> picking it up.

This branch looks great. Thank you for improving my patch.

Is there anything I need to do? This is my first time to submit a patch,
so I am a bit overwhelmed. I think I should wait for other people to
review my patch. If there is a problem, I need to fix it.

Thanks,

Jun
