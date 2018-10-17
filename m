Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07FDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D19D214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nr/DXkVN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UMhYElZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D19D214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeJQOXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:23:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeJQOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:23:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1357D602A9; Wed, 17 Oct 2018 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539757736;
        bh=oPKOXe9+4SxdDYiRbQ1esVpTt3YDL2UAzTDW6kHGZyU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Nr/DXkVNEk0/SE/bPiYtoEGfLORJZmpZ5S8GA9R4E+Asdc/ALiPcvw2x60nmyPKi8
         AMKf2Ecvh30ZD47BiMUHgcvXN2LjgHfNNfz4HacfH9T6i3DWTpAKa7B9uFgpzR3yqV
         76ruzujO+rRpSFhxAoqV2AywHsBEebYuyPBgS2Ow=
Received: from [10.79.40.46] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B50F46028D;
        Wed, 17 Oct 2018 06:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539757735;
        bh=oPKOXe9+4SxdDYiRbQ1esVpTt3YDL2UAzTDW6kHGZyU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UMhYElZwZ1vL0HYGOCGYlDJwzvrKtA2sQ+OpCM5FhWptv9POdIGnm+spTfiXAbIzj
         lfXp5gAlklNmwBqLr4TFtaVlRHnSVdEcu/EBjXJ9gIJ7HNw6bXCajzq4lWVxv12Gdu
         xOyGAowPfAWU0qxDGQ6TIMoByecWCpodg09gzGgQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B50F46028D
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
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <1ce7b24c-b154-4ce6-2b4c-9eb0fd0d71cb@codeaurora.org>
Date:   Wed, 17 Oct 2018 11:58:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XWC8q4Cx4GF0yXCgj2APwd5ZfccVBC_ORwnJg0vRsS7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,


On 10/16/2018 10:29 PM, Doug Anderson wrote:
> Hi,
>
> On Mon, Oct 15, 2018 at 10:51 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>>>> P.S.: While you are at it, can you please move 'ufs-qcom.txt'
>>>> to Documentation/devicetree/bindings/phy/qcom,ufs-phy.txt.
>>>> The current name and file location is misleading.
>>> I'd rather someone at Qualcomm do this.  Do you have a suggested
>>> person?  The reason I feel that Qualcomm needs to get involved is that
>>> I see that when I look at the file you refer to says it's for:
>>>
>>>    "qcom,ufs-phy-qmp-20nm" for 20nm ufs phy,
>>>    "qcom,ufs-phy-qmp-14nm" for legacy 14nm ufs phy,
>>>    "qcom,msm8996-ufs-phy-qmp-14nm" for 14nm ufs phy
>>>    present on MSM8996 chipset.
>>>
>>> ...but there's another Qualcomm file, 'qcom-qmp-phy.txt'.  That
>>> handles the compatible string:
>>>
>>>         "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
>>>
>>> So I'm a little confused.  Should the SDM845 UFS PHY been handled by
>>> the older UFS PHY driver?  ...or should all the older UFS PHYs be
>>> moved to be handled by the newer QMP PHY driver?  ...or are they
>>> really different hardware blocks, in which case how would you describe
>>> the difference (both are described as UFS QMP PHYs I think).
>> As you rightly said "ufs/ufs-qcom.txt" describes the bindings for
>> 14nm, and 20nm ufs phy. These phys are however handled by the older
>> ufs phy driver present at:
>> drivers/phy/qualcomm/phy-qcom-ufs-qmp-{14nm,20nm}.c
>> The sdm845 UFS phy driver is handled by the new consolidated qmp phy
>> driver: drivers/phy/qualcomm/phy-qcom-qmp.c whose bindings are
>> described by 'qcom-qmp-phy.txt'.
>> We didn't attempt to move the 14nm phy to new driver as we already had
>> 8996 using the bindings.
>>
>> So, really these are two separate drivers with different bindings. I
>> believe it should be okay to move the file. If you are fine, I can
>> attempt to post a small patch to do that.
> I guess what I should have said was that the new name you're proposing
> "qcom,ufs-phy.txt" is confusing and opening the file doesn't help
> clarify things.  The name and the binding make it sound like this is
> _the_ file to look at for Qualcomm UFS PHYs.  ...and then you look in
> the examples in the file and it seems that this even includes Qualcomm
> QMP PHYs for UFS.
>
> ...so while I agree that the file "ufs-qcom.txt" needs to be moved to
> the "PHY" directory, I think at the same time we need to change the
> name of the file and maybe the contents to disambiguate which things
> belong in this file vs. the "qcom-qmp-phy.txt".  ...and I feel like
> someone at Qualcomm will have the most information to properly do
> that.
>
> For instance, you could call the older bindings
> "qcom-qmp-phy-14nm-20nm.txt" or something like that.

Sure, I get your point. I will propose something that removes the confusion.

>
> One point of clarification I'd like to know is if there's really a
> good reason to have two drivers here.  Certainly if the hardware is
> really different then a new driver can make sense, but if there are
> two drivers for arbitrary reasons then maybe they should be combined
> into one eventually?

Right, the 14nm phy driver can be happily merged into the new qmp-phy 
driver.
But we should take care of older bindings. Removing the driver will break
things on targets with older bindings, precisely 8996.

20nm is bit tricky as it exported few APIs directly to ufs host 
controller, and
that's the reason we have declared that as BROKEN after the ufs cleanup.
So, until we are really in a kill mode, the old ufs-phy driver will have 
to live.

Regards
Vivek
>
>
> -Doug

