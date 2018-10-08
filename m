Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809BCC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4886E214DC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4B/OX4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4886E214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJIAnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:43:11 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50557 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIAnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:43:11 -0400
Received: by mail-it1-f193.google.com with SMTP id j81-v6so12537599ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U6KMT5Qbp02xl5OctkoR6xKh+uLeubHmn2gVyl6P7gg=;
        b=B4B/OX4iK2/Aae7b6149CVs8xT+F7SXOWgbm4sPXXDF8xsr6udi7OwllgeThIqob0e
         BaMdQZ+Mvd18Ek0qDd42co4liYxLqxHkOH+Almc21t6jzxZoK6gE85j9iijAnrS1uxeY
         sv6WDHNSriljfdnWxOJTIfBtCZJycY6sD09i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U6KMT5Qbp02xl5OctkoR6xKh+uLeubHmn2gVyl6P7gg=;
        b=gRsQdNoakdpfflTQh0T3wEKb0ImBSjYXVTFbh5veL7imtAgI92tHxo4FPKZWWb40T6
         v9sJGN6MmzIBOMmpa+Bu87nuHGbHCJGWTIJR6FefeMw6/lN6G25RonB7sToVnH9dChS/
         49RBHlNFpjeE91QG89FCg7vnMkCLOefxBvQuRF62YMgtzFN13RXb9C51UdjKtE/Vl7C6
         btEw7OIFfjqg5U3ggEoV7oHUgkmS4I9YxlMXRuC6rlwsPl+UtlysGcup9uTcGo/FblX0
         V6VtMc0GY6y6ZMjuCDNW46bqgy/57HMNjbHHINgOWs6zVwd1sUcyHcMV+LxA/MH8TMMC
         RBvg==
X-Gm-Message-State: ABuFfoiwGWDOpktEm2tpdN+vtPmj5F5Yu3SkLrtmOfkeb+rN0gtQR/hq
        OxSHKQDkCxZuPl91ypraaP6iEL2tfE5YhyPYB3yeHg==
X-Google-Smtp-Source: ACcGV61gfOXPUy/a9/aZbgMB/cha2iCZVuY2vCuhbEsQ/Uc92GE/bVtIipwve1GK168aE1JH4N9y4dYJA6qLeBebQPs=
X-Received: by 2002:a02:b015:: with SMTP id p21-v6mr19185629jah.2.1539019824684;
 Mon, 08 Oct 2018 10:30:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 10:30:23 -0700 (PDT)
In-Reply-To: <CALCETrWuGh=1n2bEE9B0eeyzvnaD4y_Sx6MB+r9B5aFXzg8qBw@mail.gmail.com>
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net> <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net> <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181008163953.GD5663@hirez.programming.kicks-ass.net> <CALCETrWuGh=1n2bEE9B0eeyzvnaD4y_Sx6MB+r9B5aFXzg8qBw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 8 Oct 2018 19:30:23 +0200
Message-ID: <CAKv+Gu-08i6QEahyYhBtCBmpOYNuxirgdsgGvRw+Y0DX3+DVNQ@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 October 2018 at 19:25, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Oct 8, 2018 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>
>> On Mon, Oct 08, 2018 at 09:29:56AM -0700, Andy Lutomirski wrote:
>> >
>> >
>> > > On Oct 8, 2018, at 8:57 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
>> > >
>> > > On Mon, Oct 08, 2018 at 01:33:14AM -0700, Andy Lutomirski wrote:
>> > >>> Can't we hijack the relocation records for these functions before =
they
>> > >>> get thrown out in the (final) link pass or something?
>> > >>
>> > >> I could be talking out my arse here, but I thought we could do this=
,
>> > >> too, then changed my mind.  The relocation records give us the
>> > >> location of the call or jump operand, but they don=E2=80=99t give t=
he address
>> > >> of the beginning of the instruction.
>> > >
>> > > But that's like 1 byte before the operand, right? We could even doub=
le check
>> > > this by reading back that byte and ensuring it is in fact 0xE8 (CALL=
).
>> > >
>> > > AFAICT there is only the _1_ CALL encoding, and that is the 5 byte: =
E8 <PLT32>,
>> > > so if we have the PLT32 location, we also have the instruction locat=
ion. Or am
>> > > I missing something?
>> >
>> > There=E2=80=99s also JMP and Jcc, any of which can be used for rail ca=
lls, but
>> > those are also one byte. I suppose GCC is unlikely to emit a prefixed
>> > form of any of these. So maybe we really can assume they=E2=80=99re al=
l one
>> > byte.
>>
>> Oh, I had not considered tail calls..
>>
>> > But there is a nasty potential special case: anything that takes the
>> > function=E2=80=99s address. This includes jump tables, computed gotos,=
 and
>> > plain old function pointers. And I suspect that any of these could
>> > have one of the rather large number of CALL/JMP/Jcc bytes before the
>> > relocation by coincidence.
>>
>> We can have objtool verify the CALL/JMP/Jcc only condition. So if
>> someone tries to take the address of a patchable function, it will error
>> out.
>
> I think we should just ignore the sites that take the address and
> maybe issue a warning.  After all, GCC can create them all by itself.
> We'll always have a plain wrapper function, and I think we should just
> not patch code that takes its address.  So we do, roughly:
>
> void default_foo(void);
>
> GLOBAL(foo)
>   jmp *current_foo(%rip)
> ENDPROC(foo)
>
> And code that does:
>
> foo();
>
> as a call, a tail call, a conditional tail call, etc, gets discovered
> by objtool + relocation processing or whatever and gets patched.  (And
> foo() itself gets patched, too, as a special case.  But we patch foo
> itself at some point during boot to turn it into a direct JMP.  Doing
> it this way means that the whole mechanism works from very early
> boot.)

Does that mean that architectures could opt out of doing the whole
objtool + relocation processing thing, and instead take the hit of
going through the trampoline for all calls?

> And anything awful like:
>
> switch(whatever) {
> case 0:
>   foo();
> };
>
> that gets translated to a jump table and gets optimized such that it
> jumps straight to foo just gets left alone, since it still works.
> It's just a bit suboptimial.  Similarly, code that does:
>
> void (*ptr)(void);
> ptr =3D foo;
>
> gets a bona fide pointer to foo(), and any calls through the pointer
> land on foo() and jump to the current selected foo with only a single
> indirect branch / retpoline.
>
> Does this seem reasonable?  Is there a reason we should make it more
> restrictive?
