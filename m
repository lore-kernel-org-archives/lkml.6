Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965098AbeBMOLx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:11:53 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39950 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964935AbeBMOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:11:51 -0500
X-Google-Smtp-Source: AH8x225W1yDk0K27CVHULfBQtCHjORnQq4puR3O0DAVSg3+gAkcYhyRXPhn9JJDmaApQqgkJcd4jHQ==
Subject: Re: [PATCH 1/2] i2c: piix4: Use request_muxed_region
To: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>,
        Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <20180212111041.027edd85@endymion> <20180212185152.GA20877@roeck-us.net>
 <ca8f74c0-c249-7698-21f7-e3ee49cd5516@pr.hu>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d9ed7023-84b3-366c-ac6b-74194aeffc78@roeck-us.net>
Date: Tue, 13 Feb 2018 06:11:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ca8f74c0-c249-7698-21f7-e3ee49cd5516@pr.hu>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 03:48 AM, Böszörményi Zoltán wrote:
> 2018-02-12 19:51 keltezéssel, Guenter Roeck írta:
>> On Mon, Feb 12, 2018 at 11:10:41AM +0100, Jean Delvare wrote:
>>> Hi Guneter,
>>>
>>> Sorry for the delay :(
>>>
>>> On Sat, 30 Dec 2017 08:50:57 -0800, Guenter Roeck wrote:
>>>> Accesses to SB800_PIIX4_SMB_IDX can occur from multiple drivers.
>>>> Use request_muxed_region() to ensure synchronization.
>>>
>>> Which ones? Documenting it, at least in the commit message, would seem
>>> useful. Out of curiosity, have these other drivers been converted to
>>> use request_muxed_region already?
>>>
>> Primarily watchdog, but there is also unprotected initialization code
>> in several locations.
> 
> There are three locations touching the same I/O ports:
> the PCI-USB quirks code (still doesn't use locking AFAIK), i2c-piix4 and
> the sp5100_tco watchdog drivers.
> 

There are a few more in arch code, though probably not all of those (or maybe none ?)
are relevant.

arch/x86/kernel/quirks.c
arch/x86/kernel/early-quirks.c
arch/x86/pci/fixup.c
arch/mips/loongson64/loongson-3/acpi_init.c
drivers/usb/host/pci-quirks.c
drivers/watchdog/sp5100_tco.[ch]
drivers/i2c/busses/i2c-piix4.c

Guenter
