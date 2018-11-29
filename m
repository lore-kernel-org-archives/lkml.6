Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3484AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C16213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="IhoFbv8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C16213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeK3Geu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:34:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41515 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeK3Geu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:34:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so3046569wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/8CjLTyHaB/rJBC5SbC/hOj/Hn7tnCT9tHhW9/lDn4=;
        b=IhoFbv8d9DaU0u6k37uJWvRE8hTtJj/Zrfz++PFeXSIojr5ByMZXyQbszdvXAIAikB
         Ev7/4jelSAaMb3rX3j/lZOeRqfKexceCMxoxvfcJ00FvEarxSfNl2Mt8UthTmV5nxTbd
         S1PKiTQ3XNVUxD7D+IgcYJeD1M5ALN52w9s2lki+8hj6ovjl1w6zy72ak+BTaAdA8GVf
         GXp6j6lETkcyJ/sklYL37mQEGRdqo7kwfoNy2DDHCaND/Na5/C2pRKktHBrv8iiH/ZlU
         ZZMpCaIJSHAUk9jMtLsdf0Yktx9Z0jn+uhIYY5kjugvrRYZq/yATn2PQs01Fq+ELLFf7
         43LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/8CjLTyHaB/rJBC5SbC/hOj/Hn7tnCT9tHhW9/lDn4=;
        b=c6n5sLXIk5DjBS3hxo0XsV1Spf9s6BqMzo+MRyU/TR9Xf+wbU1xgy5Xqn7jBSr4J0B
         Et9G4iYdwd2BG8kg0BmjWT0bsrfVmRs0V9ib4Pc9zpqlwt4fASdyhdP2SbNqmn2RYnGn
         Ohbqn5iyBTNavMMCY2CX59/FlbbssJEIR87VEa6hCGMbwjyaSKKd18xNrOWNiRnW5JqG
         cNHLy8YDGcBTa47QKEW1QZU9f67QOs7hlTdQ37q5zX7l1KxL4/ebuva4nkiKRnqgLELi
         VarW3HeJgE96e5rLftqDYePr/CQU3+wvXq/QrEnURaXGoh6l5YFdcUK80KL38jrLjams
         SdoQ==
X-Gm-Message-State: AA+aEWZfxvJ5MoAYf/BhRJaXvFPsjIDBGobdaw+GRwqiVitQSmVXx5A5
        m1E0ZvfPKiPi7jVoXb30t/OBWLO7F1dTFzWDrG0frQ==
X-Google-Smtp-Source: AFSGD/VRmOn6pbaZX88jp3CU+n2VA0t44NpYJnbD2FLAXGjEXkiHpPVaQySj8jmV+D1lsEkgHs3O2sJgAkcldRnYvsg=
X-Received: by 2002:a5d:5502:: with SMTP id b2mr2601876wrv.330.1543519699206;
 Thu, 29 Nov 2018 11:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <20181129141648.6ef944a9@gandalf.local.home> <CAHk-=whBuSXe1+8HGT23FWDypkAP7TPun3te=fw2aLx+F6WVig@mail.gmail.com>
In-Reply-To: <CAHk-=whBuSXe1+8HGT23FWDypkAP7TPun3te=fw2aLx+F6WVig@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 29 Nov 2018 11:28:07 -0800
Message-ID: <CALCETrU5cORg237=XvT332se8YPLq78zNPM+OsFTorXqLc05SQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:25 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Nov 29, 2018 at 11:16 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > But then we need to implement all numbers of parameters.
>
> Oh, I agree, it's nasty.
>
> But it's actually a nastiness that we've solved before. In particular,
> with the system call mappings, which have pretty much the exact same
> issue of "map unknown number of arguments to registers".
>
> Yes, it's different - there you map the unknown number of arguments to
> a structure access instead. And yes, the macros are unbelievably ugly.
> See
>
>     arch/x86/include/asm/syscall_wrapper.h
>
> and the __MAP() macro from
>
>     include/linux/syscalls.h
>
> so it's not pretty. But it would solve all the problems.
>

Until someone does:

struct foo foo;
static_call(thingy, foo);

For syscalls, we know better than to do that.  For static calls, I'm
less confident.
