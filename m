Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbeDWIIu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:08:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36980 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeDWIIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:08:47 -0400
X-Google-Smtp-Source: AIpwx4/ZELHJFEffgwChSLpqItb+nYZ2zM4bneIS2GTx0eAfBCIuIoibSQ0kbhHJuAQsNtZaS0ijvQ==
Date: Mon, 23 Apr 2018 10:08:44 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, mjg59@srcf.ucam.org,
        dvhart@infradead.org, andy@infradead.org,
        Mario Limonciello <mario.limonciello@dell.com>, tiwai@suse.com,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v4 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Message-ID: <20180423080844.yh6ndicpu6mwy336@pali>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
 <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 April 2018 16:04:55 Kai Heng Feng wrote:
> 
> 
> > On Apr 20, 2018, at 8:10 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > On Fri, 20 Apr 2018 11:44:32 +0200,
> > Kai-Heng Feng wrote:
> > > Now it's a typical discrete-only system. HDMI audio comes from AMD audio
> > > controller, others from Intel audio controller.
> > > 
> > > When SG is enabled, the unused AMD audio contoller still exposes its
> > > sysfs, so userspace still opens the control file and stream. If
> > > userspace tries to output sound through the stream, it hangs the system.
> > 
> > Hm, could you give more information about how it hangs?
> 
> Well, I should say "it hangs the userspace process" instead.
> 
> $ speaker-test -t wav -c 2 -D hw:CARD=HDMI,DEV=3
> ...and it just stopped. Can't Ctrl+C to break it.

So userspace process cannot be killed at all? Then it is different bug
in kernel and disabling pci device is just a workaround. Not a real fix.

I would propose to find out what happen and why it cannot be killed
(probably it stuck somewhere in kernel) and fix it properly.

> > 
> > 
> > > @@ -1627,6 +1629,42 @@ static void check_msi(struct azx *chip)
> > >  	}
> > >  }
> > > 
> > > +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
> > 
> > This should be IS_REACHABLE(), as both dell-laptop and HD-audio are
> > tristate.
> 
> Thanks, will update in next version.
> 
> > 
> > > +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
> > 
> > I'd remove "_dell" word here.  Such a check would be likely needed for
> > other vendors, and it's quite possible that the function will be
> > extended to cover a wider DMI table.
> 
> Makes sense. Will also update this one.
> 
> Kai-Heng
> 
> > 
> > 
> > thanks,
> > 
> > Takashi

-- 
Pali Rohár
pali.rohar@gmail.com
