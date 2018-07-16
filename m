Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2293ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D625208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXEsNgiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D625208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeGPKgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:36:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39213 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeGPKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:36:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id j8-v6so1409936pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mVKIWjfWLy6vxVZ2OLbsYzsVvg9GlTUZV17mh/ba6iw=;
        b=gXEsNgiB9u4BIKjag3jGlp31yCaV/VW9tAgM13zdZOaOqb6ZZx/HzGyDt0KGCmrC72
         djZ8anFT8VL6ybVWjcDp2Q4g4tflfhvPdMnqmRzqrzdUhDidgNzkP5BMOU3ekzJ+ntsU
         8+Rz8o7kDKVe2HTK/CFzqv7t1iQNSQvjVB0ChwdY/3jtSVt0K+dtFG0gLuELwfIQXu82
         HblpPr+mqCaCMhri84QTFybm3YHedy/Zc97nTfW1mvJ0LycvrPCWM40SatAyNLOj9NRD
         +AFueMSZmz8h2kvllCuPKj2ROstHR7HLbxY9fz+2q8AalS9ERvUMmqkIfMu3RM3e7zSY
         wEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mVKIWjfWLy6vxVZ2OLbsYzsVvg9GlTUZV17mh/ba6iw=;
        b=IZeJZSdKfwf+OxJViVfCAE7LpaiHVxErORLNIg0w1a4/YD4YSkbFFqcj3Krg65Aeu6
         8HaAEM6j1Kg/nN2oZ6HHAgpBf2hyPylZ4waO4SUB5ytUrPupMJ0QfE/0hWl+4/Zp4pL6
         AneDp1FLQGGLmGSv7kGvzUbk6o5+tLekUY4fKXwKxCDy8qw94pB5b638ZyIE1D0Md/rB
         hhxr139UTkj1zTUk1djGFsWbbn+vw8w1MdlqGqWitpzFY2AgSb2DB47ip0CUfcOkXven
         FeLHfzFib8vxc6Ar4dh0fhwGmD3JE3CVntEbEddBoCXJY4WftYVDvoZPUAgRnZIk6wPr
         5/jg==
X-Gm-Message-State: AOUpUlGLQNQraOvgXkxawO1J0xrSBc6AVqC4CNusj1+9pvWilV/prXJj
        +9yOnJ2iJE8T4tWzFXcoTLKy96dZOIhgAylXX9R75g==
X-Google-Smtp-Source: AAOMgpcSrjIrd0P0VhsCF7Knq+NyuysJWl/KKawG4Rn9z9L2LgM4PIsGOfFeuiCr8bQgH6tV16EdckmKrQv/FGkvW1I=
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr15445463pgh.216.1531735806929;
 Mon, 16 Jul 2018 03:10:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:09:46
 -0700 (PDT)
In-Reply-To: <20180713145811.683ffd0043cac26a5a5af725@linux-foundation.org>
References: <000000000000eb546f0570e84e90@google.com> <20180713145811.683ffd0043cac26a5a5af725@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 16 Jul 2018 12:09:46 +0200
Message-ID: <CACT4Y+b1HC5CtFSQJEDBJrP8u1brKxXaFcYKE=g+h3aOW6K3Kg@mail.gmail.com>
Subject: Re: unexpected kernel reboot (3)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Gargi Sharma <gs051095@gmail.com>, jhugo@codeaurora.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Laura Abbott <lauraa@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:58 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 13 Jul 2018 14:39:02 -0700 syzbot <syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com> wrote:
>
>> Hello,
>>
>> syzbot found the following crash on:
>
> hm, I don't think I've seen an "unexpected reboot" report before.
>
> Can you expand on specifically what happened here?  Did the machine
> simply magically reboot itself?  Or did an external monitor whack it,
> or...

We put some user-space workload (not involving reboot syscall), and
the machine suddenly rebooted. We don't know what triggered the
reboot, we only see the consequences. We've seen few such bugs before,
e.g.:
https://syzkaller.appspot.com/bug?id=4f1db8b5e7dfcca55e20931aec0ee707c5cafc99
Usually it involves KVM. Potentially it's a bug in the outer
kernel/VMM, it may or may not be present in tip kernel.


> Does this test distinguish from a kernel which simply locks up?

Yes. If you look at the log:

https://syzkaller.appspot.com/x/log.txt?x=17c6a6d0400000

We've booted the machine, started running a program, and them boom! it
reboots without any other diagnostics. It's not a hang.



>> HEAD commit:    1e4b044d2251 Linux 4.18-rc4
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17c6a6d0400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=cce9ef2dd25246f815ee
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=165012c2400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1571462c400000
>
> I assume the "C reproducer" is irrelevant here.
>
> Is it reproducible?

Yes, it is reproducible and the C reproducer is relevant.
If syzbot provides a reproducer, it means that it booted a clean
machine, run the provided program (nothing else besides typical init
code and ssh/scp invocation) and that's the kernel output it observed
running this exact program.
However in this case, the exact setup can be relevant. syzbot uses GCE
VMs, it may or may not reproduce with other VMMs/physical hardware,
sometimes such bugs depend on exact CPU type.


>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com
>>
>> output_len: 0x00000000092459b0
>> kernel_total_size: 0x000000000a505000
>> trampoline_32bit: 0x000000000009d000
>>
>> Decompressing Linux... Parsing ELF... done.
>> Booting the kernel.
>> [    0.000000] Linux version 4.18.0-rc4+ (syzkaller@ci) (gcc version 8.0.1
>> 20180413 (experimental) (GCC)) #138 SMP Mon Jul 9 10:45:11 UTC 2018
>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1
>> console=ttyS0 earlyprintk=serial vsyscall=native rodata=n
>> ftrace_dump_on_oops=orig_cpu oops=panic panic_on_warn=1 nmi_watchdog=panic
>> panic=86400 workqueue.watchdog_thresh=140 kvm-intel.nested=1
>>
>> ...
>>
>> regulatory database
>> [    4.519364] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>> [    4.520839] platform regulatory.0: Direct firmware load for
>> regulatory.db failed with error -2
>> [    4.522155] cfg80211: failed to load regulatory.db
>> [    4.522185] ALSA device list:
>> [    4.523499]   #0: Dummy 1
>> [    4.523951]   #1: Loopback 1
>> [    4.524389]   #2: Virtual MIDI Card 1
>> [    4.825991] input: ImExPS/2 Generic Explorer Mouse as
>> /devices/platform/i8042/serio1/input/input4
>> [    4.829533] md: Waiting for all devices to be available before autodetect
>> [    4.830562] md: If you don't use raid, use raid=noautodetect
>> [    4.835237] md: Autodetecting RAID arrays.
>> [    4.835882] md: autorun ...
>> [    4.836364] md: ... autorun DONE.
>
> Can we assume that the failure occurred in or immediately after the MD code,
> or might some output have been truncated?
>
> It would be useful to know what the kernel was initializing immediately
> after MD.  Do you have a kernel log for the same config when the kerenl
> didn't fail?  Or maybe enable initcall_debug?
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180713145811.683ffd0043cac26a5a5af725%40linux-foundation.org.
> For more options, visit https://groups.google.com/d/optout.
