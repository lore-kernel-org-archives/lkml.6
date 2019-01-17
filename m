Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6675BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35ACB2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TqsTivjY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TqsTivjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAQKjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:39:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56336 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfAQKi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:38:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF6CD60807; Thu, 17 Jan 2019 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547721538;
        bh=Qavo8mmtgJddz2ii2CbmcaSj9WDDVzTXexKEQj41nCA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TqsTivjYgfgg/tJuNEWhxrbIHcpU+HDyurK/L2f4mdlzoSVSW+0U9LICjsPUbOOkJ
         aWU8foc1i+sRrgdzzOcbdcu8WodEVsRxl+6zVYKPGgwWrSRzZANWh1K66Ii0tjmf4N
         BCIoqmIrqBP2aNR1LTyNcmUlAIm5TUTnks6kG2xM=
Received: from [10.79.128.65] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BBF36024C;
        Thu, 17 Jan 2019 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547721538;
        bh=Qavo8mmtgJddz2ii2CbmcaSj9WDDVzTXexKEQj41nCA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TqsTivjYgfgg/tJuNEWhxrbIHcpU+HDyurK/L2f4mdlzoSVSW+0U9LICjsPUbOOkJ
         aWU8foc1i+sRrgdzzOcbdcu8WodEVsRxl+6zVYKPGgwWrSRzZANWh1K66Ii0tjmf4N
         BCIoqmIrqBP2aNR1LTyNcmUlAIm5TUTnks6kG2xM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BBF36024C
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
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
Date:   Thu, 17 Jan 2019 16:08:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117093113.GA23389@basecamp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 1/17/2019 3:01 PM, Brian Masney wrote:
> 
> You can use the __maybe_unused attribute to remove the #ifdef:
> 
> static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> 

Thanks for looking into this.

As for __maybe_unused, I think it's better to keep #ifdef rather than
this attribute which seems to be meaning unused when actually its 
possible that it's used often(PM_SLEEP is def y). It's like saying 
unused when you are actually using it. The attribute seems like a
hack to avoid compilation error. Please correct me if I am wrong.

  - Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
