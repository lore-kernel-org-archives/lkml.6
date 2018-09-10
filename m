Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9614C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D162086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I4ptadFO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GA0g2Qkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D162086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeIKDmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 23:42:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeIKDmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 23:42:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2C2156083C; Mon, 10 Sep 2018 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536619559;
        bh=yxtMKecAwj0lbLPVmY0p55pKJ3bqn40PsLVleDIrGUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I4ptadFOZjb2bVQJVTq80AJUAh+51LXN2qW0P9xo3k50pvVtwNVFuo2ezu1+fnFg5
         cDiz5oxwJHIqRIHA5YxRo98j4eHffZ39w3elAnF69ydBBpOqW/xOI2vbTIBbIprub6
         zCFT4Ogc9/pk9MfSPhCHpnk/9wdrMqvnQs14WK9I=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7794C607EB;
        Mon, 10 Sep 2018 22:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536619558;
        bh=yxtMKecAwj0lbLPVmY0p55pKJ3bqn40PsLVleDIrGUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GA0g2QkkJFlJ9l38NIR87RECayR/TXsz18+yuQ4m47pm+eVco1FH9VH+P9eRiWhe2
         zXtq222rScsaTDfdsrFdt7JFOKcyQ67BXx3KntziRDhSoawWxN501ZmoSDepnOSbp5
         kJrnc4yQk2wXyra+SEoBXiyUSZe6P+NmeW3VabTU=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 10 Sep 2018 15:45:58 -0700
From:   vnkgutta@codeaurora.org
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Borislav Petkov <bp@alien8.de>, evgreen@chromium.org,
        robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v4 3/4] drivers: edac: Add EDAC driver support for QCOM
 SoCs
In-Reply-To: <b35f111c-0464-dcee-c970-4821f741694b@codeaurora.org>
References: <1536103345-1919-1-git-send-email-vnkgutta@codeaurora.org>
 <1536103345-1919-4-git-send-email-vnkgutta@codeaurora.org>
 <105f8339-61bc-072e-0498-ed44470a5fb8@codeaurora.org>
 <5d8f92b480e1b53e7e04da965d44f7ea@codeaurora.org>
 <b35f111c-0464-dcee-c970-4821f741694b@codeaurora.org>
Message-ID: <b5d9a1dc741e09db6d4044f4d82f83d9@codeaurora.org>
X-Sender: vnkgutta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-06 22:02, Sai Prakash Ranjan wrote:
> On 9/7/2018 4:01 AM, vnkgutta@codeaurora.org wrote:
>> On 2018-09-06 05:38, Sai Prakash Ranjan wrote:
>>> On 9/5/2018 4:52 AM, Venkata Narendra Kumar Gutta wrote:
>>>> +static const struct of_device_id qcom_llcc_edac_match_table[] = {
>>>> +    { .compatible = "qcom,llcc-edac" },
>>>> +    { },
>>>> +};
>>>> +
>>>> 
>>> Hi Venkata,
>>> 
>>> Devicetree binding for llcc is updated, but what about this 
>>> compatible?
>> 
>> Does it need documentation too? I was not sure if I should add 
>> documentation for this or not!
>> 
> 
> It does not require a separate binding, what I meant was to add this
> compatible in the llcc binding itself, maybe as a subnode if it is
> correct.

Hi,

We aren't really using this of_device_id structure, as this driver is 
being registered from LLCC through
platform_register_device_data(...). This structure initialization is 
just dead code as this driver won't be probed based on the DT entries.

Hence removing this compatible property and the corresponding struct in 
the next patchset.

So, this doesn't need an extra binding/documentation.
