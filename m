Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeE2FRy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:17:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48128 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeE2FRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:17:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180529051748euoutp02bffdf664eb84ad8fe606ee7d6ff2d1e2~zBcsXvjie2746427464euoutp02X
X-AuditID: cbfec7f4-713ff700000043e4-51-5b0ce27a0491
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Vinod <vkoul@kernel.org>
Cc: Frank Mori Hess <fmh6jj@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Tue, 29 May 2018 07:17:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180518072112.GG2932@vkoul-mobl>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87pVj3iiDdY8ELDYOGM9q8X0qRcY
        LVZP/ctqMf/xXDaL8+c3sFtc3jWHzWLG+X1MFnf/fWK02HnnBLMDp8fOWXfZPY7sPMbmsXjP
        SyaPTas62Tz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoErY9mqlYwFB9kqjn6dy9rA2MPaxcjJ
        ISFgIrHwyXG2LkYuDiGBFYwSy+c1MEM4XxglHn+/xwLhfGaU6L48iwWmpWHFDmYQW0hgOaPE
        q0dyEEXvGSUufL4BlhAWsJVo33IKaC4Hh4iAjMS5fdEgNcwCe5kkDl57BVbDJmAo0fW2iw3E
        ZhFQldj2+xqYLSoQI7Ht8gOwZbwCghInZz4BszkF9CVOb7wMdjezgLzE9rdzmCFscYlbT+Yz
        gSyQEDjFLnF8xX0WkMW8AmUSr2ZngZgSAi4SD9o5Ie4Xlnh1fAs7hC0jcXpyDwtESbnEvxNZ
        EOEWRom13/QhbGuJw8cvsoKUMAtoSqzfBRV2lPjRfIYRopNP4sZbQYhb+CQmbZvODBHmleho
        E4KoVpOYdXwd3M6DFy4xT2BUmoXkw1lIvpqF5KtZCHsXMLKsYhRPLS3OTU8tNspLLdcrTswt
        Ls1L10vOz93ECExMp/8d/7KDcdefpEOMAhyMSjy8AX+5o4VYE8uKK3MPMUpwMCuJ8Jbu5YkW
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzhunURclJJCeWJKanZpakFoEk2Xi4JRqYMz+teDkWg+X
        fr/0/WeWvl5g9sdE7+ojkVurdHQ3RvZ9ML6swX3j0bvOzPvXHrrXS5y+9TInuI9nXqOq7xkt
        frclfc5pIT9LTTZGTmooY1NdvltRa3+1vojuMQv2cpVLbZ4Kipk3llROuOfzt1ZVSezoC6GD
        1ZW+81OP+Hv/28igLvx6asfkbiWW4oxEQy3mouJEABd0Sl1IAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7oVj3iiDea/tbTYOGM9q8X0qRcY
        LVZP/ctqMf/xXDaL8+c3sFtc3jWHzWLG+X1MFnf/fWK02HnnBLMDp8fOWXfZPY7sPMbmsXjP
        SyaPTas62Tz6tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshU
        Sd/OJiU1J7MstUjfLkEvY9mqlYwFB9kqjn6dy9rA2MPaxcjJISFgItGwYgdzFyMXh5DAUkaJ
        GQeXMEMkZCROTmuAKhKW+HOtiw2i6C2jxNyz+5hAEsICthLtW04BJTg4RIAazu2LBqlhFtjL
        JHFv6V1GiIbnLBLvPy5mA2lgEzCU6HrbBWbzCthJtM3bzwJiswioSmz7fQ0sLioQI7F642V2
        iBpBiZMzn4DVcAroS5zeeBnsImYBM4l5mx8yQ9jyEtvfzoGyxSVuPZnPNIFRaBaS9llIWmYh
        aZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwKjcduzn5h2MlzYGH2IU4GBU4uFd
        8Z87Wog1say4MvcQowQHs5IIb+lenmgh3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgcmjLyS
        eENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYzKn+oe2HkJypr42jjx
        PKzlmPJoxxPm5ujO5ZZK+aoeirwx29a+lS28Ffo7d8/zyYFJjcm6lb9PfNfQuX7klPT+Vx7X
        osWlThz8WuKW1Tjh2pVJO/cyL/eb4MJg/z0l2uPBFf+aNPeJJu/KQi283VbNiPyhLP9Nm2NV
        WUXcofPqbxd+yN4XJaXEUpyRaKjFXFScCABLUJ+Z4AIAAA==
Message-Id: <20180529051745eucas1p2ee6ec3e34f075d255c87f8f54a626784~zBcpaqmAb1928519285eucas1p2H@eucas1p2.samsung.com>
X-CMS-MailID: 20180529051745eucas1p2ee6ec3e34f075d255c87f8f54a626784
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180518040358epcas2p353b0096d33116ca78a03b16d24569813
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180518040358epcas2p353b0096d33116ca78a03b16d24569813
References: <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com>
        <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
        <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com>
        <20180515062144.GC13271@vkoul-mobl>
        <CAJz5Open++Dj=a4ty-JbnZBFoqbMQKU6qYumJKSRMRLp_3erSw@mail.gmail.com>
        <20180517041946.GQ13271@vkoul-mobl>
        <CAJz5Opfep+TL0k_3kG7uQc_nU-BdFy1wsD1jo1agwtSvw0JibQ@mail.gmail.com>
        <CGME20180518040358epcas2p353b0096d33116ca78a03b16d24569813@epcas2p3.samsung.com>
        <20180518040349.GB2932@vkoul-mobl>
        <7f0b7404-ee12-977f-02a4-a463d1873aee@samsung.com>
        <20180518072112.GG2932@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2018-05-18 09:21, Vinod wrote:
> On 18-05-18, 08:28, Marek Szyprowski wrote:
>> Hi Vinod,
>>
>> Okay, I see that in theory, there are some tricky bits in implementing DMA
>> support in UART drivers. On the other hand there are already drivers
>> with seems
>> to be working fine. This discussion is about revert of the feature
>> present in
>> pl330 driver, which is required by other in-kernel driver without proper
>> fix to
>> them.
>>
>> Can we drop it for now and discuss what and how should be implemented to
>> make
>> everyone happy, without any regressions?
> Sure am dropping the revert, we can always bring it back if it is required

This revert is still in your -next branch. Do you plan to update it as well?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
