Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B903C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD4D20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEI8UIGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD4D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJHSlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:41:49 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51129 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeJHSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:41:48 -0400
Received: by mail-it1-f193.google.com with SMTP id j81-v6so10971296ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=12ruE3cLvMG2UNvoPpRcommT1ZKPpRpUd8Rjz0uikDE=;
        b=MEI8UIGtLE87SFETDYoKCONY+/gzGvT4w9z1GMUxGnom2S5CyWQfEfGOaOdMqYS2JZ
         Uy4UNrdRF8X4FUKBlLw62tHTJtP1tSSFWEIbIjzK076d3wpPS9jhvzl0J1SoCtmZUHM2
         TQAU2igCwIvxkD0rDMdVBtuPMymSiEXl+rzmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=12ruE3cLvMG2UNvoPpRcommT1ZKPpRpUd8Rjz0uikDE=;
        b=eHUKBxT4RAt8RYxJLrHpjevN/5UscdgRf6V/lRwdxX9YRUdbH2XIoMK8r5VtMCInnJ
         vvFRKgq5798R3mCck3LUtyS6vT2Bl1gGfTGnk55r5+38ZboddzwQbyrOAp+Ak+2Z7rOa
         74cmpDXQ1F/jnpDIFSP+8RbUyH5G8SL4xMKNz0vNo/tv8bPqaQGE3NSIv4hBTvM3WBGt
         ysPTm4z1bTbGKRDsfOWAEj40uZUdUuMYURpy1QVb/CzJWTL7XfYIu7SWgF+phq/mObaI
         W674WSjXJDRF12pefsdN9JKFTJXciNOKuX+fYywH9JRiJSQqnt08B/Pa9UrN5MjK4vR5
         v0Mw==
X-Gm-Message-State: ABuFfohkpcVl468N9DVWzDL9EZvOCV8WupXJ81BzRxmk7aACPamc9+vx
        AW+MpJLGB05IVZPpKUCvDMh+Iy/jc26Im0xqe3VFwA==
X-Google-Smtp-Source: ACcGV61tZgodggrzzbVDeT88+rOF3X3lg41csp/kNf95jP4M/bl8hfWXis2oSxPRKvu81PDXIyrgFyaEow4Nn1+5z9Q=
X-Received: by 2002:a24:a10b:: with SMTP id y11-v6mr12347572ite.148.1538998230836;
 Mon, 08 Oct 2018 04:30:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 04:30:30 -0700 (PDT)
In-Reply-To: <20181006093905.46276505@vmware.local.home>
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 8 Oct 2018 13:30:30 +0200
Message-ID: <CAKv+Gu_AOMbGDXqY1by+fZDbsL-sDy4Y=V6GUGuyMK0vy_OQdg@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 October 2018 at 15:39, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sat, 6 Oct 2018 14:12:11 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Fri, Oct 05, 2018 at 09:51:11PM -0400, Steven Rostedt wrote:
>> > +#define arch_dynfunc_trampoline(name, def) \
>> > +   asm volatile (                          \
>> > +   ".globl dynfunc_" #name "; \n\t"        \
>> > +   "dynfunc_" #name ": \n\t"               \
>> > +   "jmp " #def " \n\t"                     \
>> > +   ".balign 8 \n \t"                       \
>> > +   : : : "memory" )
>>
>> Bah, what is it with you people and trampolines. Why can't we, just like
>> jump_label, patch the call directly?
>>
>> The whole call+jmp thing is silly, don't do that. It just wrecks I$ and
>> is slower for no real reason afaict.
>
> My first attempt was to do just that. But to add a label at the
> call site required handling all the parameters too. See my branch:
>  ftrace/jump_function-v1 for how ugly it got (and it didn't work).
>
>>
>> Steve, also see:
>>
>>   https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
>
> Interesting. I don't have time to look at it at the moment to see what
> was done, but will do so in the near future.
>
> Remember, this was a proof of concept and even with the trampolines, it
> showed a great level of improvement. One thought was to do a
> "recordmcount.c" type of action to find where the calls were and patch
> them directly at boot up. I tried to keep the API the same where this
> could actually be done as an improvement later.
>
> Perhaps a gcc plugin might work too.
>
> I'll have to see what Ard did to handle the function parameters.
>

I didn't. My approach is just a generic function pointer which can be
overridden by the arch to be emitted as a trampoline instead.

Patching the call directly simply isn't feasible without compiler
support like we have with asm goto for jump_labels.

The use case I am proposing is providing different implementations of
crypto routines or CRC computation etc without having to rely on
function pointers, but still keep them as loadable modules. These
routines are a) heavy weight or we wouldn't bother providing
alternatives in the first place, and b) likely to have a considerable
I$ footprint already (and crypto libraries that have
encrypt/decrypt/setkey or init/update/final entry points will end up
with multiple trampolines in a single I-cache line). Also, the actual
patching only occurs on module load/unload.

I have no idea whether this reasoning applies to Steven's use case as
well, though, I haven't looked at his patches (I wasn't on cc)
