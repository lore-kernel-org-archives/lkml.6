Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935268AbeCENsq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:48:46 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41713 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCENso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:48:44 -0500
Subject: Re: [PATCH v3] mmc: Export host capabilities to debugfs.
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, <avri.altman@wdc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
References: <1520242120-2924-1-git-send-email-harish_kandiga@mentor.com>
 <CAPDyKFqL0tE3fdODbpo5Ci1_e=RbOfxZkTXKQ4XWo4FKHzwMiw@mail.gmail.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <9c263aee-7780-9ac9-7433-d4a5ca445f16@mentor.com>
Date: Mon, 5 Mar 2018 19:18:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqL0tE3fdODbpo5Ci1_e=RbOfxZkTXKQ4XWo4FKHzwMiw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 05 March 2018 05:43 PM, Ulf Hansson wrote:
> On 5 March 2018 at 10:28, Harish Jenny K N <harish_kandiga@mentor.com> wrote:
>> From: Abbas Raza <Abbas_Raza@mentor.com>
>>
>> This patch exports the host capabilities to debugfs
>>
>> Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
>> ---
>>
>> Changes in v3:
>> - Removed typecasting of &host->caps to (u32 *)
>>
>> Changes in v2:
>> - Changed Author
>>
>>  drivers/mmc/core/debugfs.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index c51e0c0..570c9e4 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -289,6 +289,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>>
>>         card->debugfs_root = root;
>>
>> +       if (!debugfs_create_x32("host_caps", S_IRUSR, root, &host->caps))
>> +               goto err;
>> +
> This isn't the correct place to created the node(s). Please move this
> to mmc_add_host_debugfs().
>
> Moreover, I suggest you export both caps and caps2 in the same change,
> there is no need to have two changes for that - and finally name the
> nodes to "caps" and "caps2".

Addressed your review findings in v4 patch.

Thanks,
Harish Jenny K N
