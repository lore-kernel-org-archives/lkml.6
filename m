Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC2AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6FF208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544248626;
	bh=O1cX5Q6qkk9eBP9n2cyELXrBsNHGpttVSDehdnAqmvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NlqEbhoL0LkemkQ5VacyM7UCJAZfk/C8omJPI28362cT2iBEwSt5HuXeD8+bP7I2D
	 4I8T2+rrLGsLPvb/wNGQi6q8aJKZuS8YWlcVw39yi1c8G09E+CtiX3WGbDwkVskWG0
	 MapEd9avLfwXB7KXECmFpPAZEBxQOk3QoKLWh50g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6FF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbeLHF5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 00:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbeLHF5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 00:57:03 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB40C2083D;
        Sat,  8 Dec 2018 05:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544248622;
        bh=O1cX5Q6qkk9eBP9n2cyELXrBsNHGpttVSDehdnAqmvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kpsIE9sNdqRC7CjXkwzku/ynT6Lw3YTddAmCh2eVhY880q+fsxuBABp7DkYZu7ue3
         2Dr6PqF+L7wzXFjyzFx2MKsKNtsxsmEIBEVoVJc/jos1l96N9d483A6fplQV47H4KL
         rr6gul35kKpnIah+3cMQO4T0ep2iF9i1SA3tDmKE=
Date:   Sat, 8 Dec 2018 14:56:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Message-Id: <20181208145658.4de9cfedcd265bcba4b252d0@kernel.org>
In-Reply-To: <20181207194847.GG9385@zn.tnic>
References: <20181205101131.28996-1-bp@alien8.de>
        <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
        <20181205142448.GH29510@zn.tnic>
        <20181205162526.GB109259@gmail.com>
        <20181205171547.GM29510@zn.tnic>
        <20181207234210.c29731b7a481c74a4e57220c@kernel.org>
        <20181207194847.GG9385@zn.tnic>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 20:48:47 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Dec 07, 2018 at 11:42:10PM +0900, Masami Hiramatsu wrote:
> > Hmm, I just thought that the symbol only referred from inline asm should
> > be visible. But if it is OK for any version of supported gcc and clang,
> > I'm good to remove it. :-) (IOW, I just concerned about older gcc)
> 
> I just tried two gcc versions: 8.2 and 4.8.5. Both asms looks good:
> 
> ffffffff81044690 <kretprobe_trampoline>:
> ...
> 
> 
> ffffffff810446ab:       41 57                   push   %r15
> ffffffff810446ad:       48 89 e7                mov    %rsp,%rdi
> ffffffff810446b0:       e8 db 01 00 00          callq  ffffffff81044890 <trampoline_handler>
> 
> there's the CALL...
> 
> ffffffff810446b5:       48 89 84 24 98 00 00    mov    %rax,0x98(%rsp)
> ffffffff810446bc:       00
> 
> ... and the handler is at the expected address.
> 
> ffffffff81044890 <trampoline_handler>:
> ffffffff81044890:       e8 ab c9 7b 00          callq  ffffffff81801240 <__fentry__>
> ffffffff81044895:       41 57                   push   %r15
> ffffffff81044897:       41 56                   push   %r14
> ffffffff81044899:       41 55                   push   %r13
> ffffffff8104489b:       49 89 fd                mov    %rdi,%r13
> 
> Dunno, if you feel like there might be some trouble with some compilers,
> I can keep the hunk below as a separate patch and revert it when it
> explodes somewhere...?

OK, then please remove it. :-) Even if any problem occurs, which must be
build error, so we can revert it in that case.

Thank you!

> 
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Thank you,
> > 
> > > 
> > > ---
> > > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > > index 6480056d370f..308bf103cc73 100644
> > > --- a/arch/x86/kernel/kprobes/core.c
> > > +++ b/arch/x86/kernel/kprobes/core.c
> > > @@ -66,8 +66,6 @@
> > >  
> > >  #include "common.h"
> > >  
> > > -void *trampoline_handler(struct pt_regs *regs);
> > > -
> > >  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
> > >  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> > >  
> > > @@ -753,7 +751,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> > >  /*
> > >   * Called from kretprobe_trampoline
> > >   */
> > > -__visible __used void *trampoline_handler(struct pt_regs *regs)
> > > +static __used void *trampoline_handler(struct pt_regs *regs)
> > >  {
> > >  	struct kretprobe_instance *ri = NULL;
> > >  	struct hlist_head *head, empty_rp;
> > > 
> > > -- 
> > > Regards/Gruss,
> > >     Boris.
> > > 
> > > Good mailing practices for 400: avoid top-posting and trim the reply.
> > 
> > 
> > -- 
> > Masami Hiramatsu <mhiramat@kernel.org>
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
