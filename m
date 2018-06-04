Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeFDLtf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:49:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:3400 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753062AbeFDLtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:49:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="229742264"
Message-ID: <b850a3cf565a24414d3290f6699f5a040bf61223.camel@linux.intel.com>
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
        linux-kernel@vger.kernel.org
Date: Mon, 04 Jun 2018 14:49:27 +0300
In-Reply-To: <20180601141158.93817-1-giulio.benetti@micronovasrl.com>
References: <20180601141158.93817-1-giulio.benetti@micronovasrl.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-01 at 16:11 +0200, Giulio Benetti wrote:
> It can be useful to override 8250 mctrl lines with gpios, for rts on
> rs485 for example, when rts is not mapped correctly to HW RTS pin.
> 
> Enable SERIAL_MCTRL_GPIO by default.
> 

Unfortunately NAK, see 

commit 5db4f7f80d165fc9725f356e99feec409e446baa
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue Aug 16 15:06:54 2016 +0300

    Revert "tty/serial/8250: use mctrl_gpio helpers"

for the details.

I would love to see a solution that will satisfy everyone, though I have
only means to test proposals for now.

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/tty/serial/8250/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig
> b/drivers/tty/serial/8250/Kconfig
> index f005eaf8bc57..c7992b94fece 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -7,6 +7,7 @@ config SERIAL_8250
>  	tristate "8250/16550 and compatible serial support"
>  	depends on !S390
>  	select SERIAL_CORE
> +	select SERIAL_MCTRL_GPIO if GPIOLIB
>  	---help---
>  	  This selects whether you want to include the driver for the
> standard
>  	  serial ports.  The standard answer is Y.  People who might
> say N

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
