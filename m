Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847F72087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gmsPfh5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfAGSR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:17:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35605 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfAGSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:17:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so1824155edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/G9avRAlu7VUlp68Qy2q3kIm7mkB+wojKsP3w2vAPK4=;
        b=gmsPfh5WJzYMnL5+CNHQCeJiHV2xx9cgk6EIb7fqJ25oKXa8kzK4TgFYu76JQfSWR3
         hvSw+DQSa4+SVq6qM5fBJdE/ODFkupvSPH/kAirSmarkCjeByahKpLIq8AhFY92/fbhL
         uSLix5tvjjMkLYZfrQJvrPUU6SUvLjkL0MEngRi38MpLmbG3UOk3h9cjdo3ecCSXJvbn
         JiQcMGO4SEceCR/dau+sI62sr1j1BDzPiv1oWYKKtenPJo3gA9rqfQShG5OY7LNokECX
         BSm+kUFhB2H0PccRjkSeQ7Fhl5eB9uyt0/2t3OqcLbrayCo/9J9RaPaMOQ23EOl85Rkg
         N+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/G9avRAlu7VUlp68Qy2q3kIm7mkB+wojKsP3w2vAPK4=;
        b=jGpHYcvCpYF4mCCxe4f5Wi63EOZxanS1ll7VnZXLnqTAl+voxxFENwPph0ohZf0vd4
         fgGM4uYykeue9WL1EiWireYtZ6+iDUwk2WScbAhVEgVWIDkK2DCFZhcLaDzVLG13ZqQa
         ZGz+ShXMvMbBUemtbNltu7YoDz/dzxUr1Fmg5bmd/FA5BOX+g9JQ57nzBC4k5nmN2kKr
         DNWTbV/6gf9ER7DRCRH/X+F1M3kr6Y7qWhlT3jA3V7rgbpBv+bNpGNRzAEDtbZKfBi/V
         DTXpRgej/Jcxqf7MfD+gXreQFHyQIRYFDcM7ys3vc6hu+CbYVrYFwRglaN+9AnFpykxo
         Rk5Q==
X-Gm-Message-State: AA+aEWZ5a7Dk4/cr6cjtljhi/sFNptvrfYAxAbjls3NGFIewwnJWdCUu
        3+kh865TAcWXBgNA7en26rmMXZ8sBWGvl4GLzh/I1w==
X-Google-Smtp-Source: AFSGD/UAa0MhaPFOnTeSa3cIRn7oZVkFLaYV49P8mZALL/gowJ5Z2BNrgv/2GAoUqKW7EhtZiyaNrtPayqftiCvi8S8=
X-Received: by 2002:a50:9a42:: with SMTP id o60mr58118669edb.180.1546885046809;
 Mon, 07 Jan 2019 10:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
 <20180719205545.16512-24-pasha.tatashin@oracle.com> <20181106054212.GA31768@nautica>
 <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com> <20190102202032.GA1034@eldamar.local>
 <CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com> <20190103234339.GA17457@nautica>
In-Reply-To: <20190103234339.GA17457@nautica>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 7 Jan 2019 13:17:16 -0500
Message-ID: <CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
Subject: Re: [PATCH v15 23/26] sched: early boot clock
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, John Stultz <john.stultz@linaro.org>,
        sboyd@codeaurora.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 6:43 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Pavel Tatashin wrote on Thu, Jan 03, 2019:
> > Could you please send the config file and qemu arguments that were
> > used to reproduce this problem.
>
> Running qemu by hand, nothing fancy e.g. this works:
>
> # qemu-system-x86_64 -m 1G -smp 4 -drive file=/root/kvm-wrapper/disks/f2.img,if=virtio -serial mon:stdio --enable-kvm -cpu Haswell -device virtio-rng-pci -nographic
>
> (used a specific cpu just in case but normally runnning with cpu host on
> a skylake machine; can probably go older)
>
>
> qemu is fedora 29 blend as is:
> $ qemu-system-x86_64 --version
> QEMU emulator version 3.0.0 (qemu-3.0.0-3.fc29)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>
>
> compressed .config attached to the mail, this can likely be trimmed down
> some as well but that takes more time for me..
> I didn't rebuild the kernel so not 100% sure (comes from
> /proc/config.gz) but it should work on a 4.20-rc2 kernel as written in
> the first few lines; 857baa87b64 I referred to in another mail was
> merged in 4.19-rc1 so anything past that is probably OK to reproduce...
>
>
> Re-checked today with these exact options (fresh VM start; then suspend
> laptop for a bit, then reboot VM):
> [    0.000000] Hypervisor detected: KVM
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [ 2477.907447] kvm-clock: cpu 0, msr 153a4001, primary cpu clock
> [ 2477.907448] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [ 2477.907450] tsc: Detected 2592.000 MHz processor

I could not reproduce the problem. Did you suspend to memory between
wake ups? Does this time jump happen every time, even if your laptop
sleeps for a minute?

I have tried with qemu 2.6 and 3.1 on Ubuntu, testing 4.20rc2.

Pasha
