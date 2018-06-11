Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yrpgOheFHlsJKQAAmS7hNA
	; Mon, 11 Jun 2018 14:20:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DD4BB607A4; Mon, 11 Jun 2018 14:20:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4069F60791;
	Mon, 11 Jun 2018 14:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4069F60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934175AbeFKOTx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:19:53 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:43785 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933240AbeFKOTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:19:19 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.243])
        by lucky1.263xmail.com (Postfix) with ESMTP id AA41096A56;
        Mon, 11 Jun 2018 22:19:02 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [192.168.10.112] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id C575037E;
        Mon, 11 Jun 2018 22:19:04 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 220.200.5.75
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <c829a8b32cc3f716a7b6516a7cde3bcf>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [192.168.10.112] (unknown [220.200.5.75])
        by smtp.263.net (Postfix) whith ESMTP id 22434EH6CES;
        Mon, 11 Jun 2018 22:19:05 +0800 (CST)
Cc: Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Doug Anderson <dianders@chromium.org>,
        shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>,
        Qing Xia <xiaqing17@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix card threshold control configuration
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com>
 <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <08a08d60-8176-df54-ff0e-ffc195f40d6c@rock-chips.com>
Date: Mon, 11 Jun 2018 22:17:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/11 20:20, Ulf Hansson wrote:
> + Shawn Lin, Evgeniy Didin, Doug Andersson
> 
> On 29 May 2018 at 12:38, Qing Xia <xiaqing17@hisilicon.com> wrote:
>> From: x00270170 <xiaqing17@hisilicon.com>
>>
>> Card write threshold control is supposed to be set since controller
>> version 2.80a for data write in HS400 mode and data read in
>> HS200/HS400/SDR104 mode. However the current code returns without
>> configuring it in the case of data writing in HS400 mode.
>> Meanwhile the patch fixes that the current code goes to
>> 'disable' when doing data reading in HS400 mode.
>>

I'm more or less unable to review this, as I don't have 2.80a databook,
nor a such platform to verify it. :(

>> Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
> 
> This looks good to me. However, it seems like Jaehoon has been busy,
> no response yet.
> 
> I have looped in a few more people to see if they thinks this makes sense.
> 
> Kind regards
> Uffe
> 
>> ---
>>   drivers/mmc/host/dw_mmc.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 29a1afa..3ee8f57 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1065,8 +1065,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>>           * It's used when HS400 mode is enabled.
>>           */
>>          if (data->flags & MMC_DATA_WRITE &&
>> -               !(host->timing != MMC_TIMING_MMC_HS400))
>> -               return;
>> +               host->timing != MMC_TIMING_MMC_HS400)
>> +               goto disable;
>>
>>          if (data->flags & MMC_DATA_WRITE)
>>                  enable = SDMMC_CARD_WR_THR_EN;
>> @@ -1074,7 +1074,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>>                  enable = SDMMC_CARD_RD_THR_EN;
>>
>>          if (host->timing != MMC_TIMING_MMC_HS200 &&
>> -           host->timing != MMC_TIMING_UHS_SDR104)
>> +           host->timing != MMC_TIMING_UHS_SDR104 &&
>> +           host->timing != MMC_TIMING_MMC_HS400)
>>                  goto disable;
>>
>>          blksz_depth = blksz / (1 << host->data_shift);
>> --
>> 2.8.1
>>
> 
> 
> 


-- 
Best Regards
Shawn Lin
