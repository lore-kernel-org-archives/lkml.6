Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE8CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5036920841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5036920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeJHVWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:22:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:53810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbeJHVWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:22:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97952B003;
        Mon,  8 Oct 2018 14:10:56 +0000 (UTC)
Date:   Mon, 8 Oct 2018 16:10:49 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, m.mizuma@jp.fujitsu.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org, lkft-triage@lists.linaro.org
Subject: Re: [tip:x86/boot] x86/kaslr, ACPI/NUMA: Fix KASLR build error
Message-ID: <20181008141049.GG6490@zn.tnic>
References: <20181003123402.GA15494@hirez.programming.kicks-ass.net>
 <tip-3a387c6d96e69f1710a3804eb68e1253263298f2@git.kernel.org>
 <CA+G9fYuLJH6XVsS14xjhSqJsUGZ9NXdyytseT2Pr0hoxOeWfAg@mail.gmail.com>
 <20181008130106.GE6490@zn.tnic>
 <CAK8P3a3Lek2NryUqFZGxSSG2PZD3McS7bezK9Ur3AAX2v6=mgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3Lek2NryUqFZGxSSG2PZD3McS7bezK9Ur3AAX2v6=mgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 03:48:28PM +0200, Arnd Bergmann wrote:
> I think __weak functions are too fragile, when you do this and it
> turns out that another architecture does need to do something,
> you won't ever get any indication of it.
> 
> If we know that arm64 doesn't need to do anything here, just
> add an arch/arm64/include/asm/kaslr.h with an empty function
> there.

I'm looking at fs/proc/vmcore.c and all those other weak functions there
and just doing the same.

Also, judging by

$ git grep CONFIG_PROC_VMCORE

output, ia64, mips and powerpc would need that include too.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
