Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936898AbeBUNef (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:34:35 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42123 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933203AbeBUNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:34:29 -0500
X-Google-Smtp-Source: AH8x22490o/xZHGEvLmPheGAbK2K6D9Ik4FfdUpetHwW8hn3SkD0H1QMNHNMlyf94X9vM+hBdIuvNg==
Date: Wed, 21 Feb 2018 14:34:26 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Thinkpad X1 Carbon 3rd - Reducing the compressed framebuffer size
Message-ID: <20180221133426.fcad5xieuvukdluv@pali>
References: <20180213085030.kiksdi2a7ksae5wz@pali>
 <20180213132726.GD5453@intel.com>
 <20180213133842.i5z5jj3sllorsy2w@pali>
 <20180213153654.GG5453@intel.com>
 <20180213160437.gy5luyygjvuktuqx@pali>
 <20180213161221.GK5453@intel.com>
 <20180213174341.abcjlfjymxbcz25t@pali>
 <20180213174556.GM5453@intel.com>
 <20180219093650.avb4xipvflfd2kel@pali>
 <20180221132853.GM5453@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180221132853.GM5453@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LDYdM5012785

On Wednesday 21 February 2018 15:28:53 Ville Syrjälä wrote:
> On Mon, Feb 19, 2018 at 10:36:50AM +0100, Pali Rohár wrote:
> > On Tuesday 13 February 2018 19:45:56 Ville Syrjälä wrote:
> > > On Tue, Feb 13, 2018 at 06:43:41PM +0100, Pali Rohár wrote:
> > > > On Tuesday 13 February 2018 18:12:21 Ville Syrjälä wrote:
> > > > > On Tue, Feb 13, 2018 at 05:04:37PM +0100, Pali Rohár wrote:
> > > > > > So it can be done only once after reboot? Or only prior to booting kernel?
> > > > > 
> > > > > Never.
> > > > 
> > > > Never? Now I'm lost. Why then dmesg message instruct user to try set up
> > > > it in BIOS if you say it is never possible?
> > > 
> > > You can change it in the BIOS. No way to change it from the operating system.
> > 
> > Hi! Can you explain it a bit more?
> > 
> > What does it mean "in BIOS"? Prior switching from 16bit real mode to
> > protected or long? Or before exiting EFI boot services? Or before
> > booting kernel (when initialize memory mapping)?
> 
> The BIOS is a black box, no one really knows what it's doing. The stolen
> memory is carved out pretty early I think (alongside other carved out
> chunks for SMM and whatnot). And once that's done the BIOS usually locks
> down stuff like this (the hw has magic write once lock bits for various
> registers) so there's just no way to change things afterwards.

Thank you for explanation. So real problem with changing size of stolen
memory is that BIOS "may" lock future changes.

Is there any documentation for this Intel GPU stolen memory? I hope that
I should be able at least to read status of that lock registers -- to
prove that size of stolen memory is locked and cannot be changed.

> > 
> > I still do not see reason nor understand why this cannot be possible
> > either in bootloader (e.g. grub2) or prior to loading bootloader which
> > runs in protected or long mode.
> > 
> > It is because BIOS uses some undocumented call/procedure which sets that
> > amount of memory and it is unknown how to do it?
> > 
> > -- 
> > Pali Rohár
> > pali.rohar@gmail.com
> 

-- 
Pali Rohár
pali.rohar@gmail.com
