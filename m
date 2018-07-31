Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51181C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F4920862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n9qK8tNL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EaA+/PtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F4920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeGaOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:53:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732153AbeGaOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:53:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9972460585; Tue, 31 Jul 2018 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533042819;
        bh=GCcJhS9KMn/i9viEhHre98Jr9hBsvsB9RrVVgBfsiic=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n9qK8tNLKlToHYWD83j7INqhn02H/0vYVr0khi6s8o1xHaOAvapLCuxoGJGl1y2Pn
         ZyDcBI2mJNO40gJY68lEkoYaI1X+BJ7o3+x6AvuetDJ4T0AVE6CEcWsbnUS6nxttA/
         xpze3VSV20tf0Q21Hyye7CHS33XmfbgzPoe09u8c=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 307F360264;
        Tue, 31 Jul 2018 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533042818;
        bh=GCcJhS9KMn/i9viEhHre98Jr9hBsvsB9RrVVgBfsiic=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EaA+/PtCuYNL04S094tUWYRUzeVA9hGPVWxHBDlpO3oa8+cTr7P4LJaP4k9vUlF0N
         jFtwfI/aVTRU2ZzwgCCu/pqo+dqelPPxMFLNpD/QH9sEXFtRrH2Tnw6jLaqkOyxK7i
         50/37Q0pSQJTJhMOXv51Apb+p11OQwv+3rkbk1ig=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 307F360264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 4/4] remoteproc: qcom: q6v5-pil: Add PDC restart for modem
 on SDM845 SoCs
To:     Philipp Zabel <p.zabel@pengutronix.de>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <20180727152811.15258-4-sibis@codeaurora.org>
 <1533027272.3444.9.camel@pengutronix.de>
From:   Sibi S <sibis@codeaurora.org>
Message-ID: <1040c360-3fdf-0657-95ee-0ee669e7b252@codeaurora.org>
Date:   Tue, 31 Jul 2018 18:43:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1533027272.3444.9.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,
Thanks for the review!

On 07/31/2018 02:24 PM, Philipp Zabel wrote:
> On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
>> In the presence of a PDC block working with subsystem RSC,
>> assert/deassert PDC restart in modem start/stop path.
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   .../bindings/remoteproc/qcom,q6v5.txt         |  4 +++
>>   drivers/remoteproc/qcom_q6v5_pil.c            | 27 ++++++++++++++++---
>>   2 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 601dd9f389aa..124fb1dc6fb8 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> [...]
>> @@ -1182,6 +1192,15 @@ static int q6v5_init_reset(struct q6v5 *qproc)
>>   		return PTR_ERR(qproc->mss_restart);
>>   	}
>>   
>> +	if (qproc->has_alt_reset) {
>> +		qproc->pdc_restart = devm_reset_control_get(qproc->dev,
>> +							    "pdc_restart");
> 
> Please use devm_reset_control_get_exclusive() instead.
> 

will replace it in the next re-spin.

>> +		if (IS_ERR(qproc->pdc_restart)) {
>> +			dev_err(qproc->dev, "failed to acquire pdc restart\n");
>> +			return PTR_ERR(qproc->pdc_restart);
>> +		}
>> +	}
>> +
>>   	return 0;
>>   }
> 
> regards
> Philipp
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
