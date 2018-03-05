Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeCEJSg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:18:36 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:46428 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCEJSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:18:33 -0500
Subject: Re: [PATCH v2] mmc: Export host capabilities to debugfs.
To: Shawn Lin <shawn.lin@rock-chips.com>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <adrian.hunter@intel.com>,
        <avri.altman@wdc.com>, <andriy.shevchenko@linux.intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Vladimir_Zapolskiy@mentor.com>
References: <1520223870-3471-1-git-send-email-harish_kandiga@mentor.com>
 <40000048-4f64-792d-ba38-25a15be8569a@rock-chips.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <da6cffcc-28d6-9a50-c887-4c4a5903c09c@mentor.com>
Date: Mon, 5 Mar 2018 14:48:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <40000048-4f64-792d-ba38-25a15be8569a@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 05 March 2018 01:21 PM, Shawn Lin wrote:
> On 2018/3/5 12:24, Harish Jenny K N wrote:
>> From: Abbas Raza <Abbas_Raza@mentor.com>
>>
>> This patch exports the host capabilities to debugfs
>>
>> Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
>> ---
>>
>> Changes in v2:
>> - Changed Author
>>
>>   drivers/mmc/core/debugfs.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index c51e0c0..fa2df7f 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -289,6 +289,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>>         card->debugfs_root = root;
>>   +    if (!debugfs_create_x32("host_caps", S_IRUSR, root, (u32 *)&host->caps))
>
> Perhaps you don't need cast, and '&host->caps' should be fine?

Yes. I will send updated patch.
> And you don't need to export host->caps2?

I will send this is as a separate patch, as this also requires changes in mmc-utils sample application to parse the value.


Thanks,
Harish Jenny K N
