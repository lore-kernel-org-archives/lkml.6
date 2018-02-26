Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1519652444; cv=none;
        d=google.com; s=arc-20160816;
        b=GWgVxlGoOTb/aUi9ofAF1DqVdw2qDUkGSF4k1iHqEErADQD4FbRjSEqAsj+x5P011+
         dndCMAqcLXZoML02ArGZG2QM053YfsdnPwg27tgUdtwyBPqFrTT4/IDa2mA2txvikNJE
         AoQ7mdjAvdsgq3mCZ7ELTrBwAUkX+c4fdFQeWl3zewfHOWCgDTt36pXJSDLCexKxbCaq
         IEfG4hq1Vnf9FLcWW6OizyJek6UzdEnkZyIV3e31NwEzE91nNImjLMrIyQtf0WGwcMw9
         fueTHSGNWtFNZMdeqPquvYClV1XkLbg6nKPrKydXR7ZbXB01zH0xoMW/e62bziJlWblJ
         i+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7rEKEXQphKer2x6OVWm6NPKuaUIcMnEz2NFvvLdG9mU=;
        b=vXQQFh3yw/xFihAqT6/a14hrE6+lK9DAovUaytSIKGkg+yWFEPrT2FlJFMe63uPEM3
         MKoW26bKLdAhgkXXLfJZDqHBKGV83TonSSXEmizAn3lextBO4DdVDT9/zd2dCW7IF1Cq
         A8mPwbVOvl3Hslajr1wfb1Yp737q8u9m8Qaw9mbAWaF1+HsuFk3xvNOy6rW7MsQQx0IY
         MQeRWFe6jQww37jZgm7v5E71DYP4Kl6RgjIux0FYhKrNUhyVwbuhssaNcXE9tYfwk8mD
         TYchLd6ydyfzYbJ+1K++DVD95YVg0lBoHFuiLyMF8xv1vZDkblUFVASaXaKKXzvjMHLV
         3HLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=KKxjdXGm;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=KKxjdXGm;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELupD8xXL9sCBzvU7k/u5Koau2uzkSMdAH3FkGQmBGS4ckKrBi2Vyia64aM4GdCr1AbAWZb268JEYOhup+wW4x0=
MIME-Version: 1.0
In-Reply-To: <20180226102000.1b76640e@endymion>
References: <20180226102000.1b76640e@endymion>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 26 Feb 2018 14:40:42 +0100
Message-ID: <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
Subject: Re: [PATCH] eeprom: New ee1004 driver for DDR4 memory
To: Jean Delvare <jdelvare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454680453951468?=
X-GMAIL-MSGID: =?utf-8?q?1593471080976997588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-26 10:20 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> The EEPROMs which hold the SPD data on DDR4 memory modules are no
> longer standard AT24C02-compatible EEPROMs. They are 512-byte EEPROMs
> which use only 1 I2C address for data access. You need to switch
> between the lower page and the upper page of data by sending commands
> on the SMBus.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
>  drivers/misc/eeprom/Kconfig  |   11 +
>  drivers/misc/eeprom/Makefile |    1
>  drivers/misc/eeprom/ee1004.c |  281 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+)
>

Hi Jean,

is there any reason not to use regmap as is done currently in at24? It
would spare you a lot of code.

Best regards,
Bartosz Golaszewski
