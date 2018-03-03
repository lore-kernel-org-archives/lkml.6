Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeCCSXD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 13:23:03 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:42706 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeCCSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 13:23:01 -0500
X-Google-Smtp-Source: AG47ELtCnjR8IPbWmonVBj/zkKB8/Fod2OQlYrB/YbMePVl2gFYWPi0Nd6D0VJHcH0RRfX/GoW4CyPJzxIiGSoQh27U=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KST+RcRxnYCPKN5yQCr7vfMZUL3TTytFJ+Ad0B_Au4DVw@mail.gmail.com>
References: <20180302074424.2myh3zhxnbpaohjq@gmail.com> <20180302134453.mtd4uepeiviicyef@huvuddator>
 <20180302231256.4aevdu2b5ylyrzkr@gmail.com> <CAFkk2KST+RcRxnYCPKN5yQCr7vfMZUL3TTytFJ+Ad0B_Au4DVw@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sat, 3 Mar 2018 19:23:00 +0100
Message-ID: <CAFkk2KSPFL6aPNwD5Xsg9bzTHC3GSjYaUrOtvbEq=CJhm1tEKA@mail.gmail.com>
Subject: Re: [PATCH] scripts/kconfig: replace single character strcat() appends
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnaud Lacombe <lacombar@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 3, 2018 at 7:14 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Sat, Mar 3, 2018 at 12:12 AM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
>> On Fri, Mar 02, 2018 at 02:44:53PM +0100, Ulf Magnusson wrote:
>>> Not sure this is an improvement. Zeroing the bytes after the initial
>>> null terminator is redundant, and the explicit '\0' makes it clearer to
>>> me what's going on.
>>
>> Yes, I agree with you, that is definitely quite true. This along with
>> the other comments you made me want to rethink this a little bit.
>>
>> On Fri, Mar 02, 2018 at 02:44:53PM +0100, Ulf Magnusson wrote:
>>> I like the approach, but I wonder if we can take it a bit further.
>>> Here's what I'd do:
>>>
>>>       1. Rename the 'in' parameter to 's'.
>>>       2. Rename 'p' to 'in'.
>>>       3. Rename 'end' to 'out'
>>>
>>> At that point, you're reading from 'in' and writing to 'out', which
>>> seems pretty nice and readable.
>>>
>>> This code is pretty cold by the way, so it wouldn't matter for
>>> performance. GCC knows how functions like strcat() work too, and uses
>>> that to optimize (see
>>> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html).
>>>
>>> I'm all for trying to make Kconfig's code neater though.
>>
>> Since this code is pretty cold (completely agree with you there), I
>> think it would actually be much more useful to rework my patch to
>> have a more style-centric approach rather than an optimization-centric
>> one; this code would definitely benefit from being neater.
>
> I actually prefer the memcpy() version for style reasons, even though
> it might've looked like an optimization:
>
> With strncat(), the result string is written via both 'res' and 'end'.
> With memcpy(), it's only written via the 'end'. That seems less
> twisty.
>
> Maybe this is outside the scope of the original patch, but while we're here. :)
>
>>
>> Some useful changes would be to rename of the _atrociously_ short
>> identifiers like p and l.
>
> Yeah, 'l' in particular isn't the best name, IMO ('len' is both short
> and explicit, and won't be confused for 1). 'p' can be fine if it's
> obvious in context (bit dubious here), but 'in' and 'out' (for 'end')
> would be more informative.

Another alternative: src/dst

>
> 's' is clear from convention to me. In general, I fully agree that you
> should avoid hard-to-guess names though.
>
>>
>> Anyway I'll give that link a read over and try and make a V2 later
>> on today.
>>
>> Appreciate the feedback, thanks for the comments!
>>
>> --
>> Cheers,
>> Joey Pabalinas
>
> Cheers,
> Ulf

Cheers,
Ulf
