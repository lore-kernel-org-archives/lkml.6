Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbeEaLrw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:47:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35873 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeEaLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:47:49 -0400
X-Google-Smtp-Source: ADUXVKKfBoG2g1pVIhMVb9NqlafNX+jmByunVAC7hL2sEQ3eIPb4uQXmByZIGxAHYn9bsjsmrEvwqw==
Date: Thu, 31 May 2018 13:47:43 +0200
From: Johan Hovold <johan@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/8] gnss: add new GNSS subsystem
Message-ID: <20180531114743.GG3259@localhost>
References: <20180530103242.20773-1-johan@kernel.org>
 <20180530143822.lvtwjvbqe7gvbvgq@localhost>
 <20180531085242.GE3259@localhost>
 <943C21CA-EEC6-45E2-997E-A6E1FA0549EB@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943C21CA-EEC6-45E2-997E-A6E1FA0549EB@goldelico.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:52:18AM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 31.05.2018 um 10:52 schrieb Johan Hovold <johan@kernel.org>:
> > 
> > On Wed, May 30, 2018 at 07:38:22AM -0700, Richard Cochran wrote:
> >> On Wed, May 30, 2018 at 12:32:34PM +0200, Johan Hovold wrote:
> >>> Another possible extension is to add generic 1PPS support.
> >> 
> >> There are two possibilities to consider.
> >> 
> >> 1. If the PPS causes an interrupt, then it should hook into the PPS
> >>   subsystem.
> > 
> > Registering a PPS child device is what I had in mind for this.
> 
> This seems to be duplicating functionality that is already solved by
> 
> https://elixir.bootlin.com/linux/v4.17-rc7/source/Documentation/devicetree/bindings/pps/pps-gpio.txt
> 
> and
> 
> https://elixir.bootlin.com/linux/v4.17-rc7/source/drivers/pps/clients/pps-gpio.c
> 
> Or what is bad with just using that?

Using pps-gpio would not allow you to describe the hardware properly,
something which, for example, may be needed for power management (e.g.
to power on the GNSS receiver when the pps device is being accessed).

Johan
