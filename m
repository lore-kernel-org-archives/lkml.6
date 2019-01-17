Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CADAC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2953020657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W3Y5E5SZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UOWTVvWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAQNAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:00:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47866 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfAQNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:00:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BEE4E6086A; Thu, 17 Jan 2019 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547730051;
        bh=Z2vlCHQaX9hPpwydG9WyKUvmg7ZYlm2Wytwvz3kS4vw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W3Y5E5SZ4b86u+yjU6zPgLBzSC2HSQaS+akm7S9JhQtfj3boQYC3G+M2Szr63K6Ta
         a94dk0qcFdMRQurwD6DoWgXVnDrZ/SIjqnszmnxLiTzfmhVJ+iL1XrwTB6wUhuZt94
         X9ATYZcpD7stR+ghyd74OhuiMFeGCcX+rdETfXa4=
Received: from [192.168.43.47] (unknown [106.193.6.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 700EE6053B;
        Thu, 17 Jan 2019 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547730050;
        bh=Z2vlCHQaX9hPpwydG9WyKUvmg7ZYlm2Wytwvz3kS4vw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UOWTVvWXExdPIS5ZaKGB+GKYWDcRiB1O2ZGZItmOlwkj3Sdrd0AxmWOMODLLX/AB5
         bBIg0stevM853SzYZhQEdRN5vXPf7dmHP+dy4Uw2/tIiMLPjvwEJE3L1R7atYwEJom
         ZyuUufrTaOjCwwYYg2pXdc5IsGNdn0xxmO9c6y0g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 700EE6053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
To:     Brian Masney <masneyb@onstation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
 <20190117093113.GA23389@basecamp>
 <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
 <20190117112730.GA25198@basecamp>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <b9f573ec-3787-2b05-52e3-60f11c061dd7@codeaurora.org>
Date:   Thu, 17 Jan 2019 18:30:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117112730.GA25198@basecamp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2019 4:57 PM, Brian Masney wrote:
> 
> That attribute suppresses a warning from the compiler if the function is
> unused when PM_SLEEP is disabled.  I don't consider it hackish since the
> function name no longer appears outside the #ifdef. For example:
> 
> 	#ifdef CONFIG_PM_SLEEP
> 	static int qcom_wdt_suspend(struct device *dev)
> 	{
> 		...
> 	}
> 	#endif /* CONFIG_PM_SLEEP */
> 
> 	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);
> 
> SIMPLE_DEV_PM_OPS (actually SET_SYSTEM_SLEEP_PM_OP) includes the check
> for PM_SLEEP and its a noop if PM_SLEEP is disabled so this works.
> 
> Now here's the code with __maybe_unused:
> 
> 	static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> 	{
> 		...
> 	}
> 
> 	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);
> 
> This will still be a NOOP when power management is disabled, but have
> the benefit of increased compile-time test coverage in that situation.
> The symbols won't be included in the final executable. I personally
> think the code a is cleaner with __maybe_unused.
> 
> This pattern is already in use across various subsystems in the kernel
> for suspend and resume functions:
> 
> $ git grep __maybe_unused | egrep "_suspend|_resume"  | wc -l
> 767
> 

Thanks for the explanation Brian.

But I did see the maybe_unused attribute usage in other suspend and 
resume functions before posting and decided to go with ifdef because
I think this attribute wastes CPU time by building and later discarding 
if the function is unused (it may be negligible).

I did not understand the increased compile-time test coverage
you mentioned when PM_SLEEP=n because why would we need to compile
when the config is disabled? We could just discard it. We would just
increase the build time with this attribute (although for this case it 
would be negligible but say we compile with PM_SLEEP disabled for all 
those suspend/resume functions with maybe_unused attribute).

Looking at previous discussions in LKML[1] as to why the pm 
suspend/resume functions used __maybe_unused seemes to be because of
wrong ifdef usage. For ex: Using #ifdef CONFIG_PM instead of
#ifdef CONFIG_PM_SLEEP would result in a warning when
CONFIG_PM_SLEEP=n but CONFIG_PM=y.

Anyways, *I am OK with either of them*, after some more review on the
patch I can make the change in next version of the patch.

[1] https://lore.kernel.org/patchwork/patch/732981/

- Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
