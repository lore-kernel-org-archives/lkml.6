Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9D8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED589213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sZsRMPhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED589213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJIAz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:55:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35546 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIAz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:55:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so9148288wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=87y+dBXghhm1k2vW8F/DVQb3eCe9K78iRMnlRfNMH5w=;
        b=sZsRMPhPR3MFK0oJvP3BjTK9fo6BFLPtccwCAhh/Gj7lV4XftO7vpf5QZwa1CkQRdC
         TAu1dRDE0AcIVauzmpRAiSpvTBEPFOtvl/CrKk5yEt4r/iI7we3DJjJEjHrqN0Aal1AJ
         O628m0ggB+JY6n60A/ivh1tAqWsHoJjX5T4ncZ2qke6KJVg0YWirQRq8x5QqmsLdmcUb
         n1I31vriDf6fSfO+kMhdlHr8jTFdDpcW/1eR5ilWha69yUOtPHU43/Gj+DwrwI0RQwaI
         wrFuK9ZU9SO/8FTmClnysFg1EeuT9Cb6QUndwW18M+t7xvNZDy9OejVjGnnf9fLKu6Ec
         IBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=87y+dBXghhm1k2vW8F/DVQb3eCe9K78iRMnlRfNMH5w=;
        b=uLuJe8AmXTttil7JTFHSmwHREtfL99wi/b4T/0cAVxLIbRBIkamlEeEEQ2XCRBJVP1
         U+ZfcxPa0HU+ZIm/V0bAVxSLm9xqCKR6kJahuGVybHy8W+U0QPZ/Z0NuY48YP8urX+GS
         65k9t7mY1gl4zywf6bq+vJyS+dRJnsj9JWNCLHyaXAmtwqr5F8Dwqu+/2En9uygoaVzz
         g0e5pQ88lHEDTsVryZJ75H1h1Lo6ZvN7+9HGBd3a440CSkmgnhopv7XH3Rf24q20kK3s
         EpNTMtp8X4EFYx4xjYXJ+uMBPqON9jYXSiw1aZ/2b3nrAV8rtVs4VP1hSGLRXa6S7quz
         eKrA==
X-Gm-Message-State: ABuFfohVKdaLvOFqd23NmxLrvYX3jnZs0KgHVW2TynHYp07u49SGmwBZ
        VeM5H9XA3fZ+rV7nhUCstkLHm0qY2HHXdLJqZDTuEg==
X-Google-Smtp-Source: ACcGV61mjusq6FXufniEesof0tppLnI/K4GNJvXAk2dmY7B3UybdYYMRi4m9K6Cm80Ac6pDejGBmQBgrX1B5Hj2AAgg=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr16135058wmf.19.1539020587537;
 Mon, 08 Oct 2018 10:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net> <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net> <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181008163953.GD5663@hirez.programming.kicks-ass.net> <CALCETrWuGh=1n2bEE9B0eeyzvnaD4y_Sx6MB+r9B5aFXzg8qBw@mail.gmail.com>
 <CAKv+Gu-08i6QEahyYhBtCBmpOYNuxirgdsgGvRw+Y0DX3+DVNQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-08i6QEahyYhBtCBmpOYNuxirgdsgGvRw+Y0DX3+DVNQ@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 8 Oct 2018 10:42:54 -0700
Message-ID: <CALCETrWMvtH4tS5jkZcEP=YuwV6XOtRqx-0TF5dCTABa_zC-Xg@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 10:30 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On 8 October 2018 at 19:25, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Mon, Oct 8, 2018 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wr=
ote:
> >>
> >> On Mon, Oct 08, 2018 at 09:29:56AM -0700, Andy Lutomirski wrote:
> >> >
> >> >
> >> > > On Oct 8, 2018, at 8:57 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
> >> > >
> >> > > On Mon, Oct 08, 2018 at 01:33:14AM -0700, Andy Lutomirski wrote:
> >> > >>> Can't we hijack the relocation records for these functions befor=
e they
> >> > >>> get thrown out in the (final) link pass or something?
> >> > >>
> >> > >> I could be talking out my arse here, but I thought we could do th=
is,
> >> > >> too, then changed my mind.  The relocation records give us the
> >> > >> location of the call or jump operand, but they don=E2=80=99t give=
 the address
> >> > >> of the beginning of the instruction.
> >> > >
> >> > > But that's like 1 byte before the operand, right? We could even do=
uble check
> >> > > this by reading back that byte and ensuring it is in fact 0xE8 (CA=
LL).
> >> > >
> >> > > AFAICT there is only the _1_ CALL encoding, and that is the 5 byte=
: E8 <PLT32>,
> >> > > so if we have the PLT32 location, we also have the instruction loc=
ation. Or am
> >> > > I missing something?
> >> >
> >> > There=E2=80=99s also JMP and Jcc, any of which can be used for rail =
calls, but
> >> > those are also one byte. I suppose GCC is unlikely to emit a prefixe=
d
> >> > form of any of these. So maybe we really can assume they=E2=80=99re =
all one
> >> > byte.
> >>
> >> Oh, I had not considered tail calls..
> >>
> >> > But there is a nasty potential special case: anything that takes the
> >> > function=E2=80=99s address. This includes jump tables, computed goto=
s, and
> >> > plain old function pointers. And I suspect that any of these could
> >> > have one of the rather large number of CALL/JMP/Jcc bytes before the
> >> > relocation by coincidence.
> >>
> >> We can have objtool verify the CALL/JMP/Jcc only condition. So if
> >> someone tries to take the address of a patchable function, it will err=
or
> >> out.
> >
> > I think we should just ignore the sites that take the address and
> > maybe issue a warning.  After all, GCC can create them all by itself.
> > We'll always have a plain wrapper function, and I think we should just
> > not patch code that takes its address.  So we do, roughly:
> >
> > void default_foo(void);
> >
> > GLOBAL(foo)
> >   jmp *current_foo(%rip)
> > ENDPROC(foo)
> >
> > And code that does:
> >
> > foo();
> >
> > as a call, a tail call, a conditional tail call, etc, gets discovered
> > by objtool + relocation processing or whatever and gets patched.  (And
> > foo() itself gets patched, too, as a special case.  But we patch foo
> > itself at some point during boot to turn it into a direct JMP.  Doing
> > it this way means that the whole mechanism works from very early
> > boot.)
>
> Does that mean that architectures could opt out of doing the whole
> objtool + relocation processing thing, and instead take the hit of
> going through the trampoline for all calls?
>

I don't see why not.

--Andy
