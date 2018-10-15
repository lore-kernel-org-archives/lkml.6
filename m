Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AABC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E202087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOXbYdqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E202087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeJONAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:00:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJONAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:00:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so19614483wra.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G7scxTHofyfLz6cHewgOfbzH3drfg6Biu7YDoFSBCC4=;
        b=LOXbYdqol7i71SR7DI/E/mJiBgen6/5OLeSNeEmtfgOB1+MwEtMZnzH9aRHNlE0QyO
         ua1ZbjYXuk4ApPs/Co1FXBrZSiVE2tJjI0HYM64C/xnalzWvs+tyZHD/yxpjL9nuzMGQ
         QjcoM7lEcs19xXoUpJa5P7bbcQiWJ0+niIcNoL9fXSZBInMK8PvLNhmI1cfpoI0snKGy
         i7pzbKC6zWCpQ4NVStdgnSTAc7rzAze3/RxnHvMGz1f05Zo0SbJMxGTWp6dbzk4p557G
         QQ74ZtR9X9v31ZKB8b+cHZ3faNEOr8Brd0I21O6617ZHIiZcIauW6Zkb8f6y52vctsiQ
         dlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G7scxTHofyfLz6cHewgOfbzH3drfg6Biu7YDoFSBCC4=;
        b=b2AY54yTe92Ah8MrGVN7dbIz7JrWHfP63jmxtc40G+/1Oggrb6KlGnVOYPeJxMo/gI
         mq1MGeZjc3rIAMYLlHfVFeYLOvJxljxNwcLfymXD070W0RQAtE3jrXqgco99p01hEqHG
         cE3Ig2WmS+NoDS4ivr+KSkbjX5hTLndmclCevUSkMJJwbBKnInmhSBNU3EsMW6P7pVwH
         PN0sSwBjsa/oc+gr0uNs4sZwNKhAgSJkribN/N6AN2rQsu0g2trB8xCtKqb3jLf9IJgn
         7iPOozaG3q/Dfn9lkKIYSNLVW7VxdsgIqldGz7jZI7VQH7qyidGKOvRzMnvcSbKo4b7A
         rSeQ==
X-Gm-Message-State: ABuFfoi4DXizDfpA6QPnCl9t6KTbAUMBi3HI86L4QlQ6q+qtC70QYvpU
        hYUtqpC+lN5J8Q+xFA6fSuc8DqFJjnY=
X-Google-Smtp-Source: ACcGV61fpqtcFEgMk6HLSEQURr9P6KJLgin/isRx9ba0C9Wx5fupd3XEQqeToJTV54PUCaNRqeCRHg==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr13565294wrh.72.1539580627986;
        Sun, 14 Oct 2018 22:17:07 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm7864692wme.30.2018.10.14.22.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 22:17:07 -0700 (PDT)
Date:   Sun, 14 Oct 2018 22:17:05 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     nick.desaulniers@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
Message-ID: <20181015051705.GA20687@flashbox>
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
 <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 08:43:18PM -0700, Andy Lutomirski wrote:
> On Sun, Oct 14, 2018 at 5:37 PM Nick Desaulniers
> <nick.desaulniers@gmail.com> wrote:
> >
> > Fixes the objtool warning:
> > arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
> > instruction
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/204
> > Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> > ---
> >  arch/x86/mm/fault.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 47bebfe6efa7..057d2178fa19 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> >                  * and then double-fault, though, because we're likely to
> >                  * break the console driver and lose most of the stack dump.
> >                  */
> > -               asm volatile ("movq %[stack], %%rsp\n\t"
> > +               asm volatile (UNWIND_HINT_SAVE
> > +                             "movq %[stack], %%rsp\n\t"
> >                               "call handle_stack_overflow\n\t"
> > -                             "1: jmp 1b"
> > +                             "1: jmp 1b\n\t"
> > +                             UNWIND_HINT_RESTORE
> >                               : ASM_CALL_CONSTRAINT
> >                               : "D" ("kernel stack overflow (page fault)"),
> >                                 "S" (regs), "d" (address),
> 
> NAK.  Just below this snippet is unreachable();
> 
> Can you reply with objtool -dr output on a problematic fault.o?  Josh,
> it *looks* like annotate_unreachable() should be doing the right
> thing, but something is clearly busted.
> 
> Also, shouldn't compiler-clang.h contain a reasonable definition of
> unreachable()?
> 
> --Andy

Hi Andy,

Did you mean 'objdump -dr'? If so, here you go (rather long, sorry if I
should have pasted it here instead):
https://gist.github.com/nathanchance/f038bb0a6653b975bb8a4e64fcd5503e

Nathan
