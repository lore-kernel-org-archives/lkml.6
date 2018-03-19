Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933189AbeCSK5R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:57:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59975 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbeCSK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:57:16 -0400
Date: Mon, 19 Mar 2018 11:57:04 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anshuman Gupta <anshuman.gupta@intel.com>
cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org,
        mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2] x86: i8237: Register based on FADT legacy boot flag
In-Reply-To: <20180319104627.GA2959@anshuman.gupta@intel.com>
Message-ID: <alpine.DEB.2.21.1803191152450.2010@nanos.tec.linutronix.de>
References: <1521004627-30329-1-git-send-email-rajneesh.bhardwaj@intel.com> <alpine.DEB.2.21.1803141603190.2481@nanos.tec.linutronix.de> <20180319104627.GA2959@anshuman.gupta@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, Anshuman Gupta wrote:
> On Wed, Mar 14, 2018 at 04:07:43PM +0100, Thomas Gleixner wrote:
> > On Wed, 14 Mar 2018, Rajneesh Bhardwaj wrote:
> > > +	 * support 8237 DMA or bus mastering from LPC. Platform firmware
> > > +	 * must announce the support for such legacy devices via
> > > +	 * ACPI_FADT_LEGACY_DEVICES field in FADT table.
> > > +	 */
> > > +	if (!x86_platform.legacy.devices.pnpbios && dmi_get_bios_year() >= 2017)
> > 
> > Please use arch_pnpbios_disabled() and explain why you need that year
>   arch_pnpbios_disabled is defined only when CONFIG_PNPBIOS is set, which may 
>   not be true for all configurations.

The please create a helper function x86_pnpbios_disabled() and use that one
in arch_pnp_bios_disabled() and in your new code.

> > check. If there is no pnpbios then why is the year interesting and why
> > would anyone trust something which comes from BIOS?
>
>   Modern bios fsp have started using to use ACPI_FADT_LEGACY_DEVICES field in
>   FADT table, that is the reason we require a year check for BIOS.
>   https://review.coreboot.org/#/c/coreboot/+/23833/
>   https://review.coreboot.org/#/c/coreboot/+/23835/ 

Sorry, this gerrit stuff is unreadable. Please explain it in your own
words. You have to do that anyway as that information wants to be in a
comment or at least in the change log.

Thanks,

	tglx
