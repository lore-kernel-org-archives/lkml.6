Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id O/VIOKj7GFu/CQAAmS7hNA
	; Thu, 07 Jun 2018 09:32:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CCF12608B8; Thu,  7 Jun 2018 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528363944;
	bh=4kSh2kdSGfUQrKr0i0U66kwNNGOMuejcrRNmx568Its=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=T7B038ujRdx3QioP6lY+auBpwVHO6xam6pxRSWeZjQrCyBGNAGZ2LBLIt2wJ8dEVq
	 itRQ1yIK+pYXOWeSFQHzPOhOQZxlYgiteDVPDu+16K81q9JqNqhedG/+x7OG4uzqaR
	 hpdcIPOCT9tVpGVYzZizvgljH2jJemGOGxB9jcQA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 51A60605A2;
	Thu,  7 Jun 2018 09:32:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IIzDaeQq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EHiPzRNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51A60605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932548AbeFGJcX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:32:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932326AbeFGJcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:32:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A625605A2; Thu,  7 Jun 2018 09:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528363938;
        bh=4kSh2kdSGfUQrKr0i0U66kwNNGOMuejcrRNmx568Its=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IIzDaeQqLeityhHNH+TsuP0BWXSMCAeypzIyFnCX6hbF45eQKQmO3BXNznKQ27TgX
         ahLYB/GBV9cXHWSdw2fSjQbfljgdCvGXKjruH3278vac83oJR/3/kwTXAXiJK8c53k
         it72dvG5hL1v66sxOBW+64GCm5lWoIBoAnJVbfJE=
Received: from [10.201.3.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 296F5605A2;
        Thu,  7 Jun 2018 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528363937;
        bh=4kSh2kdSGfUQrKr0i0U66kwNNGOMuejcrRNmx568Its=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EHiPzRNglDXkeczAXDFKWv2pozfguw76ZuDcJYvzr+kBpyvWhousNAcqRG2i5AnQv
         eLf2ptErb6dPHhhTp5jjXbN2y1+bPzI2j4SwsHFzpaRutnxYxTEMnVAdkW8K1OiBNW
         d+eiV5xmMUfaxnAuPgYoka0Vk2mVMLMRNMefr2f4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 296F5605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
To: Vinod <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
 <20180606161733.GE510@tuxbook-pro> <20180607041134.GF16230@vkoul-mobl>
 <20180607042443.GK510@tuxbook-pro> <20180607084348.GG16230@vkoul-mobl>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <f5b05d4f-29d6-c698-3618-4ad6e42aef54@codeaurora.org>
Date: Thu, 7 Jun 2018 15:02:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607084348.GG16230@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180607-0, 06/07/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 6/7/2018 2:13 PM, Vinod wrote:
> On 06-06-18, 21:24, Bjorn Andersson wrote:
>> On Wed 06 Jun 21:11 PDT 2018, Vinod wrote:
>>
>>> So, wouldn't Kconfig syntax something like where we say:
>>>         M if RPMSG_QCOM_GLINK_SMEM=m
>>>         bool if RPMSG_QCOM_GLINK_SMEM=y
>>>
>>
>> If we ignore SMD for a while we have the following combinations:
>>
>> glink/wcss
>> y     y - valid
>> y     m - valid
>> y     n - valid
>> m     y - link failure (invalid)
>> m     m - valid
>> m     n - valid
>> n     y - valid (platform uses wcss, but not glink)
>> n     m - valid (-----"-----)
>> n     n - valid
>>
>> So to distill this we have the two valid cases:
>> module/no if RPMSG_QCOM_GLINK_SMEM=m
>> yes/module/no if RPMSG_QCOM_GLINK_SMEM=y
>>
>> and the way you express that in Kconfig is the somewhat awkward
>>
>>   depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> 
> Understood now :) Yes it is awkward..
> 
> Btw we seem to have issue with link fail here when glink is m and wcss
> is y. Why don't we see link fail for glink being n? Yes I understand that
> platform uses wcss but am curious how that works out :)
 
For glink being n, the stub functions gets linked, and not for glink=m.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
