Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD23C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACD72147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACD72147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404181AbeHPStr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:49:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38164 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeHPStr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:49:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845037A9;
        Thu, 16 Aug 2018 08:50:29 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB62E3F5BD;
        Thu, 16 Aug 2018 08:50:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] coresight: etb10: Refactor etb_drvdata::mode handling
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
References: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
 <5cd6b8a8-2370-517d-deb1-378bff6e362b@arm.com> <20180816154817.GA14955@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <0796196d-f969-1e87-418b-bd67d4f5bf63@arm.com>
Date:   Thu, 16 Aug 2018 16:50:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816154817.GA14955@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/18 16:48, Mathieu Poirier wrote:
> On Thu, Aug 16, 2018 at 04:13:03PM +0100, Suzuki K Poulose wrote:
>> Hi Mathieu,
>>
>> The patch looks good to me. One minor nit below.
> 
> You have not included any comment - did you change your mind?
> 

Sorry, yes I did. It was about folding the checks where ETB is already
enabled in SYSFS.

>>
>> On 14/08/18 23:14, Mathieu Poirier wrote:
>>> This patch moves the etb_drvdata::mode from a locat_t to a simple u32,
>>> as it is for the ETF and ETR drivers.  This streamlines the code and adds
>>> commonality with the other drivers when dealing with similar operations.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-etb10.c | 62 +++++++++++++++------------
>>>   1 file changed, 34 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>>> index 9fd77fdc1244..69287163ce4e 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>>
>>> @@ -488,7 +494,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
>>>   	unsigned long flags;
>>>   	spin_lock_irqsave(&drvdata->spinlock, flags);
>>> -	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
>>> +	if (drvdata->mode == CS_MODE_SYSFS) {
>>>   		etb_disable_hw(drvdata);
>>>   		etb_dump_hw(drvdata);
>>>   		etb_enable_hw(drvdata);
>>
>> Looks good to me.
>>
>> Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki
