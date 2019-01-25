Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ECCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6CD2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O3bnzLt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfAYHEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:04:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46322 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfAYHEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:04:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so7617638otm.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSKcSBzjlO+Xnz+ZDo0pfpnJUZNUNT3GHzT0JfFW18w=;
        b=O3bnzLt4eeqjUZ6mKEeLqpWft6qdoz8XEsRhE0EbRYOttfTAGxxekJQfTp4Ne1nUJp
         RJkzL4BPcRyQmwk1MxaBXVQENiJPC/MBp8YmgAznQwE0cm7pNnIzQZBJtJ0Cao5TZyTZ
         cBmdz8gWBjhVmY84v9sTGUfXFD6fX0I6FnKEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSKcSBzjlO+Xnz+ZDo0pfpnJUZNUNT3GHzT0JfFW18w=;
        b=jhUZFRhmp41/4TVQbi2PLVCj1Tmbp3FNTAtsZwSHL6pE1m8qi0kgnPXHyhwrqmVmwt
         XQeyKPjdPnFQnhth9qXvccMxtYVKre8Z2UVwVaSVAfDViintbXknTN22fE2snonJfviB
         9qodsoaCiXkDzkMn00xje4C2oYBC7/bUJNeoP61ONG9tlStRNvmRbLEhzaJqbBDWGrw1
         M1gzx63updwc4HidKlVcSn9arzDjQwqGO/10n+bm7rMsI2d1Y7Pvny+Z6pTwXV3dAn9i
         MRFMNMI+ngcQf68VTP9v2DQE915Q1MHsJzntAGnvtD1KZryWAnl33iWhb9aoT/TnXbEf
         FMyQ==
X-Gm-Message-State: AJcUuke3TqxngiJs3qxDbp+JhPiU74gHpDGmhzAgHXcxeHCPi1+x4u5f
        6kD3tmm2ng70wl7UuuoYCKkyZ4TwZHdGrmLnrY8EwA==
X-Google-Smtp-Source: ALg8bN7i6AtevmO7TfgEIi4xyk5yJTqbTqSI9bMKsRr15Jx6kiMchKzoIUTmrNPgmQtqmQ5F+kA2gvkWVVOTi/3DVpU=
X-Received: by 2002:a05:6830:12c4:: with SMTP id a4mr7193353otq.138.1548399847747;
 Thu, 24 Jan 2019 23:04:07 -0800 (PST)
MIME-Version: 1.0
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin> <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
 <20190123164801.GA55887@lakrids.cambridge.arm.com> <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
 <20190123173343.GC55887@lakrids.cambridge.arm.com>
In-Reply-To: <20190123173343.GC55887@lakrids.cambridge.arm.com>
From:   Pramod Kumar <pramod.kumar@broadcom.com>
Date:   Fri, 25 Jan 2019 12:33:56 +0530
Message-ID: <CAJ+tv6+Mm8Rmsx8cfOuDT4+CVWVd4gKLzUnTs_EMxKYax+NScw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:03 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jan 23, 2019 at 09:05:26AM -0800, Scott Branden wrote:
> > Hi Mark,
> >
> > Hopefully I can shed some light on the use case inline.
> >
> > On 2019-01-23 8:48 a.m., Mark Rutland wrote:
> > > On Mon, Jan 21, 2019 at 11:30:02AM +0530, Pramod Kumar wrote:
> > > > On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com>
> > > > wrote:
> > > >
> > > >      Need comes from a specific use case where one Accelerator card(SoC) is
> > > >      plugged in a sever over a PCIe interface.  This Card gets supply from a
> > > >      battery, which could provide very less power for a very small time, in case
> > > >      of any power loss. Once Card switches to battery, this has to reduce its
> > > >      power consumption to its lowest point and back-up the DDR contents asap
> > > >      before battery gets fully drained off.
> > > In this example is Linux running on the server, or on the accelerator?
> > Accelerator
> > >
> > > What precisely are you trying to back up from DDR, and why?
> > Data in DDR is being written to disk at this time (disk is connected to
> > accelerator)
> > >
> > > What is responsible for backing up that contents?
> >
> > A low power M-class processor and DMA engine which continues necessary
> > operations to transfer DDR memory to disk.
> >
> > The high power processors on the accelerator running linux needed to be
> > halted ASAP on this power loss event and M0 take over. Graceful shutdown of
> > linux and other peripherals is unnecessary (and we don't have the power
> > necessary to do so).
>
> If graceful shutdown of Linux is not required (and is in fact
> undesireable), why is Linux involved at all in this shutdown process?
>
> For example, why is this not a secure interrupt taken to EL3, which can
> (gracefully) shut down the CPUs regardless?
>

This is an GPIO interrupt. This can not be marked secure as for that
we need to mark whole GPIO controller as secure which is not possible
as GPIO controller is meant for non-secure world having more than 100
lines connected.

I agree we have work around where we invoke handler in Linux and
switch to ATF via SMC and from ATF we need bring all secondary CPU to
ATF via sending SGI and and then respective core flushes the L1/L2 and
bring himself out of coherency domain and cluster and MCU shutdowns
the CPU subsystem gracefully. This could work for our requirement.
Need to check ATF support for that.

But What about generic system? This patch address the generic
multi-master system's requirement. Consider system where shutting down
the linux does not mean shutting down the complete system. Lets take
an example of smartnic case Where NIC master and CPUs access cachable
DDR. In smarnic its quite common to bring CPUs on demand means when
needed via MCU help.
Now in full-fledged system. if CPU subsystem is shutdown via poweroff
command which does not bring secondary CPUs out of coherency domain,
it will bring the complete system unstable when NIC master tries to
access DDR and snoop is send to CPUs as well which is not available.
Fabric/System hangs...

I feel While shutting down the CPUs subsystem or powering off, All
secondary CPUs must be shutdown properly by bring-out of coherency
domain to remain rest of subsystem usable. I agree that introducing
PSCI call introduce delay for shutdown/reboot case but stability
matter than little delay.

> > > >      Since battery can provide limited power for a very short time hence need to
> > > >      transition to lowest power. As per the transition process , CPUs power
> > > >      domain has to be off but before that it needs to flush out its content to
> > > >      system memory(L3) so that content could be backed-up by a MCU, a controller
> > > >      consuming very less power. Since we can not afford plugging-out every
> > > >      individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
> > > >      which ultimately switch to ATF to flush out all the CPUs caches and comes
> > > >      out of coherency domain so that its power rails could be switched-off.
> > > If you're stopping CPUs from completely arbitrary states, what is the
> > > benefit of saving the RAM contents?
> >
> > Some of the RAM contains data that was in the process of being written to
> > disk by the accelerator.
>
> Ok, so this isn't actually about backing up RAM contents; it's about
> completing pending I/O.
>
> I'm still confused as to how that works. How do you avoid leaving the
> disk in some corrupt state if data runs out partway through?
>
> > This data must be saved to disk and the high power CPUs consume too much
> > power to continue performing this operation.
> >
> > > CPUs might be running with IRQs disabled for an arbitrarily long time,
> >
> > In an embedded linux system we control everything running.
>
> Sure, and that complete control allows you to do something better than
> this RFC, AFAICT.
>
> Thanks,
> Mark.
