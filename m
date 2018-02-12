Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbeBLTOd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:14:33 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41677 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeBLTOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:14:30 -0500
X-Google-Smtp-Source: AH8x226J+3GbcvOPSEAPGoOAxIS2wQ3AF2QuhmO5v7XD4Guv0drHzthuWYiJz3hz5YhCzon2YrHi9Q==
Subject: Re: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-spi@vger.kernel.org
References: <20180207160002.GA9292@embeddedgus>
 <CAKv+Gu9hmxLSS0ekr8av-ADt3OQjBV=Bt-hRq_-SzWaGODs4SQ@mail.gmail.com>
 <275feee3-7140-498b-714f-4c88a302d3f6@embeddedor.com>
 <CAKv+Gu9VTkNN-6MCCuQ2jWFyDMeZKNRyPqMpTWB5jvuSw7MWeA@mail.gmail.com>
 <bab99bbb-c84b-3413-e7f8-203c7daad8b3@gmail.com>
 <CAKv+Gu9Mb7Wpzwvr=1WsUs1jXYT16DL2dYBfhSWH0HYZMYM5Nw@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f93d501d-4aaf-9504-aeb0-944dc8797ce3@gmail.com>
Date: Mon, 12 Feb 2018 11:14:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9Mb7Wpzwvr=1WsUs1jXYT16DL2dYBfhSWH0HYZMYM5Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 11:11 AM, Ard Biesheuvel wrote:
> On 12 February 2018 at 19:10, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 02/12/2018 10:45 AM, Ard Biesheuvel wrote:
>>> On 12 February 2018 at 18:04, Gustavo A. R. Silva
>>> <garsilva@embeddedor.com> wrote:
>>>> Hi Ard,
>>>>
>>>> On 02/08/2018 03:54 AM, Ard Biesheuvel wrote:
>>>>>
>>>>> On 7 February 2018 at 16:00, Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>>> wrote:
>>>>>>
>>>>>> Add suffix ULL to constant 9 in order to give the compiler complete
>>>>>> information about the proper arithmetic to use. Notice that this
>>>>>> constant is used in a context that expects an expression of type
>>>>>> unsigned long long (64 bits, unsigned).
>>>>>>
>>>>>> The expression tfr->len * 9 * 1000000 is currently being evaluated
>>>>>> using 32-bit arithmetic.
>>>>>>
>>>>>> Addresses-Coverity-ID: 1339619
>>>>>
>>>>>
>>>>> What does this number mean? If it is an index into some internal
>>>>> database, please remove it.
>>>>>
>>>>
>>>> This is a unique Coverity identifier. We want to keep information like
>>>> public Bugzilla IDs and tools like Coverity on the commit message.
>>>>
>>>
>>> Who is 'we' in this case? And how is this id to any benefit of other
>>> people that have been excluded from 'we'?
>>
>> We is probably the greater Linux community here.
>>
>>>
>>> If you add identifiers like this, make sure that they don't only make
>>> sense to the in-crowd. For instance, you could replace this with a
>>> http link to the database entry if you really must.
>>
>> I don't think it is that easy to extract good URLs from the public Linux
>> coverity instance which is why referring to coverity IDs is being done
>> AFAICT.
> 
> Ah ok, pardon my ignorance then. I wasn't aware there is a public
> Linux coverity instance. Got a link?

It requires you to sign up to get notifications and have a dashboard,
does this link work for you?

https://scan.coverity.com/projects/linux?tab=overview
-- 
Florian
