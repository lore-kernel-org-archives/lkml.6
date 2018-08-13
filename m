Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9827BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5126F217FE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5126F217FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeHMLHA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 07:07:00 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40096 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbeHMLHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 07:07:00 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fp8AX-00013D-Op; Mon, 13 Aug 2018 10:25:41 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tao Huang <huangtao@rock-chips.com>
Cc:     Caesar Wang <wxt@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Xing Zheng <zhengxing@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dbasehore@chromium.org, Will Deacon <will.deacon@arm.com>,
        dianders@chromium.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        tony.xie@rock-chips.com, David Wu <david.wu@rock-chips.com>,
        cf@rock-chips.com, Jianqun Xu <jay.xu@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add idle-states to device tree for rk3399
Date:   Mon, 13 Aug 2018 10:25:41 +0200
Message-ID: <3578407.YVa0lydFsh@phil>
In-Reply-To: <ae312dc3-f640-ecf3-049a-c8576bb83330@rock-chips.com>
References: <1467793254-10808-1-git-send-email-wxt@rock-chips.com> <5620784.b19SH5PkdR@phil> <ae312dc3-f640-ecf3-049a-c8576bb83330@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

Am Sonntag, 12. August 2018, 18:24:45 CEST schrieb Tao Huang:
> On 2018年08月10日 04:09, Heiko Stuebner wrote:
> > Am Mittwoch, 6. Juli 2016, 10:20:54 CEST schrieb Caesar Wang:
> >
> >>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> index a6dd623..12ce265 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> @@ -101,6 +101,18 @@
> >>  			};
> >>  		};
> >>  
> >> +		idle-states {
> >> +			entry-method = "psci";
> >> +			cpu_sleep: cpu-sleep-0 {
> >> +				compatible = "arm,idle-state";
> >> +				local-timer-stop;
> >> +				arm,psci-suspend-param = <0x0010000>;
> >> +				entry-latency-us = <350>;
> >> +				exit-latency-us = <600>;
> >> +				min-residency-us = <1150>;
> > Looking at the chromeos kernel, there are some more patches adapting
> > this idle-state to use different timings.
> Yes, we have another values. So the values of this patch are wrong.
> >
> > There also was a cluster-idle state added for a while but that seems to
> > cause audio issues according to the CrOS history.
> 
> DMA or Audio driver should add PM_QOS_CPU_DMA_LATENCY or other methods to avoid the effects of idle.
> Idle itself is good.

Thanks for the clarification. Do you know if some from Rockchip plans
on submitting a new version of the patch with changed timings and
cluster-sleep?

Otherwise I can also just pull the values from the vendor kernel so that
we get idle states in mainline as well.


Thanks
Heiko


