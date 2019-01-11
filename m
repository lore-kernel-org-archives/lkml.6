Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684A6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3944A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EU2LDmaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfAKUrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:47:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42139 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfAKUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:47:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so14069118lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xiz1AmOzy/ByGNqNChkzXJ1iGhA9KMYgWTx3xlbkeA8=;
        b=EU2LDmaF072sHlPiWXu4RcpOHTSBfi40aFP9bGzCo3wRHUnC4ZtrBHk+9U7Yd6dXmD
         6aNlIXMKAsB/zke9cJczPxhQ/J/mmmPBUlTJcOBld7tqW7pMFgpWNLljMp4vvnSiP3kf
         JNxw53VwMDQDjPjcZtgn64+ckXvNZrBscPAk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xiz1AmOzy/ByGNqNChkzXJ1iGhA9KMYgWTx3xlbkeA8=;
        b=lPcbHVtUrMBuU2GRifKX94LnJx3KRQf4jbwCwUF28c0x6OWNq47NCOLHJfKUsJjBCH
         vKJSOSvr43DbFLXBm4Sh2AARU59muwTkawZkeHW4wfTRPxTPTSa5cq2dGRKsIWAO+SnY
         A3omkAm1PHQ4Bj5ImogVGJ0adr/ypMr++aiBIMOduKYBMqoiiN9mk1bzJ0QBoMuxUcIq
         cCudtMErHFxahV12ufMbt/26b6Dz0KqnOyQcaGNLOKh4rmuOLae34mSbWHx7UzLy7XuM
         dxbK3K0KNGV/G6YM/h2p0YmU+kf+r0GKojw+R2KjkrguLi1FBl8M/1xgAII9Xh9xhFb3
         5cBA==
X-Gm-Message-State: AJcUukeEyhqTCAvCiVccv+ogCVLd8XFj4MyyhmZpBsVB8+V0eNDlLdfw
        se4S3nj+UHkPKwEndCORmEmXcbXYZGU=
X-Google-Smtp-Source: ALg8bN6im++d6PqO9jgcWr0ptHoCEQ0gI00FD8J+f9YQx6pZcDSJx6ggf9Lq0T3adfk+3+QGK+/HQw==
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr8090565lje.115.1547239618374;
        Fri, 11 Jan 2019 12:46:58 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v19sm14833516lfe.69.2019.01.11.12.46.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 12:46:57 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id u89-v6so14105615lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:46:56 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr8987490lja.148.1547239616134;
 Fri, 11 Jan 2019 12:46:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble> <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble>
In-Reply-To: <20190111203135.5clurevf34bkiy3o@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jan 2019 12:46:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
Message-ID: <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> I was referring to the fact that a single static call key update will
> usually result in patching multiple call sites.  But you're right, it's
> only 1-2 trampolines per text_poke_bp() invocation.  Though eventually
> we may want to batch all the writes like what Daniel has proposed for
> jump labels, to reduce IPIs.

Yeah, my suggestion doesn't allow for batching, since it would
basically generate one trampoline for every rewritten instruction.

> Regardless, the trampoline management seems more complex to me.  But
> it's easier to argue about actual code, so maybe I'll code it up to make
> it easier to compare solutions.

I do agree hat the stack games are likely "simpler" in one sense. I
just abhor playing those kinds of games with the entry code and entry
stack.

A small bit of extra complexity in the code that actually does the
rewriting would be much more palatable to me than the complexity in
the entry code. I prefer seeing the onus of complexity being on the
code that introduces the problem, not on a innocent bystander.

I'd like to say that our entry code actually looks fairly sane these
days.  I'd _like_ to say that, but I'd be lying through my teeth if I
did. The macros we use make any normal persons head spin.

The workaround for the stack corruption was fairly simple, but the
subtlety behind the *reason* for it was what made my hackles rise
about that code.

The x86 entry code is some of the nastiest in the kernel, I feel, with
all the subtle interactions about odd stack switches, odd CPU bugs
causing odd TLB switches, NMI interactions etc etc.

So I am fully cognizant that the workaround to shift the stack in the
entry code was just a couple of lines, and not very complicated.

And I agree that I may be a bit oversensitive about that area, but it
really is one of those places where I go "damn, I think I know some
low-level x86 stuff better than most, but that code scares *me*".

Which is why I'd accept a rather bigger complexity hit just about
anywhere else in the code...

               Linus
