Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeFDS5U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:57:20 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:60716 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeFDS5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:57:18 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 1/2] serial: 8250: enable SERIAL_MCTRL_GPIO by default.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
References: <20180601141158.93817-1-giulio.benetti@micronovasrl.com>
 <b850a3cf565a24414d3290f6699f5a040bf61223.camel@linux.intel.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <7f4d688c-095a-d056-1edd-430bfc4e00da@micronovasrl.com>
Date: Mon, 4 Jun 2018 20:57:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b850a3cf565a24414d3290f6699f5a040bf61223.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/06/2018 13:49, Andy Shevchenko ha scritto:
> On Fri, 2018-06-01 at 16:11 +0200, Giulio Benetti wrote:
>> It can be useful to override 8250 mctrl lines with gpios, for rts on
>> rs485 for example, when rts is not mapped correctly to HW RTS pin.
>>
>> Enable SERIAL_MCTRL_GPIO by default.
>>
> 
> Unfortunately NAK, see
> 
> commit 5db4f7f80d165fc9725f356e99feec409e446baa
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Tue Aug 16 15:06:54 2016 +0300
> 
>      Revert "tty/serial/8250: use mctrl_gpio helpers"
> 
> for the details.
> 
> I would love to see a solution that will satisfy everyone, though I have
> only means to test proposals for now.

Thanks for pointing me that.
I would try to solve serial breakage on intel with already extisting 
patches dropping this one.
I'm going to try.

I can't understand if it's enough using qemu x86 to reproduce the bug.
If so I'm going to debug and check what makes driver to fail.

Do you think it makes sense? Would it be accepted after bug fixing?

Thanks
Best regards

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

> 
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   drivers/tty/serial/8250/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/8250/Kconfig
>> b/drivers/tty/serial/8250/Kconfig
>> index f005eaf8bc57..c7992b94fece 100644
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>> @@ -7,6 +7,7 @@ config SERIAL_8250
>>   	tristate "8250/16550 and compatible serial support"
>>   	depends on !S390
>>   	select SERIAL_CORE
>> +	select SERIAL_MCTRL_GPIO if GPIOLIB
>>   	---help---
>>   	  This selects whether you want to include the driver for the
>> standard
>>   	  serial ports.  The standard answer is Y.  People who might
>> say N
> 
