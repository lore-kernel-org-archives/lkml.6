Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935758AbeCAHuW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 02:50:22 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:40405 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934908AbeCAHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 02:50:21 -0500
X-Google-Smtp-Source: AG47ELvm9xR0l2pWTf4R2SLI2YyurR0RVPo532vvF3WFry7/0QrrT581/GRbD8JBaPfzi4GodXB2GA==
Date: Thu, 1 Mar 2018 08:50:17 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] HID: add driver for Valve Steam Controller
Message-ID: <20180301075017.GB8901@gmail.com>
References: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
 <20180228184322.29636-2-rodrigorivascosta@gmail.com>
 <CAHp75VfPK=yAx9TLEX-W0SrK8xXQzrP4wAuFWS3zEjHGoPJRsw@mail.gmail.com>
 <20180228224926.GA7009@casa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228224926.GA7009@casa>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rodrigo,

On Wed, Feb 28, 2018 at 11:49:26PM +0100, Rodrigo Rivas Costa wrote:
> On Wed, Feb 28, 2018 at 09:21:15PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 28, 2018 at 8:43 PM, Rodrigo Rivas Costa
> > <rodrigorivascosta@gmail.com> wrote:
> > > There are two ways to connect the Steam Controller: directly to the USB
> > > or with the USB wireless adapter.  Both methods are similar, but the
> > > wireless adapter can connect up to 4 devices at the same time.
> > >
> > > The wired device will appear as 3 interfaces: a virtual mouse, a virtual
> > > keyboard and a custom HID device.
> > >
> > > The wireless device will appear as 5 interfaces: a virtual keyboard and
> > > 4 custom HID devices, that will remain silent until a device is actually
> > > connected.
> > >
> > > The custom HID device has a report descriptor with all vendor specific
> > > usages, so the hid-generic is not very useful. In a PC/SteamBox Valve
> > > Steam Client provices a software translation by using direct USB access
> > > and a creates a uinput virtual gamepad.
> > >
> > > This driver was reverse engineered to provide direct kernel support in
> > > case you cannot, or do not want to, use Valve Steam Client. It disables
> > > the virtual keyboard and mouse, as they are not so useful when you have
> > > a working gamepad.
> > 
> > 
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > > +MODULE_LICENSE("GPL");
> > 
> > Not the same.
> 
> Hmmm... I copied from usb-skeleton.c, IIRC...
> I'll change to GPL-2.0+, that would be correct, I think.

Yep, the usb-skeleton.c is wrong.
I have prepared a patch, just not submitted it yet..

GPL-2.0+ is "GPLv2 or later" if that is what you want.

Best regards
Marcus Folkesson
