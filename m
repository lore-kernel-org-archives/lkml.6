Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E391DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15C5214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3X13xXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15C5214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbeKLOyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:54:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34934 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeKLOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:54:04 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so11502302itj.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HinaT8KymDNWwd0EK9K+PO9iDLejU4LJurjBuIuseZE=;
        b=P3X13xXMfE2zkpBpifh56bJXn2mIz7ARItOppRy0m5lH7M+nlca/qmX6UaxvfX/xxV
         29pMMy3AK0Ar/xIxWfaUcZoDcCY2hIPdm6oZog/lXSrXCYxsnPoyL8YuherYowYE0PQM
         reHli8L9EFhJYn4G7w/wRBN7lPBcfYXDebMbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HinaT8KymDNWwd0EK9K+PO9iDLejU4LJurjBuIuseZE=;
        b=f0Kbbf3vek8rqtz0ZPxEw73pMjPfcfKtF4U5/ZWtb20/yuvPEkpsxnSS6LOtZlmxeb
         2cfUayc4x1zjYOJzo22bb8eRsSgoWx50cQ0Qg/jbkL76YzSJehbIAqypWhcAGMC79tM/
         84RVhHr4gXaxe/9i0PT8Xr+7La6HB6GPDhAVTFaOASpl1ubpCC5BCCsFNs9qj6ulFCGr
         AIYoTGKwk6aoOXgetF4P1d/ng/Dl2wdheYwqsO/ToOkgUoNlZaj/zFCJZbwQ9ZvFbSYp
         F2P1dXzSkuzVxoanjabROO2ew6ad9T8H0GbYZ1vEmMBhnfyLU9V11hV8marI6iItY3Gm
         LGoA==
X-Gm-Message-State: AGRZ1gLiTP9nP2I1/fAv0D2FsJGuIyocpRabVg3xZ/x9Qnzn6SxhoO0x
        CA2BdvrjlpLrpCUs7kBiM56xn1NWONhWyJxg800aPw==
X-Google-Smtp-Source: AJdET5dC6+EFRtVhuqzOlN4/KR+A1d7pEoXzjlD+lLvz3n3YsFR538aOsNxbBQ4+vclTruPY1voZiboPzU+2OQu4ztg=
X-Received: by 2002:a24:2190:: with SMTP id e138-v6mr10915336ita.71.1541998953821;
 Sun, 11 Nov 2018 21:02:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Sun, 11 Nov 2018 21:02:33
 -0800 (PST)
In-Reply-To: <20181112045629.3gwex4ekeglfas64@treble>
References: <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <20181109133337.63487e3a@gandalf.local.home> <20181109193505.5p5iddrtgpk2cpb4@treble>
 <20181109145746.0037da3f@gandalf.local.home> <20181109203459.wbftlkxcvfnwo2bm@treble>
 <20181110001023.57f27312@vmware.local.home> <CAKv+Gu-y=O6=dSbCXSaMxkj7LxfL9txzJ4r8Bcf1U0G6JQNUng@mail.gmail.com>
 <20181110080917.29af5d66@vmware.local.home> <20181112030722.da5cxslvlmdgttsw@treble>
 <CAKv+Gu-hs7cRjkAAzk7hUqoXWw1vQDvUGQaKnyALrPvW-TTLzA@mail.gmail.com> <20181112045629.3gwex4ekeglfas64@treble>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 12 Nov 2018 06:02:33 +0100
Message-ID: <CAKv+Gu8ycHvg3PG0wjBU8uBS5KaiwWMC45_2cVWWXWMWc3NqRw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 November 2018 at 05:56, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Mon, Nov 12, 2018 at 05:39:38AM +0100, Ard Biesheuvel wrote:
>> On 12 November 2018 at 04:07, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> > On Sat, Nov 10, 2018 at 08:09:17AM -0500, Steven Rostedt wrote:
>> >> On Sat, 10 Nov 2018 12:58:08 +0100
>> >> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >>
>> >>
>> >> > > The complaint is on:
>> >> > >
>> >> > >         DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);
>> >> > >
>> >> > > And the previous definition is on:
>> >> > >
>> >> > >         DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); \
>> >> > >
>> >> >
>> >> > Does the DECLARE really need the __ADDRESSABLE? Its purpose is to
>> >> > ensure that symbols with static linkage are not optimized away, but
>> >> > since the reference is from a header file, the symbol should have
>> >> > external linkage anyway.
>> >
>> > Yes, DECLARE needs the __ADDRESSABLE.  In the case where DECLARE
>> > is used, but DEFINE is not, GCC strips the symbol.
>> >
>>
>> I assume DECLARE() is intended for use in header files, and DEFINE()
>> for source files, no?
>
> Right.
>
>> Doesn't that mean that whatever symbol __ADDRESSABLE() refers to
>> should have external linkage, in which case it it addressable anyway?
>> Or are we talking about some LTO / --gc-sections use case here?
>
> If the key is declared, but not used, GCC doesn't put the key's ELF
> symbol in the binary's symbol table.  That makes objtool's life harder,
> because if the file has a call site, then objtool has to add the key
> symbol to the symbol table, so that it can create a relocation (in the
> call site table) which references the symbol.
>

Ah, right. So this is specific to objtool rather than a generic issue.

Should we perhaps wrap __ADDRESSABLE() into something else that
resolves to a NOP unless on X86, and give it a clear name?
