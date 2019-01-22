Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB40F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PMj9H6Xf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SrpzHPSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfAVNls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:41:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbfAVNlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:41:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AF0D260EC7; Tue, 22 Jan 2019 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548164505;
        bh=IgSFqLdlqQwQpy0++An3pk22QDbSE/HmoAiwGNuADag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PMj9H6XfVfzdocBVXudFZ+XElwlpE6u/5zHxqvGn0HbrDmU/hSha9dKxpauu/tAW9
         c9r/hN9O9A1JcrDiSR3Blb+QRo4qOO/SrIFXDXh4Dci5/jmgdxOoIcrX7miM3lYkde
         s+D30NFmf4hWarTlQB6sOs1Omh5HKrdl586Brx7Y=
Received: from [192.168.1.100] (unknown [157.49.207.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E368260E7A;
        Tue, 22 Jan 2019 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548164503;
        bh=IgSFqLdlqQwQpy0++An3pk22QDbSE/HmoAiwGNuADag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SrpzHPSyUvF5x+nV0ANAcRJPS1iE8tXS8f+TwZwKkfQwVnPZQTDzkRk82ALJxsdGm
         075re9lTu7Qwj9c4HtFp73T3zvcOaYLEoAG47flCWejiBljI9OWcftEl5MCOHOCfDG
         FkkeeM4MlQmyaAQwkbrF/w6kaqWPdCXMTz6cdj+4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E368260E7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv3 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <73bf137fd5d6cb6bddecdf13026156afcf9d473b.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <20190121183731.GA14049@xps15>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <91bcd4cc-9f66-0ca3-43bf-d912c6080b49@codeaurora.org>
Date:   Tue, 22 Jan 2019 19:11:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121183731.GA14049@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 1/22/2019 12:07 AM, Mathieu Poirier wrote:
> Hi Sai,
> 
> On Fri, Jan 18, 2019 at 05:52:53PM +0530, Sai Prakash Ranjan wrote:
>> Add coresight components found on Qualcomm SDM845 SoC.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
>> ---
>> This depends on AMBA bus pclk change by Bjorn Andersson [1].
>> Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
>> and size cells for soc") [2].
>>
>> [1] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
>> [2] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
> 
> Thank you for making modifications to this patch - I am happy with how it stands
> now.  I tried to compile it on my side on a 5.0-rc3 kernel and even after
> applying the above two patches you pointed out I get the following error:
> 
> Error: /home/mpoirier/work/coresight/kernel-maint/arch/arm64/boot/dts/qcom/sdm845.dtsi:1356.31-32 syntax error
> FATAL ERROR: Unable to parse input tree
> 
>  From what I see neither aoss_qmp or AOSS_QMP_QDSS_CLK are defined.  Are there
> more patches that need to be applied?
> 

Sorry, I added all the dependent patches in the cover letter, but
forgot to add the main dependent patch here, now added in v4.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
