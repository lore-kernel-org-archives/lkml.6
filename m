Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6009EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3E120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n3upj/q5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GLFI0x/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfAQPHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:07:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfAQPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:07:22 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 62D126081E; Thu, 17 Jan 2019 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547737641;
        bh=B94wqvUG1zQiQ7J/DXu6pKDX2bWVrpTumpBEZo9Wp8U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n3upj/q5AHlbdPJ8EHdOfiGoHJSfGM87KCD1c1f1VfoS+2G9AV0i9fP+qKasiEocy
         mxOjSmJ97A36w/9Su610VExcfFEv+fFSP7cKjZfmDjOY42BJT5VyHGDWBwHQeEtedk
         ShF/p2RXRLgPNwjgf3S18Xdo+VSCrhIJ4tJoSuWI=
Received: from [192.168.1.100] (unknown [157.45.228.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F6A5606E1;
        Thu, 17 Jan 2019 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547737640;
        bh=B94wqvUG1zQiQ7J/DXu6pKDX2bWVrpTumpBEZo9Wp8U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GLFI0x/VM/jnJ/w/1V3u4xcNCtHIYPL1ZZVNLW+0TJi8ihJEV44fa1DcA5ITAKBvT
         U+DJQiVvYOalcaD0XZuEYcclzmtQ5Pd10S8oyO4m9KhZcKLuYVlH9EK75hApzO7PkU
         pKoiKCT+CwPnghjsYx3LETSIBKre0XGpr858qTzY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F6A5606E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Brian Masney <masneyb@onstation.org>,
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
 <b9f573ec-3787-2b05-52e3-60f11c061dd7@codeaurora.org>
 <20190117143044.GA30757@roeck-us.net>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <4bd782a4-1534-28bf-78d3-c14b677641b0@codeaurora.org>
Date:   Thu, 17 Jan 2019 20:37:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117143044.GA30757@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 1/17/2019 8:00 PM, Guenter Roeck wrote:
> 
> I personally very much prefer __maybe_unused over #ifdef, for the reasons
> stated above. Other maintainers may think differently.
> 

Thanks for making your preference clear. I will post the second version
soon with the changes.

- Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
