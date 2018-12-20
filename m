Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBECE21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i1zK6So1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i1zK6So1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbeLTHqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:46:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbeLTHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:46:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DD66460878; Thu, 20 Dec 2018 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545291981;
        bh=bdEcC6oX//wenMopI59VoDJGhIvYs5PtZ5WacaajrIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i1zK6So1G6nLtqYMuGsC5u0z0K7FwvB0SlgYSEuU1KWvjrrlAY4WhXK4PNxn8fvtl
         kuLu+0+UyRrx6ROuWXQCyPDPdZDj4fjbkmeAyp8RevQA+6ze+tsCqIb3ioi1Jb0Nty
         191ZrmNMJXlhFM/p1R2O7ZL+uKg7s4Ze8rMzJpqI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 39ACC60736;
        Thu, 20 Dec 2018 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545291981;
        bh=bdEcC6oX//wenMopI59VoDJGhIvYs5PtZ5WacaajrIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i1zK6So1G6nLtqYMuGsC5u0z0K7FwvB0SlgYSEuU1KWvjrrlAY4WhXK4PNxn8fvtl
         kuLu+0+UyRrx6ROuWXQCyPDPdZDj4fjbkmeAyp8RevQA+6ze+tsCqIb3ioi1Jb0Nty
         191ZrmNMJXlhFM/p1R2O7ZL+uKg7s4Ze8rMzJpqI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Dec 2018 13:16:21 +0530
From:   mgottam@codeaurora.org
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        vgarodia@codeaurora.org
Subject: Re: [PATCH v2] arm64: dts: sdm845: add video nodes
In-Reply-To: <CAPBb6MU6b01OEfJ=dHF7Y2E1MeNNR3TTVJDo_SyaNURJVoU2ww@mail.gmail.com>
References: <1543410642-6475-1-git-send-email-mgottam@codeaurora.org>
 <CAPBb6MU6b01OEfJ=dHF7Y2E1MeNNR3TTVJDo_SyaNURJVoU2ww@mail.gmail.com>
Message-ID: <187d68a9b7d887b6e463bf3d22b80f42@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-30 12:09, Alexandre Courbot wrote:
> On Wed, Nov 28, 2018 at 10:12 PM Malathi Gottam 
> <mgottam@codeaurora.org> wrote:
>> 
>> This adds video nodes to sdm845 based on the examples
>> in the bindings.
>> 
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 35 
>> +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 0c9a2aa..4c9d6a4 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -84,6 +84,11 @@
>>                         reg = <0 0x86200000 0 0x2d00000>;
>>                         no-map;
>>                 };
>> +
>> +               venus_region: memory@95800000 {
>> +                       reg = <0x0 0x95800000 0x0 0x500000>;
> 
> This patch depends on the firmware loader being fixed to not expect a
> 6MB area size. I think you can do it as follows:
> 

For now, we are proceeding on adding node with memory region as 6MB.
Once we have the other patch for fixing firmware loader merged,
we can then try on recording the reserved area size.

I am posting updated patch with hard coded memory region.

Regards,
Malathi.

> 1) Record the reserved area size in the venus_core structure during
> venus_load_fw(),
> 2) Use that area size in place of VENUS_FW_MEM_SIZE everywhere else in 
> the code.
> 
> That way we don't put any artificial limitation on the expected
> firmware size, or on the reserved area in the DT matching a hardcoded
> size.
> 
> Once you have this, the driver should work no matter what the size of
> the reserved area is, provided the firmware first into it.
> 
>> +                       no-map;
>> +               };
>>         };
>> 
>>         cpus {
>> @@ -1103,5 +1108,35 @@
>>                                 status = "disabled";
>>                         };
>>                 };
>> +
>> +               video-codec@aa00000 {
>> +                       compatible = "qcom,sdm845-venus";
>> +                       reg = <0x0aa00000 0xff000>;
>> +                       interrupts = <GIC_SPI 174 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                       power-domains = <&videocc VENUS_GDSC>;
>> +                       clocks = <&videocc 
>> VIDEO_CC_VENUS_CTL_CORE_CLK>,
>> +                                <&videocc VIDEO_CC_VENUS_AHB_CLK>,
>> +                                <&videocc 
>> VIDEO_CC_VENUS_CTL_AXI_CLK>;
>> +                       clock-names = "core", "iface", "bus";
>> +                       iommus = <&apps_smmu 0x10a0 0x8>,
>> +                                <&apps_smmu 0x10b0 0x0>;
>> +                       memory-region = <&venus_region>;
>> +
>> +                       video-core0 {
>> +                               compatible = "venus-decoder";
>> +                               clocks = <&videocc 
>> VIDEO_CC_VCODEC0_CORE_CLK>,
>> +                                        <&videocc 
>> VIDEO_CC_VCODEC0_AXI_CLK>;
>> +                               clock-names = "core", "bus";
>> +                               power-domains = <&videocc 
>> VCODEC0_GDSC>;
>> +                       };
>> +
>> +                       video-core1 {
>> +                               compatible = "venus-encoder";
>> +                               clocks = <&videocc 
>> VIDEO_CC_VCODEC1_CORE_CLK>,
>> +                                        <&videocc 
>> VIDEO_CC_VCODEC1_AXI_CLK>;
>> +                               clock-names = "core", "bus";
>> +                               power-domains = <&videocc 
>> VCODEC1_GDSC>;
>> +                       };
> 
> We should probably have status = "disabled" here and enable this node
> on a per-board basis?
> 
> Also, shouldn't we define the firmware subnode here too?
> 
> Cheers,
> Alex.
>> --
>> 1.9.1
>> 
