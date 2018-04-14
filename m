Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeDNLZc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 07:25:32 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:51283 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeDNLZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 07:25:31 -0400
Date: Sat, 14 Apr 2018 13:25:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, mario.limonciello@dell.com,
        pali.rohar@gmail.com, andy@infradead.org, dvhart@infradead.org,
        mjg59@srcf.ucam.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180414112529.GB4245@wunner.de>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <018FF40E-B380-4E22-9599-2F4A2A8B51B7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018FF40E-B380-4E22-9599-2F4A2A8B51B7@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:12:49PM +0800, Kai-Heng Feng wrote:
> at 6:50 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > On Thu, 12 Apr 2018 12:42:39 +0200, Kai-Heng Feng wrote:
> > > When SG is enabled, the unused AMD audio controller still exposes its
> > > sysfs, so userspace still opens the control file and stream. If
> > > userspace tries to output sound through the stream, it hangs when
> > > runtime suspend kicks in:
> > > [ 12.796265] snd_hda_intel 0000:01:00.1: Disabling via vga_switcheroo
> > > [ 12.796367] snd_hda_intel 0000:01:00.1: Cannot lock devices!
> > > 
> > > Since the discrete audio controller isn't useful when SG enabled, we
> > > should just disable the device.
> > > 
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > I thought we manage this better now with runtime PM by Lukas's recent
> > patchset?
> 
> Yes, that's true. I'll update commit log for next iteration.
> 
> Nevertheless, the unusable control file and stream still get exposed via
> sysfs.
> We should disable them when SG is enabled.

Right, the hang on runtime suspend as mentioned in the commit message
should be gone in 4.17.

The purpose of this patch is thus to prevent the user from seeing or
opening the HDA controller on the discrete GPU.  If SG is enabled,
external DP/HDMI displays are muxed to the Intel GPU, hence the HDA
controller on the discrete GPU cannot communicate with the attached
displays.

Thanks,

Lukas
