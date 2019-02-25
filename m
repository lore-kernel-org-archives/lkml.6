Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D2420842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551102559;
	bh=ty2gsbIM4qX11OJ0glkz/jl6W5TC/y34boYlbDeYFes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bbHxwqMSv1SKJ+aLiAUqhuOI6kWsbqS/loAHhbNyEomzZ/K/gYeetvP8bL7ILjRd8
	 0erm5x6gdsNHfRiUbIdmgZX33jixB3vbDkris0OU03y/xvl0f6tSx4nM3FcnSb7X0M
	 f0+9XkB6OLkpN2VvhLz19DEWPsNZkN0x+IdSNZjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfBYNtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:49:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40974 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfBYNtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:49:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id t7so7829669otk.8;
        Mon, 25 Feb 2019 05:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3u0FVYgMT9kAuuRbpn0Afc5ACW25VbT1LoW1egvooZA=;
        b=FgyRvHAVkDhvpMxjbgprci9kUhQX2z9k2MDwTxisOGJ3XIYY1iu2BtZdiGIEmwI5ZR
         V8MIuYmc0m953pLjeb0E80bzMCFe91rr9cEB5Q95x4IzjK9lp6IryhMMxgAol7dbT0t2
         Mw9oL1h0GyjByXWA/VGwW1ULYahmMnTydss9IaKimIvK7j+/vYgiwmrzxs67EUu03FAp
         GFhBpoTAwPBA3WBtG12Mm2odspLLlWJrjgykN4OLOY9f0ZxjRudPs8VqwriV4EzzO/lK
         4QTnIUpavBJNed1Sp2atXO/uJsAvkMov8TSXOcVgJ7F/LZqtJeDdlCymC4SdtDPKnZkU
         XV6g==
X-Gm-Message-State: AHQUAuacntXG/zvmuTFoCkehjudgop52kS05G9co2ddpfQB0PZF3b+71
        b7/Z6koF41dgnagKj+n/jQ==
X-Google-Smtp-Source: AHgI3IbXLoAK4YSGlf/1B6UdA6HMitLBYK78VSh/g/m3XlsuVjw+0yPxEU0xuFfO9visa0O1JjIU8Q==
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr11905593otp.364.1551102555329;
        Mon, 25 Feb 2019 05:49:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i5sm4152714oia.46.2019.02.25.05.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 05:49:13 -0800 (PST)
Date:   Mon, 25 Feb 2019 07:49:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, myungjoo.ham@samsung.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: devfreq: add DMC device description
Message-ID: <20190225134913.GA32033@bogus>
References: <CGME20190128192153eucas1p2d7a796cb89e68c1789069562e91296be@eucas1p2.samsung.com>
 <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <1548703299-15806-5-git-send-email-l.luba@partner.samsung.com>
 <CAJKOXPd2g6rtZpK20emJ0tqHhq0D01=BWbU_9MP30313XHvPHg@mail.gmail.com>
 <79cd56c4-2415-7db1-be6f-73c03c0902bc@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79cd56c4-2415-7db1-be6f-73c03c0902bc@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 05:02:49PM +0100, Lukasz Luba wrote:
> Hi Krzysztof,
> 
> On 1/29/19 3:47 PM, Krzysztof Kozlowski wrote:
> > On Mon, 28 Jan 2019 at 20:21, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >> The patch adds description for DT binding for a new Exynos5 Dynamic Memory
> >> Controller device.
> >> It also contains needed MAINTAINERS file updates.
> >>
> >> CC: MyungJoo Ham <myungjoo.ham@samsung.com>
> >> CC: Kyungmin Park <kyungmin.park@samsung.com>
> >> CC: Chanwoo Choi <cw00.choi@samsung.com>
> >> CC: Rob Herring <robh+dt@kernel.org>
> >> CC: Mark Rutland <mark.rutland@arm.com>
> >> CC: Kukjin Kim <kgene@kernel.org>
> >> CC: Krzysztof Kozlowski <krzk@kernel.org>
> >> CC: linux-pm@vger.kernel.org
> >> CC: linux-samsung-soc@vger.kernel.org
> >> CC: devicetree@vger.kernel.org
> >> CC: linux-arm-kernel@lists.infradead.org
> >> CC: linux-kernel@vger.kernel.org
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   .../devicetree/bindings/devfreq/exynos5-dmc.txt    | 108 +++++++++++++++++++++
> >>   MAINTAINERS                                        |   7 ++
> >>   2 files changed, 115 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
> >> new file mode 100644
> >> index 0000000..914bd85
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
> >> @@ -0,0 +1,108 @@
> >> +* Exynos5 frequency and voltage scaling for Dynamic Memory Controller device
> >> +
> >> +The Samsung Exynos5 SoC has DMC (Dynamic Memory Controller) to which the DRAM
> >> +memory chips are connected. The driver is to monitor the controller in runtime
> >> +and switch frequency and voltage. To monitor the usage of the controller in
> >> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
> >> +is able to measure the current load of the memory.
> >> +When 'userspace' governor is used for the driver, an application is able to
> >> +switch the DMC frequency.
> >> +
> >> +Required properties for DMC device for Exynos5422:
> >> +- compatible: Should be "samsung,exynos5422-bus".
> >> +- clock-names : the name of clock used by the bus, "bus".
> >> +- clocks : phandles for clock specified in "clock-names" property.
> >> +- devfreq-events : phandles for PPMU devices connected to this DMC.
> >> +
> >> +The example definition of a DMC and PPMU devices declared in DT is shown below:
> >> +
> >> +       ppmu_dmc0_0: ppmu_dmc0_0@10d00000 {
> >> +               compatible = "samsung,exynos-ppmu";
> >> +               reg = <0x10d00000 0x2000>;
> >> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> >> +               clock-names = "ppmu";
> >> +               status = "okay";
> >> +               events {
> >> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> >> +                               event-name = "ppmu-event3-dmc0_0";
> >> +                       };
> >> +               };
> >> +       };
> >> +
> >> +
> >> +       ppmu_dmc0_1: ppmu_dmc0_1@10d10000 {
> >> +               compatible = "samsung,exynos-ppmu";
> >> +               reg = <0x10d10000 0x2000>;
> >> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
> >> +               clock-names = "ppmu";
> >> +               status = "okay";
> >> +               events {
> >> +                       ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> >> +                               event-name = "ppmu-event3-dmc0_1";
> >> +                       };
> >> +               };
> >> +       };
> >> +
> >> +       ppmu_dmc1_0: ppmu_dmc1_0@10d10000 {
> >> +               compatible = "samsung,exynos-ppmu";
> >> +               reg = <0x10d60000 0x2000>;
> >> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> >> +               clock-names = "ppmu";
> >> +               status = "okay";
> >> +               events {
> >> +                       ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> >> +                               event-name = "ppmu-event3-dmc1_0";
> >> +                       };
> >> +               };
> >> +       };
> >> +
> >> +       ppmu_dmc1_1: ppmu_dmc1_1@10d70000 {
> >> +               compatible = "samsung,exynos-ppmu";
> >> +               reg = <0x10d70000 0x2000>;
> >> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
> >> +               clock-names = "ppmu";
> >> +               status = "okay";
> >> +               events {
> >> +                       ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> >> +                               event-name = "ppmu-event3-dmc1_1";
> >> +                       };
> >> +               };
> >> +       };
> >> +
> >> +       dmc: dmc@10c20000 {
> >> +               compatible = "samsung,exynos5422-dmc";
> >> +               reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> >> +                       <0x10030000 0x1000>, <0x10000000 0x1000>;
> >> +               clocks =        <&clock CLK_FOUT_SPLL>,
> >> +                               <&clock CLK_MOUT_SCLK_SPLL>,
> >> +                               <&clock CLK_FF_DOUT_SPLL2>,
> >> +                               <&clock CLK_FOUT_BPLL>,
> >> +                               <&clock CLK_MOUT_BPLL>,
> >> +                               <&clock CLK_SCLK_BPLL>,
> >> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> >> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> >> +                               <&clock CLK_MOUT_MCLK_CDREX>,
> >> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
> >> +                               <&clock CLK_CLKM_PHY0>,
> >> +                               <&clock CLK_CLKM_PHY1>
> >> +                       ;
> > 
> > Join with previous line.
> > 
> >> +               clock-names =   "fout_spll",
> >> +                               "mout_sclk_spll",
> >> +                               "ff_dout_spll2",
> >> +                               "fout_bpll",
> >> +                               "mout_bpll",
> >> +                               "sclk_bpll",
> >> +                               "mout_mx_mspll_ccore",
> >> +                               "mout_mx_mspll_ccore_phy",
> >> +                               "mout_mclk_cdrex",
> >> +                               "dout_clk2x_phy0",
> >> +                               "clkm_phy0",
> >> +                               "clkm_phy1"
> >> +                               ;
> > 
> > Ditto.
> OK, I will fix it.
> > 
> >> +
> >> +               status = "okay";
> >> +               devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> >> +                               <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> >> +       };
> >> +
> >> +
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 9f64f8d..3581807 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -3310,6 +3310,13 @@ S:       Maintained
> >>   F:     drivers/devfreq/exynos-bus.c
> >>   F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> >>
> >> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5
> >> +M:     Lukasz Luba <l.luba@partner.samsung.com>
> >> +L:     linux-pm@vger.kernel.org
> >> +L:     linux-samsung-soc@vger.kernel.org
> >> +S:     Maintained
> >> +F:     Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
> > 
> > Maintainers change should go with the next change, I think. It looks
> > unusual to add an entry for driver... without the driver.
> Thank you for the review. I will move the dt-bindings in the patch set
> after the dmc driver file. Then the MAINTAINERS file will be updated
> only by one entry.

No, bindings should come first. Just move this hunk to the driver patch 
including the line here for the binding.

Rob
