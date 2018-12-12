Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518542086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kOApeP8h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TXb8Ow1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518542086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLLENU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 23:13:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLLENT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 23:13:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F40D601B4; Wed, 12 Dec 2018 04:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544587999;
        bh=3JChE5rlrE69Xvlf6KtpYK2hfbuYpgOwksNlB4tnBTY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kOApeP8hXu6OO8Jd21bfFl/KC4aAXF9C+3E7NT4z6dWO3SBZxtZl4+68ubiqa6W47
         i2AyBwvFU0Gnad6KPd4jSkOtzPL0HipU9j2fbhUxJOXeSctm23H47eKgbR1yNnQUe0
         zCLfN50Y7terFV/QKBmNx5cra9O9NMHDIhs6DM2c=
Received: from [10.79.128.154] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D97CA601B4;
        Wed, 12 Dec 2018 04:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544587998;
        bh=3JChE5rlrE69Xvlf6KtpYK2hfbuYpgOwksNlB4tnBTY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TXb8Ow1AyA2mMfpC5HVLGCQty3zfv5CUnlDDNHpuJ3uoDnZQp69gNtbS3Vd1lSEbS
         i5mf/XAK3e8NcSCoglTjfLLbn3WMig6LZJHqyrk539aoiwCeL2PkxsHjlGFVIp/nOb
         mWQCjxKdbJUz2hbpaY1ROqLsmp/cVTPCbgwQ8ujs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D97CA601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
To:     Stephen Boyd <swboyd@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>, Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181211094938.25086-1-rnayak@codeaurora.org>
 <20181211094938.25086-11-rnayak@codeaurora.org>
 <CAPDyKFof-rkzmzibWOrAhDFysU=y+C8Bp0cK=_iht4=vmv-0vw@mail.gmail.com>
 <00d91f90-ccf1-3486-0d42-0c4105058e61@codeaurora.org>
 <154456502486.17204.11345601448030201032@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <1c493bce-af67-2a4b-f903-8d39c39f7367@codeaurora.org>
Date:   Wed, 12 Dec 2018 09:43:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154456502486.17204.11345601448030201032@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[]...

>>>> This is used to enforce a requirement that exists for various
>>>> hardware blocks on SDM845 that MX performance state >= CX performance
>>>> state for a given operating frequency.
>>>
>>> I assume that also means the MX power domain must not be power off as
>>> long as the CX power domain is powered on?
>>
>> So with rpmh, there's really no separate on/off control, we just put
>> it in the lowest perf state at off.
> 
> I think in theory the answer is MX can't be off if CX is on, but in
> reality, MX and CX are never turned off, just set to something really
> low and even then the constraint applies for MX >= CX. Is that right?

to some extent, let me clarify this a bit more. rpmh is the central entity
controlling these rails and takes a final call on when it can or cannot
be 'really' off and when its turned on, at what level it should be set to.

CPU is just one of the entities 'voting' on them. Now legacy platforms which
had rpm (like msm8996) did have separate control to send a
on/off vote and a performance level vote. With rpmh, its just that there
is no separate message that you send to rpmh for OFF, its just mapped to
the lowest perf level. So think of it as the lowest perf level is mapped to
a '0' which is same as OFF.

So when you say 'MX can't be off if CX is on', yes MX can't be at the lowest
level '0', while CX is at something higher.

>>> Just to make sure there are no conflicting hierarchical constraints
>>> between idle management and performance state management!?
>>>
> 
> I'm not sure what idle states mean to the CX and MX domains. Would it be
> some sort of idle state governor attached at genpd creation time that
> would adjust the main SoC power rails when all devices attached are
> idle? Maybe I don't understand how idle states are different from
> performance states.
> My understanding is that devices using these domains would almost always
> expect their clk frequency and clk on/off state to decide what the
> performance state is, unless they need to ignore clk state because they
> aren't managing clks and bump up the voltage directly when the device is
> active. Either way, devices are actively managing the voltage they need
> these voltage domains to operate at by using the genpd performance
> states APIs.

I am not quite sure whats the point that you are trying to make here,
but this is what I would expect the users of these genpds to do,
regardless of if they have a clk dependency or not.
When the device is active, vote for a performance state they need
then request for the genpd to be on. When they are idle, request for the
genpd to be turned off.
  
