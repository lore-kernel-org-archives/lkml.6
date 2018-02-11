Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbeBKWDY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 17:03:24 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42716 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbeBKWDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 17:03:22 -0500
X-Google-Smtp-Source: AH8x225Stc9AibnLaX8jx1jw5l1mv4FJxvKYgYHY7k31hTD5DCIw0nYXt15Ew0ajElngN6uztFSI8w==
Date: Sun, 11 Feb 2018 23:03:17 +0100
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu,
        Jochen Eisinger <jochen@penguin-breeder.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com,
        Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Message-ID: <20180211220317.GA833@kmp-mobile.hq.kempniu.pl>
References: <20180127133209.28995-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180127133209.28995-1-pali.rohar@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Dell platform team told us that some (DMI whitelisted) Dell Latitude
> machines have ST microelectronics accelerometer at i2c address 0x29.
> 
> Presence of that ST microelectronics accelerometer is verified by existence
> of SMO88xx ACPI device which represent that accelerometer. Unfortunately
> ACPI device does not specify i2c address.
> 
> This patch registers lis3lv02d device for selected Dell Latitude machines
> at i2c address 0x29 after detection. And for Dell Vostro V131 machine at
> i2c address 0x1d which was manually detected.
> 
> Finally commit a7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to
> conflict with PCI BAR") allowed to use i2c-i801 driver on Dell machines so
> lis3lv02d correctly initialize accelerometer.
> 
> Tested on Dell Latitude E6440.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> ---
> Changes since v1:
>  * Added Dell Vostro V131 based on Michał Kępień testing

I tested this patch on a Vostro V131 and it seems to work as expected:
"lis3lv02d: 8 bits sensor found" is logged during boot, an input device
gets registered and its axis values seem to be consistent with laptop's
movements.

Tested-by: Michał Kępień <kernel@kempniu.pl>

I did not review the contents of the patch this time, sorry.

-- 
Best regards,
Michał Kępień
