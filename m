Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965403AbeBMSAz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:00:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:51148 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965158AbeBMSAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:00:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="30466453"
Message-ID: <1518544852.2708.1.camel@linux.intel.com>
Subject: Re: intel_pmc_core does not initialize intel 8th gen PMC
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        kitestramuort <kitestramuort@autistici.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Date: Tue, 13 Feb 2018 10:00:52 -0800
In-Reply-To: <CAHp75VdquuTLRgSbzKTBvyLmeFkGyDmP+U=GdOxLhBsU=w6Log@mail.gmail.com>
References: <1518426556.26505.2.camel@autistici.org>
         <CAHp75VdquuTLRgSbzKTBvyLmeFkGyDmP+U=GdOxLhBsU=w6Log@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-13 at 18:21 +0200, Andy Shevchenko wrote:
> +Cc: Authors and correct ML
> 
> On Mon, Feb 12, 2018 at 11:09 AM, kitestramuort
> <kitestramuort@autistici.org> wrote:
> > don't know if this is intended. In 4.15.2 i have:
> 
> AFAIU the driver now binds to the hardcoded value of a PA of the
> device. So, you still have driver enabled.
> 
> Srinivas, is my understanding correct?
Yes. This doesn't bind to PCI device. But the driver is still doing
what it is supposed to do.
You should still see
/sys/kernel/debug/pmc_core/* as before.

Thanks,
Srinivas

> 
> > dmesg:
> > intel_pmc_core 0000:00:1f.2: enabling device (0000 -> 0002)
> > 
> > lspci:
> > 00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC
> > (rev
> > 21)
> >         Subsystem: Intel Corporation Sunrise Point-LP PMC
> >         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx-
> >         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> > >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Region 0: Memory at dff00000 (32-bit, non-prefetchable)
> > [size=16K]
> >         Kernel driver in use: intel_pmc_core
> > in 4.16.0-rc1 this becomes
> > dmesg:
> > intel_pmc_core:  initialized
> > 
> > lspci:
> > 00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC
> > (rev
> > 21)
> >         Subsystem: Intel Corporation Sunrise Point-LP PMC
> >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx-
> >         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> > >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Region 0: Memory at dff00000 (32-bit, non-prefetchable)
> > [disabled] [size=16K]
> 
> 
> 
