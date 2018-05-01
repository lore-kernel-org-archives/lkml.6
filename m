Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750823AbeEAWdI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:33:08 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49956 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbeEAWdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:33:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
        Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Dave Young <dyoung@redhat.com>, <linux-pci@vger.kernel.org>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
References: <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
        <20180427211255.GI8199@bhelgaas-glaptop.roam.corp.google.com>
        <20180428005620.GB1675@dhcp-128-65.nay.redhat.com>
        <20180428011845.GC1675@dhcp-128-65.nay.redhat.com>
        <3ebc908fb196168bf0373875ffc5679e@codeaurora.org>
        <d8d134dc-9757-97cd-7a24-cbb21611d6c6@codeaurora.org>
        <20180430211740.GG95643@bhelgaas-glaptop.roam.corp.google.com>
        <7285da70-2c3e-c3b7-62e1-fdbb55a77729@codeaurora.org>
        <3549ffe8-7605-d72c-5c09-1436a4288c7d@codeaurora.org>
        <ffe662be-00c7-ab7f-0e88-8119ccfd9600@arm.com>
        <20180501132554.GA11698@bhelgaas-glaptop.roam.corp.google.com>
        <861sevcp74.wl-marc.zyngier@arm.com>
Date: Tue, 01 May 2018 17:32:32 -0500
In-Reply-To: <861sevcp74.wl-marc.zyngier@arm.com> (Marc Zyngier's message of
        "Tue, 01 May 2018 17:31:43 +0100")
Message-ID: <87tvrrypkv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDdp7-0004eK-7G;;;mid=<87tvrrypkv.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18GckogPUwgY3vhlhQyTphJk4NmRxgiFlo=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Marc Zyngier <marc.zyngier@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15028 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.1 (0.0%), b_tie_ro: 2.2 (0.0%), parse: 1.35 (0.0%),
        extract_message_metadata: 15 (0.1%), get_uri_detail_list: 5 (0.0%),
        tests_pri_-1000: 3.1 (0.0%), tests_pri_-950: 1.23 (0.0%), tests_pri_-900:
        1.02 (0.0%), tests_pri_-400: 42 (0.3%), check_bayes: 40 (0.3%), b_tokenize:
        14 (0.1%), b_tok_get_all: 14 (0.1%), b_comp_prob: 6 (0.0%), b_tok_touch_all:
        3.7 (0.0%), b_finish: 0.69 (0.0%), tests_pri_0: 426 (2.8%),
        check_dkim_signature: 0.57 (0.0%), check_dkim_adsp: 2.7 (0.0%),
        tests_pri_500: 14532 (96.7%), poll_dns_idle: 14524 (96.7%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038 (issued 65284 msec ago)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <marc.zyngier@arm.com> writes:

> On Tue, 01 May 2018 14:25:54 +0100,
> Bjorn Helgaas wrote:
>
> Hi Bjorn,
>
>> On Tue, May 01, 2018 at 01:59:20PM +0100, Marc Zyngier wrote:
>> > On 01/05/18 13:38, Sinan Kaya wrote:
>> > > +Marc,
>> > > 
>> > > On 4/30/2018 5:27 PM, Sinan Kaya wrote:
>> > >> On 4/30/2018 5:17 PM, Bjorn Helgaas wrote:
>> > >>>> What should we do about this?
>> > >>>>
>> > >>>> Since there is an actual HW errata involved, should we quirk this
>> > >>>> root port and not wait as if remove/shutdown doesn't exist?
>> > >>> I was hoping to avoid a quirk because AFAIK all Intel parts have this
>> > >>> issue so it will be an ongoing maintenance issue.  I tried to avoid
>> > >>> the timeout delays, e.g., with 40b960831cfa ("PCI: pciehp: Compute
>> > >>> timeout from hotplug command start time").
>> > >>>
>> > >>> But we still see the alarming messages, so we should probably add a
>> > >>> quirk to get rid of those.
>> > >>>
>> > >>> But I haven't given up on the idea of getting rid of the
>> > >>> pciehp_remove() path.  I'm not convinced yet that we actually need to
>> > >>> do anything to shut this device down.  I don't like the assumption
>> > >>> that kexec requires this.  The kexec is fundamentally just a branch,
>> > >>> and anything we do before the branch (i.e., in the old kernel), we
>> > >>> should also be able to do after the branch (i.e., in the kexec-ed
>> > >>> kernel).
>> > >>>
>> > >>
>> > >> In my experience with kexec, MSI type edge interrupts are harmless.
>> > >> You might just see a few unhandled interrupt messages during boot
>> > >> if something is pending from the first kernel.
>> > 
>> > Unfortunately, that's not always the case.
>> > 
>> > A number of GICv3/v4 implementations (a very common interrupt controller
>> > on ARM servers) cannot be disabled, which means they will keep writing
>> > to their pending tables long after kexec will have started the new
>> > kernel. And since we don't track memory allocation across kexec, you
>> > end-up with significant chances of observing single bit corruption as
>> > interrupts carry on being delivered. Oh, and you won't actually be able
>> > to take MSIs because you can't even reprogram the damn thing.
>> > 
>> > Yes, this can be considered a HW bug.
>> > 
>> > >> It is the level interrupts that are more concerning. It remains pending
>> > >> until the interrupt source is cleared. CPU never returns from the
>> > >> interrupt handler to actually continue booting the second kernel.
>> > > 
>> > > This makes me wonder why kexec doesn't disable all interrupt sources by
>> > > itself instead of relying on the drivers shutdown routine. Some drivers
>> > > don't even have a shutdown callback. Kexec could have done both as another
>> > > example. Something like.
>> > > 
>> > > 1. Call shutdown for all drivers if available.
>> > > 2. Disable all interrupt sources in the interrupt controller
>> > > 3. Start the new kernel.
>> > 
>> > See above. Although you can shut off the end-point and to some extent
>> > mask interrupts before jumping into the payload, it is not always
>> > possible to go back to a reasonable state where you can take actually MSIs.
>> 
>> This is exactly the sort of thing it would be nice to collect and
>> document as part of the background of "why kexec works the way it
>> does."  It certainly helps explain things that are far from obvious if
>> you don't have the background.
>
> I'd certainly be happy to help with it if someone was willing to
> kickstart such a document. kexec/kdump is a huge bag of "interesting"
> tricks, and it has driven me mad over the past couple of months (I'm
> typing this from a laptop that uses kexec as its bootloader, and it is
> *not fun*).

I don't know if it helps documentation wise but here is my memory of why
things are the way they are.

Case 1) kexec-on-panic.

In this case we run the new kernel in memory reserved since boot of the
previous kernel in memory has never been used by any device driver.
This means on-going DMA transactions that we don't manage to shut off
are harmless.

In actual execution a bare minimum of hardware is shutdown on the
kexec-on-panic path.  Ideally it would be nothing.  The crashing kernel
simply can not be trusted to shut things down itself.

The kernel that is executing in the after the crash loads a bare minimum
of drivers and does it's best to initialize the hardware.  Ideally if
something goes wrong the kernel will hang before we write to hardware
and mess anything up.

With this we get something like a 50% or a 60% success rate of capture
crashdump in practice in the field.

Everything else that has been tried relies more on the crashing kernel
and looks great in testing and then turns out to not have a measurable
success rate in practice.

Using lkdtm you can setup tests of various kinds of kernel corruption
and failure and see some approximation of the success rate of kexec will
see in practice.

I forget where we are with iommus, but the principles remain and iommus
tend to tricky just because they get in the middle of everything.

If someone stares hard enough we are probably at the point on x86 where
we can remove the irq shutdown code.

The kexec on panic case tends to be tested more on enterprise kernels
than on normal ones.

Case 2) Ordinary kexec.

The goal is to have a fully functionaly uncompromised system (unlike
kexec on panic).  Hardware bugs mean that in the general case the only
place we can shutdown hardware reliably is the drivers themselves.

All devices doing DMA must be shutdown in the kexec'ing kernel.  In part
because there is no guarantee that we will even load a driver for that
hardware.

The presence of DMA drove most of the decisions.  But from this thread I
see that irq handling follows the same pattern.  The best place to shut
anything down is in the driver where there is full knowledge of how
things work.

One of the more annoying things that have been discovered is the generic
pci dma disable bit doesn't work uniformly acrosss hardware.  Which
means there is no known generic way to shut down dma across the board.

In the prototypes there was only the "remove" method of drivers and that
worked well.  When it came time to merge the original kexec
implementation the maintainer of the power mananagement subsystem
insisted we add a new "shutdown" method instead, because while it is
necessary to shutdown the hardware you should not need to clean up the
data structures.

In practice that idea flopped.  The most reliable way I know to run
kexec is to remmod all of the drivers before runing sys_reboot(...,
LINUX_REBOT_CMD_KEXEC, ...) so that the shutdown methods get run.

It has been asked and I have given my approval to anyone who wants to do
the work to switch form the "shutdown" methods to "remove" on the kexec
path.  But so far it is a big enough project that no one has done that
yet.

It has been suggested that hardware does not need to be shutdown at the
end of the kernel before returning to a a firmware method.  Which is
incorrect.  Most firmware when it regains control triggers a system
reset to get the hardware back into a usable state, and be able to
reboot the system.  There is a magic register for this on x86.  On older
x86 systems and others that transfer control to firmware without doing a
soft hardware reset of the system and all of the devices.  Without
shutting down the devices they will work about as well as kexec does
when you don't remove the devices.  That is why I merged the reboot
and the kexec code paths.  Well that and so that there is a little
more testing.

In practice it still seems that rmmod is the only testing that reliably
happens to drivers.  So not sharing that code path makes kexec more
fragile than necessary.

Hopefully this helps put things into perspective and can help with your
docuement.

Eric
