Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FBDC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7C2219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fSXzEwM8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D3STrCnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7C2219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeHHSF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:05:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56336 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeHHSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:05:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 999EC601D3; Wed,  8 Aug 2018 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533743114;
        bh=wAfQ/0FpCNpWINUC8PS6XZzF+M5Bg3Xd20HtHp4LU/0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fSXzEwM8sLlEwLOs/fhoaRyElkyBD/sH4rtyp+8dnRlSo5dgMXf7Zmuttyz0PIde7
         JmKgUn9CQLzVz2TKgTKQ06QLAFj2yRmeZxdY4GA2tNb2GCzPVdJIw1G6ibCZDzL4m3
         dh8sHJlDqambtAf4OYVGZzAE27G3LR5vFbCd9s7U=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECB0960B77;
        Wed,  8 Aug 2018 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533743108;
        bh=wAfQ/0FpCNpWINUC8PS6XZzF+M5Bg3Xd20HtHp4LU/0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D3STrCnOBC5Hw5Jh1EF71H6ExIclKxGJShx6rFNHR+D2wNaypEcznRcj/eXQegzbV
         B62PGKOgZNUh8rG2jXbOrut52NRhEtJidKj0Ox8dW+BIQjjHvc+Crwf4YO5zB3eqtT
         XjfNYYhpKae5UogOx9ASdz7+0B4gQdgJ0ufATrNU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECB0960B77
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 4/4] remoteproc: qcom: q6v5-pil: Add PDC restart for modem
 on SDM845 SoCs
To:     Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <20180727152811.15258-4-sibis@codeaurora.org>
 <20180807181835.GA28960@rob-hp-laptop>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <a76d80f2-ac97-1c84-06a3-f86dbe2f35dd@codeaurora.org>
Date:   Wed, 8 Aug 2018 21:15:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180807181835.GA28960@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/07/2018 11:48 PM, Rob Herring wrote:
> On Fri, Jul 27, 2018 at 08:58:11PM +0530, Sibi Sankar wrote:
>> In the presence of a PDC block working with subsystem RSC,
>> assert/deassert PDC restart in modem start/stop path.
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   .../bindings/remoteproc/qcom,q6v5.txt         |  4 +++
> 
> Please split bindings to separate patch.
>

Okay will split them.

>>   drivers/remoteproc/qcom_q6v5_pil.c            | 27 ++++++++++++++++---
>>   2 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 601dd9f389aa..124fb1dc6fb8 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -51,6 +51,8 @@ on the Qualcomm Hexagon core.
>>   	Usage: required
>>   	Value type: <phandle>
>>   	Definition: reference to the reset-controller for the modem sub-system
>> +		    reference to the list of 2 reset-controllers for the modem
>> +		    sub-system on SDM845 SoCs
>>   		    reference to the list of 3 reset-controllers for the
>>   		    wcss sub-system
>>   
>> @@ -58,6 +60,8 @@ on the Qualcomm Hexagon core.
>>   	Usage: required
>>   	Value type: <stringlist>
>>   	Definition: must be "mss_restart" for the modem sub-system
>> +	Definition: must be "mss_restart", "pdc_restart" for the modem
>> +		    sub-system on SDM845 SoCs
>>   	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
>>   		    for the wcss syb-system
>>   

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
