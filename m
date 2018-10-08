Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAE12145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="SfojxlM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAE12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeJIAiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:38:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52709 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJIAiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:38:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so8907497wmw.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cS9LeFeJrRB5xEeA7YmkKAZLECJrSlbl++3/E4X+Jtw=;
        b=SfojxlM7qlRxk4J9CLQhyLtrCovWqqhgrJ7NO//o/BqptTjq9++j2br8/Y4+9HD15w
         3CPky4oAyxGxreexcG8fKCBhlPL0b3BTDfCMSQVOr+edS1oPqKFnRNSt93OhX6GXTJi/
         8XEDIpSnVGRJz7OnP3dEeSgSOkkNwpuTab/7QBn9qADObvmrr4SQrxc8ZBntIJUDY9+b
         Jw8WWCCYQsEIoKo95UDlUGWsYihWnIAqmnIf98b5jeJYQdXgdRlJh7FX5CUWzyNZIgqY
         ltdu3WoBvrov1eLSZ55Wnlta9Rp3Eo8BaFYpKM/zuXewsCdO26PXKwR6dLr6+yLu1huP
         SlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cS9LeFeJrRB5xEeA7YmkKAZLECJrSlbl++3/E4X+Jtw=;
        b=Fnu6jxb95eFv2eMMagbxwDGQpEwgr7z/iwGsPkNjX59esidlyZ9rVG3DfPBDcONQEI
         Y5gRbBKTo3xeaCQBbmVAAoXivIodn1/SdscYFAIVV0hE652LDJav38wzrpKBHXjTXzeq
         yH9bHWXgEYRx3sXoHtseHfIg9aaqkD4db5pJ5HN5ACh78Zfv4cZQEhi7YzBGj0BKkGtL
         k+oxHaEOgDRJWhnXuAjCJUkkIy9kH9ioFjvA9Y4bM6V0UyXadwbM64pjYuGuvu5eORMl
         Rwi13J9UKPKpiQHAZlpeEF14AC3asNXIYvheT+JHFuTry6lho43goA2MQs43+gHUdqcq
         FLog==
X-Gm-Message-State: ABuFfojXZa9IXIwxq6EE2IlIHgRLy0PqKdpNn45mrTuB/hrilkBaom0A
        F03sm1/ldIhwoS4S0BVWAVrUWF4UD39hya/KJvcEOA==
X-Google-Smtp-Source: ACcGV62CJtd/SRVBRyIKZreHdkrsMJcBhy6J/RewrtluJsJutI30Vjgn2mzGLoD085iRzLGa47YWgaoTpi5+AVxZVm4=
X-Received: by 2002:a1c:d4b:: with SMTP id 72-v6mr17114463wmn.102.1539019562875;
 Mon, 08 Oct 2018 10:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net> <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net> <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181008163953.GD5663@hirez.programming.kicks-ass.net>
In-Reply-To: <20181008163953.GD5663@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 8 Oct 2018 10:25:51 -0700
Message-ID: <CALCETrWuGh=1n2bEE9B0eeyzvnaD4y_Sx6MB+r9B5aFXzg8qBw@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mhelsley@vmware.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 08, 2018 at 09:29:56AM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Oct 8, 2018, at 8:57 AM, Peter Zijlstra <peterz@infradead.org> wro=
te:
> > >
> > > On Mon, Oct 08, 2018 at 01:33:14AM -0700, Andy Lutomirski wrote:
> > >>> Can't we hijack the relocation records for these functions before t=
hey
> > >>> get thrown out in the (final) link pass or something?
> > >>
> > >> I could be talking out my arse here, but I thought we could do this,
> > >> too, then changed my mind.  The relocation records give us the
> > >> location of the call or jump operand, but they don=E2=80=99t give th=
e address
> > >> of the beginning of the instruction.
> > >
> > > But that's like 1 byte before the operand, right? We could even doubl=
e check
> > > this by reading back that byte and ensuring it is in fact 0xE8 (CALL)=
.
> > >
> > > AFAICT there is only the _1_ CALL encoding, and that is the 5 byte: E=
8 <PLT32>,
> > > so if we have the PLT32 location, we also have the instruction locati=
on. Or am
> > > I missing something?
> >
> > There=E2=80=99s also JMP and Jcc, any of which can be used for rail cal=
ls, but
> > those are also one byte. I suppose GCC is unlikely to emit a prefixed
> > form of any of these. So maybe we really can assume they=E2=80=99re all=
 one
> > byte.
>
> Oh, I had not considered tail calls..
>
> > But there is a nasty potential special case: anything that takes the
> > function=E2=80=99s address. This includes jump tables, computed gotos, =
and
> > plain old function pointers. And I suspect that any of these could
> > have one of the rather large number of CALL/JMP/Jcc bytes before the
> > relocation by coincidence.
>
> We can have objtool verify the CALL/JMP/Jcc only condition. So if
> someone tries to take the address of a patchable function, it will error
> out.

I think we should just ignore the sites that take the address and
maybe issue a warning.  After all, GCC can create them all by itself.
We'll always have a plain wrapper function, and I think we should just
not patch code that takes its address.  So we do, roughly:

void default_foo(void);

GLOBAL(foo)
  jmp *current_foo(%rip)
ENDPROC(foo)

And code that does:

foo();

as a call, a tail call, a conditional tail call, etc, gets discovered
by objtool + relocation processing or whatever and gets patched.  (And
foo() itself gets patched, too, as a special case.  But we patch foo
itself at some point during boot to turn it into a direct JMP.  Doing
it this way means that the whole mechanism works from very early
boot.)  And anything awful like:

switch(whatever) {
case 0:
  foo();
};

that gets translated to a jump table and gets optimized such that it
jumps straight to foo just gets left alone, since it still works.
It's just a bit suboptimial.  Similarly, code that does:

void (*ptr)(void);
ptr =3D foo;

gets a bona fide pointer to foo(), and any calls through the pointer
land on foo() and jump to the current selected foo with only a single
indirect branch / retpoline.

Does this seem reasonable?  Is there a reason we should make it more
restrictive?
