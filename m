Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98171C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640D120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AHvhLIpX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AHvhLIpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfAQP0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:26:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:26:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E29156075A; Thu, 17 Jan 2019 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547738799;
        bh=Eh7BZcnU83UYilT74nCSDcWVEqhPxCKF44S8khxhtKw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AHvhLIpXUEUCXN9Wp1xuh51lwlGqkJm+YJ+/6wPmn7MjYPTvYaKXD0l54EpnIgWjg
         ZuCtWaNKVrckfUitnqjanIbWmkKOrjhMjEgt4IiprInTS3SJmUNQHFUOdedq4zQMKY
         4QR3FM5DvBK4q5qCtjK5pk2fpBLk3fHiYaAzmDrQ=
Received: from [192.168.1.100] (unknown [157.45.228.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02B336053B;
        Thu, 17 Jan 2019 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547738799;
        bh=Eh7BZcnU83UYilT74nCSDcWVEqhPxCKF44S8khxhtKw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AHvhLIpXUEUCXN9Wp1xuh51lwlGqkJm+YJ+/6wPmn7MjYPTvYaKXD0l54EpnIgWjg
         ZuCtWaNKVrckfUitnqjanIbWmkKOrjhMjEgt4IiprInTS3SJmUNQHFUOdedq4zQMKY
         4QR3FM5DvBK4q5qCtjK5pk2fpBLk3fHiYaAzmDrQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02B336053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To:     Guenter Roeck <linux@roeck-us.net>,
        Brian Masney <masneyb@onstation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <747da233-8b8c-2aa9-59cf-542ab46cc161@codeaurora.org>
Date:   Thu, 17 Jan 2019 20:56:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2019 8:49 PM, Sai Prakash Ranjan wrote:
> This adds the support for qcom watchdog suspend and resume
> when entering and exiting deep sleep states. Otherwise
> having watchdog active after suspend would result in unwanted
> crashes/resets if resume happens after a long time.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> 
> v2:
>   * Use __maybe_unused instead of #ifdef as suggested by
>     Brian and Guenter
> ---
>   drivers/watchdog/qcom-wdt.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> 

Adding Brian.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
