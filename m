Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DD6C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472AD20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj6UNKzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472AD20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIKTJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKTJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:09:45 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4648D2087F;
        Tue, 11 Sep 2018 14:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536675015;
        bh=lpypdIJMUc/ueYUTDZs/Ry0F0/ITDhjKN5Mf4yv+grg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mj6UNKzokGO8y+ajy2Wpwu6Rjzvz+b7Tx2cevM3saQ+O5NAzHDoSeFbseUwOBUEsW
         ncHy1hrxcFc0atgsNQZ8189b5wv3mflyytXOYaDGjB9QFtIxfKiaEuKA0Aj6aw16dR
         78i84JcaMWqSTFD5xit0jB3FPo0vipiu9o+ycjj8=
Date:   Tue, 11 Sep 2018 23:10:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnd@arndb.de
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-Id: <20180911231012.fdc45840f3d91860daa2e180@kernel.org>
In-Reply-To: <20180911204925.8b6dbbfd9e48369d931cafa2@kernel.org>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
        <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
        <20180828072333.36af4d5d@canb.auug.org.au>
        <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
        <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
        <20180907014209.49e2940f74615a1e4f544ffd@kernel.org>
        <ebad9c9d-a7d0-44cc-f000-bf5e500fcd24@linux.ibm.com>
        <20180908125749.9c903e507a33046d5586e841@kernel.org>
        <1de08f6a-7c9e-1a75-e3bd-e8bcf99f5e35@linux.ibm.com>
        <20180911204925.8b6dbbfd9e48369d931cafa2@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 20:49:25 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 10 Sep 2018 15:27:20 +0200
> Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
> 
> > On 08.09.2018 05:57, Masami Hiramatsu wrote:
> > > On Fri, 7 Sep 2018 14:50:59 +0200
> > > Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
> > > 
> > >> On 06.09.2018 18:42, Masami Hiramatsu wrote:
> > >>> Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
> > >>>> I've attached a quick fix that should address both problems. I'd
> > >>>> appreciate if this patch could get some testing before I post proper fix
> > >>>> patches.
> > >>>
> > >>> Hmm, I'm still not able to reproduce it on powerpc cross build even with
> > >>> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y ... So, sorry I couldn't test this patch.
> > >>
> > >> Maybe this is related to the compiler/binutils versions used. I'm using
> > >> Fedora 28's gcc-powerpc64 and binutils-powerpc64 packages:
> > >>
> > >> powerpc64-linux-gnu-gcc (GCC) 7.1.1 20170622 (Red Hat Cross 7.1.1-3)
> > >> GNU ld version 2.29.1-4.fc28
> > >>
> > >> For reference I'm also attaching the config that I used to reproduce the
> > >> problem on kernel v4.18.
> > >>
> > >>>> diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
> > >>>> index ae5fdff18406..2ca33277a28b 100644
> > >>>> --- a/arch/arm/kernel/vmlinux.lds.h
> > >>>> +++ b/arch/arm/kernel/vmlinux.lds.h
> > >>>> @@ -48,6 +48,7 @@
> > >>>>
> > >>>>  #define ARM_DISCARD							\
> > >>>>  		*(.ARM.exidx.exit.text)					\
> > >>>> +		*(.ARM.exidx.text.exit)					\
> > >>>
> > >>> BTW, why would we need this?
> > >>
> > >> That's necessary to fix one of the two ARM linker failures reported via
> > >> https://lkml.org/lkml/2018/8/24/345
> > >>
> > >>>>> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> > >>>>> kernel/trace/trace_clock.o: defined in discarded section `.text.exit'
> > >>>>> of kernel/trace/trace_clock.o
> > >>
> > >> Section ".ARM.exidx.text.exit" refers to ".text.exit" which was
> > >> discarded. With the change above, the extraneous section
> > >> ".ARM.exidx.text.exit" is also discarded, resolving the linker failure.
> > > 
> > > OK, so your patch fixes following issue too?
> > > 
> > > https://patchwork.kernel.org/patch/10584685/
> > 
> > Yes it does, by discarding the text.exit section unconditionally. I
> > don't think we need to keep any exit-related section introduced by GCOV
> > profiling. It is my understanding that the code contained in such a
> > section is only relevant for user-space profiling, to process profiling
> > data when a program ends.
> > 
> > Also discarding .ARM.exidx.text.exit seems to be more consistent to how
> > .ARM.exidx.exit.text is handled.
> > 
> > > In that case, we should drop above patch.
> > 
> > Yes, I agree.
> 
> Hm, with your patch (on linus tree), I still have this error on arm cross build.
> 
>   CC      init/version.o
>   AR      init/built-in.a
>   AR      built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> `.exit.text' referenced in section `.alt.smp.init' of net/dns_resolver/dns_key.o: defined in discarded section `.exit.text' of net/dns_resolver/dns_key.o

Ah, sorry, this is not from GCOV, but alternatives for SMP.
This should be a different issue.

> 
> I attached my config.
> 
> Since this comes from section discarding, with my patch (which prevent discarding) this error didn't happen.

So, this is just a side effect. your patch is good when CONFIG_DNS_RESOLVER=n

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
