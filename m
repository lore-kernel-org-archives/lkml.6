Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755078AbeE2Hqb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:46:31 -0400
Received: from zoot.epublica.de ([78.46.103.157]:40384 "EHLO zoot.epublica.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754920AbeE2Hq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:46:28 -0400
Subject: Re: [PATCH] HID: Add support for 146b:0902 Bigben Interactive Kids'
 gamepad
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <31245206-038e-4a5b-a1a1-8877463556a7@hanno.de>
 <CAEc3jaB7jPJ_xa5rFrunwcPgkG9VrCdJSbb=BrQsHKxrO9AixQ@mail.gmail.com>
From: Hanno Zulla <abos@hanno.de>
Message-ID: <729f18bc-65b7-9bfd-50ed-fbb1f168500d@hanno.de>
Date: Tue, 29 May 2018 09:46:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAEc3jaB7jPJ_xa5rFrunwcPgkG9VrCdJSbb=BrQsHKxrO9AixQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roderick,
Hi Benjamin,

thanks for the review!

> In terms of code style, I noticed a lot of C++ style comments which> are not part of the kernel code style instead use C comments. To
check> for potential other issues as well, run your patch through>
'scripts/checkpatch.pl'.

Okay, will check with that.

> I noticed you fixed up reported descriptors a bit to get axes remapped
> in a different way. This is reasonable as the default mappings are
> often not good. However, I would suggest use the mapping functions
> instead (e.g. see hid-sony.c and other drivers). It also allows you to
> properly remap buttons as well. I suspect the current button mapping
> is all over the place as well. Make sure axis and button mapping
> complies to the Linux gamepad spec (see
> Documentation/input/gamepad.rst).

The main reason for the fixup was to cleanup the output part of the
descriptor, as the device's original descriptor seemed to use
nonsensical/undefined "Usage" values.

Those two axis remappings were the only two necessary. The rest of the
mappings are fine and look okay when compared to other drivers that do
not fully adhere to the gamepad spec (e.g. xpad.c also doesn't map my
XBox-Controller's D-Pad to NORTH/EAST/SOUTH/WEST but instead to HAT0 in
the same way as this device does).

I had assumed that using a descriptor fixup and leaving the actual work
to the standard driver was cleaner than meddling with the incoming data
in a mapping function.

Actually, I was researching if I could fix the descriptor so that no
LED/FF-specific code is necessary, but my knowledge of HID was too
limited to achieve that.

> In addition to those comments, please also try to follow the
> submission guidelines

Ah, thank you.

> Also, keep point 9 in mind ("Don't get discouraged - or impatient").

Nah. Don't worry! :-D

Thanks & kind regards,

Hanno
