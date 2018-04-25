Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524648823; cv=none;
        d=google.com; s=arc-20160816;
        b=LIzVZEc1UKwm+FtjN7hhmv57K0fM9J66S8zt5Jt3pYHxxNeY2930i21wNS2WCGPJeC
         NmHCmkUwKN3T9jukFLllKmeIGkzg03kkpezqEoaUKCuXVMzB8f1RBmCBSSwMWHaIGjMx
         JWNmnpHYKB/slQGOJ4E0j57xrkpe5D89L+AY1aw4mYaHHnKD7nngtX/9ahgWILcdygtQ
         cqbm8ON9vFTlp03wwxZZb515lI5CdZ8JyMX7D0t3gfWoVifWmtDFCdeW34VvQ6VhhGKc
         NedxO+v02Ea0cqpekTXlRPkC2A+l9Xc/Ig6F+f23aoNlBXFEMsdQes0HnpT/5P9U+yDP
         YGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Jle9oAkruTMX9FHJzTpZhZvz2zJME9FDQImUaQw6NNI=;
        b=KcG7uysa4dBxOgLyY835gQ4WXJ1VLLzA4D8FSPXsipdlkPpwAxd4dajwuINsBEkUMF
         Q7mxu14YnSoLSbS/iqMTgVk6xruNA3/ADC8gfwxIFCsOL2FhNegGAlbxjavkeuHZzLWe
         9ukdpupsDXgFoLPdL+4+skOuaxwSYc8IVeS1l2Gg+AS2p6iJ9RcsCVQ+H6OsPl4qrmnb
         vYfagPCIDdjuZUGcWoqX48FYsXdgtg4gPG1/EdQuyO3DyaiZHw3qbenrrTKPXUbF2wXo
         Irvr7OIFd6+zbpRvTECQ44kaAkvs/m/NQzLrS2vtNTGrGXIph0ruPmDTSJBuuuCzHzfj
         lsWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=I6qORGPq;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=I6qORGPq;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx4/t891qjikuNWVB2KB4Egi2t28b+dR0yWgKfpKY3Goybco2hPvtHmbJcM96YqbV9KdTS0VMG6mjv+2PUCuOPZ4=
MIME-Version: 1.0
In-Reply-To: <20180424175752.GC3094@brightrain.aerifal.cx>
References: <20180424173051.15099-1-brgl@bgdev.pl> <20180424175752.GC3094@brightrain.aerifal.cx>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 25 Apr 2018 11:33:42 +0200
Message-ID: <CAMRc=Mcs4zR4oA3duX7z05x-5ZFfFteFx93Fm-s9gX+tU5vpsg@mail.gmail.com>
Subject: Re: [PATCH 00/11] platform: device tree support for early platform drivers
To: Rich Felker <dalias@libc.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
	Frank Rowand <frowand.list@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649607100825317?=
X-GMAIL-MSGID: =?utf-8?q?1598710165070627537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-24 19:57 GMT+02:00 Rich Felker <dalias@libc.org>:
> On Tue, Apr 24, 2018 at 07:30:40PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Device tree based systems often use OF_DECLARE() macros for devices
>> that need to be initialized early in the boot process such as clocks,
>> timers etc. However platform devices are more desirable.
>>
>> This series aims at introducing support for early platform drivers for
>> OF-based systems.
>>
>> The idea is to have a special compatible fallback string: "earlydev"
>> that similarily to "syscon" would be added to device nodes that need
>> early probing. We then need to call of_early_platform_populate() early
>> in the boot process to actually probe the registered devices.
>
> This makes no sense to me. It's not the device tree that should
> contain the knowledge that these need to be registered/probed early in
> the boot. That need is a property of the operating system/device
> drivers, and so the *drivers* should be the ones that contain the
> knowledge.
>
>> I am aware that this new compatible does not strictly correspond with
>> the "hardware description only" rule of DT, but we already have many
>> functionalities that break this rule: syscon, gpio hogs etc.
>>
>> The first user of this new functionality will be the DaVinci platform
>> for which we want to probe the pll, psc and timer drivers early in the
>> boot sequence but keep them implemented as platform drivers.
>>
>> In the future, if this series gets accepted, this could become and
>> alternative to TIMER_OF_DECLARE, CLK_OF_DECLARE etc. and could lead
>> to deprecating of those macros in favor of early platform drivers.
>
> This seems completely unacceptable, in that it would render new
> kernels unable to boot on existing device trees (which may be
> hard-coded in rom on existing devices).
>

Just ot make it clear: by deprecating I meant not accepting any new
users, not blindly replacing the current ones.

Thanks,
Bart
