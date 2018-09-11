Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B41FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B553B20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fmbxLk4S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MoMmplSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B553B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeIKOkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:40:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeIKOkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:40:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A9576034D; Tue, 11 Sep 2018 09:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536658900;
        bh=GahCwrQBAg1XMUeIE0IMTIbbzy6eeFYneAxbGHpBIps=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fmbxLk4ShQXRAyD1981cYPK9c4J8hykEQz0w7RFAOxqgLtkFoUCQ6GzC0OlZW0Uge
         6nsWgxgPHH4Fb4v97kb0hUaPqyKt1yVcbftv11gQKR9QdVeieslC4sye/BQjymXp+K
         KM7IUwmVm2oNkY0ceLPpj7JvNfOqZZtFAL8fX7TI=
Received: from [10.79.128.64] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE2746034D;
        Tue, 11 Sep 2018 09:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536658899;
        bh=GahCwrQBAg1XMUeIE0IMTIbbzy6eeFYneAxbGHpBIps=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MoMmplSgR36DR+d+jPBAisI7R+lEEzZWiZ1xICHnL5Xa1zsEGRJbvDfXVmxvkXhOV
         LWNYygwsQB+T/6VcCbSMbEikvKg4sQt1bZ7XC6P2vYcjnQvQmk8QFDzgSaLSSCdNhv
         oq1mAWEwCVR9bkIfETHGZVHjT+Gkz3/1hb06s9IU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE2746034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v4 3/4] drivers: edac: Add EDAC driver support for QCOM
 SoCs
To:     vnkgutta@codeaurora.org
Cc:     Borislav Petkov <bp@alien8.de>, evgreen@chromium.org,
        robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
References: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
 <1536103345-1919-4-git-send-email-vnkgutta@codeaurora.org>
 <105f8339-61bc-072e-0498-ed44470a5fb8@codeaurora.org>
 <5d8f92b480e1b53e7e04da965d44f7ea@codeaurora.org>
 <b35f111c-0464-dcee-c970-4821f741694b@codeaurora.org>
 <b5d9a1dc741e09db6d4044f4d82f83d9@codeaurora.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <a8fff11e-5821-f191-ed2e-ec99fadcb5e6@codeaurora.org>
Date:   Tue, 11 Sep 2018 15:11:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b5d9a1dc741e09db6d4044f4d82f83d9@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 4:15 AM, vnkgutta@codeaurora.org wrote:
> On 2018-09-06 22:02, Sai Prakash Ranjan wrote:
>> On 9/7/2018 4:01 AM, vnkgutta@codeaurora.org wrote:
>>> On 2018-09-06 05:38, Sai Prakash Ranjan wrote:
>>>> On 9/5/2018 4:52 AM, Venkata Narendra Kumar Gutta wrote:
>>>>> +static const struct of_device_id qcom_llcc_edac_match_table[] = {
>>>>> +    { .compatible = "qcom,llcc-edac" },
>>>>> +    { },
>>>>> +};
>>>>> +
>>>>>
>>>> Hi Venkata,
>>>>
>>>> Devicetree binding for llcc is updated, but what about this compatible?
>>>
>>> Does it need documentation too? I was not sure if I should add 
>>> documentation for this or not!
>>>
>>
>> It does not require a separate binding, what I meant was to add this
>> compatible in the llcc binding itself, maybe as a subnode if it is
>> correct.
> 
> Hi,
> 
> We aren't really using this of_device_id structure, as this driver is 
> being registered from LLCC through
> platform_register_device_data(...). This structure initialization is 
> just dead code as this driver won't be probed based on the DT entries.
> 
> Hence removing this compatible property and the corresponding struct in 
> the next patchset.
> 
> So, this doesn't need an extra binding/documentation.

Ok. Now that you have removed the compatible, it should be fine.

Thanks
