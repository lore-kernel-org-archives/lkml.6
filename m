Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbeCFOqN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:46:13 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:47235 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeCFOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:46:10 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 220.200.58.142
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <8dfda1361952a939f4362bd660b970c7>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: ulf.hansson@linaro.org, linus.walleij@linaro.org,
        adrian.hunter@intel.com, shawn.lin@rock-chips.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Export card RCA register to sysfs.
To: Harish Jenny K N <harish_kandiga@mentor.com>
References: <1519732580-2867-1-git-send-email-harish_kandiga@mentor.com>
 <9ed7e027-9fc0-0d29-33bc-87811b496510@mentor.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <5377795c-d065-99cb-195a-8ea37c8dd579@rock-chips.com>
Date: Tue, 6 Mar 2018 22:45:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9ed7e027-9fc0-0d29-33bc-87811b496510@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/6 20:48, Harish Jenny K N wrote:
> 
> 
> On Tuesday 27 February 2018 05:26 PM, Harish Jenny K N wrote:
>> This patch exports RCA register to sysfs which will help in
>> reading the disk identification information.
>>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
>> ---
>>   drivers/mmc/core/mmc.c | 2 ++
>>   drivers/mmc/core/sd.c  | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 208a762..d45a244 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -792,6 +792,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
>>   MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
>>   MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
>>   MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
>> +MMC_DEV_ATTR(rca, "0x%x\n", card->rca);
>>   MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);

Just a nit that I tried to find some convention here, as RCA is a 16-bit 
register, so perhaps "0x%04x\n"? Otherwise,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>>
>>   static ssize_t mmc_fwrev_show(struct device *dev,
>> @@ -848,6 +849,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
>>   	&dev_attr_raw_rpmb_size_mult.attr,
>>   	&dev_attr_rel_sectors.attr,
>>   	&dev_attr_ocr.attr,
>> +	&dev_attr_rca.attr,
>>   	&dev_attr_dsr.attr,
>>   	&dev_attr_cmdq_en.attr,
>>   	NULL,
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 62b84dd..17d9005 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -676,6 +676,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>>   MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
>>   MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
>>   MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
>> +MMC_DEV_ATTR(rca, "0x%x\n", card->rca);

Ditto.

>>
>>
>>   static ssize_t mmc_dsr_show(struct device *dev,
>> @@ -709,6 +710,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
>>   	&dev_attr_oemid.attr,
>>   	&dev_attr_serial.attr,
>>   	&dev_attr_ocr.attr,
>> +	&dev_attr_rca.attr,
>>   	&dev_attr_dsr.attr,
>>   	NULL,
>>   };
>> --
>> 1.9.1
>>
> 
> 
> 
> Any comments/inputs on this ?
> 
> 
> Thanks,
> Harish Jenny K N
> 
> 
> 


-- 
Best Regards
Shawn Lin
