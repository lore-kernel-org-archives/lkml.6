Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1681AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FD22098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FD22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeIXUCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:02:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:40841 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbeIXUCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:02:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 06:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="75488324"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2018 06:59:36 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1g4ROh-0003Aj-7m; Mon, 24 Sep 2018 16:59:35 +0300
Date:   Mon, 24 Sep 2018 16:59:35 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Banik, Subrata" <subrata.banik@intel.com>,
        "Bohra, Aamir" <aamir.bohra@intel.com>
Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for
 community-4/5
Message-ID: <20180924135935.GP15943@smile.fi.intel.com>
References: <20180913223143.12664-1-rajatja@google.com>
 <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
 <CACK8Z6FhJhhfgk1zPMv5M0oRwz=o75YOKFmU+4Wx-X9-prPnKA@mail.gmail.com>
 <CACK8Z6GeZ+2uRsRDPfdd=i+WrdQwQgEBvEyDxQuKLygXqPp4dw@mail.gmail.com>
 <CACK8Z6FLPVSJpPuAXZsqHV2rY2zy3L-Fvd=QPn=+Ynp3aHyhaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6FLPVSJpPuAXZsqHV2rY2zy3L-Fvd=QPn=+Ynp3aHyhaQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:19:34AM -0700, Rajat Jain wrote:
> On Fri, Sep 14, 2018 at 2:38 PM Rajat Jain <rajatja@google.com> wrote:
> > On Fri, Sep 14, 2018 at 2:06 PM Rajat Jain <rajatja@google.com> wrote:
> > > On Fri, Sep 14, 2018 at 12:41 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Sep 14, 2018 at 1:54 AM Rajat Jain <rajatja@google.com> wrote:
> > > > >
> > > > > The Icelake does not have a community-3, and the memory resources are
> > > > > laid out in the following order in the ACPI:
> > > > >
> > > > > resource-0: community-0 registers
> > > > > resource-1: community-1 registers
> > > > > resource-2: community-2 registers
> > > > > resource-3: community-4 registers
> > > > > resource-4: community-5 registers
> > > > >
> > > > > (EDS also describes the communities in the above order).
> > > > >
> > > > > Since the pinctrl driver exposes communities 0, 1, 4, 5, it needs to get
> > > > > the corresponding community registers by getting the resourse number right.
> > > > > Currently the resourse number is not correct for community 4 and 5, thus
> > > > > fix that.
> > > > >
> > > >
> > > > Can you share link to the ACPI dump of the tables? (you may get one by
> > > > running `acpidump -o tables.dat`)
> 
> Hello Andy,
> 
> Any feedback on this patch? I provided a dump of the ACPI below,
> please let me know if you need more info.

Sorry it took a while (I had to get tested on our reference BIOS(es) on Ice Lake platforms we have).
See my reply below.

> > > I don't have that command on my system, but I took
> > > /sys/firmware/acpi/tables/DSDT from the system and disassembled it
> > > using Intel disassembler (iasl -d) and here is the relevant portion
> > > that describes the GPIO controller. The port IDs for communities can
> > > be seen in the below output (i.e. the PCRB()):
> >
> > I realized PCRB() is an ACPI method defined in the same disasembly:
> >
> >             Method (PCRB, 1, NotSerialized)
> >             {
> >                 Return ((0xFD000000 + (Arg0 << 0x10)))
> >             }
> >
> > >
> > >             Device (GPIO)
> > >             {
> > >                 Name (_HID, "INT3455")  // _HID: Hardware ID
> > >                 Name (_UID, Zero)  // _UID: Unique ID
> > >                 Name (_DDN, "GPIO Controller")  // _DDN: DOS Device Name
> > >                 Name (RBUF, ResourceTemplate ()
> > >                 {
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y06)
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y07)
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y08)
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y09)
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y0A)
> > >                     Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
> > >                     {
> > >                         0x0000000E,
> > >                     }
> > >                 })
> > >                 Method (_CRS, 0, NotSerialized)  // _CRS: Current
> > > Resource Settings
> > >                 {
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y06._BAS,
> > > BAS0)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y06._LEN,
> > > LEN0)  // _LEN: Length
> > >                     BAS0 = PCRB (0x6E)
> > >                     LEN0 = 0x00010000
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y07._BAS,
> > > BAS1)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y07._LEN,
> > > LEN1)  // _LEN: Length
> > >                     BAS1 = PCRB (0x6D)
> > >                     LEN1 = 0x00010000
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y08._BAS,
> > > BAS2)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y08._LEN,
> > > LEN2)  // _LEN: Length
> > >                     BAS2 = PCRB (0x6C)
> > >                     LEN2 = 0x00010000
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y09._BAS,
> > > BAS4)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y09._LEN,
> > > LEN4)  // _LEN: Length
> > >                     BAS4 = PCRB (0x6A)
> > >                     LEN4 = 0x00010000
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y0A._BAS,
> > > BAS5)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y0A._LEN,
> > > LEN5)  // _LEN: Length
> > >                     BAS5 = PCRB (0x69)
> > >                     LEN5 = 0x00010000
> > >                     Return (RBUF) /* \_SB_.PCI0.GPIO.RBUF */
> > >                 }
> > >
> > >                 Method (_STA, 0, NotSerialized)  // _STA: Status
> > >                 {
> > >                     Return (0x0F)
> > >                 }
> > >             }
> > >
> > > Please let me know if this helps, or if you need more info.

First of all, this is pre-production chip, so, I don't think there is a bug in the driver (yet) discovered.

Looking to the above ASL code I may conclude that is definitely is *not* from our reference BIOS.
I have checked two versions of it and found that in both we have the following mapping:
for LP variant: there are only 4 communities are exported
for H variant: there are only 5 communities are exported

So, I guess the problem is in ASL code you provided. It simple should not
export that community at all.

In case you need to do so, there are ways:
 - contact Intel and ask for a change in reference BIOS
 - acquire another ACPI ID for the case, or, perhaps use special constants like
   _HRV for that purpose (also need to contact Intel while doing that)

P.S. I think EDS covers it as it present in HW, though not exported by FW.

-- 
With Best Regards,
Andy Shevchenko


