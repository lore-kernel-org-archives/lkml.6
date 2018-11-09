Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD40C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74AE20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J92Nkn/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74AE20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeKIXbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:31:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43851 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeKIXbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:31:12 -0500
Received: by mail-io1-f67.google.com with SMTP id t81-v6so1265766iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XCG/V04jlegloMSWsjMPIYWmvNahieLfPQIduirITOQ=;
        b=J92Nkn/7mFYY7NnCBUAv+ehrb1wild+Cj7uEP9ILYzZubTMZtab0pgFoN8yAkYJvoU
         dljxioQr6w+VTC0BJONTFYlBBg44vjUslUOvnzwhB/9BHPNoqeqpHMI7xk2CoMktW4BH
         BVMZPhcZrpdtvFp3ZKK+tsVAEBi8X4KeAXalM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XCG/V04jlegloMSWsjMPIYWmvNahieLfPQIduirITOQ=;
        b=B1ZsKSGhPAEf1V+PqotFOU1kGFKaiWgClONwQXoLBlkyE7fNvnp5cNC5+H8HYhHF1z
         hJN0VRlB0rqQcBVeOU24MlYbtAkkaN9YVohje49BGBmaNqtDdw3pn41VqTzIg22zMhJH
         tM7LtlFEOQK/v/WmjODhIyDo8CjG4x59HtLTJhbZsBwbc0fX83TOUC5fkPVAA86Pt1Bu
         DxJfWj/kROWN0nBwg1r4c+bRxY1J/vGnEXQCprGCcnODEX9BTXTNaKIFZFkWXcSzvciN
         Ik+c5hM5pkX4l+OOq1/wP0W76ZJHVUn9u8zVnavKQey3QFkGOkQ+/i5u4G14h2cAsMr/
         jX3w==
X-Gm-Message-State: AGRZ1gJsU472C89x7SL1TdXsoGKDysKVuQggXpt6Is94TUjZe2hFPBHv
        c17Ia7eoW7klXVYQiDx3/ot5lhZoDyUw63CJ1NWMijp6Uc8=
X-Google-Smtp-Source: AJdET5cNJEf9aBvr/z6NFl0OfM5dgY13bjeJBWwYAphWtxflSTNqjVFr1vC/UdGVUE5DtXnc98LNs01sC1e4HgHRZs4=
X-Received: by 2002:a6b:37c2:: with SMTP id e185-v6mr7094932ioa.173.1541771428539;
 Fri, 09 Nov 2018 05:50:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 05:50:27 -0800 (PST)
In-Reply-To: <20181109072811.GB86700@gmail.com>
References: <cover.1541711457.git.jpoimboe@redhat.com> <20181109072811.GB86700@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 9 Nov 2018 14:50:27 +0100
Message-ID: <CAKv+Gu-3OfrgGafO3OY3hAir723tD6shEaWTLJ5Ec4YcW4yZyQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Static calls
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On 9 November 2018 at 08:28, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
>> These patches are related to two similar patch sets from Ard and Steve:
>>
>> - https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
>> - https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org
>>
>> The code is also heavily inspired by the jump label code, as some of the
>> concepts are very similar.
>>
>> There are three separate implementations, depending on what the arch
>> supports:
>>
>>   1) CONFIG_HAVE_STATIC_CALL_OPTIMIZED: patched call sites - requires
>>      objtool and a small amount of arch code
>>
>>   2) CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED: patched trampolines - requires
>>      a small amount of arch code
>>
>>   3) If no arch support, fall back to regular function pointers
>>
>>
>> TODO:
>>
>> - I'm not sure about the objtool approach.  Objtool is (currently)
>>   x86-64 only, which means we have to use the "unoptimized" version
>>   everywhere else.  I may experiment with a GCC plugin instead.
>
> I'd prefer the objtool approach. It's a pretty reliable first-principles
> approach while GCC plugin would have to be replicated for Clang and any
> other compilers, etc.
>

I implemented the GCC plugin approach here for arm64

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=static-calls

That implements both the unoptimized and the optimized versions.

I do take your point about GCC and other compilers, but on arm64 we
don't have a lot of choice.

As far as I can tell, the GCC plugin is generic (i.e., it does not
rely on any ARM specific passes, but obviously, this requires a *lot*
of testing and validation to be taken seriously.

>> - Does this feature have much value without retpolines?  If not, should
>>   we make it depend on retpolines somehow?
>
> Paravirt patching, as you mention in your later reply?
>
>> - Find some actual users of the interfaces (tracepoints? crypto?)
>
> I'd be very happy with a demonstrated paravirt optimization already -
> i.e. seeing the before/after effect on the vmlinux with an x86 distro
> config.
>
> All major Linux distributions enable CONFIG_PARAVIRT=y and
> CONFIG_PARAVIRT_XXL=y on x86 at the moment, so optimizing it away as much
> as possible in the 99.999% cases where it's not used is a primary
> concern.
>
> All other usecases are bonus, but it would certainly be interesting to
> investigate the impact of using these APIs for tracing: that too is a
> feature enabled everywhere but utilized only by a small fraction of Linux
> users - so literally every single cycle or instruction saved or hot-path
> shortened is a major win.
>
> Thanks,
>
>         Ingo
