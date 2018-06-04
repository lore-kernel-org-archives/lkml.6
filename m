Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeFDVZR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:25:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42484 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeFDVZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:25:16 -0400
Date: Mon, 4 Jun 2018 23:25:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andreas Hartmann <andihartmann@01019freenet.de>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spectre mitigation doesn't seem to work at all?!
In-Reply-To: <e6c80163-0d73-1bf8-9c3f-1184a73040f6@01019freenet.de>
Message-ID: <alpine.DEB.2.21.1806042318570.1583@nanos.tec.linutronix.de>
References: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de> <e6c80163-0d73-1bf8-9c3f-1184a73040f6@01019freenet.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1179886342-1528147514=:1583"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1179886342-1528147514=:1583
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 4 Jun 2018, Andreas Hartmann wrote:
> Sorry for a ping - but I think the behavior shown below should really be
> investigated!

There is not much to investigate ...

> > I tested the spectre mitigation of different machines and kernels with
> > https://github.com/crozone/SpectrePoC
> > 
> > You can see the results below.
> > My question: Did I miss something?

Yes.

> > My expectation was, that on base of the output of
> > /sys/devices/system/cpu/vulnerabilities/spectre_v* as shown below the
> > problem should be gone away.
> > But the results seem to tell me something other ... .

> > CPU:    AMD Ryzen 7 1700X Eight-Core Processor
> > Bios:   BIOS 4011 04/19/2018 - ibpb is listed in /proc/cpuinfo
> > Kernel: 4.14.44-1.1-default
> > cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
> > Mitigation: Full AMD retpoline, IBPB
> > cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
> > Mitigation: __user pointer sanitization

Looks correct, but irrelevant.

> > 
> >  ./spectre.out
> > Using a cache hit threshold of 80.
> > Build: RDTSCP_SUPPORTED MFENCE_SUPPORTED CLFLUSH_SUPPORTED

This is the info you missed:

> > INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED

The whole POC is sniffing on itself and it allows you to compile with
different mitigation enabled or disabled. You disabled both. So it's
expected to succeed.

It does not matter at all which mitigations the kernel has enabled because
they do not affect the user space programm attacking itself. It's just a
demonstrator of the attack technology along with options to demonstrate the
effectiveness of mitigation strategies.

Thanks,

	tglx




--8323329-1179886342-1528147514=:1583--
