Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeE1Iit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:38:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53264 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753986AbeE1Iil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:38:41 -0400
X-Google-Smtp-Source: AB8JxZqICmGTz5BovShF0ap0wWgIeAA0DgHavJs6BGl9z6mt0lx1OYLKbK5N+Er7KKp3BGJUDv1Rvw==
Date: Mon, 28 May 2018 10:38:34 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: gadget: ccid: add support for USB CCID
 Gadget Device
Message-ID: <20180528083834.GB4651@gmail.com>
References: <CGME20180526212048epcas2p1510fd6c92f20e8f6d0059742ab5fb3f7@epcas2p1.samsung.com>
 <20180526211940.25474-1-marcus.folkesson@gmail.com>
 <20180528070453eucas1p294be19abd2cab7d112404d15710edfde~yvQ5mevbz2769227692eucas1p2k@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180528070453eucas1p294be19abd2cab7d112404d15710edfde~yvQ5mevbz2769227692eucas1p2k@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Mon, May 28, 2018 at 09:04:51AM +0200, Andrzej Pietrasiewicz wrote:
> Mi Marcus,
> 
> W dniu 26.05.2018 o 23:19, Marcus Folkesson pisze:
> > Chip Card Interface Device (CCID) protocol is a USB protocol that
> > allows a smartcard device to be connected to a computer via a card
> > reader using a standard USB interface, without the need for each manufacturer
> > of smartcards to provide its own reader or protocol.
> > 
> > This gadget driver makes Linux show up as a CCID device to the host and let a
> > userspace daemon act as the smartcard.
> > 
> > This is useful when the Linux gadget itself should act as a cryptographic
> > device or forward APDUs to an embedded smartcard device.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> 
> >   
> > +config USB_CONFIGFS_CCID
> > +	bool "Chip Card Interface Device (CCID)"
> > +	depends on USB_CONFIGFS
> > +	select USB_F_CCID
> > +	help
> > +	  The CCID function driver provides generic emulation of a
> > +	  Chip Card Interface Device (CCID).
> > +
> > +	  You will need a user space server talking to /dev/ccidg*,
> > +	  since the kernel itself does not implement CCID/TPDU/APDU
> > +	  protocol.
> 
> Your function needs a userspace daemon to work.
> It seems you want to use FunctionFS for such a purpose
> instead of creating a new function.
> 
> Andrzej

> > +	  since the kernel itself does not implement CCID/TPDU/APDU
Oops, the driver does handle CCID.

Well, yes, It needs an application that perform the "smartcard operations", such as
generate keys or sign data, as this depends on how it should be used.

The actual smartcard operations could for example be in software,
use a crypto engine in SoC or external HSM (Hardware Security Module).

Without the application, the gadget shows up as a smart card reader
with an unconnected smartcard.

I guess it could be accomplished with FunctionFS as well.

Best regards
Marcus Folkesson
