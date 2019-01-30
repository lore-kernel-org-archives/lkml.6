Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41A1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C5F2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fz0/DF3I";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qn4TO82s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbfA3QpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:45:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbfA3QpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:45:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8EC7C61767; Wed, 30 Jan 2019 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866704;
        bh=uf050Gw7bj3M8u+ZlR3oLl6hMlAildd5Y1Zm9Q2aO2g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fz0/DF3I/+huJws9L6B0k5JOf4QVE5Jm6gw5XBXhs8eeGP220GNfICpJzvhrqUa3A
         mYqMVaOYrSMoevu9Rn7WTI0xlhT2CQLu2d3qnV9qnOH9xQxUc88+9RRjM8cjgbF90q
         hs6JGrSfX1tiQscZ5OlU68y+ePszoH6ZNSVxvZfU=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06C6F61737;
        Wed, 30 Jan 2019 16:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548866702;
        bh=uf050Gw7bj3M8u+ZlR3oLl6hMlAildd5Y1Zm9Q2aO2g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qn4TO82snk4TYhlza+iM35p4cvTrmDeBhrjWXNukTf9BiBL3Y9KP8YKiLsHqFMvP4
         tgm28eLncdfipegXIbxqoERZgI089yjM8bCkqkJJAjTRIi+mNxFizQAI2R3Bbl3aCq
         TeI243JeAuRG1MHb7ElRVYQ8fBWXnAssWZEgYbyk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06C6F61737
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: Add support for msm8998
To:     Rob Herring <robh@kernel.org>
Cc:     mark.rutland@arm.com, balbi@kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
References: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
 <1548106366-5042-1-git-send-email-jhugo@codeaurora.org>
 <20190130154257.GA15568@bogus>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <33dc8d6c-d007-4338-8ea8-ac04fcafab4f@codeaurora.org>
Date:   Wed, 30 Jan 2019 09:45:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130154257.GA15568@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2019 8:42 AM, Rob Herring wrote:
> On Mon, Jan 21, 2019 at 02:32:46PM -0700, Jeffrey Hugo wrote:
>> msm8998 USB has a dwc3 controller just like the existing sdm845 support.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/usb/qcom,dwc3.txt | 1 +
>>   1 file changed, 1 insertion(+)
> 
> You missed my R-by.
> 

Drat.  Sorry.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
