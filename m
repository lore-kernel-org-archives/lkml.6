Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SNq6Ht3CGFu2RgAAmS7hNA
	; Thu, 07 Jun 2018 05:30:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 46E90608BA; Thu,  7 Jun 2018 05:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528349409;
	bh=NXYPMdstNUadT3rj+nnRQqW1HGGBC7HRT84vatrQTIk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hFsh+kKxLFQVPASb6w4hXLDocaMBVBnfIeuzcJa7mv2TkX/g58CQIhvjKeZZ2DJG4
	 HwRNq/y71LuK0RDMHYn8roxuyPhwcMLKSFv0630iDfpJnbLvn0cv+KbWFTd8S6fjG5
	 Twjffp4YS32n9RKbeCQu9JLS63k4CGA0APdblTws=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AFDC4607DC;
	Thu,  7 Jun 2018 05:30:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oTNAt0X6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZPyoaUKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFDC4607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeFGFaH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:30:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33740 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeFGFaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:30:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7CE71608B8; Thu,  7 Jun 2018 05:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528349404;
        bh=NXYPMdstNUadT3rj+nnRQqW1HGGBC7HRT84vatrQTIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oTNAt0X6zjHOdIVFdMS6Zy9/AAXWIc+M6OaiXYboasjdHNtYE/uQLvZ6RCOD02AYQ
         RF4ZjwgRnSYbtO9Ne5CkaQ06wfWbJxQotfu+oBR08MKXyv91lSeVCabbk9nt3e1lAo
         xe6U4MiaIs2WGhbaNpo8VpvJjsKX4bpnDu7qoa6U=
Received: from [10.201.3.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EB39607DC;
        Thu,  7 Jun 2018 05:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528349403;
        bh=NXYPMdstNUadT3rj+nnRQqW1HGGBC7HRT84vatrQTIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZPyoaUKnw/+Ygi9uCfVFomOScZcvuLU+ndpyPLZj2RBjK7Gs6IG6/rMCdZpek+Emf
         TsPcmwiIdBoaVdXFzPpO6HkNCi1EBqc7Y0eqYl1Tp4cnTvnGS0LGI23LDo/phMzn/v
         PG5R/3Me2bJZGcmaGcogbUuOxYE3CuTgqCPXrrQI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EB39607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod <vkoul@kernel.org>
Cc: ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
 <20180606161733.GE510@tuxbook-pro> <20180607041134.GF16230@vkoul-mobl>
 <20180607042443.GK510@tuxbook-pro>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <d01d6819-3f95-0b65-1251-aead88fe86cc@codeaurora.org>
Date: Thu, 7 Jun 2018 10:59:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607042443.GK510@tuxbook-pro>
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

On 6/7/2018 9:54 AM, Bjorn Andersson wrote:
> On Wed 06 Jun 21:11 PDT 2018, Vinod wrote:
> 
>> On 06-06-18, 09:17, Bjorn Andersson wrote:
>>> On Tue 05 Jun 05:56 PDT 2018, Sricharan R wrote:
>>>
>>>> Hi Vinod,
>>>>
>>>> On 6/5/2018 11:49 AM, Vinod wrote:
>>>>> On 05-06-18, 11:12, Sricharan R wrote:
>>>>>
>>>>>> +config QCOM_Q6V5_WCSS
>>>>>> +	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
>>>>>> +	depends on OF && ARCH_QCOM
>>>>>> +	depends on QCOM_SMEM
>>>>>> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>>>>>> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>>>>>
>>>>> Is there a reason why it depends on RPMSG_QCOM_GLINK_SMEM=n? What would
>>>>> happen if distro wants both this and RPMSG_QCOM_GLINK_SMEM
>>>>>
>>>
>>> It says that QCOM_Q6V5_WCSS either must have a compatible state (i.e.
>>> builtin vs builtin, module vs builtin, but not builtin vs module) or
>>> that it's disabled, in which case we will hit the stub functions in
>>> qcom_glink.h.
>>>
>>> I.e. this prevents QCOM_Q6V5_WCSS to be compiled builtin when
>>> RPMSG_QCOM_GLINK_SMEM is module, as this would give us both stubs and
>>> the module.
>>
>> IIUC, you want to have QCOM_Q6V5_WCSS and RPMSG_QCOM_GLINK_SMEM as
>> modules or builtin
>>
> 
> RPMSG_QCOM_SMD, RPMSG_QCOM_GLINK_SMEM and QCOM_Q6V5_WCSS are all
> tristate.
> 
>> So, wouldn't Kconfig syntax something like where we say:
>>         M if RPMSG_QCOM_GLINK_SMEM=m
>>         bool if RPMSG_QCOM_GLINK_SMEM=y
>>
> 
> If we ignore SMD for a while we have the following combinations:
> 
> glink/wcss
> y     y - valid
> y     m - valid
> y     n - valid
> m     y - link failure (invalid)
> m     m - valid
> m     n - valid
> n     y - valid (platform uses wcss, but not glink)
> n     m - valid (-----"-----)
> n     n - valid
> 
> So to distill this we have the two valid cases:
> module/no if RPMSG_QCOM_GLINK_SMEM=m
> yes/module/no if RPMSG_QCOM_GLINK_SMEM=y
> 
> and the way you express that in Kconfig is the somewhat awkward
> 
>   depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> 

 ok, Having "depends on RPMSG_QCOM_GLINK_SMEM" takes care of the
 first 6 cases in the above list.

 But just was thinking that by allowing the last three combinations,
 there is a chance that some config that really needs GLINK_SMEM and WCSS,
 but selects only Q6V5_WCSS and misses to select GLINK_SMEM,
 would still built and make it non-functional, right ?

Regards,
 Sricharan

>> Which makes it clear that both these have to be same type?
>>
> 
> They don't have to be of the same type, only of a compatible type.
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
