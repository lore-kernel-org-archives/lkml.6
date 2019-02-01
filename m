Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1970DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AFB20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CDd9QtlE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GsX2NRsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfBAArS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:47:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43950 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfBAArR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:47:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 03E8160909; Fri,  1 Feb 2019 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548982036;
        bh=Y8lg0DlVDLXzhowlfWcZvLE2uBEi8sHKrhd8v6t2Stc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CDd9QtlE+qHzDWilTtljDyGnX5uHulyBxJ728qFfYsdTeZblyKLh83rEuJeIDsHW9
         CRd8+CeNHhU65cu24Ueayxch8zrRSNwTQaM6HsGKNTov87LIYfxSC1d3I/U3gRKJrO
         MgRsxmzfxkPZuM7iXneRbDjosgLYcAY2pfQtb+Fk=
Received: from [192.168.43.47] (unknown [223.186.125.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C941A6060A;
        Fri,  1 Feb 2019 00:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548982032;
        bh=Y8lg0DlVDLXzhowlfWcZvLE2uBEi8sHKrhd8v6t2Stc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GsX2NRsvbd12+TV21lFQQPE9KcUT/y/L5O6jsO/jjJbUaOORRJxX55XA76dlRqk1Z
         0ZDzHbAyD9pkL9sg7zbLm3xUWyhhwrEZSOhZgdpAuyZad4y3pOHEPd8MpkIntuCYWD
         gCWOMFOaE3yFB4HpgeqvVgLfUgsUzjFtYlz77BlU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C941A6060A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier
 (UCI) table
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, marc.w.gonzalez@free.fr
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        tingwei@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <304febd7-da9a-92d6-47bb-d9983d4bc5d4@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <2801964a-ba35-9393-593b-c5108a8825e4@codeaurora.org>
Date:   Fri, 1 Feb 2019 06:17:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <304febd7-da9a-92d6-47bb-d9983d4bc5d4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2019 11:31 PM, Suzuki K Poulose wrote:
> 
> 
> On 31/01/2019 14:22, Sai Prakash Ranjan wrote:
>> Add UCI table for coresight CPU debug module. This patch adds
>> the UCI entries for Kryo CPUs found on MSM8996 which shares
>> the same PIDs as ETMs.
>>
>> Without this, below error is observed on MSM8996:
> 
> nit: Subject doesn't match the patch contents. You could simply say :
> 
> coresight: cpu-debug: Add support for Qualcomm Kryo
> 

Done.

>>
>> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c 
>> b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> index e8819d750938..915d86a39cee 100644
>> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> @@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
>>       return 0;
>>   }
>> +static struct amba_cs_uci_id uci_id_debug[] = {
> 
> As Stephen mentioned, this must be "const".
> 
> Rest looks fine.

Done.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
