Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RDcCHlbSGFuFKAAAmS7hNA
	; Thu, 07 Jun 2018 06:36:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 071F76089E; Thu,  7 Jun 2018 06:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528353374;
	bh=c+ify53pfebEvXsh/EPaIA+yRy8KGlmssNOysdJU3U8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AwDPNWeC4KeMKIYutzvN8dp4hLbJqSrCWvB6tfdG6qZYlt9quO4M8YmIfosK0MJUX
	 ugG2mnd3atwgKrguU5lnTW5YYZArDsCXoB6Nv/XmIRIgRzoFL9Z4qQhNGfcOybzmOL
	 J0gCQg+7M8MTr79WKI9Ly2jwjxau5snFKCo/TKkk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E5D0605A2;
	Thu,  7 Jun 2018 06:36:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fpixedBJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fpixedBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E5D0605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeFGGgL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:36:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeFGGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:36:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA4EA601B4; Thu,  7 Jun 2018 06:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528353366;
        bh=c+ify53pfebEvXsh/EPaIA+yRy8KGlmssNOysdJU3U8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fpixedBJBd5b/gM1YdbgLo3oSaLjSm4OAgJHm1PZhgL2RU11N4JTPjs8OTnbfaEVF
         Om/ePWYQ11ixDj67cDrhhsXRxt5MKCw6eTdnvG65LzKRnihuXTcYr9PpSF+RS4rgcK
         0ukRM0vVZq2iFpBXYWQR5LsxaA2pHCriJU9Bkuo8=
Received: from [10.201.3.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABE3C605A2;
        Thu,  7 Jun 2018 06:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528353366;
        bh=c+ify53pfebEvXsh/EPaIA+yRy8KGlmssNOysdJU3U8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fpixedBJBd5b/gM1YdbgLo3oSaLjSm4OAgJHm1PZhgL2RU11N4JTPjs8OTnbfaEVF
         Om/ePWYQ11ixDj67cDrhhsXRxt5MKCw6eTdnvG65LzKRnihuXTcYr9PpSF+RS4rgcK
         0ukRM0vVZq2iFpBXYWQR5LsxaA2pHCriJU9Bkuo8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABE3C605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod <vkoul@kernel.org>, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sibis@codeaurora.org
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
 <20180606161733.GE510@tuxbook-pro> <20180607041134.GF16230@vkoul-mobl>
 <20180607042443.GK510@tuxbook-pro>
 <d01d6819-3f95-0b65-1251-aead88fe86cc@codeaurora.org>
 <20180607054838.GM510@tuxbook-pro>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <b89ea4db-0b74-7381-3594-b7684900dd19@codeaurora.org>
Date: Thu, 7 Jun 2018 12:06:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607054838.GM510@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180606-4, 06/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 6/7/2018 11:18 AM, Bjorn Andersson wrote:
> On Wed 06 Jun 22:29 PDT 2018, Sricharan R wrote:
> 
>> Hi Bjorn,
>>
>> On 6/7/2018 9:54 AM, Bjorn Andersson wrote:
>>> On Wed 06 Jun 21:11 PDT 2018, Vinod wrote:
>>>
>>>> On 06-06-18, 09:17, Bjorn Andersson wrote:
>>>>> On Tue 05 Jun 05:56 PDT 2018, Sricharan R wrote:
>>>>>
>>>>>> Hi Vinod,
>>>>>>
>>>>>> On 6/5/2018 11:49 AM, Vinod wrote:
>>>>>>> On 05-06-18, 11:12, Sricharan R wrote:
> [..]
>>> If we ignore SMD for a while we have the following combinations:
>>>
>>> glink/wcss
>>> y     y - valid
>>> y     m - valid
>>> y     n - valid
>>> m     y - link failure (invalid)
>>> m     m - valid
>>> m     n - valid
>>> n     y - valid (platform uses wcss, but not glink)
>>> n     m - valid (-----"-----)
>>> n     n - valid
>>>
>>> So to distill this we have the two valid cases:
>>> module/no if RPMSG_QCOM_GLINK_SMEM=m
>>> yes/module/no if RPMSG_QCOM_GLINK_SMEM=y
>>>
>>> and the way you express that in Kconfig is the somewhat awkward
>>>
>>>   depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>>>
>>
>>  ok, Having "depends on RPMSG_QCOM_GLINK_SMEM" takes care of the
>>  first 6 cases in the above list.
>>
>>  But just was thinking that by allowing the last three combinations,
>>  there is a chance that some config that really needs GLINK_SMEM and WCSS,
>>  but selects only Q6V5_WCSS and misses to select GLINK_SMEM,
>>  would still built and make it non-functional, right ?
>>
> 
> It would allow you to compile a kernel with GLINk disabled that in
> runtime loads a firmware that depends on GLINK being there.
> 
> As it would be convenient to thereby state that "WCSS always depends on
> GLINK" we can make the analog to 410 where "MSS always depends on SMD",
> which isn't true when the same driver is reused on e.g. 845 - which
> uses GLINK.
> 
> 
> So my recommendation is that we stick with Kconfig options that
> describes the build time dependencies of this particular driver, rather
> than its runtime dependencies in a particular platform.
> 

ok thanks. It sort of gave an impression that the last three combinations in
the above list was only for "compile testing". Hence was thinking to have
(COMPILE_TEST && RPMSG_QCOM_GLINK_SMEM=n). Anyways for WCSS, would drop 
the dependency on SMD and just have RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
