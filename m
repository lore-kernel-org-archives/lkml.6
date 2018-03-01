Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032848AbeCAQOI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:14:08 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45573 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032580AbeCAQOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:14:07 -0500
X-Google-Smtp-Source: AG47ELuux6tMqv+BLTN4wvQFG57RZulj6kLU0v8Xk9IRbLgVbGmt4FkzQg8k64D6mHCpOiMKuPznxA==
Subject: Re: [PATCH] of: Kconfig: OF_OVERLAY, select OF_EARLY_FLATTREE
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1519000156-14319-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqLa83SKe5vbCkU8pwjPzBszsHrWQEA-ThMMciMwLO1XmA@mail.gmail.com>
 <300becd6-db35-59e6-1b81-6b1940070df0@gmail.com>
 <CAL_Jsq+BBHT3AyNeHWJe22KioC9s3Jm1d4pydVQLJA6jKoTGXA@mail.gmail.com>
 <d0e5e07b-cdf8-0cbc-d073-7f8982433c7f@gmail.com>
Message-ID: <449f7ec6-e07b-7787-92c2-55b9404baa1c@gmail.com>
Date: Thu, 1 Mar 2018 08:14:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d0e5e07b-cdf8-0cbc-d073-7f8982433c7f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/18 13:44, Frank Rowand wrote:
> On 02/28/18 12:26, Rob Herring wrote:
>> Sorry for the delay, been away for a few days.
>>
>> On Mon, Feb 19, 2018 at 12:24 AM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 02/18/18 17:46, Rob Herring wrote:
>>>> On Sun, Feb 18, 2018 at 6:29 PM,  <frowand.list@gmail.com> wrote:
>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>
>>>>> kbuild test robot reported a new warning for a recent patch:
>>>>>>> drivers/of/overlay.c:832:2: error: implicit declaration of function 'of_fdt_unflatten_tree' [-Werror=implicit-function-declaration]
>>>>>      of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
>>>>>
>>>>> The cause is that the prototype for of_fdt_unflatten_tree() in
>>>>> include/linux/of_fdt.c is guarded by OF_EARLY_FLATTREE.
>>
>> Umm, this is not true. of_fdt_unflatten_tree is outside the ifdef for
>> OF_EARLY_FLATTREE.
> 
> Brown paper bag.  :-(  As you note below, CONFIG_OF_FLATTREE is the
> relevant option.


< snip >

> function, so it seems all is OK from that angle.  But all use of overlays 
> for many previous releases requires manually selecting OF_FLATTREE, given
> that FDTs have been the overlay source.

I was not correct about needing to manually select OF_FLATTREE.  For
the unittest of overlays, which did the overlay unflattening, OF_UNITTEST
selected (selects until my other patch series) OF_EARLY_FLATTREE, which
selects OF_FLATTREE.

-Frank
