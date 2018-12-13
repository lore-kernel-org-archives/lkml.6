Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EB3C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37B12086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LW4mF41B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PdE1kqbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37B12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeLMWcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:32:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeLMWcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:32:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6185060722; Thu, 13 Dec 2018 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544740334;
        bh=BdeQTVEhx+OiI8GAjJO6EgneqyfQJOFlkV8VQCzRM9I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LW4mF41BojFdZbdko0Rz13XcVcF2ZsfCYVI47BTH41XLy/gB6LIa3iGp/nPe7Uytx
         f8d1MxBspalrysqQFaCgjXuX6cQDG5KfK21kB+lnFuANmNcvfTEkzv8OMHZsW3dwUA
         hAOmqNzbCy/43eAj/677mk9RYt1ZPuP1sTlB1C5E=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09DB660237;
        Thu, 13 Dec 2018 22:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544740333;
        bh=BdeQTVEhx+OiI8GAjJO6EgneqyfQJOFlkV8VQCzRM9I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PdE1kqbBiR62AveZkXMEkihW/pjooc5DnSBVtwYnHmsb2AHdd0YGBqf/L8z8uEs+e
         4rubcRfDGF7Hdke1JbLGzHBs7PuCXBMOjTRnoIa8vFWAN8WCkhi36l1IjPzMeqzhrF
         EAtyxdQxn1TwPqEDu6eduEFRqO0lLnjjMK/hwbpo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09DB660237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2] clk: qcom: Drop unused 8998 clock
To:     Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr
References: <1544720949-18404-1-git-send-email-jhugo@codeaurora.org>
 <154472988944.19322.6557891989616167911@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <d7ac2e27-8e9e-7ee1-430d-ed0f61d98171@codeaurora.org>
Date:   Thu, 13 Dec 2018 15:32:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154472988944.19322.6557891989616167911@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2018 12:38 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2018-12-13 09:09:09)
>> gcc_lpass_trig_clk is not used downstream, therefore there is no reason to
>> expect it to be needed for clients.  Let's remove it because messing with
>> the clock has been observed to cause Linux hangs when the qdss_clk is
>> initialized by rpmcc.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
>>
>> v2:
>> -corrected commit text per Marc
>> -added Marc's reviewed-by
> 
> Please slow down. There isn't any need to resend for such things.
> 

Sorry.  Used to other maintainers.
 From your v1 comment, would be
Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
I'm assuming from the above, you'll just apply the tag when you apply 
the change.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
