Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeCTTmJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:42:09 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35340 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeCTTmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:42:05 -0400
X-Google-Smtp-Source: AG47ELvtVbkhBx4O8MO7vfUoL+QIniCDGWWFPrq1s4bOOPx84LWB/c9P9irAFa7ui8aMk6x6s2EJvw==
Subject: Re: [PATCH] leds: fix wrong dmi_match on PC Engines APU LEDs
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>
References: <20180305170910.8905-1-ulli.kroll@googlemail.com>
 <b51f1f41-e06e-25e6-30f8-a2b9f7e8ffb8@gmail.com>
 <alpine.LNX.2.00.1803181509330.7595@T420s>
Cc: Alan Mizrahi <alan@mizrahi.com.ve>, Richard Purdie <rpurdie@rpsys.net>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <1fd03089-2e39-1463-31bb-26de1f63c046@gmail.com>
Date: Tue, 20 Mar 2018 20:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1803181509330.7595@T420s>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 03/18/2018 03:24 PM, Hans Ulli Kroll wrote:
> Hi Jacek
> 
> On Sat, 10 Mar 2018, Jacek Anaszewski wrote:
> 
>> Hi Hans,
>>
>> Thank you for the patch.
>>
>> On 03/05/2018 06:09 PM, Hans Ulli Kroll wrote:
>>> APU has compared to APU2 no DMI_BOARD_NAME.
>>> Use DMI_PRODUCT_NAME instead.
>>
>> Could we have the commit message more expressive?
>>
>> Is it that now this driver doesn't work for APU board?
> 
> Yes it doesn't work for my APU board.
> I've already checked the updated driver in -next
> 
> As you can see here
> # grep . /sys/class/dmi/id/*
> /sys/class/dmi/id/bios_date:04/05/2014
> /sys/class/dmi/id/bios_vendor:coreboot
> /sys/class/dmi/id/bios_version:SageBios_PCEngines_APU-45
> /sys/class/dmi/id/chassis_type:3
> /sys/class/dmi/id/chassis_vendor:PC Engines
> /sys/class/dmi/id/modalias:dmi:bvncoreboot:bvrSageBios_PCEngines_APU-45:bd04/05/2014:svnPCEngines:pnAPU:pvr1.0:cvnPCEngines:ct3:cvr:
> /sys/class/dmi/id/product_family:None Provided
> /sys/class/dmi/id/product_name:APU
> /sys/class/dmi/id/product_serial:XXXXXXX
> /sys/class/dmi/id/product_version:1.0
> /sys/class/dmi/id/sys_vendor:PC Engines
> /sys/class/dmi/id/uevent:MODALIAS=dmi:bvncoreboot:bvrSageBios_PCEngines_APU-45:bd04/05/2014:svnPCEngines:pnAPU:pvr1.0:cvnPCEngines:ct3:cvr:
> 
> there is no board name on APU.
> 
> here is the output from my APU2 board
> # grep . /sys/class/dmi/id/*
> /sys/class/dmi/id/bios_date:02/28/2017
> /sys/class/dmi/id/bios_vendor:coreboot
> /sys/class/dmi/id/bios_version:4.0.7
> /sys/class/dmi/id/board_name:APU2
> /sys/class/dmi/id/board_serial:XXXXXXX
> /sys/class/dmi/id/board_vendor:PC Engines
> /sys/class/dmi/id/board_version:1.0
> /sys/class/dmi/id/chassis_type:3
> /sys/class/dmi/id/chassis_vendor:PC Engines
> /sys/class/dmi/id/modalias:dmi:bvncoreboot:bvr4.0.7:bd02/28/2017:svnPCEngines:pnAPU2:pvr1.0:rvnPCEngines:rnAPU2:rvr1.0:cvnPCEngines:ct3:cvr:
> /sys/class/dmi/id/product_name:APU2
> /sys/class/dmi/id/product_serial:XXXXXX
> /sys/class/dmi/id/product_version:1.0
> /sys/class/dmi/id/sys_vendor:PC Engines
> /sys/class/dmi/id/uevent:MODALIAS=dmi:bvncoreboot:bvr4.0.7:bd02/28/2017:svnPCEngines:pnAPU2:pvr1.0:rvnPCEngines:rnAPU2:rvr1.0:cvnPCEngines:ct3:cvr:
> 
> As you can see here for APU2 the board_name is set.

Thanks for this explanation. I modified the commit message
accordingly and applied the patch to the for-next branch
in the following form:

commit 92d7ec1d71e351f11ba503369eb78225510cfcc7
Author: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Date:   Mon Mar 5 18:09:10 2018 +0100

    leds: Fix wrong dmi_match on PC Engines APU LEDs

    BIOS on APU board doesn't expose board_name property, and thus
    we have to rely on the product_name instead.

    Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
    Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>


Please let me know if you have any comments.

Best regards,
Jacek Anaszewski

>>
>> If it fails here, then how it is possible that it succeeds
>> in the apu_led_init() ?
>>
> 
> in apu_led_init() is a check for product_name for both both boards.
> Ans this succeeds
> 
> Thus the fix here
>> -     if (dmi_match(DMI_BOARD_NAME, "APU")) {
>> +     if (dmi_match(DMI_PRODUCT_NAME, "APU")) {
> 
> I can rewrite the patch to catch both board_name and product_name for the 
> APU board, and add a better commit log.
> 
> They are more recent bios updates for this board, but the are specified as 
> "beta" so I'm afraid of an update. I have no hardware to recover a 
> "damaged" SPI flash chip.
