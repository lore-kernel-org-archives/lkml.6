Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeEURbR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:31:17 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35903 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753261AbeEURa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:30:58 -0400
X-Google-Smtp-Source: AB8JxZq9tZkb1/47Ijl3To1Pf+W7v7V3kn/e/fHG95HG7NGatBvpijlHBXHwg3P7CxLBk31Cm1B81A==
Subject: Re: [PATCHv8] gpio: Remove VLA from gpiolib
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>, Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        Phil Reid <preid@electromag.com.au>
References: <20180518175304.20414-1-labbott@redhat.com>
 <CAHp75VciKgqYV_DB=h+zaVkk2+dmKJDhT02M4K8T1VGJA6KM0g@mail.gmail.com>
 <CAMuHMdX878Vun9oCrECA+uW-ErEgzRx8Gp2wLkoLdKXR0nNKAw@mail.gmail.com>
 <CAHp75VezhMm9R64y2A6mobQVqbLMLUKtzxQHp7uRDTBTMMzpRw@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <fc2fb457-57eb-d929-1061-5bc00ee218a8@redhat.com>
Date: Mon, 21 May 2018 10:30:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VezhMm9R64y2A6mobQVqbLMLUKtzxQHp7uRDTBTMMzpRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 02:12 PM, Andy Shevchenko wrote:
> On Sat, May 19, 2018 at 12:05 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Fri, May 18, 2018 at 10:07 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Fri, May 18, 2018 at 8:53 PM, Laura Abbott <labbott@redhat.com> wrote:
> 
>>>> +               bits = mask + BITS_TO_LONGS(chip->ngpio);
>>>> +               memset(mask, 0, BITS_TO_LONGS(chip->ngpio) * sizeof(*mask));
>>>
>>> Wouldn't be better
>>>
>>> bitmap_zero(mask, chip->ngpio);
>>>
>>> ?
>>
>> chip->ngpio is never const, so bitmap_zero() would always fall back to
>> plain memset().
> 
> Yes. But it also much more readable and understandable here.
> 

I wasn't aware of that API. I'll switch to that.
