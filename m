Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935494AbeBMOjA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:39:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50668 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935246AbeBMOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:38:58 -0500
Date: Tue, 13 Feb 2018 15:39:02 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tvrtko Ursulin <tursulin@ursulin.net>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
In-Reply-To: <f4069994-6065-af69-0ab5-0587efe26636@ursulin.net>
Message-ID: <alpine.DEB.2.21.1802131533160.1130@nanos.tec.linutronix.de>
References: <1696e2c6-8d0a-e954-1205-439d70a81f77@ursulin.net> <f4069994-6065-af69-0ab5-0587efe26636@ursulin.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, Tvrtko Ursulin wrote:
> On 07/02/18 12:48, Tvrtko Ursulin wrote:
> > We are seeing failures to online the CPU0 on Apollo Lake in the form of:
> > 
> >   <6>[  126.508783] smpboot: CPU 0 is now offline
> >   <6>[  127.520746] smpboot: Booting Node 0 Processor 0 APIC 0x0
> >   <3>[  137.521036] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
> > 
> > I unfortunately cannot say with which kernel version this started since
> > we added a test which does this only recently. I also have no local
> > access to this machine. (It is part of a test farm for i915 driver
> > development testing.) But we recently added a test which off-lines, and
> > on-lines back, CPUs and started seeing this. Small reproducer looks like
> > this (without boilerplate):
>
> Any hints on how to debug this? Could it be firwmare? Try some boot options or
> something?

There are issues with CPU0 hotplug on commodity hardware. I have systems
where it does not work, but TBH I never bothered to investigate it. Some
years ago we had issues with suspend/resume when it was not running on
CPU0.  These were related to firmware assumptions about CPU0. So I wouldn't
be too surprised if there are general issues with unplugging CPU0.

CPU0 unplug is really only relevant for systems which support physical
hotplug, so testing it on commodity hardware does not have much
value. Testing in VMs for increasing the test coverage works well enough.

Thanks,

	tglx
