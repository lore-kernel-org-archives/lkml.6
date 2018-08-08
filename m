Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5094C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6698B21767
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jvObRW+K";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UDBjyx0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6698B21767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeHHQaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:30:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeHHQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:30:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F04E460B23; Wed,  8 Aug 2018 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533737416;
        bh=sd4ewQVvkPb2jmbCJMQ+WXBof3Rzo/P2On74JO0IUTE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jvObRW+KGJLlBCkhIGfD6YW9yBL5+DsbtFYquKnFCr0zBYrQAwGemPdAPiB9Ft7FT
         OEmHQBXLBxhIwe//bJ/PBCtA+wQQEqP64NDo4PgLolJgW/YkgDOusKPxErk/65AAX2
         /1zEFNupBJkXNm7jYTv5LYVVFbvzD/D2Inw+fr7M=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC394601D3;
        Wed,  8 Aug 2018 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533737415;
        bh=sd4ewQVvkPb2jmbCJMQ+WXBof3Rzo/P2On74JO0IUTE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UDBjyx0VvHklFqjlnrMvN2MDtmLHtUHQR+x+4hFpjJr7SGQ/T25YO1KuUPMTAPlx1
         Km1RRVhQrLMIXV5TtXuLSwnZONNBtzHDdu9HZjdkw+9Gz1yssnEslj4ttVkJyV0BGX
         do3yNITqHzI8/k3r40FJX74naoQ8xFn78Ioa2cCE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC394601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v3 1/6] remoteproc: Introduce custom dump function for
 each remoteproc segment
To:     Vinod <vkoul@kernel.org>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ohad@wizery.com, kyan@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180727152003.11663-1-sibis@codeaurora.org>
 <20180727152003.11663-2-sibis@codeaurora.org>
 <20180807061539.GG2395@vkoul-mobl>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <362fcf75-6fb6-5423-7b9f-915324df6317@codeaurora.org>
Date:   Wed, 8 Aug 2018 19:40:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180807061539.GG2395@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,
Thanks for the review,

On 08/07/2018 11:45 AM, Vinod wrote:
> Hi Sibi,
> 
> On 27-07-18, 20:49, Sibi Sankar wrote:
>> Introduce custom dump function per remoteproc segment. It is responsible
>> for filling the device memory segment associated with coredump
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 15 ++++++++++-----
>>   include/linux/remoteproc.h           |  3 +++
>>   2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 283b258f5e0f..ec56cd822b26 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1183,13 +1183,18 @@ static void rproc_coredump(struct rproc *rproc)
>>   		phdr->p_align = 0;
>>   
>>   		ptr = rproc_da_to_va(rproc, segment->da, segment->size);
>> -		if (!ptr) {
>> -			dev_err(&rproc->dev,
>> +
>> +		if (segment->dump) {
>> +			segment->dump(rproc, ptr, segment->size, data + offset);
> 
> Am not sure I follow, you are calling this w/o checking if ptr is valid,
> so you maybe passing null to segment->dump() ?
> 

the rationale behind passing ptr directly to dump_fn is that it will
help in tracking the segments being core dumped (q6v5_pil in particular
requires to unlock mba before dumping and cleanup after all the segments
are dumped which is currently decided based on a mask that is
maintained). It also allows the remoteproc driver to fill the memory as
needed (instead of the default 0xff). This is applicable to drivers that
implement dump_fn, for others the default behavior is maintained.

>> +		} else {
>> +			if (!ptr) {
>> +				dev_err(&rproc->dev,
>>   				"invalid coredump segment (%pad, %zu)\n",
>>   				&segment->da, segment->size);
>> -			memset(data + offset, 0xff, segment->size);
>> -		} else {
>> -			memcpy(data + offset, ptr, segment->size);
>> +				memset(data + offset, 0xff, segment->size);
>> +			} else {
>> +				memcpy(data + offset, ptr, segment->size);
>> +			}
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
