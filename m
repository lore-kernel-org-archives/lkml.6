Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADD2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572302070D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NRKTWYNT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SLYn0Nz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeLNQ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:29:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbeLNQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:29:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B65DC60740; Fri, 14 Dec 2018 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544804997;
        bh=dtKhURp5xuv8CH6UDIRI/H7CSGOC79aSo6nyvpobbe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NRKTWYNTsZ38Nh8a6VqamfSg6KDkPGRrZUpvUD2oM8zoths3Nk3eIwzIXk88Hjz+H
         V4QnB4BrsbEnEviAXFt8LSHjkF8/fBuCqtzLudB84OpB1c3G2Eb+WPIe/WwuoaGWyb
         /32RldiX4f61cfnnjt6Q8+oQpAWd56B5hb17Wv4A=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9EABD602F5;
        Fri, 14 Dec 2018 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544804996;
        bh=dtKhURp5xuv8CH6UDIRI/H7CSGOC79aSo6nyvpobbe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SLYn0Nz3YM1NigglOqaaevg076a+c25aNtfRT6EvB3677ocZgBZ5G7FX4GPDNSgdD
         IWjO8Ad433oazq8WdUeKswS5LGeYjVYIo0QEGVuiKx45uA3LR3QW+SbE4bC5B2xHm9
         YS41khAe+CpOECNokXYbqZET51LsBG0KwVq2g7NA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Dec 2018 21:59:56 +0530
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
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
In-Reply-To: <CAD=FV=U+LHa0QpPuZhd04=WkMrrM1kBUYhkS9RqSSR6uLijbBA@mail.gmail.com>
References: <20181127085828.17908-1-sibis@codeaurora.org>
 <CAD=FV=U+LHa0QpPuZhd04=WkMrrM1kBUYhkS9RqSSR6uLijbBA@mail.gmail.com>
Message-ID: <ba289e556bb1ac0f6bd743e295164c59@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,
Thanks for the review!

On 2018-12-14 03:47, Doug Anderson wrote:
> Hi,
> 
> On Tue, Nov 27, 2018 at 12:58 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> The remoteproc mss node depends on the following bindings:
>> https://patchwork.kernel.org/patch/10490559/ - rpmhp dt bindings
> 
> This is an older version of the patch.  Now at v7 at
> <https://patchwork.kernel.org/patch/10725801/>
> 
> 
>> https://patchwork.kernel.org/patch/10678301/ - AOP QMP dt bindings
>> https://patchwork.kernel.org/patch/10691215/ - mss power-domain dt 
>> bindings
>> https://patchwork.kernel.org/patch/10691213/ - shutdown-ack dt 
>> bindings
>> 
>> It also depends on the mpss and mba memory regions and pdc reset node.
>> https://patchwork.kernel.org/patch/10662089/
>> https://patchwork.kernel.org/patch/10657325/
>> 
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 63 
>> ++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 58870273dbc9..df16ee464872 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -1095,6 +1095,69 @@
>>                         };
>>                 };
>> 
>> +               remoteproc@4080000 {
>> +                       compatible = "qcom,sdm845-mss-pil";
>> +                       reg = <0x04080000 0x408>, <0x04180000 0x48>;
> 
> s/0x04080000/0x4080000 to appease the DT folks.
> 

as you said in the other thread will leave the
padding untouched

> 
>> +                       reg-names = "qdsp6", "rmb";
>> +
>> +                       interrupts-extended =
>> +                               <&intc GIC_SPI 266 
>> IRQ_TYPE_EDGE_RISING>,
>> +                               <&modem_smp2p_in 0 
>> IRQ_TYPE_EDGE_RISING>,
>> +                               <&modem_smp2p_in 1 
>> IRQ_TYPE_EDGE_RISING>,
>> +                               <&modem_smp2p_in 2 
>> IRQ_TYPE_EDGE_RISING>,
>> +                               <&modem_smp2p_in 3 
>> IRQ_TYPE_EDGE_RISING>,
>> +                               <&modem_smp2p_in 7 
>> IRQ_TYPE_EDGE_RISING>;
>> +
>> +                       interrupt-names = "wdog", "fatal", "ready",
>> +                                         "handover", "stop-ack",
>> +                                         "shutdown-ack";
> 
> nit: maybe remove blank line between "interrupts-extended" and
> "interrupt-names".  Nice to keep -names close to the things they're
> naming.
> 

sure will do that.. I guess I'll have to remove
the blank line in clock-names as well

> 
>> +                       clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>> +                                <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
>> +                                <&gcc GCC_BOOT_ROM_AHB_CLK>,
>> +                                <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
>> +                                <&gcc GCC_MSS_SNOC_AXI_CLK>,
>> +                                <&gcc GCC_MSS_MFAB_AXIS_CLK>,
>> +                                <&gcc GCC_PRNG_AHB_CLK>,
>> +                                <&rpmhcc RPMH_CXO_CLK>;
>> +
>> +                       clock-names = "iface", "bus", "mem", 
>> "gpll0_mss",
>> +                                     "snoc_axi", "mnoc_axi", "prng", 
>> "xo";
> 
> Bindings list clock-names as "iface", "bus", "mem".  You have "iface",
> "bus", "mem", "gpll0_mss", "snoc_axi", "mnoc_axi", "prng", "xo".  It
> looks like these extra clocks were added in commit 231f67d1fb2f
> ("remoteproc: q6v5: Add support for mss remoteproc on SDM845") but you
> forgot to update the bindings.  Looking in that patch I also see an
> "axis2" which you seem to be missing.  Do you need it?
> 

yes missed adding them..will add them in the next respin

> 
>> +                       qcom,smem-states = <&modem_smp2p_out 0>;
>> +                       qcom,smem-state-names = "stop";
>> +
>> +                       resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
>> +                                <&pdc_reset PDC_MODEM_SYNC_RESET>;
>> +                       reset-names = "mss_restart", "pdc_reset";
>> +
>> +                       qcom,halt-regs = <&tcsr_mutex_regs
>> +                                               0x23000 0x25000 
>> 0x24000>;
>> +
>> +                       power-domains = <&aoss_qmp_pd 
>> AOSS_QMP_LS_MODEM>,
>> +                                       <&rpmhpd SDM845_CX>,
>> +                                       <&rpmhpd SDM845_MX>,
>> +                                       <&rpmhpd SDM845_MSS>;
>> +                       power-domain-names = "aop", "cx", "mx", "mss";
>> +
>> +                       mba {
>> +                               memory-region = <&mba_region>;
>> +                       };
>> +
>> +                       mpss {
>> +                               memory-region = <&mpss_region>;
>> +                       };
>> +
>> +                       glink-edge {
>> +                               interrupts = <GIC_SPI 449 
>> IRQ_TYPE_EDGE_RISING>;
>> +                               label = "modem";
>> +                               qcom,remote-pid = <1>;
> 
> The "qcom,remote-pid" property isn't documented for "glink-edge".  Do
> you need it?  ...if you do, please send a patch to update the
> bindings.
> 

yes glink seems to be missing the remote-pid..
I will add that as well in v2

> 
> -Doug

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
