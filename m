Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeBAQ4W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:56:22 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39013 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeBAQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:56:19 -0500
X-Google-Smtp-Source: AH8x2266CMJJpeQPvhYlAXmEUJspZTJIziYAUM3sBbZpiBXyyAq3DVZ3r6et7rUsz2pzLeEimtQhc5oPS46sqVuDsHo=
MIME-Version: 1.0
In-Reply-To: <3132455.r9uCTL3ZTk@amdc3058>
References: <20180131093434.20050-1-ulfalizer@gmail.com> <CGME20180131093527epcas2p3978f33b8407c31bd95e01bca682346da@epcas2p3.samsung.com>
 <20180131093434.20050-3-ulfalizer@gmail.com> <3132455.r9uCTL3ZTk@amdc3058>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 1 Feb 2018 17:56:18 +0100
Message-ID: <CAFkk2KQxPnwMKmvhCoKQ0BBciTc5JKqjJqHGHAMR5uHF0w13sg@mail.gmail.com>
Subject: Re: [PATCH 02/11] video: fbdev: kconfig: Remove blank help text
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Bolle <pebolle@tiscali.nl>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 4:52 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Wednesday, January 31, 2018 10:34:21 AM Ulf Magnusson wrote:
>> Blank help texts are probably either a typo, a Kconfig misunderstanding,
>> or some kind of half-committing to adding a help text (in which case a
>> TODO comment would be clearer, if the help text really can't be added
>> right away).
>>
>> Best to remove them, IMO.
>
> How about actually adding some meaningful help texts instead
> (as a general rule each user visible option should have valid
> help text)?
>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>>  drivers/video/fbdev/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>> index 6962b4583fd7..11e699f1062b 100644
>> --- a/drivers/video/fbdev/Kconfig
>> +++ b/drivers/video/fbdev/Kconfig
>> @@ -1156,7 +1156,6 @@ config FB_I810_I2C
>>       bool "Enable DDC Support"
>>       depends on FB_I810 && FB_I810_GTF
>>       select FB_DDC
>> -     help
>
> Please add a missing help text instead (take a look at FB_SAVAGE_I2C
> config option to see how a valid help text entry should look like).

The FB_I810_I2C option was added in 74f6ae84b23 ("[PATCH] i810fb: Add
i2c/DDC support"). What do you think about adding this bit from the
commit message as the help text?

  Add DDC/I2C support for i810fb.  This will allow the driver to get display
  information, especially for monitors with fickle timings.

I'm not familiar with this code, so I don't want to do too much
guessing myself. :)

>
> In the longer term we should consider removing *_I2C config options
> and just make the main config options always enable I2C subsystem
> directly if needed/useful (some fbdev drivers are doing it this way
> already).
>
>>  config FB_LE80578
>>       tristate "Intel LE80578 (Vermilion) support"
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>

Cheers,
Ulf
