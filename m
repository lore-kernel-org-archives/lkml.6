Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AG47ELuDeuB2AzY7mS8xUHXLlz1gOyQ9pJ5jqNZoIdyG2mrtbvKz6rJV7bdKCKnDW4rtoLsUPSV6
ARC-Seal: i=1; a=rsa-sha256; t=1521015601; cv=none;
        d=google.com; s=arc-20160816;
        b=F0NK9PLEBMCs3KANDeI4Sg34eov3sIITZDbb2svRYMAuuthxW7t+3S0FtIh/KQS7Cs
         ZFyFzFeEkdWcMkLnzkdLotb/kwgvhe+OAxbePC6Me9WhZrSKNI7LUtXYlQ+o9a3MO1RI
         W0S49oWi1UXFCkDBxoThDDUMC+vOfYBzbkDSSn2wkK7ISlpCozvFBAqijHXF/BHx0gU/
         mvLHgCHm+pB+doShNyedKvvKTR+yTIExdp4Ns5UEu9araXc2mGPVh0BnnaxBRMWPCLun
         ELxjmVxFPdh2XgX0zAL5Y+MGFxfXVhhZmtbwF9UQ+WiSugKvoOkoKo6EzAwNMhsHh/0f
         6e2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=nmYXI0SxvNWPydiP22L4J4Bibf/4YNAHpqQBhHSP2Ko=;
        b=YnZMWJHywJrVOgZKu+3nVI+6spHC/xbKstsHjPa2P+Nimrud7udC3JtkUbAnhcohDe
         8CCeGC7isA7eT+9XaO1fjlS7zfq/Rs16QjXzFDtZLnoXr/h3rNknjwSP+txPcDCWU1PR
         q6Z4vNgBgybme2ZsVnsaYiCC16XI1ZlOKAmRTn4vVZU/dHBcQUJfu10aJJU1iHxrrAW4
         oogywwZuKeFRL/4DIZpx5rCVKVclfdrWbJCne+3gtfkLarGmPElJQwQECpjlcEyryEJL
         e2cTJkScZZftII3lrzg63Hb8ro/PlioOKtCMZO33zx0TulIRCasI322Z7gClQV4NreDH
         WCmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.81 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.81 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 05667290370d4e1f89f63586432b55c1-20180314
Message-ID: <1521015535.3717.26.camel@mhfsdcap03>
Subject: Re: [PATCH] Add Apple Carplay driver
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
	Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, "Alan Stern" <stern@rowland.harvard.edu>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Date: Wed, 14 Mar 2018 16:18:55 +0800
In-Reply-To: <CAA6KcBAnLYZ2UyUB6Ecv96D0zWhmce2BMmA_iWx04njeNYsd9w@mail.gmail.com>
References: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
	 <CAA6KcBAnLYZ2UyUB6Ecv96D0zWhmce2BMmA_iWx04njeNYsd9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594891852474932951?=
X-GMAIL-MSGID: =?utf-8?q?1594900455467993368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-03-13 at 23:53 -0700, Matthew Dharm wrote:
> Why is this a kernel-level driver, rather than a userspace application
> that uses libusb to send the single vendor-specific command required?
> Since this command would be applicable to many CarPlay devices, with
> many different VID/PIDs, it would seem to make more sense as a
> userspace app that took a reference to a USB device or VID/PID.
Sorry, I'm not familiar with libusb.
But after I roughly read a simple example using libusb, it indeed can be
realized by a userspace driver.

Thanks for your useful comments

> 
> Matt
> 
> On Tue, Mar 13, 2018 at 11:02 PM, Chunfeng Yun
> <chunfeng.yun@mediatek.com> wrote:
> > From bf48dcd9cb254576cfea373c9a5d2ab996408895 Mon Sep 17 00:00:00 2001
> > From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Date: Tue, 13 Mar 2018 11:47:38 +0800
> > Subject: [PATCH] Add Apple Carplay driver
> >
> > Some Apple devices which support Carplay can enter USB Host Mode from USB
> > Device Mode after receiving a specific USB Vendor Request. There is a
> > requirement apply to accesssories that support the USB dual role switch
> > feature, and must have a USB-A receptacle that is capable of functioning
> > in both USB Host and USB Device roles.
> > It means that the driver should supports manual Dual-Role switch, due to
> > no IDDIG pin is avaliable.
> >
> > There is no suitable place to add this spicific USB Vendor Request, so
> > here I extract a single driver which allow user force to send it by a debug
> > interface when need it, and keep it independent on USB Dual-Role Controller
> > Drivers.
> > But to implement carplay feature, there are some requirments for USB Dual-Role
> > Driver:
> > 1. supports manual dual-role switch, such as, by a debug interface;
> > 2. keep vbus alive even when switch host into device mode;
> >
> > More information please refer to "Chapter 46. USB Role Switch" in
> > MFI Accessroy Interface Specification.pdf
> >
> > Chunfeng Yun (1):
> >   usb: misc: supports Apple Carplay driver
> >
> >  drivers/usb/misc/Kconfig   |    9 +++
> >  drivers/usb/misc/Makefile  |    1 +
> >  drivers/usb/misc/carplay.c |  193 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 203 insertions(+)
> >  create mode 100644 drivers/usb/misc/carplay.c
> >
> > --
> > 1.7.9.5
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
