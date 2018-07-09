Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90371C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4569220857
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kk8vrNvZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i4PLtvuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4569220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeGIJeS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:34:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932366AbeGIJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:34:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A499602AE; Mon,  9 Jul 2018 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531128855;
        bh=LVZcKDVZRURUYXmo7D59nFQS+yOIj566mfjlEW2WF4g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kk8vrNvZPTjD2t8YzwZPfMACOTv9u7JlYZYgQIhv5QgVlqELrotYnKnTHHc4zoFW1
         iMdNb4kjRyGMJjCj8fUyMpT4HdkC1ZmPpmJMIak1ZR7tjyUoylpo8MAieYMs0kQp0i
         2+wBesyhT7z3hS6zFYYe7buJ6qL8P+o6n4BEt8r4=
Received: from [10.79.165.52] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B13E660591;
        Mon,  9 Jul 2018 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531128854;
        bh=LVZcKDVZRURUYXmo7D59nFQS+yOIj566mfjlEW2WF4g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i4PLtvuXn2O88i0jcLIfR7/tarqDJ0hMaOkn1C91vgJxu+tVGUucvhihgsAIpONs9
         k8DHXObd0n7nWsMxJVCrI6OpWH/1t7vRWBwK0k75JxueGM/+9635YhaXEFsOqlhm9n
         b1f7g9lFmdmKylaSn4q7Qy3GXK2bFr91VYNFTRMY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B13E660591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
 <153109408562.143105.15954380130353645468@swboyd.mtv.corp.google.com>
 <10f87216-caa2-d523-e134-6cf3acd268a7@codeaurora.org>
 <153111701079.143105.13387458941681113476@swboyd.mtv.corp.google.com>
 <436cc6a3-7406-c695-7879-3b9d042262cc@codeaurora.org>
 <153112184177.143105.15452587215679149679@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <288770be-a763-b287-f62a-72ab7616efdb@codeaurora.org>
Date:   Mon, 9 Jul 2018 15:04:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <153112184177.143105.15452587215679149679@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2018 1:07 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-07-09 00:07:21)
>>
>>
>> On 7/9/2018 11:46 AM, Stephen Boyd wrote:
>>>>
>>>>    > Why is the nocache flag needed? Applies to all clks in this file.
>>>>    >
>>>>
>>>> This flag is required for all RCGs whose PLLs are controlled outside the
>>>> clock controller. The display code would require the recalculated rate
>>>> always.
>>>
>>> Right. Why is the PLL controlled outside of the clock controller? The
>>> rate should propagate upward to the PLL from here, so who's going
>>> outside of that?
>>>
>> The DSI0/1 PLL are not part of the display clock controller, but in the
>> display subsystem which are managed by the DRM drivers. When DRM drivers
>> query for the rate clock driver should always return the non cached rates.
> 
> Why? Is the DSI PLL changing rate all the time, randomly, without going
> through the clk APIs to do so?
>

Hmm, I am afraid I do not have an answer for this, but this was the 
requirement to always return the non cached rates from the clock driver.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
