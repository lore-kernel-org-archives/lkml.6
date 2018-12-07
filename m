Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB9C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E952082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NGoe+yEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E952082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLGTs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:48:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55506 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeLGTs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:48:58 -0500
Received: from zn.tnic (p200300EC2BCEC900504308BAD9A4A5FF.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:c900:5043:8ba:d9a4:a5ff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBB4F1EC096B;
        Fri,  7 Dec 2018 20:48:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544212137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NHW1MvmW9iO8UNV1X2UmkYEGH8/7sq7dr1ZOx1pcmuQ=;
        b=NGoe+yEp1IxkmYBCBWMfOQ4zTVXeEYuNPEggLS1Sk8pfZNihqG5KMoS6KlvABndmlH6zqv
        2RtTfJurDUzJmkiM2gZBVhCphADYwG8FHbQk3NMq/eQ4l0HI67S8dW/PNihh39FSB3gUf2
        lpIzVybIJXsTa9fYJHARg5Y4SHZPbKE=
Date:   Fri, 7 Dec 2018 20:48:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20181207194847.GG9385@zn.tnic>
References: <20181205101131.28996-1-bp@alien8.de>
 <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
 <20181205142448.GH29510@zn.tnic>
 <20181205162526.GB109259@gmail.com>
 <20181205171547.GM29510@zn.tnic>
 <20181207234210.c29731b7a481c74a4e57220c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207234210.c29731b7a481c74a4e57220c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:42:10PM +0900, Masami Hiramatsu wrote:
> Hmm, I just thought that the symbol only referred from inline asm should
> be visible. But if it is OK for any version of supported gcc and clang,
> I'm good to remove it. :-) (IOW, I just concerned about older gcc)

I just tried two gcc versions: 8.2 and 4.8.5. Both asms looks good:

ffffffff81044690 <kretprobe_trampoline>:
...


ffffffff810446ab:       41 57                   push   %r15
ffffffff810446ad:       48 89 e7                mov    %rsp,%rdi
ffffffff810446b0:       e8 db 01 00 00          callq  ffffffff81044890 <trampoline_handler>

there's the CALL...

ffffffff810446b5:       48 89 84 24 98 00 00    mov    %rax,0x98(%rsp)
ffffffff810446bc:       00

... and the handler is at the expected address.

ffffffff81044890 <trampoline_handler>:
ffffffff81044890:       e8 ab c9 7b 00          callq  ffffffff81801240 <__fentry__>
ffffffff81044895:       41 57                   push   %r15
ffffffff81044897:       41 56                   push   %r14
ffffffff81044899:       41 55                   push   %r13
ffffffff8104489b:       49 89 fd                mov    %rdi,%r13

Dunno, if you feel like there might be some trouble with some compilers,
I can keep the hunk below as a separate patch and revert it when it
explodes somewhere...?

> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you,
> 
> > 
> > ---
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index 6480056d370f..308bf103cc73 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -66,8 +66,6 @@
> >  
> >  #include "common.h"
> >  
> > -void *trampoline_handler(struct pt_regs *regs);
> > -
> >  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
> >  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> >  
> > @@ -753,7 +751,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> >  /*
> >   * Called from kretprobe_trampoline
> >   */
> > -__visible __used void *trampoline_handler(struct pt_regs *regs)
> > +static __used void *trampoline_handler(struct pt_regs *regs)
> >  {
> >  	struct kretprobe_instance *ri = NULL;
> >  	struct hlist_head *head, empty_rp;
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > Good mailing practices for 400: avoid top-posting and trim the reply.
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
