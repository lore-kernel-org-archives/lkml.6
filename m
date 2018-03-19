Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521470615; cv=none;
        d=google.com; s=arc-20160816;
        b=PlKkOliz/TL3SpFoNFGdPC7DFYFkxZd7nf1El+TigQ/dlRv30wJQvc6xk45x/d07M2
         oezSA0n1foEoxc/DNUT7EbRTgTXre6XE2xnzZi1sA5BW451bVtscwP6NUs7XncMUJZ7S
         /3Pwp86YE+3JBV05Qcvg0YBUx2o2TiF/1xUXrbSqFCzO5JNghI3pVQE0VXKm2wBBOl9z
         aYiijZp0Xxpdiwp/vlsRpLaatZMXXj6Qpth0XfDtriKYk7aics0to2A4ucxIlHOno7Zz
         nD5Hr0MIuwgBqebPeAKuyfM/wK1ROfmBx+h9qtvH43wBNwzEJfwVjS8D4IUZRmXUvN8s
         cZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HwilU2E63RJusxOfNCSzX4IzoU3INjSTpPEhwb6vjuA=;
        b=hYHp5pM3RriUZbTWCzH9OVMEh4uWwbLJW7bavL4XtTJnnG+e5+zGFTq/i8y6GhjSIY
         fIevppz/FJF6fLEf8XIRAAA4f3/XPkPA5h3fL2vMihE6MxCF+8qwiBR56p0ifX+DF1wn
         NJX18NhFhU3k5FpIv2KBw6MOnk0nYQxeJ+c4WgOUyVLuki2X7Wr5kzaGHuO6HTId4vyk
         5bom1i+Z/5e9kt2ilFrsODJ8GWL/pyNT/nnS2XKLGFoPyIcmOt5rJqqzsfS2iagoChsi
         kYPj0dWpTs83KfHubcoSUeytKJ9IT3QQ7AZxKGtIT+qkdAnUu4beQKVHjPR9z0ZGwPqX
         SlXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OL3LNvdd;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OL3LNvdd;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu5cxxD38xtdRuvncXxlsPjVb5xIvOTOcgwqExyuB16hQnLIqZCTSjSYFwlvPu1ZmfaaL7o1rSu5c85Bqp8ngU=
MIME-Version: 1.0
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Mar 2018 16:43:35 +0200
Message-ID: <CAHp75VevXq6NwpmvTU_2GzSdLjUQ47RLM__M3jNLBjZ1YoeQHw@mail.gmail.com>
Subject: Re: [PATCH 00/21] eeprom: at24: driver refactoring
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357052478188626?=
X-GMAIL-MSGID: =?utf-8?q?1595377572613086054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 11:17 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> This series contains what I hope to be a non-controversial refactoring
> of the at24 eeprom driver.
>
> Most changes revolve around at24_probe() which became quite complicated
> and hard to read.
>
> The only functional changes are: disabling the internal locking
> mechanisms of regmap (since we already take care of that in the driver)
> and removing an if checking if byte_len is a power of 2 (as we do
> support models for which it's not true).
>
> All other patches affect readability and code structure.
>
> Tested with a couple models and different both for device tree and
> platform data modes.

Is there any available tree with that series applied?
I would test it on Intel Galileo Gen 2 which has ACPI enumerated AT24
EEPROM attached.

>
> Bartosz Golaszewski (21):
>   eeprom: at24: disable regmap locking
>   eeprom: at24: remove nvmem_config from at24_data
>   eeprom: at24: arrange local variables
>   eeprom: at24: use SPDX identifier instead of GPL boiler-plate
>   eeprom: at24: remove code separators
>   eeprom: at24: drop redundant variable in at24_read()
>   eeprom: at24: drop redundant variable in at24_write()
>   eeprom: at24: make struct initialization uniform in at24_probe()
>   eeprom: at24: don't check if byte_len is a power of 2
>   eeprom: at24: rename at24_get_pdata()
>   eeprom: at24: rename chip to pdata in at24_probe()
>   eeprom: at24: use a helper variable for dev
>   eeprom: at24: readability tweak in at24_probe()
>   eeprom: at24: provide and use at24_base_client_dev()
>   eeprom: at24: switch to using probe_new() from the i2c framework
>   eeprom: at24: move platform data processing into a separate routine
>   eeprom: at24: remove at24_platform_data from at24_data
>   eeprom: at24: refactor at24_probe()
>   eeprom: at24: tweak newlines
>   eeprom: at24: fix a line break
>   eeprom: at24: simplify the i2c functionality checking
>
>  drivers/misc/eeprom/at24.c | 293 ++++++++++++++++++++++++---------------------
>  1 file changed, 156 insertions(+), 137 deletions(-)
>
> --
> 2.16.1
>



-- 
With Best Regards,
Andy Shevchenko
