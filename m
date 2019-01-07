Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5765CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F02206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R1MRsGbJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J10Q3NZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfAGSvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:51:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfAGSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:51:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B91DB608CB; Mon,  7 Jan 2019 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546887075;
        bh=hDYvR2jmdUmdtWZrkFQYkQOc4X2saVKpjAyx4BXrYb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1MRsGbJOP1Y3CjS+I0BBa0HdG1aU2oMZwPUSnU7HqcYCQJKjV+LMQLQtPEEoP3nz
         s2gAfmq3cu8jBpY+kAfu+fKgiVnkeLuIU1bmfcZWaAKXtBL2sjs4qaP1+E7KvheGpK
         SXsHTl/8XHkPx/wQ+vrnDVVGEspiUerEhEKlDmOU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A98BB60132;
        Mon,  7 Jan 2019 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546887074;
        bh=hDYvR2jmdUmdtWZrkFQYkQOc4X2saVKpjAyx4BXrYb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J10Q3NZdYQLwGnEnaKvcJcwEcYibpGQuZUf1n4BHzEga5BkJAboR/erP7FwB2cWWq
         lFmR7x9F0hykqL5LR1JXKBN/HO7/qUFwQk0Nitp7vLEEsFti5HtA5320nP4hPmOsvV
         0cmtoeoTrWkj2DBYHuyyiiepnds21xIrztWa42aw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A98BB60132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 7 Jan 2019 11:51:14 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: sdm845-pinctrl: add wakeup interrupt
 parent for GPIO
Message-ID: <20190107185113.GH14960@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
 <20181219221105.3004-5-ilina@codeaurora.org>
 <20181229000714.GA3654@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181229000714.GA3654@bogus>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28 2018 at 17:07 -0700, Rob Herring wrote:
>On Wed, Dec 19, 2018 at 03:11:02PM -0700, Lina Iyer wrote:
>> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
>> routed to the PDC as interrupts that can be used to wake the system up
>> from deep low power modes and suspend.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt    | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> index 665aadb5ea28..a522ca46667d 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> @@ -29,6 +29,11 @@ SDM845 platform.
>>  	Definition: must be 2. Specifying the pin number and flags, as defined
>>  		    in <dt-bindings/interrupt-controller/irq.h>
>>
>> +- wakeup-parent:
>> +	Usage: optional
>> +	Value type: <phandle>
>> +	Definition: A phandle to the wakeup interrupt controller for the SoC.
>
>Is this really necessary? Is there more than one possible wakeup-parent
>node?
>
No.  There is only one but depending on the architecture, the wakeup
interrupt controller could be different device like PDC on SDM845 or MPM
on SDM820.

What do you have in mind? Let me know if you have a better idea than
referencing in DT.

Thanks,
Lina

>> +
>>  - gpio-controller:
>>  	Usage: required
>>  	Value type: <none>
>> @@ -53,7 +58,6 @@ pin, a group, or a list of pins or groups. This configuration can include the
>>  mux function to select on those pin(s)/group(s), and various pin configuration
>>  parameters, such as pull-up, drive strength, etc.
>>
>> -
>>  PIN CONFIGURATION NODES:
>>
>>  The name of each subnode is not important; all subnodes should be enumerated
>> @@ -160,6 +164,7 @@ Example:
>>  		#gpio-cells = <2>;
>>  		interrupt-controller;
>>  		#interrupt-cells = <2>;
>> +		wakeup-parent = <&pdc>;
>>
>>  		qup9_active: qup9-active {
>>  			mux {
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
