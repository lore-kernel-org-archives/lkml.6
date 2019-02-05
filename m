Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A356C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015642075C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z+JKSxgW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ey8WX42I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfBEWIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:08:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfBEWIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:08:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 749AD607F5; Tue,  5 Feb 2019 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549404528;
        bh=14IjDPQdxeOAhs3LpJjV5ekrquMldJ3leQ8INQeqIos=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z+JKSxgWe2tOFdXyaa8D0htTERbzTGGeDCVfA4Fy9CEh2s2fOk/5ZpQb5jNchnWxS
         4n3rIwEGisDuAvtLH9BeXu687n4chrVJIflGlsJlSX2ZPE0h0L5/wKJwR+Bmkk8Qaa
         K0AsSnklArMBmUZlDDZ8y3SHhwP0sleK4uwFEg34=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC3D760134;
        Tue,  5 Feb 2019 22:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549404527;
        bh=14IjDPQdxeOAhs3LpJjV5ekrquMldJ3leQ8INQeqIos=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ey8WX42IAkDR0Qrrco6bbLLdmI5ZSfzw5SjtGZTJJdVGa8Ft1wNT5MN1aS8mKNBCl
         16netxy5ZB4bhGXSr23PdZBbi5TyLmMepxpAMmbYGwJZBVQbhBIlR/ygMbfSnaJSsl
         VQDKGdwK/y0W487TEq8CoVLhLP/cJl0rOF+pmrag=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC3D760134
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: Add support for the MSM8998
 mmcc
To:     Stephen Boyd <sboyd@kernel.org>, bjorn.andersson@linaro.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
 <1548866159-30304-1-git-send-email-jhugo@codeaurora.org>
 <154940414347.169292.9150834270087697417@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <ba5d7855-9dd2-5a99-ae8c-a7fce125ca25@codeaurora.org>
Date:   Tue, 5 Feb 2019 15:08:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154940414347.169292.9150834270087697417@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2019 3:02 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-01-30 08:35:59)
>> Document the multimedia clock controller found on MSM8998
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/clock/qcom,mmcc.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
>> index 8b0f784..ae85bca 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
>> +++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
>> @@ -10,11 +10,18 @@ Required properties :
>>                          "qcom,mmcc-msm8960"
>>                          "qcom,mmcc-msm8974"
>>                          "qcom,mmcc-msm8996"
>> +                       "qcom,mmcc-msm8998"
>>   
>>   - reg : shall contain base register location and length
>>   - #clock-cells : shall contain 1
>>   - #reset-cells : shall contain 1
>>   
>> +For MSM8998 only:
>> +       - clocks: a list of phandles and clock-specifier pairs,
>> +                 one for each entry in clock-names.
>> +       - clock-names: "xo" for the xo clock,
>> +                      "gpll0" for the global pll 0 clock.
> 
> Wouldn't the DSI plls also be listed here? And anything else that is
> external to this clock controller?
> 

We can't get the DSI plls from DT as far as I am aware (upstream).  That 
is why I mentioned in the cover letter we need to rely on the global 
namespace.

Also, the DSI plls, etc present a chicken and egg situation, as the plls 
require mmcc, and mmcc requires the plls.  I forsee an unsolvable 
EPROBE_DEFER issue.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
