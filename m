Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933354AbeBVQdm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:33:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933213AbeBVQdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:33:39 -0500
Date: Thu, 22 Feb 2018 08:33:35 -0800
From: Darren Hart <dvhart@infradead.org>
To: Mario.Limonciello@dell.com
Cc: notmart@gmail.com, jeremy@jcline.org, pali.rohar@gmail.com,
        andriy.shevchenko@linux.intel.com, mjg59@srcf.ucam.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
Message-ID: <20180222163335.GD19843@fury>
References: <01000161bbeed4e3-8160ffbc-0998-453d-9afd-14b7dd80dd53-000000@email.amazonses.com>
 <1628582.nV6hDClBbL@phobos>
 <01000161bdd7f206-c8d87cce-1b8c-4888-8d6a-5247198b3ead-000000@email.amazonses.com>
 <CAD6_Bos5Qrvz=Mr_rYCZXZ1s=5+8rawfZXxzXSvyc-tLBO07fg@mail.gmail.com>
 <b9b9ad823d9e49df82fc4626124c2a14@ausx13mpc120.AMER.DELL.COM>
 <20180222161859.GA19843@fury>
 <d3789bab5f2c49c7966deabdacab38a8@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3789bab5f2c49c7966deabdacab38a8@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 04:28:57PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
> > owner@vger.kernel.org] On Behalf Of Darren Hart
> > Sent: Thursday, February 22, 2018 10:19 AM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: notmart@gmail.com; jeremy@jcline.org; pali.rohar@gmail.com;
> > andriy.shevchenko@linux.intel.com; mjg59@srcf.ucam.org; platform-driver-
> > x86@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
> > 
> > On Thu, Feb 22, 2018 at 03:21:45PM +0000, Mario.Limonciello@dell.com wrote:
> > > > -----Original Message-----
> > > > From: Marco Martin [mailto:notmart@gmail.com]
> > > > Sent: Thursday, February 22, 2018 9:16 AM
> > > > To: Jeremy Cline <jeremy@jcline.org>
> > > > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Pali Rohár
> > > > <pali.rohar@gmail.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>;
> > > > Matthew Garrett <mjg59@srcf.ucam.org>; Darren Hart
> > <dvhart@infradead.org>;
> > > > Platform Driver <platform-driver-x86@vger.kernel.org>; Linux Kernel Mailing
> > List
> > > > <linux-kernel@vger.kernel.org>
> > > > Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
> > > >
> > > > On Thu, Feb 22, 2018 at 3:08 PM, Jeremy Cline <jeremy@jcline.org> wrote:
> > > > > Input driver version is 1.0.1
> > > > > Input device ID: bus 0x19 vendor 0x0 product 0x0 version 0x0
> > > > > Input device name: "Intel Virtual Button driver"
> > > > > Supported events:
> > > > >   Event type 0 (EV_SYN)
> > > > >   Event type 1 (EV_KEY)
> > > > >     Event code 114 (KEY_VOLUMEDOWN)
> > > > >     Event code 115 (KEY_VOLUMEUP)
> > > > >     Event code 116 (KEY_POWER)
> > > > >     Event code 125 (KEY_LEFTMETA)
> > > > >     Event code 240 (KEY_UNKNOWN)
> > > > >     Event code 561 (?)
> > > > >   Event type 4 (EV_MSC)
> > > > >     Event code 4 (MSC_SCAN)
> > > > >   Event type 5 (EV_SW)
> > > > >     Event code 1 (SW_TABLET_MODE) state 1
> > > > > Properties:
> > > > > Testing ... (interrupt to exit)
> > > >
> > > > Indeed, it's thinking a switch exists and that is on, which is wrong,
> > > > then i guess VGBS() reports a wrong status..
> > > > Mario, do you have any ideas about that?
> > > >
> > > > --
> > > > Marco Martin
> > >
> > > I guess that means we got this wrong and the patch should be reverted
> > > until we figure this out.
> > >
> > > Jeremy,
> > >
> > > Can you please confirm what BIOS version you are on?
> > > Also Is this a 9360 with 7th or 8th gen Intel CPU?
> > >
> > > I'll see if I can find out anything more relative to this.
> > 
> > Watching closely.
> > 
> > Mario, do you want me to revert immediately, or wait until you've had a couple
> > rounds of Q&A here?
> > 
> > --
> 
> Darren,
> 
> Let's hold off until we've discussed a little more.  Jeremy is responsive and we might
> get to the bottom quickly.
> 
> Btw you have a 9360 on hand still right?  Can you see if you can reproduce this problem too?
> 

I'm planning on it, yup.

-- 
Darren Hart
VMware Open Source Technology Center
