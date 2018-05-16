Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeEPICH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:02:07 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:63818 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751319AbeEPICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:02:04 -0400
Subject: Re: [RESEND PATCH] clk: stm32: fix: stm32 clock drivers are not
 compiled by default
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <gabriel.fernandez@st.com>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>
References: <1525329609-7291-1-git-send-email-gabriel.fernandez@st.com>
 <0066b4db-8da6-007d-780d-a8ffc4884ad0@st.com>
 <152548833044.138124.7516235724401510636@swboyd.mtv.corp.google.com>
 <b7116836-28e0-f6a5-8791-b62a66774aff@st.com>
 <152642091618.237094.8294094887191293130@swboyd.mtv.corp.google.com>
 <a49b89ee-2aee-274d-ccc0-3eaf7d9a3755@st.com>
 <152645747055.210890.12866212092853247736@swboyd.mtv.corp.google.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <503ec7d8-e493-3458-e974-5fab5649aaf8@st.com>
Date: Wed, 16 May 2018 10:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152645747055.210890.12866212092853247736@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/16/2018 09:57 AM, Stephen Boyd wrote:
> Quoting Alexandre Torgue (2018-05-16 00:34:21)
>>>>
>>>> Sorry I don't understand. Clock driver is mandatory to boot each
>>>> platform and depends on machine type. Do you see a use case where we
>>>> could need to disable the clock driver? (it would impose to change
>>>> devicetree to use fixed clocks and to have a booloader which configures
>>>> all PLL and clocks).
>>>
>>> No. My understanding of the patch that introduced the options was to
>>> allow the user to disable these drivers if they wanted to. I'm just
>>> reiterating the spirit of that patch. That must be wrong?
>>>
>> Actually initial patch is a mistake. You can't boot STM32 platform
>> without clock driver. This patch fixes that, and offers the possibility
>> to not build the clock driver of the machine which are not used
>> (currently all machine are selected but to reduce memory footprint you
>> could disable not used machine in defconfig).
> 
> Ok I stuck the patch into clk-fixes. Will send off to Linus tomorrow or the
> next day.
> 
Thanks Stephen
