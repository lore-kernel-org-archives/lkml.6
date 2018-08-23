Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58171C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA74208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0ZbgcEV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA74208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeHWFDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 01:03:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36833 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeHWFDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 01:03:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id m27-v6so3146508wrf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 18:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gfYO0GBE+r+UEJlJxdr+644ej6McVRAnI+QcuUQUj3U=;
        b=0ZbgcEV5RmKlZqbSQuMV0lTqdBYvN22G6YQfuPblikHYsrR4rjkXL1W3TOQMzJSplI
         AirsW/UOQHtgQLs50SjFvhEekduBecjIi9sIQHO5sjJ+LRGL2re2zFD00G86IPDyPD1n
         segmPQRL/vrkhHasw7CTHom8LQKebdeciP8zLFPe1b+8ueAxl00S/aWta8GWhMSNyedo
         J9B5CLjmUxjYKX0RP7rOLKfCAHz9J91syPo0ZsB7YHvj8uXUd09Kr6GSQ+2WhiH3ponP
         4huM7mMBMqkoqdcQaxZ17RdIQWU/SxY5YFIgdPn9chT7q8hfHvqxcRAw8UMHxMVhf5le
         HIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gfYO0GBE+r+UEJlJxdr+644ej6McVRAnI+QcuUQUj3U=;
        b=UCXMN1TCUTs5umeIiklexLW694oVo6dKjO7U18R7LWOb69GUxIZLQee4xNpBV/p+i3
         pybb7c6FidRdFVg5q61KUSKQcJAFA8N73ksh+xF9ACOqDBu+c216FNabIoful/nmzDDn
         RElLy0MZWmDi1PAf775hSzk2BAH1Zq+q+pXb68GkE09EE4IPJgMNrQ9NG4u5NWuVLLg4
         X2zAIjC2qwsj9O/s3d8jlkvSNIZPhMSCCZ3a2YSms2tbIr4RU2tmwmDC7aP1tTT0/Azi
         Sum9kW8IIXK3bi06QkezRmqKXI8f5tCA5iUmfgMq2lIVasixyDeq7GeE6Evr+bRSZwRK
         dR8Q==
X-Gm-Message-State: APzg51CeWpZ1SyJvwB3fl22w6Qv+zPO0ObeAZhdV9fjfAwg9tKy5/CJG
        IIPnnGFg0tCB8lAAL+eEIaCOOUtTAs2Ac3uaTF22Gg==
X-Google-Smtp-Source: ANB0VdaDheTETmGkVGGT9ad9r2UunGxVkPK0KCHog0imGV4qOLyB36UXQD2vpN0ydPAm1hpr7i6zg21fNEGMaf4s6+M=
X-Received: by 2002:a5d:4c45:: with SMTP id n5-v6mr11534639wrt.71.1534988199338;
 Wed, 22 Aug 2018 18:36:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 18:36:18 -0700 (PDT)
In-Reply-To: <CAG48ez3fyav-cw-PP+45UwZLy6RjoDAwVgbpziKTj-pnB3zrYg@mail.gmail.com>
References: <20180807012257.20157-1-jannh@google.com> <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net>
 <CAG48ez0c0L+WyfjDcfx=3wDwOQDOSJM-2JSVUBoWJCaKDVEfbw@mail.gmail.com>
 <CALCETrU6gUBiTkpAUKh97y2R1cSftbMcfSTnSYxhZFRKf7vGWQ@mail.gmail.com> <CAG48ez3fyav-cw-PP+45UwZLy6RjoDAwVgbpziKTj-pnB3zrYg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 22 Aug 2018 18:36:18 -0700
Message-ID: <CALCETrXDHE7CJ+vN7hcPaRfn1f5kEiY8u=hxp1TuRZn_r6A3pQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86: WARN() when uaccess helpers fault on kernel addresses
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 5:55 PM, Jann Horn <jannh@google.com> wrote:
> On Thu, Aug 23, 2018 at 2:28 AM Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> On Wed, Aug 22, 2018 at 4:53 PM, Jann Horn <jannh@google.com> wrote:
>> > On Tue, Aug 7, 2018 at 4:55 AM Andy Lutomirski <luto@amacapital.net> wrote:
>> >> > On Aug 6, 2018, at 6:22 PM, Jann Horn <jannh@google.com> wrote:
>> >> > There have been multiple kernel vulnerabilities that permitted userspace to
>> >> > pass completely unchecked pointers through to userspace accessors:
>> >> >
>> >> > - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
>> >> >  access_ok() checks")
>> >> > - the sg/bsg read/write APIs
>> >> > - the infiniband read/write APIs
>> >> >
>> >> > These don't happen all that often, but when they do happen, it is hard to
>> >> > test for them properly; and it is probably also hard to discover them with
>> >> > fuzzing. Even when an unmapped kernel address is supplied to such buggy
>> >> > code, it just returns -EFAULT instead of doing a proper BUG() or at least
>> >> > WARN().
>> >> >
>> >> > This patch attempts to make such misbehaving code a bit more visible by
>> >> > WARN()ing in the pagefault handler code when a userspace accessor causes
>> >> > #PF on a kernel address and the current context isn't whitelisted.
>> >>
>> >> I like this a lot, and, in fact, I once wrote a patch to do something similar. It was before the fancy extable code, though, so it was a mess.  Here are some thoughts:
>> >>
>> >> - It should be three patches. One patch to add the _UA annotations, one to improve the info passes to the handlers, and one to change behavior.
>> >>
>> >> - You should pass the vector, the error code, and the address to the handler.
>> >
>> > I'm polishing the patch a bit, and I've noticed that to plumb the
>> > error code and address through properly, I might need significantly
>> > more code churn because of kprobes - I want to make sure I'm not going
>> > down the completely wrong path here.
>> >
>> > I'm extending fixup_exception() to take two extra args "unsigned long
>> > error_code, unsigned long fault_addr". Most callers of
>> > fixup_exception() are fairly straightforward, but
>> > kprobe_fault_handler() has a dozen callchains from different exception
>> > handlers, and most of them are coming via notify_die().
>>
>> KILL IT WITH FIRE!!!!!!!!
>>
>> More seriously, kill kprobe_exceptions_notify() and just fold the
>> contents into do_general_protection().  This notifier chain crap is
>> incomprehensible.  I would love to see notify_die() removed entirely,
>> and crap like this is just more reason to want it gone.
>
> This isn't just do_general_protection() though, that's just one
> example. As far as I can tell, similar stuff happens everywhere where
> notify_die() is used - #DF, #BR, #BP, #MF and so on.

True.  But there aren't actually that many places in the kernel that
use die notifiers at all.  Here's the complete list, excluding non-x86
arch-specific ones, annotated a bit:

arch/x86/kernel/kgdb.c:    retval = register_die_notifier(&kgdb_notifier);
arch/x86/kernel/kgdb.c:    unregister_die_notifier(&kgdb_notifier);
arch/x86/kernel/kgdb.c:    unregister_die_notifier(&kgdb_notifier);

OK, maybe not totally crazy for kgdb.

arch/x86/mm/kasan_init_64.c:    register_die_notifier(&kasan_die_notifier);

Should be in traps.c directly.

arch/x86/mm/kmmio.c:    return register_die_notifier(&nb_die);
arch/x86/mm/kmmio.c:    unregister_die_notifier(&nb_die);

Should probably be in traps.c directly.

drivers/bus/brcmstb_gisb.c:        register_die_notifier(&gisb_die_notifier);

I don't know WTF this is, but it is certainly garbage if anyone ever
tries to build this on x86.

drivers/dma/sh/shdmac.c:    int err =
register_die_notifier(&sh_dmae_nmi_notifier);
drivers/dma/sh/shdmac.c:    unregister_die_notifier(&sh_dmae_nmi_notifier);

SH-specific, I think.  Not really sure.

drivers/firmware/google/gsmi.c:    register_die_notifier(&gsmi_die_notifier);
drivers/firmware/google/gsmi.c:    unregister_die_notifier(&gsmi_die_notifier);

This is actually an *oops* notifier.  That's totally reasonable, but
it should be a separate OOPS notification chain.

drivers/hv/vmbus_drv.c:        register_die_notifier(&hyperv_die_block);
drivers/hv/vmbus_drv.c:        unregister_die_notifier(&hyperv_die_block);

Appears to *want* to be an OOPS notifier, but it appears to be rather
buggy and to actually catch everything.

drivers/misc/sgi-xp/xpc_main.c:
(void)unregister_die_notifier(&xpc_die_notifier);
drivers/misc/sgi-xp/xpc_main.c:    ret =
register_die_notifier(&xpc_die_notifier);
drivers/misc/sgi-xp/xpc_main.c:
(void)unregister_die_notifier(&xpc_die_notifier);

Haven't looked.

kernel/events/hw_breakpoint.c:    return
register_die_notifier(&hw_breakpoint_exceptions_nb);

This is an utter abomination and needs to be killed.  The #DB code is
gnarly enough without this particular indirection.  I want to kill it
on x86.  I have a big #DB cleanup series.  Maybe I'll do it.

kernel/events/uprobes.c:    return register_die_notifier(&uprobe_exception_nb);

For Pete's sake, the code should just call
uprobe_pre_sstep_notifier(regs)) and uprobe_post_sstep_notifier(regs)
directly.

kernel/kprobes.c:        err = register_die_notifier(&kprobe_exceptions_nb);

This is yours :)  And it is literally only hooking DIE_GPF.  Just make
the body empty, add a comment like /* XXX: the core code expects this
function to exist */ and call the hander from do_general_protection().

kernel/trace/trace.c:    register_die_notifier(&trace_die_notifier);

This is an OOPS notifier.

In any event, the particular offending kprobe notifier is literally
only checking for DIE_GPF.  So it really can be folded into
do_general_protection().  Or you could add fault_address to die_args.
