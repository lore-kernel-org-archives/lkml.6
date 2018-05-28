Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934902AbeE1W6B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 18:58:01 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45791 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934027AbeE1W56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 18:57:58 -0400
X-Google-Smtp-Source: AB8JxZo1vFrDONGBrHlC1xyre8LRCvZHDv34zMj+vSZSpaA5gv26yl/98G7kleZphI85bmAB6OZmCrIXCHhzOVJMZAw=
MIME-Version: 1.0
In-Reply-To: <31245206-038e-4a5b-a1a1-8877463556a7@hanno.de>
References: <31245206-038e-4a5b-a1a1-8877463556a7@hanno.de>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Mon, 28 May 2018 15:57:56 -0700
Message-ID: <CAEc3jaB7jPJ_xa5rFrunwcPgkG9VrCdJSbb=BrQsHKxrO9AixQ@mail.gmail.com>
Subject: Re: [PATCH] HID: Add support for 146b:0902 Bigben Interactive Kids' gamepad
To: Hanno Zulla <abos@hanno.de>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanno,

A few suggestions for your patch based on a quick review (had limited time).

In terms of code style, I noticed a lot of C++ style comments which
are not part of the kernel code style instead use C comments. To check
for potential other issues as well, run your patch through
'scripts/checkpatch.pl'.

I noticed you fixed up reported descriptors a bit to get axes remapped
in a different way. This is reasonable as the default mappings are
often not good. However, I would suggest use the mapping functions
instead (e.g. see hid-sony.c and other drivers). It also allows you to
properly remap buttons as well. I suspect the current button mapping
is all over the place as well. Make sure axis and button mapping
complies to the Linux gamepad spec (see
Documentation/input/gamepad.rst).

Thanks,
Roderick

On Wed, May 23, 2018 at 8:57 AM, Hanno Zulla <abos@hanno.de> wrote:
> Hello,
>
> this is a driver for the "BigBen Interactive Kid-friendly Wired
> Controller PS3OFMINIPAD SONY" [1] with USB id 146b:0902. It was
> originally sold as a PS3 accessory and serves as a very nice gamepad for
> Retropie.
>
> With the help of serialusb [2], it was possible to analyze the protocol
> used by the gamepad and fix the missing entries for the descriptor.
>
>
> This is my *first* driver, so please review accordingly.
>
>
> Three things where I'm not sure and hope to hear from you about:
>
> - is that the correct use of hid_validate_values() in bigben_probe()?
>
> - is the error handling in bigben_probe() correct?
>
> - how do I properly test possible suspend/resume scenarios?
>
> Thanks,
>
> Hanno
>
>
> [1]
> <https://www.bigben-interactive.co.uk/bigben-products/gaming-accessories/wired-mini-controller-ps3>
>
> [2] <https://github.com/matlo/serialusb>
