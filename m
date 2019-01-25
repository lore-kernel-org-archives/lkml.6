Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5818DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2654D217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c5HHoT0T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c5HHoT0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfAYH4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:56:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfAYH4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:56:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E94846084F; Fri, 25 Jan 2019 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548402961;
        bh=aG8SKKcT7jomM2jSxVBPcO8UJnGhH1Gl9TByfnJBuXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c5HHoT0T2jgm/NeYF/3Y1Rl6IAna8CMTOIiWIsSWT31aoFaEDi+vBqROt/V1PJxgU
         ug9zmAE4qNCqc9/KA50XokwRGyrKriFB6eAbGW5dzHnWsVhxKTsJNGsNUoWZlRwEgz
         UazAiXIrdtYuKiD0hMQiAF511R/Zsy7FNm7GcfRg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id F1B516049C;
        Fri, 25 Jan 2019 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548402961;
        bh=aG8SKKcT7jomM2jSxVBPcO8UJnGhH1Gl9TByfnJBuXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c5HHoT0T2jgm/NeYF/3Y1Rl6IAna8CMTOIiWIsSWT31aoFaEDi+vBqROt/V1PJxgU
         ug9zmAE4qNCqc9/KA50XokwRGyrKriFB6eAbGW5dzHnWsVhxKTsJNGsNUoWZlRwEgz
         UazAiXIrdtYuKiD0hMQiAF511R/Zsy7FNm7GcfRg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Jan 2019 13:26:00 +0530
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
Subject: Re: [PATCH v3] arm64: dts: sdm845: add video nodes
In-Reply-To: <CAPBb6MWedPvoFW2jrqhZhNP-41PrEC+G4xnXs=cex1ywnVdm-w@mail.gmail.com>
References: <1545292023-5489-1-git-send-email-mgottam@codeaurora.org>
 <0ee6676f-f169-1ea1-506e-16e4097d1c04@linaro.org>
 <CAPBb6MWedPvoFW2jrqhZhNP-41PrEC+G4xnXs=cex1ywnVdm-w@mail.gmail.com>
Message-ID: <a83e253be7a188e9d89dccf20d5f73e4@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-25 13:16, Alexandre Courbot wrote:
> On Thu, Jan 17, 2019 at 8:58 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>> 
>> Hi Malathi,
>> 
>> On 12/20/18 9:47 AM, Malathi Gottam wrote:
>> > This adds video nodes to sdm845 based on the examples
>> > in the bindings.
>> >
>> > Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> > ---
>> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 35 +++++++++++++++++++++++++++++++++++
>> >  1 file changed, 35 insertions(+)
>> 
>> Looks good to me:
>> 
>> Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> 
>> >
>> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> > index b72bdb0..ccd2b10 100644
>> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> > @@ -87,6 +87,11 @@
>> >                       reg = <0 0x86200000 0 0x2d00000>;
>> >                       no-map;
>> >               };
>> > +
>> > +             venus_region: memory@95800000 {
>> > +                     reg = <0x0 0x95800000 0x0 0x500000>;
>> > +                     no-map;
>> > +             };
>> >       };
>> >
>> >       cpus {
>> > @@ -1403,5 +1408,35 @@
>> >                               status = "disabled";
>> >                       };
>> >               };
>> > +
>> > +             video-codec@aa00000 {
>> > +                     compatible = "qcom,sdm845-venus";
>> > +                     reg = <0x0aa00000 0xff000>;
>> > +                     interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>> > +                     power-domains = <&videocc VENUS_GDSC>;
>> > +                     clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
>> > +                              <&videocc VIDEO_CC_VENUS_AHB_CLK>,
>> > +                              <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
>> > +                     clock-names = "core", "iface", "bus";
>> > +                     iommus = <&apps_smmu 0x10a0 0x8>,
>> > +                              <&apps_smmu 0x10b0 0x0>;
>> > +                     memory-region = <&venus_region>;
>> > +
>> > +                     video-core0 {
>> > +                             compatible = "venus-decoder";
>> > +                             clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
>> > +                                      <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
>> > +                             clock-names = "core", "bus";
>> > +                             power-domains = <&videocc VCODEC0_GDSC>;
>> > +                     };
>> > +
>> > +                     video-core1 {
>> > +                             compatible = "venus-encoder";
>> > +                             clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
>> > +                                      <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
>> > +                             clock-names = "core", "bus";
>> > +                             power-domains = <&videocc VCODEC1_GDSC>;
>> > +                     };
>> > +             };
> 
> This patch lacks the video-firmware node, it should at the very least
> be added before this gets merged.

Yes Alex, I missed adding video-firmware node. Thanks for noticing.
Will add it and post new version.

Thanks,
Malathi.
