Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936753AbeBUN3D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:29:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:56866 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933705AbeBUN27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:28:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="19990838"
Date: Wed, 21 Feb 2018 15:28:53 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Thinkpad X1 Carbon 3rd - Reducing the compressed framebuffer size
Message-ID: <20180221132853.GM5453@intel.com>
References: <20180206152143.vea6si7ncjj7sxyq@pali>
 <20180213085030.kiksdi2a7ksae5wz@pali>
 <20180213132726.GD5453@intel.com>
 <20180213133842.i5z5jj3sllorsy2w@pali>
 <20180213153654.GG5453@intel.com>
 <20180213160437.gy5luyygjvuktuqx@pali>
 <20180213161221.GK5453@intel.com>
 <20180213174341.abcjlfjymxbcz25t@pali>
 <20180213174556.GM5453@intel.com>
 <20180219093650.avb4xipvflfd2kel@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180219093650.avb4xipvflfd2kel@pali>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 10:36:50AM +0100, Pali Rohár wrote:
> On Tuesday 13 February 2018 19:45:56 Ville Syrjälä wrote:
> > On Tue, Feb 13, 2018 at 06:43:41PM +0100, Pali Rohár wrote:
> > > On Tuesday 13 February 2018 18:12:21 Ville Syrjälä wrote:
> > > > On Tue, Feb 13, 2018 at 05:04:37PM +0100, Pali Rohár wrote:
> > > > > So it can be done only once after reboot? Or only prior to booting kernel?
> > > > 
> > > > Never.
> > > 
> > > Never? Now I'm lost. Why then dmesg message instruct user to try set up
> > > it in BIOS if you say it is never possible?
> > 
> > You can change it in the BIOS. No way to change it from the operating system.
> 
> Hi! Can you explain it a bit more?
> 
> What does it mean "in BIOS"? Prior switching from 16bit real mode to
> protected or long? Or before exiting EFI boot services? Or before
> booting kernel (when initialize memory mapping)?

The BIOS is a black box, no one really knows what it's doing. The stolen
memory is carved out pretty early I think (alongside other carved out
chunks for SMM and whatnot). And once that's done the BIOS usually locks
down stuff like this (the hw has magic write once lock bits for various
registers) so there's just no way to change things afterwards.

> 
> I still do not see reason nor understand why this cannot be possible
> either in bootloader (e.g. grub2) or prior to loading bootloader which
> runs in protected or long mode.
> 
> It is because BIOS uses some undocumented call/procedure which sets that
> amount of memory and it is unknown how to do it?
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com

-- 
Ville Syrjälä
Intel OTC
