Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935893AbeBLOcc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:32:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48345 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935375AbeBLOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:32:31 -0500
Date: Mon, 12 Feb 2018 15:32:32 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: karahmed@amazon.de, sironi@amazon.de, x86@kernel.org,
        kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH v2 1/6] x86/speculation: Update Speculation Control
 microcode blacklist
In-Reply-To: <1518444989.6606.83.camel@infradead.org>
Message-ID: <alpine.DEB.2.21.1802121532200.1158@nanos.tec.linutronix.de>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>  <1518305967-31356-2-git-send-email-dwmw@amazon.co.uk> <1518444989.6606.83.camel@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1368810593-1518445952=:1158"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1368810593-1518445952=:1158
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 12 Feb 2018, David Woodhouse wrote:

> On Sat, 2018-02-10 at 23:39 +0000, David Woodhouse wrote:
> > 
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -123,8 +123,6 @@ static const struct sku_microcode
> > spectre_bad_microcodes[] = {
> >         { INTEL_FAM6_KABYLAKE_MOBILE,   0x09,   0x84 },
> >         { INTEL_FAM6_SKYLAKE_X,         0x03,   0x0100013e },
> >         { INTEL_FAM6_SKYLAKE_X,         0x04,   0x0200003c },
> > -       { INTEL_FAM6_SKYLAKE_MOBILE,    0x03,   0xc2 },
> > -       { INTEL_FAM6_SKYLAKE_DESKTOP,   0x03,   0xc2 },
> >         { INTEL_FAM6_BROADWELL_CORE,    0x04,   0x28 },
> >         { INTEL_FAM6_BROADWELL_GT3E,    0x01,   0x1b },
> >         { INTEL_FAM6_BROADWELL_XEON_D,  0x02,   0x14 },
> 
> Arjan points out that the SKYLAKE_DESKTOP one there is premature. There
> are *two* rows in Intel's table which match that CPUID (506E3).
> 
> Only *one* of them ("Skylake H/S") has cleared the 0xC2 microcode for
> use, while the "Skylake E3" line still doesn't approve it. (But doesn't
> explicitly list it in the "STOP deploying" column any more either,
> which it probably should, and might have helped me notice.)
> 
> Ingo, Thomas: do you want to drop this patch which is already in
> tip/x86/pti and have a new version with the SKYLAKE_DESKTOP no longer
> removed? Or shall I send an incremental patch to add it back?

Delta patch please.
--8323329-1368810593-1518445952=:1158--
