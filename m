Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C69C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0525F214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="WyYBHI/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0525F214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeJKEVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:21:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37748 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeJKEVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:21:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so7235443wrd.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkhyl+2r2NL8TyD3Y1w4o8560Blkeu002Iey2TqQo0E=;
        b=WyYBHI/I7EPSksdzZnPySC1hCW6jj/1f0YfSq/lSX7kAYkqv2bMrZcyGhu7OM74Cd6
         QVacQqZUJ3msEuuZLuhbGllf0gFjP7Y7Ecq9P7Ag8K71sz3OmVCgQMoMUTvV3oTkYAWh
         b8sG06TlkG67nfl/EWze7h4aiH/nSE9eZHzVqNdqG7H25F8Kl+YrgbA4pwK4hIhpxs97
         ehQSLrvqQ5cyl7qempE6EOZq/NrKhP3+J1w2/m/BNmCDnCGLQBPNUAZUaD2UeozefI5z
         2s5q0raHMc3xLulW8FKH7qPugEFzNa4h4on2n58kXVJlBvUqBLPgXAo2pr3QS4jRClgl
         0cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkhyl+2r2NL8TyD3Y1w4o8560Blkeu002Iey2TqQo0E=;
        b=FQ1dBaKOPP99wV8VDVPKXbgECo4MzJZcol94f0e9c3lUq4/Mg89Px1M55ntrprSQqQ
         JSxXJVAs6dl6HAaCvqzGD4Ee9lAprJ6dMSS4PSnYbXiZfi6eDwE90vM9d0URQp2eqONH
         EYdw2+5t2Wj7vL/m9qsG+TVefqRjUSBUFFiONaYZ8/zrhSxSRuoNrrLN+6mA7fbbWR2I
         r1a+berjIPOF7gCJ8BgvEhBc4YCWgA+Si7GAS06WEIXweK67cGIDfk6FbVaoFrEmRiog
         MG4XNGw7Qw5cif8KYr9B8myPMktHYd/6aYQLb5fgllpj9z+/Pmwcg8KzELuk2cezfPX7
         QI/w==
X-Gm-Message-State: ABuFfoiqd5q2c6hnwPDVtx7b3cAyz84j8P7VAjdCSjciciCHnAGJ78Zx
        fBxIz1MYGGsHmxssceApUJkLaJk4ldQ2x+CnM4Z37w==
X-Google-Smtp-Source: ACcGV62hJ6bf3hVKABiwtHzZsD8d8orOppK+T1MqB/syuu7DvyhEhUh6Sldrkiin00NXELQ1v+qUZenSD9dreXEjTLI=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr23820193wrc.131.1539205037516;
 Wed, 10 Oct 2018 13:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net> <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181009021710.qwt5hpntyeps44h3@treble> <20181008235750.59da83ae@gandalf.local.home>
 <20181010175237.e7m3sldcu2maoqcq@treble> <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com>
 <20181010181605.arsyjxwdztztrjih@treble> <20181010183330.ootwmz6deazg2k2n@treble>
 <20181010145608.2094d254@gandalf.local.home> <20181010201609.3zwvzpr3ulredpek@treble>
In-Reply-To: <20181010201609.3zwvzpr3ulredpek@treble>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 10 Oct 2018 13:57:05 -0700
Message-ID: <CALCETrXGP_m+Ak8JyWS0aG47tVo7X8+eXMht8JNwQ6V8fvTR1Q@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 1:16 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Oct 10, 2018 at 02:56:08PM -0400, Steven Rostedt wrote:
> > On Wed, 10 Oct 2018 13:33:30 -0500
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > Re-reading your suggestion, I may have misunderstood what you're
> > > suggesting here, but I'm thinking about doing something like what you
> > > proposed earlier:
> > >
> > >     GLOBAL(tramp)
> > >       jmp *current_func(%rip)
> > >     ENDPROC(tramp)
> > >
> > > That is, doing an indirect jump instead of the above direct jump, so
> > > that any previous references to the trampoline would still work (and it
> > > would also work during early boot).
> > >
> > > Though it should probably be a retpoline instead of an indirect jump.
> >
> > But do we care, as it only takes place during text_poke_bp() right?
> >
> > I don't think we need to worry about training trampoline branch
> > prediction that can only be hit when something enables the jump.
>
> Yeah, I guess it depends on if we'd expect anybody (or gcc) to get a
> function pointer to the trampoline itself.  I can just create a warning
> for that in objtool.
>

The jmp * in the trampoline itself is harmless even with Spectre
because it won't ever execute -- static_call_init() should just patch
it out even if the actual call target is never updated.  And gcc has
no business generating any unprotected indirect branches to it from
anywhere else, since, as far as gcc is concerned, they're just like
indirect branches to any other function.
