Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E03C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B846920892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lh79xb/H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lh79xb/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B846920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLFRoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:44:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:44:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9CA4360B12; Thu,  6 Dec 2018 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544118277;
        bh=VOCRTzFrFVQRl7dL0GF5rgRjjfrRLQaM/tmndkCnGus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lh79xb/H7u3CZJsqN+s8/2qdehkgv6hf5V5mYhcaadlWgCPmFmTsM0YaYFvyHFlKY
         RXQW/luy8llAQTadW2DiryXiBZfWD7YdhNNIF9QL7m6NeJ9hWQmuXLhdim18olm3pA
         H7Hi/D02fHeOIIw174mMUeLCAXGQ4sxd+jZRaedo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3DD77606FA;
        Thu,  6 Dec 2018 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544118277;
        bh=VOCRTzFrFVQRl7dL0GF5rgRjjfrRLQaM/tmndkCnGus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lh79xb/H7u3CZJsqN+s8/2qdehkgv6hf5V5mYhcaadlWgCPmFmTsM0YaYFvyHFlKY
         RXQW/luy8llAQTadW2DiryXiBZfWD7YdhNNIF9QL7m6NeJ9hWQmuXLhdim18olm3pA
         H7Hi/D02fHeOIIw174mMUeLCAXGQ4sxd+jZRaedo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Dec 2018 23:14:37 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom: Add power-domain bindings
 for Q6V5
In-Reply-To: <20181206165810.GC31596@builder>
References: <20181120210828.12590-1-sibis@codeaurora.org>
 <20181206165810.GC31596@builder>
Message-ID: <a162ed66f2017b42c3d30e9279e363a3@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review!

On 2018-12-06 22:28, Bjorn Andersson wrote:
> On Tue 20 Nov 13:08 PST 2018, Sibi Sankar wrote:
> 
>> Add power-domain bindings for Q6V5 MSS on SDM845 SoCs.
>> 
> 
> Thanks Sibi,
> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> Add dt-binding corresponding to 
>> https://patchwork.kernel.org/patch/10586893/
>> (remoteproc: q6v5: Add support to vote for rpmh power domains)
>> 
>>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt      | 11 
>> +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 14947562bc67..bd9f4882fcf0 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -75,6 +75,17 @@ on the Qualcomm Hexagon core.
>>  	Definition: reference to the regulators to be held on behalf of the
>>  		    booting of the Hexagon core
>> 
>> +- power-domains:
>> +	Usage: required
>> +	Value type: <phandle>
>> +	Definition: reference to the cx, mx and mss power-domains to be held 
>> on
>> +		    behalf of the booting the Hexagon core
> 
> This should mention that these are the domains for SDM845, as the list
> seems to differ somewhat between platforms. Please also define the
> requirements for MSM8996 (cx & mx) here, while you're at it.
> 
> Let's also make sure it includes the "load_state", for SDM845.
> 

I'll list the power domains per SoC in the next respin

> Regards,
> Bjorn
> 
>> +
>> +- power-domain-names:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "cx", "mx", "mss"
>> +
>>  - qcom,smem-states:
>>  	Usage: required
>>  	Value type: <phandle>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
