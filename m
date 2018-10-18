Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196AAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEE22145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fojhwv9l";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YKkgH/f9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEE22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeJRPwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:52:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeJRPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:52:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F347461309; Thu, 18 Oct 2018 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539849135;
        bh=Q2WsZBdGtld7gB1MEczUmXeqjJ7MRuquO1FTCMD8DMk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fojhwv9ls+FFle2b3FgdWgI5bXfEraF5KDzAUuWd/Zw6H3UvUK0E3rlYWRxxxxoI9
         LEUFmMB11omaIHTJV1QnPLanbycrbhFYAvbT2aXGpDY46NsRWXc3PDdZUvAjB0mn27
         9F8wbAFSYgD0xfhG1x7BGUTpSNvDneRXgti6+Q1U=
Received: from [10.79.40.46] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3689612EE;
        Thu, 18 Oct 2018 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539849134;
        bh=Q2WsZBdGtld7gB1MEczUmXeqjJ7MRuquO1FTCMD8DMk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YKkgH/f9wHfrDC78HcQ50ygmBm17/sDe81koQOc8c+8jDfCIqAQB9w5rxZkmU2G5Y
         FhieqxNVsjn+15uVELOAOgwpwPhqq/QqzY6qHIK8P54vLM/JNOrF63AIfmpBWbRH9K
         EG+sU6R5mB4yP5HUBbufkiyOsE6aCRExGGlLyMtU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3689612EE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH] dt-bindings: ufs: Fix the compatible string definition
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        cang@codeaurora.org, Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sayalil@codeaurora.org, Asutosh Das <asutoshd@codeaurora.org>,
        devicetree@vger.kernel.org, liwei213@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181012213926.253765-1-dianders@chromium.org>
 <CAFp+6iFy8V34cs6pEOie_tBX5wJqM7teUnH_XLLZ7cioPrX_hA@mail.gmail.com>
 <CAD=FV=WYM5OOigy+81cVzPtAJXhvrhB1znr9zHzMf3q5iFOtFw@mail.gmail.com>
 <CAFp+6iGxvDoptnjM18ggnHqX6MV0+HFqsnCMi61b8gquBxaYmw@mail.gmail.com>
 <CAD=FV=XWC8q4Cx4GF0yXCgj2APwd5ZfccVBC_ORwnJg0vRsS7A@mail.gmail.com>
 <1ce7b24c-b154-4ce6-2b4c-9eb0fd0d71cb@codeaurora.org>
 <CAD=FV=XSjfRSHP6B6GtiTqrQuUZaoA=hZNW_L1=71MU9fEXpDQ@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <20cf6f02-ff3c-0904-2edc-a1b72c135866@codeaurora.org>
Date:   Thu, 18 Oct 2018 13:22:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XSjfRSHP6B6GtiTqrQuUZaoA=hZNW_L1=71MU9fEXpDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2018 9:41 PM, Doug Anderson wrote:
> Hi,
>
> On Tue, Oct 16, 2018 at 11:28 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> Hi Doug,
>>
>>
>> On 10/16/2018 10:29 PM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Mon, Oct 15, 2018 at 10:51 PM Vivek Gautam
>>> <vivek.gautam@codeaurora.org> wrote:
>>>>>> P.S.: While you are at it, can you please move 'ufs-qcom.txt'
>>>>>> to Documentation/devicetree/bindings/phy/qcom,ufs-phy.txt.
>>>>>> The current name and file location is misleading.
>>>>> I'd rather someone at Qualcomm do this.  Do you have a suggested
>>>>> person?  The reason I feel that Qualcomm needs to get involved is that
>>>>> I see that when I look at the file you refer to says it's for:
>>>>>
>>>>>     "qcom,ufs-phy-qmp-20nm" for 20nm ufs phy,
>>>>>     "qcom,ufs-phy-qmp-14nm" for legacy 14nm ufs phy,
>>>>>     "qcom,msm8996-ufs-phy-qmp-14nm" for 14nm ufs phy
>>>>>     present on MSM8996 chipset.
>>>>>
>>>>> ...but there's another Qualcomm file, 'qcom-qmp-phy.txt'.  That
>>>>> handles the compatible string:
>>>>>
>>>>>          "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
>>>>>
>>>>> So I'm a little confused.  Should the SDM845 UFS PHY been handled by
>>>>> the older UFS PHY driver?  ...or should all the older UFS PHYs be
>>>>> moved to be handled by the newer QMP PHY driver?  ...or are they
>>>>> really different hardware blocks, in which case how would you describe
>>>>> the difference (both are described as UFS QMP PHYs I think).
>>>> As you rightly said "ufs/ufs-qcom.txt" describes the bindings for
>>>> 14nm, and 20nm ufs phy. These phys are however handled by the older
>>>> ufs phy driver present at:
>>>> drivers/phy/qualcomm/phy-qcom-ufs-qmp-{14nm,20nm}.c
>>>> The sdm845 UFS phy driver is handled by the new consolidated qmp phy
>>>> driver: drivers/phy/qualcomm/phy-qcom-qmp.c whose bindings are
>>>> described by 'qcom-qmp-phy.txt'.
>>>> We didn't attempt to move the 14nm phy to new driver as we already had
>>>> 8996 using the bindings.
>>>>
>>>> So, really these are two separate drivers with different bindings. I
>>>> believe it should be okay to move the file. If you are fine, I can
>>>> attempt to post a small patch to do that.
>>> I guess what I should have said was that the new name you're proposing
>>> "qcom,ufs-phy.txt" is confusing and opening the file doesn't help
>>> clarify things.  The name and the binding make it sound like this is
>>> _the_ file to look at for Qualcomm UFS PHYs.  ...and then you look in
>>> the examples in the file and it seems that this even includes Qualcomm
>>> QMP PHYs for UFS.
>>>
>>> ...so while I agree that the file "ufs-qcom.txt" needs to be moved to
>>> the "PHY" directory, I think at the same time we need to change the
>>> name of the file and maybe the contents to disambiguate which things
>>> belong in this file vs. the "qcom-qmp-phy.txt".  ...and I feel like
>>> someone at Qualcomm will have the most information to properly do
>>> that.
>>>
>>> For instance, you could call the older bindings
>>> "qcom-qmp-phy-14nm-20nm.txt" or something like that.
>> Sure, I get your point. I will propose something that removes the confusion.
>>
>>> One point of clarification I'd like to know is if there's really a
>>> good reason to have two drivers here.  Certainly if the hardware is
>>> really different then a new driver can make sense, but if there are
>>> two drivers for arbitrary reasons then maybe they should be combined
>>> into one eventually?
>> Right, the 14nm phy driver can be happily merged into the new qmp-phy
>> driver.
>> But we should take care of older bindings. Removing the driver will break
>> things on targets with older bindings, precisely 8996.
>>
>> 20nm is bit tricky as it exported few APIs directly to ufs host
>> controller, and
>> that's the reason we have declared that as BROKEN after the ufs cleanup.
>> So, until we are really in a kill mode, the old ufs-phy driver will have
>> to live.
> OK, sounds like a plan.  I'll assume you're posting the patch to move
> the old PHY bindings and add some of the above information to them so
> people aren't confused.
>
> ...all this is sort off the original subject, though.  ;-)  Just a
> quick summary here is that nothing suggests ${SUBJECT} patch shouldn't
> land and all the additional discussion has been about making further
> improvements to the bindings situation for UFS on Qualcomm.

Yes, this patch is good to go.

Thanks
Vivek
>
> -Doug

