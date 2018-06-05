Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeFEKA7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:00:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:46835 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbeFEKA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:00:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,478,1520924400";
   d="scan'208";a="46866532"
Message-ID: <2b2a81ce166f16ab88a4733caed2544c8128ae6b.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] serial: 8250: enable SERIAL_MCTRL_GPIO by default.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        Ed Blake <ed.blake@sondrel.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Vignesh R <vigneshr@ti.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>
Date: Tue, 05 Jun 2018 13:00:42 +0300
In-Reply-To: <7f4d688c-095a-d056-1edd-430bfc4e00da@micronovasrl.com>
References: <20180601141158.93817-1-giulio.benetti@micronovasrl.com>
         <b850a3cf565a24414d3290f6699f5a040bf61223.camel@linux.intel.com>
         <7f4d688c-095a-d056-1edd-430bfc4e00da@micronovasrl.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-04 at 20:57 +0200, Giulio Benetti wrote:
> Il 04/06/2018 13:49, Andy Shevchenko ha scritto:
> > On Fri, 2018-06-01 at 16:11 +0200, Giulio Benetti wrote:
> > > It can be useful to override 8250 mctrl lines with gpios, for rts
> > > on
> > > rs485 for example, when rts is not mapped correctly to HW RTS pin.
> > > 
> > > Enable SERIAL_MCTRL_GPIO by default.
> > > 
> > 
> > Unfortunately NAK, see
> > 
> > commit 5db4f7f80d165fc9725f356e99feec409e446baa
> > Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Date:   Tue Aug 16 15:06:54 2016 +0300
> > 
> >      Revert "tty/serial/8250: use mctrl_gpio helpers"
> > 
> > for the details.
> > 
> > I would love to see a solution that will satisfy everyone, though I
> > have
> > only means to test proposals for now.
> 
> Thanks for pointing me that.
> I would try to solve serial breakage on intel with already extisting 
> patches dropping this one.
> I'm going to try.
> 
> I can't understand if it's enough using qemu x86 to reproduce the bug.
> If so I'm going to debug and check what makes driver to fail.

You need to provide an ACPI table with UART contains GpioInt() or
GpioIo() resource in it.

Where GPIO number is a number of pin related to UART's RxD.


> Do you think it makes sense? Would it be accepted after bug fixing?

I can test on our hardware. Can't say about the rest, though.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
