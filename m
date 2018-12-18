Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF94C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1BA2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BNjXcXN/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GArBNeEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLRFws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:52:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeLRFwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:52:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0EE146058E; Tue, 18 Dec 2018 05:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545112366;
        bh=p1tw1Z0LFPM3iluJj1jUZWm89hLe4jawIyRafF1rI50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BNjXcXN/FIJVF/SroKEUxebBnUlP/r3qz5YcCDMJ0Z8gD9IFOg/0u7bhB0+j0qUXz
         h2sd6Y4FN3SGoJdg5laIXnTIzpa9wK9rdz1OfIk6NwjlvyNm07tCgJBbKsUO5OUpUq
         ZzpNe8NF+Xz9xsZFEJKWVzfF6VuacnEn8grT4qVc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 95CF66058E;
        Tue, 18 Dec 2018 05:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545112364;
        bh=p1tw1Z0LFPM3iluJj1jUZWm89hLe4jawIyRafF1rI50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GArBNeEBQFE6G3LxAujRE3Ofh5oCibz7zeNv6hU0k60B2A2dy4FwVaCD89xLj1Vpx
         wblVecoWHP9BHKfrUQqIBATNBrbNnj6akeOWGKWRBn9/Tgn/+cBgABQfcHSARcJSRU
         7xr/AM+IosxzyDCbyvml3dBwS7RxAUq3i7W82Nd0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Dec 2018 11:22:44 +0530
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
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: remoteproc: qcom: Add clock bindings
 for Q6V5
In-Reply-To: <CAD=FV=Ui6ys4R3nenix3USeRPAd_vVdrArXxdf-iEc=4QRhE+A@mail.gmail.com>
References: <20181217100724.4593-1-sibis@codeaurora.org>
 <20181217100724.4593-2-sibis@codeaurora.org>
 <CAD=FV=Ui6ys4R3nenix3USeRPAd_vVdrArXxdf-iEc=4QRhE+A@mail.gmail.com>
Message-ID: <8decd38d8e28c6657949f3c140947977@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,
Thanks for the review :)

On 2018-12-18 05:29, Doug Anderson wrote:
> Hi,
> 
> On Mon, Dec 17, 2018 at 2:07 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> Add missing clock bindings for Q6V5 MSS on SDM845 SoCs.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt       | 10 
>> +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc
> on msm8996")
> Fixes: fb22022ff63d ("dt-bindings: remoteproc: Add Q6v5 Modem PIL
> binding for SDM845")
> 
> ...it probably doesn't matter too much but if we wanted to be really
> careful we could split into two patches, one for the msm8996 and one
> for sdm845.  I don't think people care that much about stable
> backports of bindings though (someone can feel free to correct me)...
> 

I did think of splitting this up but it doesn't
actually fix 9f058fa2efb1 yet. I noticed a few missing
clocks for mss on 8996 when I did a diff with the
corresponding CAF tree. Hence couldn't add bindings for
it. Will add them once I validate mss on 8996 with the
necessary changes.

> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 9ff5b0309417..780adc043b37 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -39,13 +39,17 @@ on the Qualcomm Hexagon core.
>>  - clocks:
>>         Usage: required
>>         Value type: <phandle>
>> -       Definition: reference to the iface, bus and mem clocks to be 
>> held on
>> -                   behalf of the booting of the Hexagon core
>> +       Definition: reference to the list of 4 clocks for the modem 
>> sub-system
>> +                   reference to the list of 8 clocks for the modem 
>> sub-system
>> +                   on SDM845 SoCs
> 
> The above is confusing because you don't list the SoCs that are
> supposed to use the 4 clocks.  How about instead:
> 
> Definition: reference to the clocks that match clock-names
> 

AFAIK, only the exceptions are captured. I am fine
with both, I'll wait for Bjorn/Rob's preference.

> 
>>  - clock-names:
>>         Usage: required
>>         Value type: <stringlist>
>> -       Definition: must be "iface", "bus", "mem"
>> +       Definition: must be "iface", "bus", "mem", "xo" for the modem 
>> sub-system
>> +                   must be "iface", "bus", "mem", "gpll0_mss", 
>> "snoc_axi",
>> +                   "mnoc_axi", "prng", "xo" for the modem sub-system 
>> on SDM845
>> +                   SoCs
> 
> Same here where it's confusing.  ...but also, it it correct?  As far
> as I can tell you're missing msm8996.  It's better to just be explicit
> and list each one, ideally without all the prose.
> 
> Definition: The clocks needed depend on the compatible string:
> 

ditto

> qcom,sdm845-mss-pil: "xo", "prng", "iface", "snoc_axi", "bus", "mem",
> "gpll0_mss", "mnoc_axi"
> qcom,msm8996-mss-pil: "xo", "pnoc", "iface", "bus", "mem", 
> "gpll0_mss_clk"

ditto

> qcom,msm8974-mss-pil: "xo", "iface", "bus", "mem"
> qcom,msm8916-mss-pil: "xo", "iface", "bus", "mem"
> qcom,q6v5-pil: "xo", "iface", "bus", "mem"
> 
> ...as far as I can tell this binding is supposed to account for
> "qcom,ipq8074-wcss-pil" too but it seems that one doesn't have
> clock-names.
> 

Yeah the lack of clocks have to be documented
for ipq8074-wcss-pil.. will do it in v3

> 
> -Doug

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
