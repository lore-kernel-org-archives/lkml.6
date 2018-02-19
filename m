Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeBSOBT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:01:19 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:40363 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeBSOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:01:17 -0500
X-Google-Smtp-Source: AH8x224MwsaaVbwQFk+CdBLmLMlp90bq/vC9v101ChVkxm9o923Qk/Ed53ioZHKoBpvuxZERkE0prCfpHAbCtq7WGZI=
MIME-Version: 1.0
In-Reply-To: <20180218163211.GA1650@light.dominikbrodowski.net>
References: <20180217132543.GA21571@light.dominikbrodowski.net>
 <1518879773.22495.378.camel@linux.intel.com> <1518880180.22495.379.camel@linux.intel.com>
 <20180217165815.GA1854@light.dominikbrodowski.net> <1518901021.22495.383.camel@linux.intel.com>
 <20180218094135.GA2459@light.dominikbrodowski.net> <CAHp75Vf2sS8c4GubL1MRkrGdpYdn0n5stmzZNnp8axNn3AkEcw@mail.gmail.com>
 <20180218163211.GA1650@light.dominikbrodowski.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Feb 2018 16:01:15 +0200
Message-ID: <CAHp75VeEPyuonH+Yji9B1mMgaYvw7god0MQW8z52722kfOAaJg@mail.gmail.com>
Subject: Re: i2c-designware: sound and s2ram broken on Broadwell-U system
 since commit ca382f5b38f367b6 (add i2c gpio recovery option)
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tim@krieglstein.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 6:32 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Sun, Feb 18, 2018 at 04:23:41PM +0200, Andy Shevchenko wrote:
>> On Sun, Feb 18, 2018 at 11:41 AM, Dominik Brodowski
>> <linux@dominikbrodowski.net> wrote:
>> > On Sat, Feb 17, 2018 at 10:57:01PM +0200, Andy Shevchenko wrote:
>> >> On Sat, 2018-02-17 at 17:58 +0100, Dominik Brodowski wrote:
>>
>> >> >  Do you still need the DEBUG_GPIO output?
>> >>
>> >> It would be nice to have, though if it makes difficulties to you, then
>> >> don't bother.
>> >
>> > Note that I have to enable CONFIG_GPIOLIB before I can enable DEBUG_GPIO;
>> > CONFIG_PINCTRL was off as well. Maybe some "SELECT" is missing for
>> > CONFIG_I2C_DESIGNWARE_BAYTRAIL ?
>>
>> Ah, so, your configuration misses pin control driver. You need to
>> enable it in order to get GPIOs working.
>
> Well, I did not need it in the past to have working sound and working
> suspend to RAM. And it already works if
>
>         CONFIG_PINCTRL=y
>         CONFIG_DEBUG_PINCTRL=y
>
>         CONFIG_GPIOLIB=y
>         CONFIG_GPIO_ACPI=y
>         CONFIG_DEBUG_GPIO=y
>
> are set (but no PINCTRL or GPIO drivers!).
>
> So I'd suggest to
>
> (a) keep your fixup patch (as things work as previously then),

You may answer to mail with the patch by giving a Tested-by tag.

> (b) to have CONFIG_I2C_DESIGNWARE_BAYTRAIL select the appropriate options from
>     above [and CONFIG_XPOWER_PMIC_OPREGION ?] (or depend on it?), or

I don't think there is such dependency.

Jarkko, what do you think?

>> Yes, and with enabled pin control driver.
>
> Well, I've reverted your fixup patch locally and enabled all drivers that I
> could -- including CONFIG_XPOWER_PMIC_OPREGION, CONFIG_MFD_AXP20X, and
> CONFIG_MFD_AXP20X_I2C. But I'm not sure at all that a driver actually became
> active...

-ENOSYS is returned when !GPIOLIB. That what made behaviour different
in the first place.

-- 
With Best Regards,
Andy Shevchenko
