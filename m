Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73A8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84788206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IofcxYya";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HFl23VVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfAHK0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:26:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:26:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 18E5360397; Tue,  8 Jan 2019 10:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943179;
        bh=lunE4HEPhYBUHIg40yT7BGhWem+Qqgi9VA/kJNavnYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IofcxYyaNujLDP9iXotoM+rGVCRKSPgga05A2vlkC4ToPqQRVI1sZwGmNpOuIlcAi
         mTc+xKd6ESmnWzRnHojyjVgM6g5nNqGnZPzVzJLkI7yn7UBICkLXUH/JZkezIeRifO
         0hKX7v7s/6ovnoFqOieIDoycoUhief2np+7nLGYE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 595AA601EA;
        Tue,  8 Jan 2019 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943178;
        bh=lunE4HEPhYBUHIg40yT7BGhWem+Qqgi9VA/kJNavnYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HFl23VVX1kNAIR2cTAgc18T+NWdIkAuyRucPCcQEiWnlubR60fK24maM4UO/Ho2sI
         cQHoshkSK4DCnKvWiLhnlbPywQmbGOKGyBzw0pVxd7eN5YroqTxJrmuAgqU22/TDgO
         eT0M3UQE7l13zCYfG7CHyw5mo0zr+Zca5j2U8uQg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Jan 2019 15:56:18 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        clew@codeaurora.org, akdwived@codeaurora.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, evgreen@chromium.org,
        briannorris@chromium.org, sricharan@codeaurora.org,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: soc: qcom: Add remote-pid binding for
 GLINK SMEM
In-Reply-To: <20190103201720.GE31596@builder>
References: <20181228185307.25645-1-sibis@codeaurora.org>
 <20190103201720.GE31596@builder>
Message-ID: <3e10e2c430d29879acf47e019d4c71a4@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review!

On 2019-01-04 01:47, Bjorn Andersson wrote:
> On Fri 28 Dec 10:53 PST 2018, Sibi Sankar wrote:
> 
>> Add missing qcom,remote-pid dt binding required for GLINK SMEM
>> which specifies the remote endpoint of the GLINK edge.
>> 
>> Fixes: 2b41d6c8e696 ("dt-bindings: soc: qcom: Extend GLINK to cover
>> SMEM")
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Thanks for the updates Sibi!
> 
> @Andy, as this relates to rpmsg I'll take this (patch 1/8) through the
> rpmsg tree.
> 
> And I'm picking 2-7 through the remoteproc tree.
> 
> 
> PS. Please use a --cover-letter when sending a series of patches.

sure will do... this was never meant to be a
series (started of as a single patch) :P

> 
> Regards,
> Bjorn
> 
>> ---
>> 
>> v3:
>>   * Fixed typo
>> 
>>  Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt 
>> b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>> index 0b8cc533ca83..587bb1ddc8cc 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>> @@ -21,6 +21,11 @@ edge.
>>  	Definition: should specify the IRQ used by the remote processor to
>>  		    signal this processor about communication related events
>> 
>> +- qcom,remote-pid:
>> +	Usage: required for glink-smem
>> +	Value type: <u32>
>> +	Definition: specifies the identifier of the remote endpoint of this 
>> edge
>> +
>>  - qcom,rpm-msg-ram:
>>  	Usage: required for glink-rpm
>>  	Value type: <prop-encoded-array>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
