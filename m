Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757776AbeBPJQl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:16:41 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47022 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757760AbeBPJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:16:38 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180216091636euoutp0246762172a03f2ce4eb698be078f40c7f~Tw6EjxObH3234532345euoutp02R
X-AuditID: cbfec7f4-b4fc79c0000043e4-ce-5a86a1707466
Subject: Re: [PATCH v3 0/5] crypto: ahash.c: Require export/import in ahash
To: Marek Vasut <marex@denx.de>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sonic Zhang <sonic.zhang@analog.com>,
        Fabio Estevam <fabio.estevam@freescale.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-id: <77b4e0a0-0e2c-af7a-690e-4d516d616717@partner.samsung.com>
Date: Fri, 16 Feb 2018 10:16:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <14364c45-8f56-e6d6-66f2-8357bf89a894@denx.de>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+3bOmWfW8njMfDHRmAoZaTehA6UkSB3xT78q98NaelJR59jU
        LtDF8paXVnPehoVCpJl5a1pZqc2hRi2p4UhTK0VLa5DNSk0tt6Pgv+fle14+no+PxGgz4Ukm
        yFM5pVyWJBE6463dc32Biqps6S7TU3fGUliFMU1lDQRT0ZeJM7q8QCZ/you5MmkVMLbacZzR
        LlQLmI8jcwLG3FYhZL5nZyBmvP4Oxgy1XBUyRm07cXAjm/VuUchO9Yex+nsDAva2rhdnl7rU
        AvaJbtiJbe30Z5smvuDskOWZkL2ur0Wsrdn7yHqp84FYLikhnVPuDD3pHG/VTGCKBp+zBbP0
        ZfQT8pCIBCoYcqy9TnnImaSpGgSTOeUYP9gQvKy2CFctY6dmxbqLYOJ+JcEPEwiMesvyCkm6
        UZEwv0DZFzZREfC5I9fhYNQoBpoXD5D9QEjtg9FHrwV2FlOH4PdihoNxyh/6r807HHfqOFQV
        jyPecYXZohHcziJqP3z/kE/YGaMC4OuMBufZA65mDaywDzysszoSgLrrBKWNFgGfEA5arQnj
        2Q2mevROPHuBuSgf5xfUCNS3ywl+KEMw1mQieGs/dPW8Xbl6I2haSx3JQIkhN5vmFRb+Gq2I
        5zBofT618kRmDJozzNgN5K1bU6RbU6FbU6FbU1GJ8FrkwaWpkuM41R45dyZIJUtWpcnjgmJS
        kpvR8ld7tdQz8xi1LZwyIIpEkg3ixsIsKU3I0lXnkg0ISEyySTxYmi2lxbGyc+c5ZcoJZVoS
        pzKgLSQu8RBHb7sopak4WSqXyHEKTrl6KiBFnpfRDtObwkn3DnU0s8iKUl1dougR3+3PswxJ
        KfqggZBfBcLggljjvx9pNu7mV+8/mSXhRTGFEdWpty6FfAsIqnkfEbx1xCYf00bVl/jSxPR0
        Q/cdXd5h6acf5oh+sy3mnZtyc2hiXaLtUnd7acGg3sXvtEIdeVR+zLbOr+VCWPHwXgmuipft
        3o4pVbL/qVxU6WYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xq7p5C9uiDI5Ot7K41ruQ2WLjjPWs
        FnPOt7BYzOrSteh+JWPR9PItk8XnVU9ZLKb8Wc5kcf/eTyaLy7vmsFm8aWtktHi6bgmzxZ2t
        zWwWR6bsY3Xg82i99JfN49VVR48tK28yecybdYLF49/hfiaPnbPusntsO6DqsfHZcxaPO9f2
        sHn0bVnF6PF5k1wAdxSXTUpqTmZZapG+XQJXxttJz5gL1stX9PwQamD8JNHFyMkhIWAiceTA
        JPYuRi4OIYEljBJb+x+wQTjPGCUOr7sOlOHgEBbwlvj1RwCkQUTAU+Lh/g5WkBpmgSfMEof3
        bmOBaLjKLLHj5xVGkCo2AXOJR9vPMIHYvAJuEt/+NoLZLAKqElc7f4HViApESHSunM8CUSMo
        8WPyPTCbU8Ba4s3tblaQxcwC6hJTpuSChJkFxCWaW2+yQNjyEpvXvGWewCgwC0n3LISOWUg6
        ZiHpWMDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw5rYd+7llB2PXu+BDjAIcjEo8vBt6
        W6OEWBPLiitzDzFKcDArifDemt4WJcSbklhZlVqUH19UmpNafIhRmoNFSZz3vEFllJBAemJJ
        anZqakFqEUyWiYNTqoHRUnLXlrs37h4VY2wsLWMp0U1VPjbXZ6eA620vJ1+Wsqv/kmrcQiYr
        tm+ofKthp71G7WVMf/Bfddm78Xouddtl2Df2Xja+917t5K6ld0T9am/IXPn4+iqD0H3py5J/
        3YPNOowDNxy667ampkrrEF/Tvqw/YsnnEudEub97YynD+373SYdZQblKLMUZiYZazEXFiQDq
        rprZtQIAAA==
X-CMS-MailID: 20180216091631eucas1p1e7b2cbe2e730580dc1b4e1c33599e1fe
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180118183438eucas1p2e2e7be8625ae0950c519e27424f9301a
X-RootMTR: 20180118183438eucas1p2e2e7be8625ae0950c519e27424f9301a
References: <CGME20180118183438eucas1p2e2e7be8625ae0950c519e27424f9301a@eucas1p2.samsung.com>
        <20180118183404.12583-1-k.konieczny@partner.samsung.com>
        <20180215154132.GA7352@gondor.apana.org.au>
        <6b29116a-c39c-9813-34a0-d5c05bd30c9d@denx.de>
        <32069edc-e816-6ab0-f057-b1dab5d30db4@partner.samsung.com>
        <d7300e36-392a-18cf-5176-6eaf4c16eb43@denx.de>
        <cdb62a71-bb7e-8c62-06bc-ab91c9642e06@partner.samsung.com>
        <14364c45-8f56-e6d6-66f2-8357bf89a894@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.02.2018 19:32, Marek Vasut wrote:
> On 02/15/2018 07:06 PM, Kamil Konieczny wrote:
>>
>>
>> On 15.02.2018 18:06, Marek Vasut wrote:
>>> On 02/15/2018 06:00 PM, Kamil Konieczny wrote:
>>>>
>>>>
>>>> On 15.02.2018 17:27, Marek Vasut wrote:
>>>>> On 02/15/2018 04:41 PM, Herbert Xu wrote:
>>>>>> On Thu, Jan 18, 2018 at 07:33:59PM +0100, Kamil Konieczny wrote:
>>>>>>> First four patches add empty hash export and import functions to each driver,
>>>>>>> with the same behaviour as in crypto framework. The last one drops them from
>>>>>>> crypto framework. Last one for ahash.c depends on all previous.
>>>>>>>
>>>>>>> Changes in v3:
>>>>>>> added change for bfin_crc.c
>>>>>>> make this a patchset, instead of unreleated patches
>>>>>>> make commit message more descriptive
>>>>>>>
>>>>>>> Kamil Konieczny (5):
>>>>>>>   crypto: mxs-dcp: Add empty hash export and import
>>>>>>>   crypto: n2_core: Add empty hash export and import
>>>>>>>   crypto: ux500/hash: Add empty export and import
>>>>>>>   crypto: bfin_crc: Add empty hash export and import
>>>>>>>   crypto: ahash.c: Require export/import in ahash
>>>>>>>
>>>>>>>  crypto/ahash.c                        | 18 ++----------------
>>>>>>>  drivers/crypto/bfin_crc.c             | 12 ++++++++++++
>>>>>>>  drivers/crypto/mxs-dcp.c              | 14 ++++++++++++++
>>>>>>>  drivers/crypto/n2_core.c              | 12 ++++++++++++
>>>>>>>  drivers/crypto/ux500/hash/hash_core.c | 18 ++++++++++++++++++
>>>>>>>  5 files changed, 58 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> All applied.  Thanks.
>>>>>
>>>>> This makes no sense, cfr my comment on 5/5
>>>>>
>>>>> Seems like if the driver doesn't implement those, the core can easily
>>>>> detect that and perform the necessary action. Moving the checks out of
>>>>> core seems like the wrong thing to do, rather you should enhance the
>>>>> checks in core if they're insufficient in my opinion.
>>>>
>>>> The bug can only be in driver which will not implement those two functions,
>>>> but we already had all drivers with those due to patches 1..4
>>>> All other drivers do have them.
>>>
>>> The core can very well check if these functions are not populated and
>>> return ENOSYS
>>>
>>>> Additionally, with crypto we want minimize code and run as fast as possible.
>>>
>>> So you remove all NULL pointer checks ? Esp. in security-sensitive code?
>>> What is the impact of this non-critical path code on performance?
>>>
>>> Come on ...
>>>
>>
>> Why you want checks for something that not exist ?
>>
>> Those without them will not work and will do Oops in crypto testmgr,
>> so such drivers should not be used nor accepted in drivers/crypto
>>
>> Ask yourself why crypto do not check for NULL in ahash digest or other
>> required ahash functions.
> 
> Are you suggesting that the kernel code should NOT perform NULL pointer
> checks ?
> 
> Are you suggesting each driver should implement every single callback
> available and if it is not implemented, return -ENOSYS ? This looks like
> a MASSIVE code duplication.

It is source code duplication. One do not load all crypto drivers at once,
simple because one board has only one crypto HW (or few closely related),
and if one even try, almost none of them will initialize on given
hardware. E.g. on Exynos board only exynos drivers will load, on board with
omap crypto only omap crypto will load.
 
>>>> Moving checks out of core will impose on driver author need for implement
>>>> those functions, or declare them empty, but in case of empty ones 
>>>> crypto will not work properly with such driver.
>>>
>>> You can very well impose that in the core, except you don't duplicate
>>> the code.
>>
>> Now size of crypto core is reduced.
> 
> You implemented the same code thrice, it surely is not reduced.

As I said above, it reduces binary size at cost of more source code in few drivers.

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland
