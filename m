Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB9FC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 02:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89DE2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 02:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfAZCOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 21:14:05 -0500
Received: from pinero.vault24.org ([69.164.212.126]:38228 "EHLO
        pinero.vault24.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZCOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 21:14:05 -0500
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jan 2019 21:14:03 EST
Received: from feynman.vault24.org (c-98-243-50-21.hsd1.mi.comcast.net [98.243.50.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by pinero.vault24.org (Postfix) with ESMTPS id 68348603D;
        Fri, 25 Jan 2019 21:04:12 -0500 (EST)
Received: by feynman.vault24.org (Postfix, from userid 1000)
        id 1FCCB3020AE7; Fri, 25 Jan 2019 21:04:10 -0500 (EST)
Date:   Fri, 25 Jan 2019 21:04:10 -0500
From:   Jon DeVree <nuxi@vault24.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
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
Subject: Re: [PATCH v15 23/26] sched: early boot clock
Message-ID: <20190126020410.GB3796@feynman.vault24.org>
Mail-Followup-To: Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        Peter Zijlstra <peterz@infradead.org>, prarit@redhat.com,
        feng.tang@intel.com, Petr Mladek <pmladek@suse.com>,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
 <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <20181106054212.GA31768@nautica>
 <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
 <20190102202032.GA1034@eldamar.local>
 <CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
 <20190103234339.GA17457@nautica>
 <CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
 <20190107234839.GA15269@nautica>
 <CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 20:04:41 -0500, Pavel Tatashin wrote:
> I did exactly the same sequence on Kaby Lake CPU and could not
> reproduce it. What is your host CPU?
> 

I have some machines which display this bug and others that don't, so I
was able to figure out the difference between their configurations.

TL;DR the bug appears to be based on wther or not
/sys/devices/system/clocksource/clocksource0/current_clocksource is set
to TSC in the hypervisor

This is the log from a machine with the bug:

[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 12 and 11
[1162908.013830] kvm-clock: cpu 0, msr 3e0fea001, primary cpu clock
[1162908.013830] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[1162908.013834] tsc: Detected 1899.888 MHz processor

This is the log from a machine without the bug:

[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 149fea001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 1558436482528906 cycles
[    0.000002] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000004] tsc: Detected 2097.570 MHz processor

Note the additional line of output on the machine without the bug:

[    0.000000] kvm-clock: using sched offset of 1558436482528906 cycles

This is printed from kvm_sched_clock_init() in
arch/x86/kernel/kvmclock.c based on whether or not the clock is stable.
For the clock to be stable both KVM_FEATURE_CLOCKSOURCE_STABLE_BIT and
PVCLOCK_TSC_STABLE_BIT have to be set.  Both of these are controlled by
the hypervisor kernel.

* KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is always set by the hypervisor
  starting with Linux v2.6.35 - 371bcf646d17 ("KVM: x86: Tell the guest
  we'll warn it about tsc stability")
* PVCLOCK_TSC_STABLE_BIT is set starting in Linux v3.8 but only if the
  clocksource is the TSC - d828199e8444 ("KVM: x86: implement
  PVCLOCK_TSC_STABLE_BIT pvclock flag")

I changed the clocksource of a hypervisor that wasn't having issues from
TSC to HPET and when I started up a guest VM the bug suddenly appeared.
I shut down the guest, set the hypervisor's clocksource back to TSC,
started up the guest and the bug went away again.

You don't actually have to reboot the guest before the bug is visible
either, just letting the guest sit at the GRUB menu for a minute or two
before loading Linux is enough to make the bug plainly visible in the
printk timestamps.

I don't know enough to actually fix the bug, but hopefully this is
enough to allow everyone else to reproduce it and come up with a fix.

-- 
Jon
X(7): A program for managing terminal windows. See also screen(1) and tmux(1).
