Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeEBOHy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:07:54 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:33608 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBOHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:07:51 -0400
Subject: Re: [PATCH] net: stmmac: Avoid VLA usage
To: Kees Cook <keescook@chromium.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
References: <20180501210130.GA47709@beast>
 <2587c245-1d02-22a2-d24b-90b498183fc9@synopsys.com>
 <CAGXu5jKrpEOrUVng7zrq0Em9DsAwKfidaqa2AKGrz3ZSXXLn1g@mail.gmail.com>
CC: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Network Development" <netdev@vger.kernel.org>
From: Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <4c209618-8da0-ef1d-ff79-5da3f235b9bc@synopsys.com>
Date: Wed, 2 May 2018 15:07:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKrpEOrUVng7zrq0Em9DsAwKfidaqa2AKGrz3ZSXXLn1g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.59]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02-05-2018 13:36, Kees Cook wrote:
> On Wed, May 2, 2018 at 1:54 AM, Jose Abreu <Jose.Abreu@synopsys.com> wrote:
>> Hi Kees,
>>
>> On 01-05-2018 22:01, Kees Cook wrote:
>>> In the quest to remove all stack VLAs from the kernel[1], this switches
>>> the "status" stack buffer to use the existing small (8) upper bound on
>>> how many queues can be checked for DMA, and adds a sanity-check just to
>>> make sure it doesn't operate under pathological conditions.
>>>
>>> [1] https://urldefense.proofpoint.com/v2/url?u=http-3A__lkml.kernel.org_r_CA-2B55aFzCG-2DzNmZwX4A2FQpadafLfEzK6CC-3DqPXydAacU1RqZWA-40mail.gmail.com&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=WHDsc6kcWAl4i96Vm5hJ_19IJiuxx_p_Rzo2g-uHDKw&m=TBD6a7UY2VbpPmV9LOW_eHAyg8uPq1ZPDhq93VROTVE&s=4fvOST1HhWmZ4lThQe-dHCJYEXNOwey00BCXOWm8tKo&e=
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>
>> I rather prefer the variables declaration in reverse-tree order,
>> but thats just a minor pick.
> I can explicitly reorder the other variables, if you want?

No need by me, unless Giuseppe or Alexandre prefer that. Thanks!

Best Regards,
Jose Miguel Abreu

>
>> Reviewed-by: Jose Abreu <joabreu@synopsys.com>
> Thanks!
>
>> PS: Is VLA warning switch in gcc already active? Because I didn't
>> see this warning in my builds.
> It is not. A bunch of people have been building with KCFLAGS=-Wvla to
> find the VLAs and sending patches. Once we get rid of them all, we can
> add the flag to the top-level Makefile.
>
> -Kees
>
