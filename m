Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1945952AbeBORAy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:00:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54676 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423522AbeBORAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:00:50 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180215170047euoutp01988adcd2eb04a00246a7eb065ebc83ad~TjmFCSo1j2824128241euoutp01H
X-AuditID: cbfec7f5-b45ff700000028a9-c2-5a85bcbeebc5
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
Message-id: <32069edc-e816-6ab0-f057-b1dab5d30db4@partner.samsung.com>
Date: Thu, 15 Feb 2018 18:00:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <6b29116a-c39c-9813-34a0-d5c05bd30c9d@denx.de>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djPc7r79rRGGdyZqmFxrXchs8XGGetZ
        Leacb2GxmNWla9H9Ssai6eVbJovPq56yWEz5s5zJ4v69n0wWl3fNYbN409bIaPF03RJmiztb
        m9ksjkzZx+rA59F66S+bx6urjh5bVt5k8pg36wSLx7/D/UweO2fdZffYdkDVY+Oz5ywed67t
        YfPo27KK0ePzJrkA7igum5TUnMyy1CJ9uwSujOX7P7AXnBWouLBatIHxH08XIyeHhICJxLUX
        H1i6GLk4hARWMEpcmtLMDuF8ZpSYu/0II0zVtv1LGCESyxglDvR9YYZwnjFK7Pj4EyjDwSEs
        4C3x648ASIOIgKfEw/0drCA1zAKPmCUmHVwLNolNwFzi0fYzTCA2r4CbROuFO2wgNouAqsS3
        fd/ZQWxRgQiJhVOfMkLUCEr8mHyPBcTmFLCW2PXiOlgNs4CmxIsvk1ggbHGJ5tabULa8xOY1
        b8GOkxBYxi5x7uwxdogXXCRWrZ7KAmELS7w6vgUqLiPR2XGQCaKhn1Gif95MVghnBqPE441n
        WSGqrCUOH7/ICrGCT2LStunMIC9LCPBKdLQJQZR4SPw+8hYaXo4S2/a+YoUE0XdGiZZ5j1gm
        MMrNQvLRLCRfzELyxSwkXyxgZFnFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmNRO/zv+
        dQfjvj9JhxgFOBiVeHg39LZGCbEmlhVX5h5ilOBgVhLh/RgFFOJNSaysSi3Kjy8qzUktPsQo
        zcGiJM4bp1EXJSSQnliSmp2aWpBaBJNl4uCUamD0cPzOrsqvW3aCbcop4xlKRm+3Tp0WfUhg
        17f3PKf+/oqtePPoa9fp2p6azKOvJ3OslH1Wfcl1r6P2pbnesgLOpZVq+eUa8adPZu6UPsi+
        P4uR29jxPq+t8TcuD6uU5hCRMps3OZ5Hd137ftkphHViXo0N1/ZKy0qVtcqKP3cvuOW/2lgp
        XVWJpTgj0VCLuag4EQAq7AzBZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xq7r79rRGGTT847S41ruQ2WLjjPWs
        FnPOt7BYzOrSteh+JWPR9PItk8XnVU9ZLKb8Wc5kcf/eTyaLy7vmsFm8aWtktHi6bgmzxZ2t
        zWwWR6bsY3Xg82i99JfN49VVR48tK28yecybdYLF49/hfiaPnbPusntsO6DqsfHZcxaPO9f2
        sHn0bVnF6PF5k1wAdxSXTUpqTmZZapG+XQJXxvL9H9gLzgpUXFgt2sD4j6eLkZNDQsBEYtv+
        JYxdjFwcQgJLGCUal7WzQTjPGCWaOq4ydzFycAgLeEv8+iMA0iAi4CnxcH8HK0gNs8ATZonD
        e7exQDT8BGrY8IkNpIpNwFzi0fYzTCA2r4CbROuFO2BxFgFViW/7vrOD2KICERKdK+ezQNQI
        SvyYfA/M5hSwltj14jo7yGJmAXWJKVNyQcLMAuISza03WSBseYnNa94yT2AUmIWkexZCxywk
        HbOQdCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGHPbjv3cvIPx0sbgQ4wCHIxKPLwb
        elujhFgTy4orcw8xSnAwK4nwfowCCvGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliS
        mp2aWpBaBJNl4uCUamBkaGv8sMN3h9Gdj/feOqxa9vdslWenivukp9yHzkxPcw5fI5wuK/BS
        JMC/1/H9X3WJgss7OvIX1T1gbP+VkxPCybS0+8ghy0lMW3ZMV/g++3jLBcf9qZ/7RE6/zC8q
        vrs4cTOn7dVtF/c8Kp9/Sv5k5WWvA3rRSskJ3Tc7p6W9PRDhPM024aSGEktxRqKhFnNRcSIA
        8Q1ncrUCAAA=
X-CMS-MailID: 20180215170046eucas1p1584287a2d0eaf241673a2c57b26a1ec6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180118183438eucas1p2e2e7be8625ae0950c519e27424f9301a
X-RootMTR: 20180118183438eucas1p2e2e7be8625ae0950c519e27424f9301a
References: <CGME20180118183438eucas1p2e2e7be8625ae0950c519e27424f9301a@eucas1p2.samsung.com>
        <20180118183404.12583-1-k.konieczny@partner.samsung.com>
        <20180215154132.GA7352@gondor.apana.org.au>
        <6b29116a-c39c-9813-34a0-d5c05bd30c9d@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.2018 17:27, Marek Vasut wrote:
> On 02/15/2018 04:41 PM, Herbert Xu wrote:
>> On Thu, Jan 18, 2018 at 07:33:59PM +0100, Kamil Konieczny wrote:
>>> First four patches add empty hash export and import functions to each driver,
>>> with the same behaviour as in crypto framework. The last one drops them from
>>> crypto framework. Last one for ahash.c depends on all previous.
>>>
>>> Changes in v3:
>>> added change for bfin_crc.c
>>> make this a patchset, instead of unreleated patches
>>> make commit message more descriptive
>>>
>>> Kamil Konieczny (5):
>>>   crypto: mxs-dcp: Add empty hash export and import
>>>   crypto: n2_core: Add empty hash export and import
>>>   crypto: ux500/hash: Add empty export and import
>>>   crypto: bfin_crc: Add empty hash export and import
>>>   crypto: ahash.c: Require export/import in ahash
>>>
>>>  crypto/ahash.c                        | 18 ++----------------
>>>  drivers/crypto/bfin_crc.c             | 12 ++++++++++++
>>>  drivers/crypto/mxs-dcp.c              | 14 ++++++++++++++
>>>  drivers/crypto/n2_core.c              | 12 ++++++++++++
>>>  drivers/crypto/ux500/hash/hash_core.c | 18 ++++++++++++++++++
>>>  5 files changed, 58 insertions(+), 16 deletions(-)
>>
>> All applied.  Thanks.
> 
> This makes no sense, cfr my comment on 5/5
> 
> Seems like if the driver doesn't implement those, the core can easily
> detect that and perform the necessary action. Moving the checks out of
> core seems like the wrong thing to do, rather you should enhance the
> checks in core if they're insufficient in my opinion.

The bug can only be in driver which will not implement those two functions,
but we already had all drivers with those due to patches 1..4
All other drivers do have them.

Additionally, with crypto we want minimize code and run as fast as possible.

Moving checks out of core will impose on driver author need for implement
those functions, or declare them empty, but in case of empty ones 
crypto will not work properly with such driver.

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland
