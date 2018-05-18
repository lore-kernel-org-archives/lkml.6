Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeERVMN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:12:13 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:39580 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeERVML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:12:11 -0400
X-Google-Smtp-Source: AB8JxZrA1JhL7Y/wuhn1w5k5YG+2EUc9f81X2ZQygfSRFrv7stBCv4/4MBfhfSDBpw5V3661GivJOcmQnDVinLpluBw=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX878Vun9oCrECA+uW-ErEgzRx8Gp2wLkoLdKXR0nNKAw@mail.gmail.com>
References: <20180518175304.20414-1-labbott@redhat.com> <CAHp75VciKgqYV_DB=h+zaVkk2+dmKJDhT02M4K8T1VGJA6KM0g@mail.gmail.com>
 <CAMuHMdX878Vun9oCrECA+uW-ErEgzRx8Gp2wLkoLdKXR0nNKAw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 19 May 2018 00:12:10 +0300
Message-ID: <CAHp75VezhMm9R64y2A6mobQVqbLMLUKtzxQHp7uRDTBTMMzpRw@mail.gmail.com>
Subject: Re: [PATCHv8] gpio: Remove VLA from gpiolib
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>, Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        Phil Reid <preid@electromag.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 12:05 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, May 18, 2018 at 10:07 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, May 18, 2018 at 8:53 PM, Laura Abbott <labbott@redhat.com> wrote:

>>> +               bits = mask + BITS_TO_LONGS(chip->ngpio);
>>> +               memset(mask, 0, BITS_TO_LONGS(chip->ngpio) * sizeof(*mask));
>>
>> Wouldn't be better
>>
>> bitmap_zero(mask, chip->ngpio);
>>
>> ?
>
> chip->ngpio is never const, so bitmap_zero() would always fall back to
> plain memset().

Yes. But it also much more readable and understandable here.

-- 
With Best Regards,
Andy Shevchenko
