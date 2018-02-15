Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164146AbeBOSHE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:07:04 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38445 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163521AbeBOSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:07:00 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180215180657euoutp0229085d9d33700a5309a1f8786a2bcaed~Tkf2Z7TOI2322623226euoutp02X
X-AuditID: cbfec7f5-b45ff700000028a9-01-5a85cc40a3a4
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
Message-id: <cdb62a71-bb7e-8c62-06bc-ab91c9642e06@partner.samsung.com>
Date: Thu, 15 Feb 2018 19:06:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <d7300e36-392a-18cf-5176-6eaf4c16eb43@denx.de>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTud19ercmvqeyUYrQQepAWWV4wyh7EjYgKEmqVecuLSr7asrIX
        Zlo6NWsZ2SozEpf2nNoyc6ZTWpEyUhKs+chhmbUgLOlhVvNO2H/fOef7zjnf4bCkvJOeySam
        HBDVKUKSkvGhTM9+2hZGteWoFhW8YbiuwhskZyy5T3NXbdkUp9cu5PKHg7isj06CG6kapLji
        MQPB9fX+JLjO+qsM9/n0ScQN3isnOfvDUwzXWtxIR/nyOR1/GH749Sq+trKb4Ev1zyl+vKWI
        4B/re7x4U1MIb3z/geLtXQ0Mf7a2CvEj1cGbp6p8lseJSYkHRXXYilifhJJrb5k0s+KwubKb
        yUQmuRZ5s4DDwVrVQmmRDyvHtxA86SsjpGAEwZXCZjTJyhpykFKhAoGz3+CWvEdwzVnvpUUs
        64c3wK8x7BL44/Xw7mku7eKQeIAEXfPdiU4MjoCBR22EC8vwOmgaPTOBKRwC/T01pAsH4G1w
        4+IgkjjT4ceFXsrV3xtHgta+zJUm8TwY+qajJKyAUzndbjwLau44JxYFXOEFhv5yRnKwFhrP
        F7jd+MGwtdZLwkGQl9tMSIIiBEWll2kpKEHgMLbTEisSWqyvaGmEL+hMl0jXRoBlkHvafUge
        frc63QNWgck8TEsXGiSgts1Gn0PBeg9Deg8Xeg8Xeg8XZYiqQgoxXZMcL2qWpIiHQjVCsiY9
        JT50b2pyNfr/ai/Hrd/rUOPYHgvCLFJOkz0ozFHJaeGgJiPZgoAllf6yr6r/KVmckHFEVKfu
        VqcniRoLCmQppUIWM/eESo7jhQPiPlFME9WTVYL1npmJXui2PusxdcbWjc4tnNaft39JcI1p
        wLEzdsuj/Orb2L40j1mzeulfX2OMbddKwhba2rsgLyJAqzopTztua7TXlCqO9DSMferaaHid
        HTLljjr6W5LQbay7FOjYviNmRon5psW8aXa7MeSYzH49VVjQ9vvPveg5HXHhX8rDjr5xruRH
        lZQmQVg8n1RrhH+WeRRoZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xy7r2Z1qjDL4/4ba41ruQ2WLjjPWs
        FnPOt7BYzOrSteh+JWPR9PItk8XnVU9ZLKb8Wc5kcf/eTyaLy7vmsFm8aWtktHi6bgmzxZ2t
        zWwWR6bsY3Xg82i99JfN49VVR48tK28yecybdYLF49/hfiaPnbPusntsO6DqsfHZcxaPO9f2
        sHn0bVnF6PF5k1wAdxSXTUpqTmZZapG+XQJXxoy5t9kK9opX7F15k62BcZtQFyMnh4SAiUTT
        i8fMILaQwBJGicsvkrsYuYDsZ4wSB88uYO1i5OAQFvCW+PVHAKRGRMBT4uH+DlaQGmaBJ8wS
        h/duY4FoeM4kcW72C3aQKjYBc4lH288wgdi8Am4SB761g9ksAqoSD+5uBtsmKhAh0blyPgtE
        jaDEj8n3WECWcQpYS3TdMQMxmQXUJaZMyQWpYBYQl2huvckCYctLbF7zlnkCo8AsJM2zEDpm
        IemYhaRjASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMCI23bs5+YdjJc2Bh9iFOBgVOLh
        3dDbGiXEmlhWXJl7iFGCg1lJhPdjFFCINyWxsiq1KD++qDQntfgQozQHi5I473mDyighgfTE
        ktTs1NSC1CKYLBMHp1QDY/Qjhfcxu7htzTQUsp859c1vZe3/Y703WCtt15NMCauZMvmtATeW
        7LlX3n/w6CS/tLp/QaxPv0y5fT/bMyEsw/i8ssv3srce6hW2gsxdMn6zJ25Q6rk7KVLiyNvO
        H2F3r3V/+RT1NzNxW6TbTudbSz28PvlckFK0lGNij2P5plrwWj3v0ozHSizFGYmGWsxFxYkA
        ow414rQCAAA=
X-CMS-MailID: 20180215180655eucas1p16a614dbbebc375fcfd148d5a8ecaf02b
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
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.2018 18:06, Marek Vasut wrote:
> On 02/15/2018 06:00 PM, Kamil Konieczny wrote:
>>
>>
>> On 15.02.2018 17:27, Marek Vasut wrote:
>>> On 02/15/2018 04:41 PM, Herbert Xu wrote:
>>>> On Thu, Jan 18, 2018 at 07:33:59PM +0100, Kamil Konieczny wrote:
>>>>> First four patches add empty hash export and import functions to each driver,
>>>>> with the same behaviour as in crypto framework. The last one drops them from
>>>>> crypto framework. Last one for ahash.c depends on all previous.
>>>>>
>>>>> Changes in v3:
>>>>> added change for bfin_crc.c
>>>>> make this a patchset, instead of unreleated patches
>>>>> make commit message more descriptive
>>>>>
>>>>> Kamil Konieczny (5):
>>>>>   crypto: mxs-dcp: Add empty hash export and import
>>>>>   crypto: n2_core: Add empty hash export and import
>>>>>   crypto: ux500/hash: Add empty export and import
>>>>>   crypto: bfin_crc: Add empty hash export and import
>>>>>   crypto: ahash.c: Require export/import in ahash
>>>>>
>>>>>  crypto/ahash.c                        | 18 ++----------------
>>>>>  drivers/crypto/bfin_crc.c             | 12 ++++++++++++
>>>>>  drivers/crypto/mxs-dcp.c              | 14 ++++++++++++++
>>>>>  drivers/crypto/n2_core.c              | 12 ++++++++++++
>>>>>  drivers/crypto/ux500/hash/hash_core.c | 18 ++++++++++++++++++
>>>>>  5 files changed, 58 insertions(+), 16 deletions(-)
>>>>
>>>> All applied.  Thanks.
>>>
>>> This makes no sense, cfr my comment on 5/5
>>>
>>> Seems like if the driver doesn't implement those, the core can easily
>>> detect that and perform the necessary action. Moving the checks out of
>>> core seems like the wrong thing to do, rather you should enhance the
>>> checks in core if they're insufficient in my opinion.
>>
>> The bug can only be in driver which will not implement those two functions,
>> but we already had all drivers with those due to patches 1..4
>> All other drivers do have them.
> 
> The core can very well check if these functions are not populated and
> return ENOSYS
> 
>> Additionally, with crypto we want minimize code and run as fast as possible.
> 
> So you remove all NULL pointer checks ? Esp. in security-sensitive code?
> What is the impact of this non-critical path code on performance?
> 
> Come on ...
> 

Why you want checks for something that not exist ?

Those without them will not work and will do Oops in crypto testmgr,
so such drivers should not be used nor accepted in drivers/crypto

Ask yourself why crypto do not check for NULL in ahash digest or other
required ahash functions.

>> Moving checks out of core will impose on driver author need for implement
>> those functions, or declare them empty, but in case of empty ones 
>> crypto will not work properly with such driver.
> 
> You can very well impose that in the core, except you don't duplicate
> the code.

Now size of crypto core is reduced.

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland
