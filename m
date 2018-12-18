Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C206BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB3C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o+7WEATB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eSaoUdtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeLRGfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:35:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRGfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:35:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A9AE6071C; Tue, 18 Dec 2018 06:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545114909;
        bh=/htFridCA8jE+qMOjNatI1frpK7kt0XtDqCHg62HzPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o+7WEATBTo+QYSVjNtVX4v7/OEAKgnGOn5kfkIwg8TPT1+sjGZ6ifWxauZOPf5VD8
         yzWrzQiTr55n9WVICTorQZJUtgFvGwdN1TyKNaIDKc+6SVSv6zFeaQQSPhwsPx7cws
         CwKPU5y3SN+Wl/5ncC6/6V+JkbO74OiAfi73uBa0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BDC4B6058E;
        Tue, 18 Dec 2018 06:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545114908;
        bh=/htFridCA8jE+qMOjNatI1frpK7kt0XtDqCHg62HzPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eSaoUdtn3uJa59QyZ44wDsPNIx2KD4yFoHYCBipmHJCKSlg91rkDJx3v/ygbOQSQ5
         2jDE5BYlokWfjkUIUysFUogAdo4anSHXhhNA2Gp5Lvh5/dIhQMN+tKzmuYm/Sd8hCE
         HFYD8lS44+a4yTszhwwKrLFLLThUYVJuwVFyKCrU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Dec 2018 12:05:08 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-soc-owner@vger.kernel.org
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
In-Reply-To: <CAD=FV=X9KmE60vdkGahRGoEahr6Gufi1Qg0Qa+v6wQtdDVFvcQ@mail.gmail.com>
References: <20181217100724.4593-1-sibis@codeaurora.org>
 <20181217100724.4593-5-sibis@codeaurora.org>
 <CAD=FV=X9KmE60vdkGahRGoEahr6Gufi1Qg0Qa+v6wQtdDVFvcQ@mail.gmail.com>
Message-ID: <2530f7f6019ba1ec950b4b27acba6993@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,
Thanks for the review :)

On 2018-12-18 05:32, Doug Anderson wrote:
> Hi,
> 
> On Mon, Dec 17, 2018 at 2:08 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> v2:
>>   * Fixed style changes
>>   * Added missing clocks in the dt-bindings
>>   * Split mss remoteproc node into a number of patches
> 
> I know there was some off-list suggestion to split this into a number
> of patches, but to actually make that useful to anyone we'd actually
> need to _also_ post up patches to make the driver probe / work without
> these power domains.  ...and as per other discussions it's kinda
> "lucky" that it happens to work without them and Bjorn wasn't
> supportive of making this optional.
> 
> So I'd actually fold patch 6 into patch 5 and focus on getting the
> "aoss_qmp_pd" landed sooner rather than later.
> 

I'll fold them in v3

> 
> Keeping the "shutdown-ack" as a separate patch makes sense though
> since the bindings currently list that as "optional" and I guess
> things work OK w/out it.
> 
> 
> Once patch #6 is folded into patch #5 feel free to add my Reviewed-by 
> tag.

okay

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
