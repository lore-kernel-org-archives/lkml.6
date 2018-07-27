Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBEFC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D3420673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lxbpyCUg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lxbpyCUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D3420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeG0JG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:06:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeG0JG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:06:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DFE0360B11; Fri, 27 Jul 2018 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532677579;
        bh=mqpBJQG/XiRjt3KRLR3w9qqfEGIQ1U/s8uhyj8gCcOw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lxbpyCUgzG/yDLdJHzO4yLT8etJ5QzG440gXp7KFbOBh/5ko2/ukAQSD/XXvq2hIG
         i4VnBH2+yE4XojwmZxMAKUHlaTm/uv6D4HxNnrGEevGsMIuVh7nCmDwlK2pFLPe9WD
         QTaJFRSWkKwWsDrwYH2qfY/hqcmaTZSKO48SMzq4=
Received: from [192.168.225.247] (unknown [49.33.239.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13DDF602AE;
        Fri, 27 Jul 2018 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532677579;
        bh=mqpBJQG/XiRjt3KRLR3w9qqfEGIQ1U/s8uhyj8gCcOw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lxbpyCUgzG/yDLdJHzO4yLT8etJ5QzG440gXp7KFbOBh/5ko2/ukAQSD/XXvq2hIG
         i4VnBH2+yE4XojwmZxMAKUHlaTm/uv6D4HxNnrGEevGsMIuVh7nCmDwlK2pFLPe9WD
         QTaJFRSWkKwWsDrwYH2qfY/hqcmaTZSKO48SMzq4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13DDF602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v5] clk: qcom: Add display clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532343275-7027-1-git-send-email-tdas@codeaurora.org>
 <1532343275-7027-2-git-send-email-tdas@codeaurora.org>
 <153264274182.48062.5474788613503562604@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <e9771a35-d35f-18d2-2447-2c969cb8fc09@codeaurora.org>
Date:   Fri, 27 Jul 2018 13:15:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153264274182.48062.5474788613503562604@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2018 3:35 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-07-23 03:54:35)
>> Add support for the display clock controller found on SDM845
>> based devices. This would allow display drivers to probe and
>> control their clocks.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
> 
> This is fine to merge as long as you're ok with removing the no rate
> cache flag. I can do that myself so you don't have to resend.
> 

Thanks, please go ahead and remove the flags, in case the display 
drivers would require the flags for any proper use case then we could 
think on re-introducing them.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
