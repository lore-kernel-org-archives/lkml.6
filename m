Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03425C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD342075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H0BzMHZk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cyIcBeuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfBHOxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:53:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfBHOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:53:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3BBE8601C4; Fri,  8 Feb 2019 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549637598;
        bh=MPRaqOdkGpix0APQkLF+9Z/Ip7Q0xgLGZYfbeWNgmao=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H0BzMHZkFW8CxQOIZpkQMaQKMB5qqhwPDD+hL7Y5iyalbzBwpG++LOptTR5Lz9eVO
         I0i1DzGA0bjfzTaajRFGHujjtKczwZynEoiyss5UWhv14D5n5A8D32KPXXd6r4rlXq
         HnvN0y6c+B5wB3x+2GzMOKa/LmGtIza5M4Mi/y0U=
Received: from [192.168.1.100] (unknown [157.45.225.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93C4F60208;
        Fri,  8 Feb 2019 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549637597;
        bh=MPRaqOdkGpix0APQkLF+9Z/Ip7Q0xgLGZYfbeWNgmao=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cyIcBeujMHi2oZAkg1z3EGJzMNrRji9YMGARAdGeO3b9Zcty2cHsnG6/ngK5v1QSX
         w8dHHy1qoSNNWcB8CzpIbTuYZKoW9rsA2zRCGAYPeuAaXLARnidJ4QYW7aLJWcC3qb
         IhzlVFYGRIyT/0+BZ9OqzTvu9CDhhMJXHdPLJZB4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93C4F60208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv7 1/6] arm64: dts: qcom: sdm845: Add Coresight support
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
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <b672119cd1ffb5cba9da27ab5974fd5978e55b31.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <81dc97e6-2640-d600-9373-30518ed59792@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <3922a74f-3607-fb9f-2b50-bb9b2f45b1cf@codeaurora.org>
Date:   Fri, 8 Feb 2019 20:23:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <81dc97e6-2640-d600-9373-30518ed59792@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2019 7:50 PM, Suzuki K Poulose wrote:
> 
> 
> On 01/02/2019 00:53, Sai Prakash Ranjan wrote:
>> Add coresight components found on Qualcomm SDM845 SoC.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
>> ---
>> For testing, all dependent patches are in below tree:
>>   * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
>>
>> - Depends on AOSS QMP side channel patches by Bjorn Andersson [1] - [4].
>> - AMBA bus pclk change [5].
>> - Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
>>    and size cells for soc") [6].
>>
>> [1] 
>> https://lore.kernel.org/lkml/20190131003933.11436-5-bjorn.andersson@linaro.org/ 
>>
>> [2] 
>> https://lore.kernel.org/lkml/20190131003933.11436-6-bjorn.andersson@linaro.org/ 
>>
>> [3] 
>> https://lore.kernel.org/lkml/20190131003933.11436-7-bjorn.andersson@linaro.org/ 
>>
>> [4] 
>> https://lore.kernel.org/lkml/20190131003933.11436-10-bjorn.andersson@linaro.org/ 
>>
>> [5] 
>> https://lore.kernel.org/lkml/20190131020141.28352-1-bjorn.andersson@linaro.org/ 
>>
>> [6] 
>> https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/ 
>>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 434 +++++++++++++++++++++++++++
>>   1 file changed, 434 insertions(+)
>>
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks!

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
