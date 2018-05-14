Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeENQ64 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:58:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36097 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:58:54 -0400
Date: Mon, 14 May 2018 18:58:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
Message-ID: <20180514165844.GD27984@xo-6d-61-c0.localdomain>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org>
 <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > config CAN_PEAK_PCIEFD
> >         depends on PCI
> >         tristate "PEAK-System PCAN-PCIe FD cards"
> >         ---help---
> >           This driver adds support for the PEAK-System PCI Express FD
> >           CAN-FD cards family.
> >           These 1x or 2x CAN-FD channels cards offer CAN 2.0 a/b as well as
> >           CAN-FD access to the CAN bus. Besides the nominal bitrate of up to
> >           1 Mbit/s, the data bytes of CAN-FD frames can be transmitted with
> >           up to 12 Mbit/s. A galvanic isolation of the CAN ports protects the
> >           electronics of the card and the respective computer against
> >           disturbances of up to 500 Volts. The PCAN-PCI Express FD can be
> >           operated with ambient temperatures in a range of -40 to +85 °C.
> >
> >
> > kconfiglib.KconfigSyntaxError:
> > Malformed ascii in drivers/net/can/peak_canfd/Kconfig
> > Context: b't temperatures in a range of -40 to +85 \xc2\xb0C.\n'
> > Problematic data: b'\xc2'
> > Reason: ordinal not in range(128)
> >
> >
> > thanks,
> > --
> > ~Randy
> 
> Thanks for trying it out!
> 
> You're probably running in the C locale, which implies an ASCII
> encoding. That has caused enough trouble that the Python devs decided
> to automatically convert it to UTF-8 in Python 3.7:
> https://www.python.org/dev/peps/pep-0538/. LC_CTYPE=C.UTF-8 should fix
> it.
> 
> It's a bit silly to have it crash for something like that though. I
> could force UTF-8 instead of respecting the locale (though it feels
> neater to respect settings), or tell Python to ignore decoding errors.
> Should probably do something at least...

Well, Kconfig files are utf-8, as is the rest of kernel.

So yes, you should respect $LC_CTYPE for display etc, but you should always
assume Kconfig files are utf-8... and that does not need to be optional.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
