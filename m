Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAE4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60EF20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOh5R36n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60EF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeK0DFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:05:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34854 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0DFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:05:50 -0500
Received: by mail-io1-f68.google.com with SMTP id u19so14366462ioc.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFa602G6GtEH4ohV2+bgcsHqu0THqSdL/T4lwbW+8YA=;
        b=OOh5R36natz+r1vpNaaaIjSEWLHgK9vALa2K8zy7k2ytYnMsuOuoZXElx7zwyXvl4g
         BRQWceGR0V9sqftdiHqB6MDHhOQkAGKQbF4/FVNl7Ts57wrl29AtchAuUYqxws5B8x6K
         kuvcUQ7yvTOedBcRBoeu0GEosBGztQ+bHarzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFa602G6GtEH4ohV2+bgcsHqu0THqSdL/T4lwbW+8YA=;
        b=gSx0mX8NCtlKmkKa8wlNh+5Ys1IAor+KBZLAlxQa9OgtRiA5YpVP+NHLard7ylUX0r
         F5xtphZXdzzbt61I0NlOC8UtQ697DoTXjDRYF9cqIkw7VNDCbUTF7xBQyCoW0iQUIb8+
         Or4SXvfCWRXtWRtfNdV+HQJwGzGKwWS8XIiYAxxMG7o2TynZ6aGuDUJOXnm2770W7Vps
         vxh6v+agLEOUXpfe0oGapa+cjPNBW0Iq304SYclnmgTA13IqGptfPuMw7Z5R6HxLdG+N
         0N1xAERyV1HcnpmKA86MZyDQUJo1++up/vX92iK7lVJBbaLHFdSMpCrIVmZB4RSwAKLM
         p5Zg==
X-Gm-Message-State: AA+aEWaR/aAkLuTCQCD9QW0MzL1kJ9FZQ9yAqZu9wcMEdgeLs936Z5MX
        PwUFWNKg94vfXs0axpBjFhtKDPGX0Eoi1EgaQ2lrNw==
X-Google-Smtp-Source: AFSGD/VjBNHSjNYBvEg3aiohy0EKFQKKB8vGCNvF9aKD9zsVdxo1aFWvHSyp0xYb03658IGsMarFyyOkWBfR9WgaisM=
X-Received: by 2002:a5d:8402:: with SMTP id i2mr12688974ion.173.1543248677044;
 Mon, 26 Nov 2018 08:11:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543200841.git.jpoimboe@redhat.com> <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160837.GS2113@hirez.programming.kicks-ass.net>
In-Reply-To: <20181126160837.GS2113@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 26 Nov 2018 17:11:05 +0100
Message-ID: <CAKv+Gu8WiBtPJCjBDbOjjsjALHgdgokMCtyAZbSy6NPpxo=usQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com,
        Jessica Yu <jeyu@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 at 17:08, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 26, 2018 at 07:55:00AM -0600, Josh Poimboeuf wrote:
> > +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> > +void arch_static_call_defuse_tramp(void *site, void *tramp)
> > +{
> > +     unsigned short opcode = INSN_UD2;
> > +
> > +     mutex_lock(&text_mutex);
> > +     text_poke((void *)tramp, &opcode, 2);
> > +     mutex_unlock(&text_mutex);
> > +}
> > +#endif
>
> I would rather think that makes the trampoline _more_ dangerous, rather
> than less so.
>
> My dictionary sayeth:
>
>   defuse: verb
>
>     - remove the fuse from (an explosive device) in order to prevent it
>       from exploding.
>
>     - make (a situation) less tense or dangerous
>
> patching in an UD2 seems to do the exact opposite.

That is my fault.

The original name was 'poison' iirc, but on arm64, we need to retain
the trampoline for cases where the direct branch is out of range, and
so poisoning is semantically inaccurate.

But since you opened your dictionary anyway, any better suggestions? :-)
