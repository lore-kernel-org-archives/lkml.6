Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0476E20892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjBKGYsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0476E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeKJVm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 16:42:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:56136 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbeKJVm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 16:42:56 -0500
Received: by mail-it1-f194.google.com with SMTP id b7-v6so6642984itd.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 03:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P1V5x2k7fOoJ8xXi2CY9WNnfD740a6H/HHDON62o4xE=;
        b=ZjBKGYsApAdYoLBZGneYf8hLXYVD+djsMckoOT6nBhllFDbT2CtTgvSgS5SBe4RGWs
         90s3Oh9GXikww0mBKKQFCkXnMDnf1sdAt7tzvyKhJTc9r/saF5RAMMfHb+V45Jk1pbEb
         nu56v3ihzYK/LY6LuV4NH0dmW+qbInZxrcKl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P1V5x2k7fOoJ8xXi2CY9WNnfD740a6H/HHDON62o4xE=;
        b=dfDZzm9s20AVVBL913BZVFeNacJydZ29/zOj7sgk9tBFyttXOhadR2C6qJub+XVqA1
         4/A8ZyyoVuWtkvZK1EfngPeIrGSVoDm8ceWWSAjb2j3CUQaOGE2ChOCaoKakVC+M7yra
         6gBE5c8S79U8GQD2SZkTpjhYGoaFyItUGdOFDuTj/w18uk9Dn/AJ9PFyRMeZcvNfCRQM
         sKLFHZNJMC7git1shZD9FCmKAjFk/a69r8o9hApOxo5bQw+F+YyEOax0At2k02W/Kl8q
         xLttrUNDh64+s1E6RlMY3au0bzHVk0wCk97b4npOA/NaIzguq+9NRA6bGs3IAbUmnm5o
         lRKg==
X-Gm-Message-State: AGRZ1gJDgEUb/tZWSIqTWbN9YGULwOQ1LlmckuPat+KucyZEEGOlQ93R
        nc2Xxs0ER3BwX5afzyW5OMf9UCyiUgQYXuA6bPX9fQ==
X-Google-Smtp-Source: AJdET5c1U+TY0CCVttq69seY+2wc+QqjHuSzKGl48XYNuUrmygFSYdFzy3qpMG/TpoO104kZe9zh/7ec5LOgn/QuMl0=
X-Received: by 2002:a24:2190:: with SMTP id e138-v6mr5640235ita.71.1541851088798;
 Sat, 10 Nov 2018 03:58:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Sat, 10 Nov 2018 03:58:08
 -0800 (PST)
In-Reply-To: <20181110001023.57f27312@vmware.local.home>
References: <cover.1541711457.git.jpoimboe@redhat.com> <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <20181109133337.63487e3a@gandalf.local.home> <20181109193505.5p5iddrtgpk2cpb4@treble>
 <20181109145746.0037da3f@gandalf.local.home> <20181109203459.wbftlkxcvfnwo2bm@treble>
 <20181110001023.57f27312@vmware.local.home>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 10 Nov 2018 12:58:08 +0100
Message-ID: <CAKv+Gu-y=O6=dSbCXSaMxkj7LxfL9txzJ4r8Bcf1U0G6JQNUng@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 November 2018 at 06:10, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 9 Nov 2018 14:34:59 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> I'm slowly massaging this to work with tracepoints.
>
> But I hit a snag on this patch.
>
>> On Fri, Nov 09, 2018 at 02:57:46PM -0500, Steven Rostedt wrote:
>> > On Fri, 9 Nov 2018 13:35:05 -0600
>> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> >
>> >
>> > > > > +#define DECLARE_STATIC_CALL(key, func)                         =
              \
>> > > > > +     extern struct static_call_key key;                        =
      \
>> > > > > +     extern typeof(func) STATIC_CALL_TRAMP(key);               =
      \
>> > > > > +     /* Preserve the ELF symbol so objtool can access it: */   =
      \
>> > > > > +     __ADDRESSABLE(key)
>> > > >
>> > > > Does the __ADDRESSABLE(key) need to be in the DECLARE part?
>> > > > If so, there needs to be more explanation than just the comment ab=
ove
>> > > > it.
>> > >
>> > > For each call site, objtool creates a struct in .static_call_sites:
>> > >
>> > >   struct static_call_site {
>> > >           s32 addr;
>> > >           s32 key;
>> > >   };
>> > >
>> > > In order to do that, it needs to create a relocation which reference=
s
>> > > the key symbol.  If the key is defined in another .o file, then the
>> > > current .o will not have an ELF symbol associated with the key.  The
>> > > __ADDRESSABLE(key) thing tells GCC to leave the key symbol in the .o
>> > > file, even though it's not referenced anywhere.  That makes objtool'=
s
>> > > job easier, so it doesn't have to edit the symbol table.
>> > >
>> > > I could add a comment saying as much, though it's hard to explain it=
 in
>> > > fewer words than I just did :-)
>> >
>> > Does this have to do with adding the references by relative address?
>> >
>> > In record_mcount, I just picked an existing symbol and referenced that=
..
>> > But perhaps this is a cleaner way.
>>
>> I think recordmcount is different.  It creates references (in
>> __mcount_loc) to functions which are already in the object file, so they
>> already have symbols associated with them.
>>
>> But in this case, when objtool is creating references, the symbol it
>> needs to reference is outside the .o file, so there's no symbol to
>> associate it with.
>>
>
> The __ADDRESSABLE() appears to fail if you have a header with a
> DECLARE_STATIC_CALL() that is included where the DEFINE_STATIC_CALL()
> is, because I'm getting this:
>
> In file included from <command-line>:
> /work/git/linux-trace.git/include/linux/compiler.h:285:11: error: redefin=
ition of =E2=80=98__addressable___tp_func_sys_enter40=E2=80=99
>    __PASTE(__addressable_##sym, __LINE__) =3D (void *)&sym;
>            ^~~~~~~~~~~~~~
> /work/git/linux-trace.git/include/linux/compiler_types.h:53:23: note: in =
definition of macro =E2=80=98___PASTE=E2=80=99
>  #define ___PASTE(a,b) a##b
>                        ^
> /work/git/linux-trace.git/include/linux/compiler.h:285:3: note: in expans=
ion of macro =E2=80=98__PASTE=E2=80=99
>    __PASTE(__addressable_##sym, __LINE__) =3D (void *)&sym;
>    ^~~~~~~
> /work/git/linux-trace.git/include/linux/static_call.h:112:2: note: in exp=
ansion of macro =E2=80=98__ADDRESSABLE=E2=80=99
>   __ADDRESSABLE(key)
>   ^~~~~~~~~~~~~
> /work/git/linux-trace.git/include/linux/static_call.h:115:2: note: in exp=
ansion of macro =E2=80=98DECLARE_STATIC_CALL=E2=80=99
>   DECLARE_STATIC_CALL(key, _func);    \
>   ^~~~~~~~~~~~~~~~~~~
> /work/git/linux-trace.git/include/linux/tracepoint.h:310:2: note: in expa=
nsion of macro =E2=80=98DEFINE_STATIC_CALL=E2=80=99
>   DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);
>   ^~~~~~~~~~~~~~~~~~
> /work/git/linux-trace.git/include/trace/define_trace.h:42:2: note: in exp=
ansion of macro =E2=80=98DEFINE_TRACE_FN=E2=80=99
>   DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
>   ^~~~~~~~~~~~~~~
> /work/git/linux-trace.git/include/trace/events/syscalls.h:18:1: note: in =
expansion of macro =E2=80=98TRACE_EVENT_FN=E2=80=99
>  TRACE_EVENT_FN(sys_enter,
>  ^~~~~~~~~~~~~~
> /work/git/linux-trace.git/include/linux/compiler.h:285:11: note: previous=
 definition of =E2=80=98__addressable___tp_func_sys_enter40=E2=80=99 was he=
re
>    __PASTE(__addressable_##sym, __LINE__) =3D (void *)&sym;
>            ^~~~~~~~~~~~~~
> /work/git/linux-trace.git/include/linux/compiler_types.h:53:23: note: in =
definition of macro =E2=80=98___PASTE=E2=80=99
>  #define ___PASTE(a,b) a##b
>                        ^
> /work/git/linux-trace.git/include/linux/compiler.h:285:3: note: in expans=
ion of macro =E2=80=98__PASTE=E2=80=99
>    __PASTE(__addressable_##sym, __LINE__) =3D (void *)&sym;
>    ^~~~~~~
> /work/git/linux-trace.git/include/linux/static_call.h:112:2: note: in exp=
ansion of macro =E2=80=98__ADDRESSABLE=E2=80=99
>   __ADDRESSABLE(key)
>   ^~~~~~~~~~~~~
> /work/git/linux-trace.git/include/linux/tracepoint.h:234:2: note: in expa=
nsion of macro =E2=80=98DECLARE_STATIC_CALL=E2=80=99
>   DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); \
>   ^~~~~~~~~~~~~~~~~~~
> /work/git/linux-trace.git/include/linux/tracepoint.h:421:2: note: in expa=
nsion of macro =E2=80=98__DECLARE_TRACE=E2=80=99
>   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
>   ^~~~~~~~~~~~~~~
> /work/git/linux-trace.git/include/linux/tracepoint.h:560:2: note: in expa=
nsion of macro =E2=80=98DECLARE_TRACE=E2=80=99
>   DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>   ^~~~~~~~~~~~~
> /work/git/linux-trace.git/include/trace/events/syscalls.h:18:1: note: in =
expansion of macro =E2=80=98TRACE_EVENT_FN=E2=80=99
>  TRACE_EVENT_FN(sys_enter,
>
> The complaint is on:
>
>         DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);
>
> And the previous definition is on:
>
>         DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); =
\
>

Does the DECLARE really need the __ADDRESSABLE? Its purpose is to
ensure that symbols with static linkage are not optimized away, but
since the reference is from a header file, the symbol should have
external linkage anyway.
