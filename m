Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeEBLvN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:51:13 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33129 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeEBLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:51:10 -0400
X-Google-Smtp-Source: AB8JxZp5E/hf1VGT2sWyszYu+hnDZWr8UXLZJdHK8G2tIEBi3Iw1omEZdLP3EQD1CY3BzogUt4XfQMSLQVj/E0YM8Rw=
MIME-Version: 1.0
In-Reply-To: <CAMRc=Me2YD49VkwENwFmRUHGDYzPc_80b6uABUvi7_QeeoMrrQ@mail.gmail.com>
References: <20180410203028.11412-1-brgl@bgdev.pl> <CACRpkda+K3-=sPpJO90rjW0=+bsQ1uYT6E9Hp+G+-OEyTpc=fg@mail.gmail.com>
 <CAMRc=Me2YD49VkwENwFmRUHGDYzPc_80b6uABUvi7_QeeoMrrQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 13:51:09 +0200
Message-ID: <CACRpkdbbCKkzCq1S86OTwjrZ4SQFFPAg92qgbzt2U2QaqEwZaw@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: add hogs support for machine code
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 6:42 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2018-04-26 14:07 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Tue, Apr 10, 2018 at 10:30 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>>> Board files constitute a significant part of the users of the legacy
>>> GPIO framework. In many cases they only export a line and set its
>>> desired value. We could use GPIO hogs for that like we do for DT and
>>> ACPI but there's no support for that in machine code.
>>>
>>> This patch proposes to extend the machine.h API with support for
>>> registering hog tables in board files.
>>>
>>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>>> ---
>>> v1 -> v2:
>>> - kbuild bot complains about enum gpiod_flags having incomplete type
>>>   although it builds fine for me locally: change the type of dflags
>>>   to int
>>
>> I like the idea and thinking behind this patch, so patch applied.
>>
>> It's a bit of code to carry, so if it doesn't see any use, I will simply
>> revert it :)
>>
>> But I bet you intend to follow up with some machine patches
>> and then it is immediately worth it.
>
> Yes, I'll be submitting patches removing the legacy gpio calls for
> boards in mach-davinci.

Awesome, thanks!

(I guess they should all be converted to device tree though, hope that
will happen...)

Yours,
Linus Walleij
