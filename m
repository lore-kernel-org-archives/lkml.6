Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932908AbeCEFmb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:42:31 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45844 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932614AbeCEFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:42:26 -0500
X-Google-Smtp-Source: AG47ELtyEnGmyInTSu12GZyuW2lG1kicPsQV+deoWx4sS8SDsNaHC9nvas/1eYRQeBgO5wVpdVsJusBKbokflB5eErA=
MIME-Version: 1.0
In-Reply-To: <20180302112059.GA27322@gmail.com>
References: <20180302063746.10993-1-joel@jms.id.au> <20180302063746.10993-3-joel@jms.id.au>
 <20180302112059.GA27322@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 5 Mar 2018 16:12:05 +1030
X-Google-Sender-Auth: 3bftNTrv80xSkMyhJ-k6_nPr4bk
Message-ID: <CACPK8Xdcd7Dx5OvoRKH8OCJ1O1uOKi8BTwpTRz6+YAiOG5eoAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: Add Nuvoton NPCM watchdog driver
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 9:50 PM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> Hello Joel!
>
> On Fri, Mar 02, 2018 at 05:07:46PM +1030, Joel Stanley wrote:
>> The Nuvoton NPCM750 has a watchdog implemented as a single register
>> inside the timer peripheral.
>>
>> This driver exposes that watchdog as a standard watchdog device with
>> coarse timeout intervals, limited by the combination of prescaler and
>> counter that is provided by the hardware. The calculation is taken from
>> the Nuvoton vendor tree.
>>
>> There is a pre-timeout IRQ that is wired up. This timeout always occurs
>> 1024 clocks before the timeout.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  drivers/watchdog/Kconfig    |  11 +++
>>  drivers/watchdog/Makefile   |   1 +
>>  drivers/watchdog/npcm_wdt.c | 223 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 235 insertions(+)
>>  create mode 100644 drivers/watchdog/npcm_wdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index aff773bcebdb..0c1cc68894e6 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -513,6 +513,17 @@ config COH901327_WATCHDOG
>>         This watchdog is used to reset the system and thus cannot be
>>         compiled as a module.
>>
>> +config NPCM7XX_WATCHDOG
>> +     bool "NPCM750 watchdog"
>
> Just asking, we do not want to make it possible to build this as a module?

The watchdog provides the SoC with a way to reboot itself, so I would
expect all users of the kernel to have it built in in case the system
cannot find it's initrd or root file system, and therefore is unable
to load the watchdog module.

I am happy to change it if you would prefer.

Thanks for the review.

Cheers,

Joel
