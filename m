Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965412AbeBMRqE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:46:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:62348 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965057AbeBMRqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:46:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="19702182"
Date: Tue, 13 Feb 2018 19:45:56 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Thinkpad X1 Carbon 3rd - Reducing the compressed framebuffer size
Message-ID: <20180213174556.GM5453@intel.com>
References: <20180206152143.vea6si7ncjj7sxyq@pali>
 <20180213085030.kiksdi2a7ksae5wz@pali>
 <20180213132726.GD5453@intel.com>
 <20180213133842.i5z5jj3sllorsy2w@pali>
 <20180213153654.GG5453@intel.com>
 <20180213160437.gy5luyygjvuktuqx@pali>
 <20180213161221.GK5453@intel.com>
 <20180213174341.abcjlfjymxbcz25t@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180213174341.abcjlfjymxbcz25t@pali>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 06:43:41PM +0100, Pali Rohár wrote:
> On Tuesday 13 February 2018 18:12:21 Ville Syrjälä wrote:
> > On Tue, Feb 13, 2018 at 05:04:37PM +0100, Pali Rohár wrote:
> > > $ cat /sys/kernel/debug/dri/0/i915_gem_stolen
> > > Stolen:
> > >    ffff8b55bf17e080:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 00083000, size: 00004000, type: 0) (stolen: 00001000)
> > >    ffff8b55c2693040:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 02b9f000, size: 00004000, type: 0) (stolen: 00005000)
> > >    ffff8b55bf9a7300:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 0) (ggtt offset: 0f6b4000, size: 00004000, type: 0) (stolen: 00009000)
> > >    ffff8b55a6161040:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 0) (ggtt offset: 0937f000, size: 00004000, type: 0) (stolen: 0000d000)
> > >    ffff8b5563e0dac0:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 0) (ggtt offset: 0f714000, size: 00004000, type: 0) (stolen: 00019000)
> > >    ffff8b55bf17e800:    g         4KiB 41 00 [ 0 0 0 0 ] 0  LLC (pinned x 1) (ggtt offset: ffffe000, size: 00001000, type: 0) (stolen: 0012c000)
> > >    ffff8b55bf02d540:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 00141000, size: 00004000, type: 0) (stolen: 0012d000)
> > >    ffff8b55c2989340:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 00148000, size: 00004000, type: 0) (stolen: 00131000)
> > >    ffff8b55c29890c0:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 0014f000, size: 00004000, type: 0) (stolen: 00135000)
> > >    ffff8b55c2989840:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 00156000, size: 00004000, type: 0) (stolen: 00139000)
> > >    ffff8b55bf02da40:  p g     14400KiB 77 00 [ 0 0 0 0 ] 0  uncached dirty (name: 1) (pinned x 1) (display) (ggtt offset: 0015a000, size: 00e10000, type: 0) (stolen: 0013d000) (p mappable)
> > >    ffff8b556dfba780:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 0) (ggtt offset: 0ad2a000, size: 00004000, type: 0) (stolen: 01655000)
> > > 
> > > > likely you'll have the fbdev framebuffer taking up a sizeable chunk.
> > > 
> > > Seems 14MB.
> > > 
> > > > You could get some back by reducing fbdev depth to 16bpp, or even 8bpp,
> > > > but I'm not convinced the fbdev gamma LUT stuff really works currently
> > > > so you might end up with bogus colors in your vts with that.
> > > 
> > > Ok, I could try it. Via fbset tool?
> > 
> > Kernel command line. We don't allow resizing the fbdev fb once it's
> > created.
> 
> Ok, will try.
> 
> > > 
> > > > > 
> > > > > [    0.000000] Memory: 7972840K/8282704K available (6196K kernel code, 1159K rwdata, 2848K rodata, 1408K init, 688K bss, 309864K reserved, 0K cma-reserved)
> > > > > 
> > > > > > The BIOS may or may not provide a knob to change the size
> > > > > > of the stolen memory.
> > > > > 
> > > > > In BIOS Setup screen I have option to choose GPU memory and I set it to
> > > > > max 512MB. So this is not the right option...
> > > > > 
> > > > > And why cannot kernel use some continuous check of RAM itself?
> > > > 
> > > > Because the hardware won't allow it.
> > > 
> > > So it can be done only once after reboot? Or only prior to booting kernel?
> > 
> > Never.
> 
> Never? Now I'm lost. Why then dmesg message instruct user to try set up
> it in BIOS if you say it is never possible?

You can change it in the BIOS. No way to change it from the operating system.

-- 
Ville Syrjälä
Intel OTC
