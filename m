Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC656C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B667A217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YOueXLiM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iJYXjW1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfBEWgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:36:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfBEWgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:36:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AEF5E60850; Tue,  5 Feb 2019 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549406195;
        bh=kxs2jqd7eCP8kv0Ny3UqXk8Vh+8vmL0Rss0Fl8BDdxc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YOueXLiMysRFXhT0j05yyiHM0g1yJhbs//aUfMs3tkvS0/3Etd7gNcfijBrSvJeW9
         h9bPWGzX2R51DZEe4GFPj1XH+PrfAk1uHkFImoUeY87lIqkRHexdaiVLIP3bYNuKAK
         3P+yzDvD1cg6cEZ84VRWXAjs/3BOEupWPYMUbkmI=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 710AC6030D;
        Tue,  5 Feb 2019 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549406192;
        bh=kxs2jqd7eCP8kv0Ny3UqXk8Vh+8vmL0Rss0Fl8BDdxc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iJYXjW1RPs8z8fWjhnTxSTi52MVKCQRTF2L+JKFuWoM1ldcPyBEuCVT8UWK4eUugr
         dEJyu3gJZgUFKDoraMRESoUD1OgQaaU4J1vyitvXkxTcbPAfDeXzarCN6rxJjtJ7gK
         GO9TAaR2G8mPtptQY/lcyubD+wPXkirJTB1vczN0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 710AC6030D
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
 <ba5d7855-9dd2-5a99-ae8c-a7fce125ca25@codeaurora.org>
 <154940496255.169292.11279175475668034167@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <a048afe5-e87a-b539-1558-a26464622c1c@codeaurora.org>
Date:   Tue, 5 Feb 2019 15:36:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154940496255.169292.11279175475668034167@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2019 3:16 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-02-05 14:08:43)
>> On 2/5/2019 3:02 PM, Stephen Boyd wrote:
>>> Quoting Jeffrey Hugo (2019-01-30 08:35:59)
>>>> Document the multimedia clock controller found on MSM8998
>>>>
>>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>>> ---
>>>>    Documentation/devicetree/bindings/clock/qcom,mmcc.txt | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
>>>> index 8b0f784..ae85bca 100644
>>>> --- a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
>>>> @@ -10,11 +10,18 @@ Required properties :
>>>>                           "qcom,mmcc-msm8960"
>>>>                           "qcom,mmcc-msm8974"
>>>>                           "qcom,mmcc-msm8996"
>>>> +                       "qcom,mmcc-msm8998"
>>>>    
>>>>    - reg : shall contain base register location and length
>>>>    - #clock-cells : shall contain 1
>>>>    - #reset-cells : shall contain 1
>>>>    
>>>> +For MSM8998 only:
>>>> +       - clocks: a list of phandles and clock-specifier pairs,
>>>> +                 one for each entry in clock-names.
>>>> +       - clock-names: "xo" for the xo clock,
>>>> +                      "gpll0" for the global pll 0 clock.
>>>
>>> Wouldn't the DSI plls also be listed here? And anything else that is
>>> external to this clock controller?
>>>
>>
>> We can't get the DSI plls from DT as far as I am aware (upstream).  That
>> is why I mentioned in the cover letter we need to rely on the global
>> namespace.
> 
> Why not? Because the DSI PLL isn't a clk provider? Or it doesn't have
> #clock-cells? Please try to use the DSI PLLs from DT or at least specify
> them in the binding as optional clocks that may not matter if DSI is not
> enabled for example.

I had thought that there wasn't a DT node that exposed those (I find it 
very odd how the DSI PLLs get inited), but upon checking again, I see 
what I have missed.  I'll need to incorporate them now.

> 
>>
>> Also, the DSI plls, etc present a chicken and egg situation, as the plls
>> require mmcc, and mmcc requires the plls.  I forsee an unsolvable
>> EPROBE_DEFER issue.
>>
> 
> We've "solved" that problem with orphan clks and the clk parent rewrite
> series. Maybe you can try it out to help flush out any bugs lurking
> there.
> 

Thanks for the reference in your other reply.  Will have a look.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
