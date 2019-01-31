Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E748C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C9D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YvIXg1rB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ezgdqh8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbfAaNQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:16:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaNQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:16:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0960C60960; Thu, 31 Jan 2019 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548940612;
        bh=7j3uvsjDcR92+OTtXjcZ+22TSj38+BwxBrGrYSGDZ/4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YvIXg1rBOcxjD3R20T2Wqd/xvphh2IZ6mV7IhdVf9jlBj7gEi7vzvyrgkVC0ktECH
         affdckBTY2vRUAkhC+4rnmeH+fs7BwqO+2tcr1m1mX6Z7+Ee5iDTZ548vb8e0o+IV7
         kBZVJI2Y3Dry201RVRVlZq+/YkUjM2DInP18V0c4=
Received: from [192.168.43.47] (unknown [27.59.108.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E01BF60909;
        Thu, 31 Jan 2019 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548940609;
        bh=7j3uvsjDcR92+OTtXjcZ+22TSj38+BwxBrGrYSGDZ/4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ezgdqh8dUfNdGMmtMWMxpQQgz58Sb6Rq/n6kAYzlJdBHI7JZfyvJm1NBwfqemUKj7
         adNEuVmd92DDHNv+jECV/bMpKEUXzy7Fp89AN5vrZ2iEeoozIdY9NnHvTimYcZJnv7
         f3BnvH9Pdd+bKya5TuXydlVuzND2QAbdUAmLpOSw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E01BF60909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv5 1/7] arm64: dts: qcom: sdm845: Add Coresight support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <60ebf1617f0285c89e921bf3839cba6906d493c9.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <20190130183723.GA19234@xps15>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <6ba118d5-5b54-8b91-d003-3f56fae5b925@codeaurora.org>
Date:   Thu, 31 Jan 2019 18:46:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130183723.GA19234@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2019 12:07 AM, Mathieu Poirier wrote:
> On Tue, Jan 29, 2019 at 12:43:58AM +0530, Sai Prakash Ranjan wrote:
>> Add coresight components found on Qualcomm SDM845 SoC.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
>> ---
>> Depends on AOSS QMP side channel patches and AMBA bus pclk change
>> by Bjorn Andersson [1][2].
>> Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
>> and size cells for soc") [3].
>>
>> [1] https://lore.kernel.org/lkml/20190106080915.4493-1-bjorn.andersson@linaro.org/
>> [2] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
>> [3] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
> 
> This patch still doesn't compile for me.  In the above [1] is a cover letter and
> [2] is a patch that is part of [1] - what do you want me to do?  Add all the
> patches in [1]?  And how do those related to the dependencies you've listed in
> the cover letter?
> 
> I can't continue reviewing your work until you provide me with a tree based on
> coresight-next [3] with all the depencendies to get this set applied and
> compiled.
> 

Hi Mathieu,

Sorry to have wasted your time. There were many dependencies
with some nesting and getting updated as well, so in the next version, I 
will have my patches rebased on top of coresight-next and also I will
give a tree based on the same with all dependencies applied.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
