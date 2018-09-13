Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4341BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866612133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866612133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeIMJPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:15:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34675 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeIMJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:15:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so3501218eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3dLCWVRyTNjDV+RM5lsypt2L6kN6EvzCtDD422svD0=;
        b=BHUK+WGJXvxyB/ZdJl9yqQxcw40D264TJR2VzdBBUKjQuBGtO3RJ2hr57HjXOwKoPU
         Fdh1sSZjQL0Cs1a+cIOY2SOyDOj3lS4GKFMOKEfHa91V+Y6MjLXj3qQhFm+Jq1GELeEh
         ffLOqAtgfTx7K1Fgd4xXLAEOKyzeN5PeWsxOhO9iCmJAefVi2LPPHbW3qX/n92lOgduQ
         4SiLMu8dQ96WztPtnvf2aWiRY3OCN3RKHCCKxkitY9xqdka/WMJouWiofpXYiugmyP0k
         uwhFmlDecVS+DK4LD7eRg0L8a7Kw9+syuylslmZhV5t3KzEoHkxm1X8PVaYIscSh9bAe
         BrgA==
X-Gm-Message-State: APzg51CbZVJG414ZL5fkeDM26OrQlBJwPajSo+5amokDkBdh1fO5/XiA
        Hd8O+RTKmGcnzu8jFKe4OQ/EN8x4yhI=
X-Google-Smtp-Source: ANB0Vdb9/WC5bcgzgXH5Oy3d9rXyNwplKR6LWTuCMAO5H/TyAwBElna8tn09YxoHQdWA4SJwII8bPg==
X-Received: by 2002:a50:d6cd:: with SMTP id l13-v6mr7024560edj.213.1536811659480;
        Wed, 12 Sep 2018 21:07:39 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id h34-v6sm1442690eda.58.2018.09.12.21.07.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 21:07:39 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id k5-v6so4087973wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:07:38 -0700 (PDT)
X-Received: by 2002:adf:8485:: with SMTP id 5-v6mr3822471wrg.34.1536811658284;
 Wed, 12 Sep 2018 21:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
 <494ff778-1888-7743-3a91-62364431d82e@amlogic.com> <c1d08bc7-b868-7781-e69a-0e6bacde5b40@baylibre.com>
In-Reply-To: <c1d08bc7-b868-7781-e69a-0e6bacde5b40@baylibre.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 13 Sep 2018 12:07:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v67ybV=U2yKARQYrXnvg3N4ARuXg3wi3cWYo7-1cMJ=McQ@mail.gmail.com>
Message-ID: <CAGb2v67ybV=U2yKARQYrXnvg3N4ARuXg3wi3cWYo7-1cMJ=McQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     yixun.lan@amlogic.com, Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 26/07/2018 16:41, Yixun Lan wrote:
> > HI Neil
> >
> > On 07/26/2018 10:13 PM, Neil Armstrong wrote:
> >> The order between "syscon" and "simple-mfd" is important because in these
> >> particular cases, the node needs to be first a "simple-mfd" to expose
> >> it's sub-nodes, and later on a "syscon" to permit other nodes to access
> >> this register space through the "syscon" mechanism.
> >>
> >
> > could you explain a bit which specific case that it need compatible
> > "simple-mfd" come first? is this a problem in kernel side? because I see
> > you have a comment below about problem in U-Boot..
>
> It's not a problem for Linux, but Linux is just an implementation, the device tree
> should work on multiple OSs like U-Boot or BSD kernels. We should base ourselves on
> the bindings documentation and the Device tree specification to specify the HW.
>
> In this case, we need to switch the order to specify it correctly.

syscon on Linux works because syscon is not a full blown device driver in
the driver model. It is just a set of APIs wrapping regmap.

> >
> >
> > also while Rob review the mmc-clkc patch, he raise a suggestion to  drop
> > "syscon" in drivers/mfd/syscon.c, see [1], will that solve or affect
> > your problem?
>
> Rob wants us to drop the "syscon" because he wants us to move all nodes
> depending of HHI as subnode, which is impossible for HDMI and the VPU power controller,
> they are only "syscon" clients, their own registers are not in HHI.

You can have whatever device driver this is bound to export regmaps for clients
to consume. This gives you finer control over what registers can be accessed.

See the following example.

Provider: https://elixir.bootlin.com/linux/v4.19-rc3/source/drivers/clk/sunxi-ng/ccu-sun8i-r40.c#L1315
Client: https://elixir.bootlin.com/linux/v4.19-rc3/source/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c#L1035

Hope this helps.

ChenYu

> Neil
>
> >
> > [1]
> > https://lkml.kernel.org/r/CAL_Jsq+r+7BaJAPBn3L26sdxATVyDiuC=V3xE+yz0-27q0RJhA@mail.gmail.com
> >
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >> This also has a consequence for U-Boot since the U-Boot DM is much simpler
> >> and can only associate a single device to a node, thus here we want these
> >> nodes to be an mfd bus to be able to probe the sub-nodes.
> >>
> >>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
> >>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> >> index 6adc8d3..3f0de9d 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> >> @@ -342,7 +342,7 @@
> >>                      ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
> >>
> >>                      sysctrl: system-controller@0 {
> >> -                            compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
> >> +                            compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";
> >>                              reg = <0 0 0 0x400>;
> >>
> >>                              clkc: clock-controller {
> >> @@ -1180,7 +1180,7 @@
> >>                      ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
> >>
> >>                      sysctrl_AO: sys-ctrl@0 {
> >> -                            compatible = "amlogic,meson-axg-ao-sysctrl", "syscon", "simple-mfd";
> >> +                            compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
> >>                              reg =  <0x0 0x0 0x0 0x100>;
> >>
> >>                              clkc_AO: clock-controller {
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> >> index b8dc4db..d88699f 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> >> @@ -344,7 +344,7 @@
> >>                      ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
> >>
> >>                      sysctrl_AO: sys-ctrl@0 {
> >> -                            compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
> >> +                            compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
> >>                              reg =  <0x0 0x0 0x0 0x100>;
> >>
> >>                              pwrc_vpu: power-controller-vpu {
> >> @@ -431,7 +431,7 @@
> >>                      ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
> >>
> >>                      sysctrl: system-controller@0 {
> >> -                            compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
> >> +                            compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
> >>                              reg = <0 0 0 0x400>;
> >>                      };
> >>
> >>
> >
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
