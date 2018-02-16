Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeBPTM0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:12:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeBPTMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:12:21 -0500
Date: Fri, 16 Feb 2018 11:12:16 -0800
From: Darren Hart <dvhart@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Paul Menzel <pmenzel+linux-platform-driver-x86@molgen.mpg.de>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: eeepc-wmi loaded on Asus desktop board
Message-ID: <20180216191216.GD5786@fury>
References: <63d05833-a0ba-7fff-4514-5234d43a82fe@molgen.mpg.de>
 <CAHp75VfOi=UHc_F-SMeMcqqYY7qF1Cc14Qb7EVvBrBF2wz2+VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfOi=UHc_F-SMeMcqqYY7qF1Cc14Qb7EVvBrBF2wz2+VA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 06:45:20PM +0200, Andy Shevchenko wrote:
> +Cc: Darren (for sure)
> 
> On Fri, Feb 16, 2018 at 12:42 AM, Paul Menzel
> <pmenzel+linux-platform-driver-x86@molgen.mpg.de> wrote:
> > Dear Linux folks,
> >
> >
> > Debugging an ACPI suspend problem on the desktop board Asus F285-M PRO with
> > Linux 4.14, I noticed, the module *eeepc_wmi* is loaded, and an input device
> > is created.
> >

Does this driver impact your suspend problem?

> > ```
> > Feb 15 18:49:01 asusf2a85mpro kernel: calling  eeepc_wmi_init+0x0/0x1000
> > [eeepc_wmi] @ 285
> > Feb 15 18:49:01 asusf2a85mpro kernel: asus_wmi: Initialization: 0x0
> > Feb 15 18:49:01 asusf2a85mpro kernel: asus_wmi: BIOS WMI version: 0.9
> > Feb 15 18:49:01 asusf2a85mpro kernel: asus_wmi: SFUN value: 0x0
> > Feb 15 18:49:01 asusf2a85mpro kernel: input: Eee PC WMI hotkeys as
> > /devices/platform/eeepc-wmi/input/input7
> > Feb 15 18:49:01 asusf2a85mpro kernel: asus_wmi: Number of fans: 1
> > Feb 15 18:49:01 asusf2a85mpro kernel: initcall eeepc_wmi_init+0x0/0x1000
> > [eeepc_wmi] returned 0 after 12130 usecs
> > ```
> >
> > Please find the full log attached.
> >
> > Is that expected, or should the module not load at all on desktop boards?

The eeepc_wmi driver loads when the EEEPC_ACPI_HID or WMI_EVENT_GUID is
presented by the platform firmware. It is tightly coupled with the Asus wmi
driver, so this isn't surprising that it loads on an Asus board as it isn't
uncommon to use the same GUIDs across platforms. This may suggest a need to
rename this driver to something less specific - assuming of course that it is
performing a necessary function.

-- 
Darren Hart
VMware Open Source Technology Center
