Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D2AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EEB20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G92DOVWe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kfj5o5UT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EEB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeGaOwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:52:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732068AbeGaOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:52:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EC66060481; Tue, 31 Jul 2018 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533042712;
        bh=Dqgz54mTO3AJhLe3GpgM1lZvTqzMfzRfWmNMAeDafPI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G92DOVWeYexXqOWKt0BRnBznG1unB47a0QvY46mHdmXLCDdioQLek4uVE3e6rW2Pc
         pWaInflF/eJF1tf4VwBeMDGG/jUXVqIbkjakM7QYj6LPnRHFrTyO/fEJMCWfVXtp6g
         1I8A2e9DAw0xFlCRlVBApDGRcVjxdnFDm+tO3mqo=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5748060376;
        Tue, 31 Jul 2018 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533042711;
        bh=Dqgz54mTO3AJhLe3GpgM1lZvTqzMfzRfWmNMAeDafPI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kfj5o5UTQ4AFDrllH0uvVn9uPQz9TH60XM7cpsgG7DF8BUimXwkISV19jRpyzG5mF
         MR1F1xobT1An2fSE02zSUj/RmUONdVsBqEfjMU8d9M199/GqiFdbQ81ZEVE6AM5lg7
         y/4T5PImt+itDSXvulF3hm24cAa37Q+8voPGBjik=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5748060376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 3/4] remoteproc: qcom: q6v5-pil: Explicitly get
 mss_restart line
To:     Philipp Zabel <p.zabel@pengutronix.de>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <20180727152811.15258-3-sibis@codeaurora.org>
 <1533027423.3444.11.camel@pengutronix.de>
From:   Sibi S <sibis@codeaurora.org>
Message-ID: <2d3ba00f-7379-dda3-fb7a-3112b7b0ef99@codeaurora.org>
Date:   Tue, 31 Jul 2018 18:41:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1533027423.3444.11.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,
Thanks for the review!

On 07/31/2018 02:27 PM, Philipp Zabel wrote:
> On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
>> Explicitly get mss_restart to facilitate adding PDC
>> restart line for modem on SDM845 SoCs
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   drivers/remoteproc/qcom_q6v5_pil.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
>> index b1296d614b8b..d57fdb34e3dd 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pil.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
>> @@ -1176,8 +1176,7 @@ static int q6v5_init_clocks(struct device *dev, struct clk **clks,
>>   
>>   static int q6v5_init_reset(struct q6v5 *qproc)
>>   {
>> -	qproc->mss_restart = devm_reset_control_get_exclusive(qproc->dev,
>> -							      NULL);
>> +	qproc->mss_restart = devm_reset_control_get(qproc->dev, "mss_restart");
> 
> Please keep using devm_reset_control_get_exclusive.
> 

got misled when I saw it being used in a recent driver :), will revert
it back.

> regards
> Philipp
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
