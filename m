Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EE8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462E2208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKQqJeBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462E2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeKKXbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:31:34 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38087 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeKKXbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:31:34 -0500
Received: by mail-it1-f195.google.com with SMTP id k141-v6so9700367itk.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RGzub7tlXzS5z3FKnQAN8eNP9GXfEpc7NOMdYjc4d9M=;
        b=hKQqJeBj9vAGuPU8siQHkEi+PVhIKOVtgHrgzEf06C1RaYgrPQExJmPyPMZIKyPU56
         3GZi7qTY6cin1UXxLvBjDkag7VikHdMK3EjmgNEkTSGMLB/rDdAdJ9zxuD/t9Hvo+nOL
         N6/JN9ynoUD3uU3BxQ9qXDKk24ezrfsYTby/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RGzub7tlXzS5z3FKnQAN8eNP9GXfEpc7NOMdYjc4d9M=;
        b=JUU5Yas695mGZYH8O3pAeTUC9qjr4p3ucKDREfLLDo9dqSjeVFo8wBCP1p9wXgfTUg
         9kGi4GaFusIslOr+tmEpwydxT3Di5KdJYXqtliyZ026/OhuEhuFMhC3goWocmQG1Pcyv
         cflP8HaHhH6UyK/UBgvi8qzgZX4SXcpWtsicoxbKWHso7G5+tzO68EKYrLueoTiTf+Xa
         k+VmaofogxoLtvnfztt2ec0A5A9xNboYdi62Xq7YA2olqmrXDIVmqQUtylGRh7TPuyEH
         8IiJgBC1kYkFViVVUDjWh9NNhWg/0zrwdUNqERqBlR2G7zGNYicAsf6SczYxoiIOhvPq
         nvBg==
X-Gm-Message-State: AGRZ1gJik/DaQka0mQOICr8MCCimrqbapAzz/FWPUiGV5o6kWdDfDhHY
        NvousCjatntTYZT+hcCJVrL4fkQytl9E4Y1MHcyKhw==
X-Google-Smtp-Source: AJdET5fPaj8GcBhBEAvggK7Z0ywJRnQBGb1DrLNRNc6y5pikhMGKa+OawUb4rV7ybyoPORC6D+AmOVzMn93nL+QUaA8=
X-Received: by 2002:a24:8347:: with SMTP id d68-v6mr9362265ite.158.1541943776312;
 Sun, 11 Nov 2018 05:42:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Sun, 11 Nov 2018 05:42:55
 -0800 (PST)
In-Reply-To: <20181110232059.GA12766@worktop.psav.com>
References: <cover.1541711457.git.jpoimboe@redhat.com> <20181109072811.GB86700@gmail.com>
 <CAKv+Gu-3OfrgGafO3OY3hAir723tD6shEaWTLJ5Ec4YcW4yZyQ@mail.gmail.com> <20181110232059.GA12766@worktop.psav.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 11 Nov 2018 14:42:55 +0100
Message-ID: <CAKv+Gu_y2vH3eu7rMt7d7Hzum_MvYy7=30sNe1fhnB2QLe5i5A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Static calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On 11 November 2018 at 00:20, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Nov 09, 2018 at 02:50:27PM +0100, Ard Biesheuvel wrote:
>> On 9 November 2018 at 08:28, Ingo Molnar <mingo@kernel.org> wrote:
>> >> - I'm not sure about the objtool approach.  Objtool is (currently)
>> >>   x86-64 only, which means we have to use the "unoptimized" version
>> >>   everywhere else.  I may experiment with a GCC plugin instead.
>> >
>> > I'd prefer the objtool approach. It's a pretty reliable first-principles
>> > approach while GCC plugin would have to be replicated for Clang and any
>> > other compilers, etc.
>> >
>>
>> I implemented the GCC plugin approach here for arm64
>
> I'm confused; I though we only needed objtool for variable instruction
> length architectures, because we can't reliably decode our instruction
> stream. Otherwise we can fairly trivially use the DWARF relocation data,
> no?

How would that work? We could build vmlinux with --emit-relocs, filter
out the static jump/call relocations and resolve the symbol names to
filter the ones associated with calls to trampolines. But then, we
have to build the static_call_sites section and reinject it back into
the image in some way, which is essentially objtool, no?
