Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0766C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7CD2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FGoOUY2J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="icIjJ2e9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbeL1Epv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 23:45:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbeL1Epv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 23:45:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EFCEE6081B; Fri, 28 Dec 2018 04:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972350;
        bh=ZnDqbhxvc0uLq9v7I8gGj9wCV57zD9XmYq9xT82ZH/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FGoOUY2JADSEglRDfkhbuXUiTLpZqtFFk6lrsDt1rNqnILOOAhe13RZEDP81Xtd69
         8uSLDZH3pS/pbOvk+StqbJGjFLvMGex9HyogOt3H4uXqGWycT4Q/IkbQSpw570O0+v
         dyuHoNQ30kYxQivBc9J8hTcBqF70fa/a8WsR5IWo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 06FCE60350;
        Fri, 28 Dec 2018 04:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972349;
        bh=ZnDqbhxvc0uLq9v7I8gGj9wCV57zD9XmYq9xT82ZH/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=icIjJ2e9SRfxIbLhgA0Pchq6SjSo646waha6PLjXkPcEzacQODvnvXGkjzwKkEosT
         nB/ZyjJ6x4KJPcwwLpqP/ElmNchq36Wfti7rqy4nuxnzrYXPEoS8iaHrRL4jZm4FqW
         WgmHLA/TZGy0U0mXLTZGPiUxzeCU0EDsZeIVLPSo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 10:15:48 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH v3 2/8] dt-bindings: remoteproc: qcom: Add missing clocks
 for SDM845
In-Reply-To: <20181227212105.GA19897@bogus>
References: <20181226125229.20149-1-sibis@codeaurora.org>
 <20181226125229.20149-2-sibis@codeaurora.org> <20181227212105.GA19897@bogus>
Message-ID: <0af3f1d295fa5edd8a9cfc8101b36b33@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Thanks for the review!

On 2018-12-28 02:51, Rob Herring wrote:
> On Wed, Dec 26, 2018 at 06:22:23PM +0530, Sibi Sankar wrote:
>> Add missing clock bindings for Q6V5 MSS on SDM845 SoCs.
>> 
>> Fixes: fb22022ff63d ("dt-bindings: remoteproc: Add Q6v5 Modem PIL
>> binding for SDM845")
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> v3:
>>   * Fixup dt-binding documentation as suggested by Doug
>> 
>>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt   | 14 
>> +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 9ff5b0309417..20dd19f9ed99 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -39,13 +39,21 @@ on the Qualcomm Hexagon core.
>>  - clocks:
>>  	Usage: required
>>  	Value type: <phandle>
>> -	Definition: reference to the iface, bus and mem clocks to be held on
>> -		    behalf of the booting of the Hexagon core
>> +	Definition: reference to the clocks that match clock-names
>> 
>>  - clock-names:
>>  	Usage: required
>>  	Value type: <stringlist>
>> -	Definition: must be "iface", "bus", "mem"
>> +	Definition: The clocks needed depend on the compatible string:
>> +	qcom,ipq8074-wcss-pil:
>> +		    no clock names required
>> +	qcom,q6v5-pil:
>> +	qcom,msm8916-mss-pil:
>> +	qcom,msm8974-mss-pil:
>> +		    must be "iface", "bus", "mem", "xo"
>> +	qcom,sdm845-mss-pil:
>> +		    must be "xo", "prng", "iface", "bus", "mem", "gpll0_mss",
>> +		    "snoc_axi", "mnoc_axi"
> 
> Please keep the same order for the 4 clocks which are the same.

Will re-order them in the next re-spin.

> 
> Rob

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
