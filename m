Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B00C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891E420834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jzEhwnKu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jzEhwnKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891E420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLEBON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:14:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41400 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeLEBON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:14:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D767607B5; Wed,  5 Dec 2018 01:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543972452;
        bh=tMq/JbmF+7+Xpm7/CqrLGIipD7JS9OZhUMrPacJtuTA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jzEhwnKub+FWy+UkaUCWQAadnKKOBW+Zjq0fx1W8HruZMu/tc6UxQlwbVY2b85WWW
         KIwIfp46W8+Yb3ayvHQXPzuC+Eukb2eKp/FK4yWP8hCryGpFhkrhARlXOKCh6fyx1J
         Wd+EIJRIbpd2IzQhgN6y2cfhKdjv+lgab4fKYJF8=
Received: from [10.46.162.234] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55F88602F4;
        Wed,  5 Dec 2018 01:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543972452;
        bh=tMq/JbmF+7+Xpm7/CqrLGIipD7JS9OZhUMrPacJtuTA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jzEhwnKub+FWy+UkaUCWQAadnKKOBW+Zjq0fx1W8HruZMu/tc6UxQlwbVY2b85WWW
         KIwIfp46W8+Yb3ayvHQXPzuC+Eukb2eKp/FK4yWP8hCryGpFhkrhARlXOKCh6fyx1J
         Wd+EIJRIbpd2IzQhgN6y2cfhKdjv+lgab4fKYJF8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55F88602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
To:     Stephen Boyd <sboyd@kernel.org>, Alex Elder <elder@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
 <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
 <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
 <8dafe631-4b16-94cd-392e-84728f2bb382@linaro.org>
 <154396284056.88331.12279283832884556349@swboyd.mtv.corp.google.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <edeebce5-24a2-b844-6bff-781017949e2d@codeaurora.org>
Date:   Tue, 4 Dec 2018 17:14:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154396284056.88331.12279283832884556349@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/2018 2:34 PM, Stephen Boyd wrote:
> Quoting Alex Elder (2018-12-04 13:41:47)
>> On 12/4/18 1:24 PM, Stephen Boyd wrote:
>>> Quoting David Dai (2018-12-03 19:50:13)
>>>> Add IPA clock support by extending the current clk rpmh driver to support
>>>> clocks that are managed by a different type of RPMh resource known as
>>>> Bus Clock Manager(BCM).
>>> Yes, but why? Does the IPA driver need to set clk rates and that somehow
>>> doesn't work as a bandwidth request?
>> The IPA core clock is a *clock*, not a bus.  Representing it as if
>> it were a bus, abusing the interconnect interface--pretending a bandwidth
>> request is really a clock rate request--is kind of kludgy.  I think Bjorn
>> and David (and maybe Georgi? I don't know) decided a long time ago that
>> exposing this as a clock is the right way to do it.  I agree with that.
>>
> But then we translate that clock rate into a bandwidth request to the
> BCM hardware? Seems really weird because it's doing the opposite of what
> you say is abusive. What does the IPA driver plan to do with this clk?
> Calculate a frequency by knowing that it really boils down to some
> bandwidth that then gets converted back into some clock frequency? Do we
> have the user somewhere that can be pointed to?
The clock rate is translated into a unitless threshold value sent as 
part of the rpmh msg
that BCM takes to select a performance. In this case, the unit 
conversion is based on
the unit value read from the aux data which is in Khz. I understand that 
this wasn't
explicitly mentioned anywhere and I'll improve on that next patch. 
Here's a link to
the IPA driver implementation: https://lkml.org/lkml/2018/11/7/220

>
> Of course, none of these details are in the commit text so it's really
> hard for me as a bystander to figure this all out.  So again, please add
> these sorts of details to the commit text so we can be "sold" on the
> idea of the patch instead of stating what the patch does.
Understood, I'll be as detailed and as explicit as I can in the future.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

