Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeBLSpa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:45:30 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:38971 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeBLSp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:45:28 -0500
X-Google-Smtp-Source: AH8x224XFuo3Ix6lHckUgEhWExuDkGIut3jX5U85aQFNRmfBlNfh/MjC77npzJvysZytOrFxm05K7ouJo7n+kLm2fMA=
MIME-Version: 1.0
In-Reply-To: <275feee3-7140-498b-714f-4c88a302d3f6@embeddedor.com>
References: <20180207160002.GA9292@embeddedgus> <CAKv+Gu9hmxLSS0ekr8av-ADt3OQjBV=Bt-hRq_-SzWaGODs4SQ@mail.gmail.com>
 <275feee3-7140-498b-714f-4c88a302d3f6@embeddedor.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 12 Feb 2018 18:45:27 +0000
Message-ID: <CAKv+Gu9VTkNN-6MCCuQ2jWFyDMeZKNRyPqMpTWB5jvuSw7MWeA@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 February 2018 at 18:04, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> Hi Ard,
>
> On 02/08/2018 03:54 AM, Ard Biesheuvel wrote:
>>
>> On 7 February 2018 at 16:00, Gustavo A. R. Silva <gustavo@embeddedor.com>
>> wrote:
>>>
>>> Add suffix ULL to constant 9 in order to give the compiler complete
>>> information about the proper arithmetic to use. Notice that this
>>> constant is used in a context that expects an expression of type
>>> unsigned long long (64 bits, unsigned).
>>>
>>> The expression tfr->len * 9 * 1000000 is currently being evaluated
>>> using 32-bit arithmetic.
>>>
>>> Addresses-Coverity-ID: 1339619
>>
>>
>> What does this number mean? If it is an index into some internal
>> database, please remove it.
>>
>
> This is a unique Coverity identifier. We want to keep information like
> public Bugzilla IDs and tools like Coverity on the commit message.
>

Who is 'we' in this case? And how is this id to any benefit of other
people that have been excluded from 'we'?

If you add identifiers like this, make sure that they don't only make
sense to the in-crowd. For instance, you could replace this with a
http link to the database entry if you really must.
