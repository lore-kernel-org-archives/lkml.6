Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC3C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0A52087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jsft3sqn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jsft3sqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfAGHsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:48:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfAGHsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:48:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E5FF060541; Mon,  7 Jan 2019 07:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546847285;
        bh=1J9UTJzlAAxpaGQNm6ducRkVjBFVhAU81g0QER2Z9WE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jsft3sqnZmCqnn0KsFPIk4C6lFIrXovmc1VuwzXuEVRJygmAskhtTO+jSVVQs92OL
         PdeNWwkE1aY3O73UJgIRoRZyzGjUyIgRbunikP1PTRtMSB0oLTilHY/QJhH9EU4oi1
         4kqNOU0cfTihhywFzW2VlfeP5svbuVvjWSKRmFgk=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB8886029B;
        Mon,  7 Jan 2019 07:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546847285;
        bh=1J9UTJzlAAxpaGQNm6ducRkVjBFVhAU81g0QER2Z9WE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jsft3sqnZmCqnn0KsFPIk4C6lFIrXovmc1VuwzXuEVRJygmAskhtTO+jSVVQs92OL
         PdeNWwkE1aY3O73UJgIRoRZyzGjUyIgRbunikP1PTRtMSB0oLTilHY/QJhH9EU4oi1
         4kqNOU0cfTihhywFzW2VlfeP5svbuVvjWSKRmFgk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB8886029B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: Add ADSP reserve-memory
 nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     dianders@chromium.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        linux-remoteproc@vger.kernel.org
References: <1545313174-13481-1-git-send-email-rohitkr@codeaurora.org>
 <1545313174-13481-2-git-send-email-rohitkr@codeaurora.org>
 <20190103234249.GH31596@builder>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <6b81869e-1d8b-510e-760a-9476ac08528f@codeaurora.org>
Date:   Mon, 7 Jan 2019 13:17:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103234249.GH31596@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for review.

On 1/4/2019 5:12 AM, Bjorn Andersson wrote:
> On Thu 20 Dec 05:39 PST 2018, Rohit kumar wrote:
>
>> Add memory nodes required for remoteproc q6v5_adsp pil.
>>
> This range doesn't match the documented memory map. I would prefer to
> see a "Specify all PIL regions as defined in V10" or similar.

Yes,  Sibi will post it along with other PIL regions with update address 
in next spin.


>
> Regards,
> Bjorn
>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 23a253b..c0a012f 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -88,6 +88,11 @@
>>   			reg = <0 0x86200000 0 0x2d00000>;
>>   			no-map;
>>   		};
>> +
>> +		pil_adsp_mem: memory@8b100000 {
>> +			reg = <0 0x8b100000 0 0x1a00000>;
>> +			no-map;
>> +		};
>>   	};
>>   
>>   	cpus {
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
>> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
Regards,
Rohit
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

