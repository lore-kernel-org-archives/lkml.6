Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeBROXo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 09:23:44 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:39643 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeBROXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 09:23:42 -0500
X-Google-Smtp-Source: AH8x226zOd9YrKMz7ZJqUF2I5cUD1BW+q3LvBhBAnqwXfRKHVqfXTRcIRxTMRgfgJXabOv123SvlMRt6Zegbcp1Be1k=
MIME-Version: 1.0
In-Reply-To: <20180218094135.GA2459@light.dominikbrodowski.net>
References: <20180217132543.GA21571@light.dominikbrodowski.net>
 <1518879773.22495.378.camel@linux.intel.com> <1518880180.22495.379.camel@linux.intel.com>
 <20180217165815.GA1854@light.dominikbrodowski.net> <1518901021.22495.383.camel@linux.intel.com>
 <20180218094135.GA2459@light.dominikbrodowski.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 18 Feb 2018 16:23:41 +0200
Message-ID: <CAHp75Vf2sS8c4GubL1MRkrGdpYdn0n5stmzZNnp8axNn3AkEcw@mail.gmail.com>
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

On Sun, Feb 18, 2018 at 11:41 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Sat, Feb 17, 2018 at 10:57:01PM +0200, Andy Shevchenko wrote:
>> On Sat, 2018-02-17 at 17:58 +0100, Dominik Brodowski wrote:

>> >  Do you still need the DEBUG_GPIO output?
>>
>> It would be nice to have, though if it makes difficulties to you, then
>> don't bother.
>
> Note that I have to enable CONFIG_GPIOLIB before I can enable DEBUG_GPIO;
> CONFIG_PINCTRL was off as well. Maybe some "SELECT" is missing for
> CONFIG_I2C_DESIGNWARE_BAYTRAIL ?

Ah, so, your configuration misses pin control driver. You need to
enable it in order to get GPIOs working.
It might fix your issue w/o my patch.

> The following output is with your patch applied.

...which is useless.

> Do you need it without
> your fixup patch as well?

Yes, and with enabled pin control driver.

-- 
With Best Regards,
Andy Shevchenko
