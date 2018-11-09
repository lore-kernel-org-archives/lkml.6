Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37709C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73D520685
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBoZN8mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73D520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeKJDeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:34:09 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35630 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeKJDeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:34:09 -0500
Received: by mail-it1-f194.google.com with SMTP id v11so4542007itj.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E95R29DOT5MM3H1746Z4C+nswoj3mJlY/BGH9VkG6+E=;
        b=FBoZN8mvfeR23+MowdwI4g93WdTL/aJ/GQOU4WYoxc7wnDBViJVaTNoCahGP7+9BWI
         fN9fcSbCZkFaOCFvw/aD69a3DcgAA1cTOid5ILrewdpPYappF/cP8vb+YarJ1vheAHJC
         IihgcsEXJCrXkqjp+N/pK7AqMG3c/etorDPIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E95R29DOT5MM3H1746Z4C+nswoj3mJlY/BGH9VkG6+E=;
        b=CoNl99mBXNejph4WTeC5AEAapIp4jDPEKNpEXvlwbr0jCsJtHKJLCCq7DDVlOsAlBc
         gxFy8R/3b1S6t6jc1EBApnDozefoW6GkcWln+eZdtgs6a6rVz5FdKYt3bAKQzOakgySl
         Uy06qtJt4eqMOb6U1xf9020a+7ckAiszS6E82JPE0lwy2RITnaeAo3xW/8lV+Y5n8JB9
         8i4Jin4r+d9Q48Uu7+Fk8ZXuqjr23wSWGHeSzg3vSfVZRqIMUh1OKD8NNF5bBhFByE+s
         rSFIKeijaKe10omrRf4nYrAsO/wk4x5L6+91mw/iLOvqe6MPdHMnCRS1d4FAxVarrSw/
         e5Bg==
X-Gm-Message-State: AGRZ1gJrcdJyuOMT0U4+PfWbyh/pZ+8Ss5ib3QSGlD1NuSQGSBUvC23J
        woWfBUSm4yd0vGqKwphwzCnNGOn6V/zc1eeXpN2ZDg==
X-Google-Smtp-Source: AJdET5cXWNe/fFBo4+BgBFo/uIRAkHV+FnyhZoZLWC2QG1vx9iUDF5UNbmmSHDx4x3E+YTdv1afUgwBvxibnDaJlT2k=
X-Received: by 2002:a24:8347:: with SMTP id d68-v6mr3295999ite.158.1541785950378;
 Fri, 09 Nov 2018 09:52:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 09:52:29 -0800 (PST)
In-Reply-To: <20181109174608.eahqh4fkyl3k2gvs@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com> <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com>
 <20181109151028.faifw66enzye32gg@treble> <CAKv+Gu_J1b30+pMNRF0icEpyew4TM_VP3ShG=4HkLnk=fRL9zg@mail.gmail.com>
 <CAKv+Gu-DOW2WT=h8C0x5igbCDAc2bp3mTRM6U_wTJST+RnVicg@mail.gmail.com>
 <20181109173106.kbghzsdsu7oachl6@treble> <CAKv+Gu-9XYOwAPJ5m6F4Cn9Uo6dvbtEG9p0knX+_XcjHp2QKGA@mail.gmail.com>
 <20181109174608.eahqh4fkyl3k2gvs@treble>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 9 Nov 2018 18:52:29 +0100
Message-ID: <CAKv+Gu8b1KbRtJPrbXk3+K=1uRV6OcvB+zEMYk-UK3sFxKzsgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On 9 November 2018 at 18:46, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Fri, Nov 09, 2018 at 06:33:03PM +0100, Ard Biesheuvel wrote:
>> On 9 November 2018 at 18:31, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> > On Fri, Nov 09, 2018 at 06:25:24PM +0100, Ard Biesheuvel wrote:
>> >> On 9 November 2018 at 16:14, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >> > On 9 November 2018 at 16:10, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> >> >> On Fri, Nov 09, 2018 at 02:39:17PM +0100, Ard Biesheuvel wrote:
>> >> >>> > +       for (site = start; site < stop; site++) {
>> >> >>> > +               struct static_call_key *key = static_call_key(site);
>> >> >>> > +               unsigned long addr = static_call_addr(site);
>> >> >>> > +
>> >> >>> > +               if (list_empty(&key->site_mods)) {
>> >> >>> > +                       struct static_call_mod *mod;
>> >> >>> > +
>> >> >>> > +                       mod = kzalloc(sizeof(*mod), GFP_KERNEL);
>> >> >>> > +                       if (!mod) {
>> >> >>> > +                               WARN(1, "Failed to allocate memory for static calls");
>> >> >>> > +                               return;
>> >> >>> > +                       }
>> >> >>> > +
>> >> >>> > +                       mod->sites = site;
>> >> >>> > +                       list_add_tail(&mod->list, &key->site_mods);
>> >> >>> > +
>> >> >>> > +                       /*
>> >> >>> > +                        * The trampoline should no longer be used.  Poison it
>> >> >>> > +                        * it with a BUG() to catch any stray callers.
>> >> >>> > +                        */
>> >> >>> > +                       arch_static_call_poison_tramp(addr);
>> >> >>>
>> >> >>> This patches the wrong thing: the trampoline is at key->func not addr.
>> >> >>
>> >> >> If you look at the x86 implementation, it actually does poison the
>> >> >> trampoline.
>> >> >>
>> >> >> The address of the trampoline isn't actually known here.  key->func
>> >> >> isn't the trampoline address; it's the destination func address.
>> >> >>
>> >> >> So instead I passed the address of the call instruction.  The arch code
>> >> >> then reads the instruction to find the callee (the trampoline).
>> >> >>
>> >> >> The code is a bit confusing.  To make it more obvious, maybe we should
>> >> >> add another arch function to read the call destination.  Then this code
>> >> >> can pass that into arch_static_call_poison_tramp().
>> >> >>
>> >> >
>> >> > Ah right, so I am basically missing a dereference in my
>> >> > arch_static_call_poison_tramp() code if this breaks.
>> >> >
>> >>
>> >> Could we call it 'defuse' rather than 'poision'? On arm64, we will
>> >> need to keep it around to bounce function calls that are out of range,
>> >> and replace it with a PLT sequence.
>> >
>> > Ok, but doesn't that defeat the purpose of the inline approach?
>> >
>>
>> It does. But this only occurs when a module is loaded far away, and
>> this will only happen if you have 2 GB range KASLR enabled, or your
>> 128 MB module region gets exhausted for some reason, so the majority
>> of calls should use a single relative branch.
>
> Makes sense.  Do you also account for the possibility that the original
> call emitted by GCC was far away and thus used the PLT?
>

That doesn't really happen. vmlinux is never over 128 MB, and the
modules are only partially linked, so the linker never gets to the
stage where it needs to emit veneers.

It's a bit fiddly since inline and out-of-line both use
arch_static_call_transform(), but what I need to do is basically:

- for out-of-line, the trampoline needs to be patched into a
movn/movk/movk/br sequence if the target is too far
- for inline, the trampoline itself needs to be patched from
adrp/ldr/br (which does a load and a indirect branch) to
movn/movk/movk/br (which uses immediates), and the call sites need to
be patched into calls to the veneer if the target is out of range.

So arch_static_call_transform() needs to know where the trampoline is
for this use case, so could we perhaps add a 'void *orig' in the key
struct that keeps track of the original value of 'addr' ?
