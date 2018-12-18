Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA13C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31412133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SFBom49P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PpJuM0q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLRGii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:38:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRGih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:38:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 00FCB60595; Tue, 18 Dec 2018 06:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545115116;
        bh=tSMPHMEbe+vNr56bCqk+w6WjTTJn/UgHhKNPpsB2N18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SFBom49PoPHTcmnZlvuzf1x4pfsh+oelk22sLqQQ5WOAe7z1XbWtthbO/qiWVi1am
         kX5sHrJ+4gfUVgtEhFUGWKQsY6heC5pWI1zko9nWwYL1TpjozECxvZKUnteWvApcnl
         pJv6K2ZcN3Gz60x/8DRp1N2znM85QF7nZEBdAxW4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 24BA260595;
        Tue, 18 Dec 2018 06:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545115115;
        bh=tSMPHMEbe+vNr56bCqk+w6WjTTJn/UgHhKNPpsB2N18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PpJuM0q8VSK0/cNSnnD+GOfJYInHNCO+KuZHKKCvoLiJ1wmJZbuym8DrP78lohuMV
         A4annfKpCx29F8wT6fJj53fHivt6Wfu5/ox3bOgcXjf/QHk3pRfUB9G7sfMJxwRo6T
         J7o50DJvtFM16sJCFGPn7j/8yQByWnHLHBJWd104=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Dec 2018 12:08:35 +0530
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
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sdm845: Add power-domain for
 Q6V5 MSS node
In-Reply-To: <CAD=FV=WEhobH=fBTonJdABYzOqykgk6XYt9=3eoHap8K6rAQKA@mail.gmail.com>
References: <20181217100724.4593-1-sibis@codeaurora.org>
 <20181217100724.4593-6-sibis@codeaurora.org>
 <CAD=FV=WEhobH=fBTonJdABYzOqykgk6XYt9=3eoHap8K6rAQKA@mail.gmail.com>
Message-ID: <3b86d9853a6448a0a2f2c85deafae1fb@codeaurora.org>
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
>> Add power-domains cx, mx, mss and load_state for Q6V5 MSS node.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> This patch depends on the following bindings:
>> https://patchwork.kernel.org/patch/10725801/ - rpmhpd dt bindings
>> https://patchwork.kernel.org/patch/10725793/ - rpmhpd dt node
>> https://patchwork.kernel.org/patch/10678301/ - AOP QMP dt bindings
>> 
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
> 
> As per my comments on patch #5, I think this patch (AKA patch #6)
> should be folded in there.
> 

okay

> 
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 33ff8668828f..56f5f55db9e2 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -1401,6 +1401,12 @@
>>                         qcom,halt-regs = <&tcsr_mutex_regs
>>                                                 0x23000 0x25000 
>> 0x24000>;
>> 
>> +                       power-domains = <&aoss_qmp_pd 
>> AOSS_QMP_LS_MODEM>,
>> +                                       <&rpmhpd SDM845_CX>,
>> +                                       <&rpmhpd SDM845_MX>,
>> +                                       <&rpmhpd SDM845_MSS>;
>> +                       power-domain-names = "load_state", "cx", "mx", 
>> "mss";
> 
> I guess you changed this to "load_state" from "aop" before?  Is there
> code that actually uses this?
> 

Bjorn said he will be posting the patch
for handling power-domains for mss..

> 
> -Doug
> 
> -Doug

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
