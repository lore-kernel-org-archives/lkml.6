Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02507C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ECB208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X1WdQwXP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X1WdQwXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97ECB208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeH1Fds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:33:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeH1Fds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:33:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E0834603D2; Tue, 28 Aug 2018 01:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535420674;
        bh=zqsUWxBk7XGF9CuJIa05VdIxroF7PWkerwuMmg+MHS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1WdQwXPaDmyujdZgVE+/MxV363oKp0xhpBnCPJl/jb1RqmpE3+sGpDfUBvwlwxxE
         p+ChTl0dW6aQMMZjB87zNvErcIPUMBwnD/GLK7ZKKeeomPZ0eC1SXwOysedmX7aMSZ
         Qx0SuuWWAZlaVZIiaqoa3hlEUgW3DIoAwJkUxJOY=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBCEF60117;
        Tue, 28 Aug 2018 01:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535420674;
        bh=zqsUWxBk7XGF9CuJIa05VdIxroF7PWkerwuMmg+MHS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1WdQwXPaDmyujdZgVE+/MxV363oKp0xhpBnCPJl/jb1RqmpE3+sGpDfUBvwlwxxE
         p+ChTl0dW6aQMMZjB87zNvErcIPUMBwnD/GLK7ZKKeeomPZ0eC1SXwOysedmX7aMSZ
         Qx0SuuWWAZlaVZIiaqoa3hlEUgW3DIoAwJkUxJOY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBCEF60117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 27 Aug 2018 19:44:33 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     marc.zyngier@arm.com, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
Subject: Re: [PATCH v2 4/5] drivers: pinctrl: qcom: sdm845: support GPIO
 wakeup from suspend
Message-ID: <20180828014433.GA13998@codeaurora.org>
References: <20180824200157.9993-1-ilina@codeaurora.org>
 <20180824200157.9993-5-ilina@codeaurora.org>
 <20180828003131.GD2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180828003131.GD2523@minitux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27 2018 at 18:31 -0600, Bjorn Andersson wrote:
>On Fri 24 Aug 13:01 PDT 2018, Lina Iyer wrote:
>
>> Enable TLMM IRQs to be sensed by PDC when we enter suspend. It is
>> possible that the TLMM may be powered off and not detect GPIOs that are
>> configured as wake up interrupts. By hooking into suspend callbacks, we
>> allow PDC IRQs to take over and wake up the system if wakeup interrupts
>> are triggered.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/pinctrl/qcom/pinctrl-sdm845.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
>> index 2ab7a8885757..cc333b8afb99 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
>> @@ -1297,10 +1297,16 @@ static const struct of_device_id sdm845_pinctrl_of_match[] = {
>>  	{ },
>>  };
>>
>> +static const struct dev_pm_ops msm_pinctrl_dev_pm_ops = {
>> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(msm_pinctrl_suspend_late,
>> +				     msm_pinctrl_resume_late)
>> +};
>> +
>
>I expect these four lines to be duplicated in every platform file, so I
>think it would be better to just move it to pinctrl-msm.c and extern
>declare it in pinctrl-msm.h.
>
Sure.

>>  static struct platform_driver sdm845_pinctrl_driver = {
>>  	.driver = {
>>  		.name = "sdm845-pinctrl",
>>  		.of_match_table = sdm845_pinctrl_of_match,
>> +		.pm = &msm_pinctrl_dev_pm_ops,
>>  	},
>>  	.probe = sdm845_pinctrl_probe,
>>  	.remove = msm_pinctrl_remove,
>
>Regards,
>Bjorn
