Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935291AbeBMN1l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:27:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:36196 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935174AbeBMN1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:27:40 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="18074511"
Date: Tue, 13 Feb 2018 15:27:26 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Thinkpad X1 Carbon 3rd - Reducing the compressed framebuffer size
Message-ID: <20180213132726.GD5453@intel.com>
References: <20180206152143.vea6si7ncjj7sxyq@pali>
 <20180213085030.kiksdi2a7ksae5wz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180213085030.kiksdi2a7ksae5wz@pali>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 09:50:30AM +0100, Pali Rohár wrote:
> On Tuesday 06 February 2018 16:21:43 Pali Rohár wrote:
> > Hi! I'm periodically getting following message in dmesg on Lenovo
> > Thinkpad X1 Carbon 3rd generation:
> > 
> > [drm] Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.
> > 
> > In BIOS I already set GPU size to 512M, but this did not help. Also
> > update to last BIOS version did not help.
> > 
> > So why this message is periodically print in dmesg? And what can I do
> > with this problem?
> > 
> > And why cannot Linux kernel allocate itself more memory for GPU (if BIOS
> > can/could do that)? Is not 512MB for GPU enough?
> 
> And here is output from lspci, which clearly says that 512MB is already
> set for GPU:

The PCI BAR size has nothing to do with the size of the stolen memory.
The BAR just provides a window into the global GTT address space of the
GPU. Stolen memory is a contiguous chunk of physical memory carved out
by the BIOS. The BIOS may or may not provide a knob to change the size
of the stolen memory.

> 
> $ lspci -v -s 00:02.0
> 00:02.0 VGA compatible controller: Intel Corporation HD Graphics 5500 (rev 09) (prog-if 00 [VGA controller])
>         Subsystem: Lenovo HD Graphics 5500
>         Flags: bus master, fast devsel, latency 0, IRQ 46
>         Memory at e0000000 (64-bit, non-prefetchable) [size=16M]
>         Memory at c0000000 (64-bit, prefetchable) [size=512M]
>         I/O ports at 3000 [size=64]
>         [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
>         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [d0] Power Management version 2
>         Capabilities: [a4] PCI Advanced Features
>         Kernel driver in use: i915
>         Kernel modules: i915
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel OTC
