Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC36DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD9420675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XZyRw0Hw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="icKgFDVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfAOQ1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:27:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfAOQ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:27:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 36B3A607F4; Tue, 15 Jan 2019 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547569636;
        bh=HibyisDaHH+itZajGqpTFCELahWNFmaTiYbQu9hM7FY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XZyRw0HwGlkGX+NKCQPDFWwjiZIn6Yu4Ty1dt3egrSEX3vnQ1QMV9Vkrbtu+oElFZ
         58lSX5WVNhKe/PJp79IvKvmjm8kOemmIaoa8CbZaCxOBko1Rbxaj3OefTYShyQqIAq
         bBlV33PPd+SvC99eRTyoYZOfDS73eTLZODJf15ig=
Received: from [192.168.43.47] (unknown [223.237.252.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2037D605A0;
        Tue, 15 Jan 2019 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547569635;
        bh=HibyisDaHH+itZajGqpTFCELahWNFmaTiYbQu9hM7FY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=icKgFDVkm2h7YYOaslP8B2s4fVCTrNTKphOfbokzvWdy34SiB4+w8P20RsvJ79vTF
         V6B8mbzAfad4WEn6S3mcLt7htAN816oLVXOFn8DMjnjrDNrBHd7svVCtNk/1wkFEog
         jJ+4jNmMtKc/6VuMaR7dlBf3OwbPyN2MsK3MA8/g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2037D605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190113072319.GB28907@builder>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <5724d2d4-39df-a923-5f94-b53c40a84fd3@codeaurora.org>
Date:   Tue, 15 Jan 2019 21:57:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190113072319.GB28907@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for the review. Please find my comments inline.

On 1/13/2019 12:53 PM, Bjorn Andersson wrote:
> On Wed 09 Jan 09:46 PST 2019, Sai Prakash Ranjan wrote:
> 
>> Add coresight components found on Qualcomm SDM845 SoC.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> Hi Sai,
> 
> The content of this patch looks good, but please fold it into
> sdm845.dtsi (keep the nodes sorted by address).
> 

I had looked at the sample from hi6220 for coresight and
decided to keep sdm845 coresight dtsi in separate file as it
would look much cleaner than mixing it with main dtsi file.
Also I guess it would make coresight topology more understandable
if we keep it separately (plus there are about 400+ lines of coresight
dt entries). Is there any reason for wanting coresight entries merged
into sdm845.dtsi file? If you still prefer it, I can make the
change in the next version.

> And mention below the --- that this depends on my AMBA bus pclk change
> and include the URL:
> 
> https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
> 

I had mentioned this dependency in the cover letter. But I suppose
I can mention it here as well.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
