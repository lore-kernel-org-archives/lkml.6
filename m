Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD03DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA1B2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="di7ygljQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA1B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeIZBqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeIZBqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:46:03 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D8421480;
        Tue, 25 Sep 2018 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537904217;
        bh=xj/4bc8BmB5LAPU5G5UHAUBLebKx9+PFS8G7Kix4+jk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=di7ygljQfShl0rD2R0UtoIS3K1lKGBdTzdYTY1X0F9vDsAvgvxDxL4nI+qOtZGT2D
         VRwRszedzLywmE0IAavTi0XSbfuhRfeTic7bQzdnSo0V7Yh8wEqzdw6UwwvZmHNnzv
         2+ZwhBX0xVG0O2MTsul9t4d/9DvvF9BSRGCz/Kis=
Received: by mail-qt1-f179.google.com with SMTP id z8-v6so14711285qto.9;
        Tue, 25 Sep 2018 12:36:56 -0700 (PDT)
X-Gm-Message-State: ABuFfohnJF+NaaYfwgPkqEBEoTw7HGY+VBtHxc51VK4870OQOpg0ZCEs
        J2X9sdsssm1BGPCHfdhF4V5U6NLLv0rqq1vIqQ==
X-Google-Smtp-Source: ACcGV61s2VmlOsJPa0DPyjI7AtBvdRNmSZxzFJlEA2z0Dois1UwGmw5hGzy3ypgxjIjxqSWVRl5PCzIQWIm8D3ILQ2c=
X-Received: by 2002:ac8:190e:: with SMTP id t14-v6mr1974644qtj.327.1537904216132;
 Tue, 25 Sep 2018 12:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180830194356.14059-1-digetx@gmail.com> <20180830194356.14059-2-digetx@gmail.com>
 <20180925165810.GA32430@bogus> <074a169d-294b-ad4b-ddbd-6db742278f2a@gmail.com>
In-Reply-To: <074a169d-294b-ad4b-ddbd-6db742278f2a@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Sep 2018 14:36:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLf+_Q8ZQAo=k8yQ4XKMccUHpm8WsQ3z_Q-PMY6gbQbbA@mail.gmail.com>
Message-ID: <CAL_JsqLf+_Q8ZQAo=k8yQ4XKMccUHpm8WsQ3z_Q-PMY6gbQbbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:29 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> On 9/25/18 7:58 PM, Rob Herring wrote:
> > On Thu, Aug 30, 2018 at 10:43:52PM +0300, Dmitry Osipenko wrote:
> >> Add device-tree binding that describes CPU frequency-scaling hardware
> >> found on NVIDIA Tegra20/30 SoC's.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> >> new file mode 100644
> >> index 000000000000..2c51f676e958
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> >> @@ -0,0 +1,38 @@
> >> +Binding for NVIDIA Tegra20 CPUFreq
> >> +==================================
> >> +
> >> +Required properties:
> >> +- clocks: Must contain an entry for each entry in clock-names.
> >> +  See ../clocks/clock-bindings.txt for details.
> >> +- clock-names: Must include the following entries:
> >> +  - pll_x: main-parent for CPU clock, must be the first entry
> >> +  - backup: intermediate-parent for CPU clock
> >> +  - cpu: the CPU clock
> >
> > The Cortex A9 has CLK, PERIPHCLK, and PERIPHCLKEN clocks and only CLK
> > is used for the cpu core. You can't just define your own clocks that
> > you happen to want access to.
> >
> > Otherwise, you're not defining anything new here, so a binding document
> > isn't required.
>
> PERIPHCLK is a different thing.

Right, that's what I meant. Only CLK is used.

> Here we are defining the CPU clock and
> its *parent* sources, the PLLX (main) and backup (intermediate clock
> that is used while PLLX changes its rate). These are not some random
> clocks "that you happen to want access to", they are essential for the
> Tegra CPUFreq driver, CPU is running off them.

assigned-clocks is generally how we get parent clocks in this
situation. "clocks" is for what physical clocks are attached to a
given block. ARM very clearly documents the clocks for their IP
blocks.

> I assume that PERIPHCLK and other clocks are derived from the "CPU"
> clock and their configuration is hardwired. Probably Peter knows how
> it's implemented in HW.

Yes, because PERIPHCLK must be synchronous. In any case, it is
irrelevant to cpu nodes and applies to timer, SCU, and GIC nodes.

> I'm now working on v2 that will include more Tegra-specific stuff in the
> binding, like custom "opp-supported-hw" property and probably some more.
