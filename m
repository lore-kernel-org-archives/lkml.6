Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeEDEbZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 00:31:25 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36198 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeEDEbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 00:31:23 -0400
X-Google-Smtp-Source: AB8JxZpamE47jkbkDdf4MeMKDVgP9V/nGKlLMG+7m83PSO/EkthsPtMytkUq9SQ/iHQa6BtNPX57jVJ9pk9oy08pqEI=
MIME-Version: 1.0
In-Reply-To: <20180503183408.GA12152@kroah.com>
References: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
 <20180503183408.GA12152@kroah.com>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Fri, 4 May 2018 10:01:21 +0530
Message-ID: <CAHhAz+iub6boqtK7UgFuKW=4t9DYPrnPX6nDu8R4T2J4=v=-DA@mail.gmail.com>
Subject: Re: serial: start_tx & buffer handling
To: Greg KH <greg@kroah.com>
Cc: linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w444VVkU020861

On Fri, May 4, 2018 at 12:04 AM, Greg KH <greg@kroah.com> wrote:
> On Thu, May 03, 2018 at 08:08:48PM +0530, Muni Sekhar wrote:
>> Hi All,
>>
>> I’m trying to understand how user mode buffer is written to low level
>> serial hardware registers.
>>
>> For this I read the kernel code and I came to know that from user mode
>> write() API lands into kernel’s tty_write() ("drivers/tty/tty_io.c")
>> and then it calls a uart_write() ("drivers/tty/serial/serial_core.c").
>>
>> In uart_write(), the buffer is copied to circ_buf and then it calls
>> low level serial hardware driver’s start_tx() (struct uart_ops
>> .start_tx). But here I could not find how the buffer kept in circ_buf
>> is copied to serial port’s TX_FIFO registers?
>>
>> Can someone take a moment to explain me on this?
>
> It all depends on which specific UART driver you are looking at, they
> all do it a bit different depending on the hardware.
>
> Which one are you looking at?  Look at what the start_tx callback does
> for that specific driver, that should give you a hint as to how data
> starts flowing.  Usually an interrupt is enabled that is used to flush
> the buffer out to the hardware.
>

I’m looking for any existing sample code which does DMA transfers of
UART transmitted data. I looked at the bcm63xx_uart.c, it looks it
does not handle DMA transfers. Even copying the Tx buffer (from
circ_buf) to UART_FIFO_REG happening in ISR.


> thanks,
>
> greg k-h



-- 
Thanks,
Sekhar
