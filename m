Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF471C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725BC208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725BC208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeHWTBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:01:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeHWTBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:01:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46A2A7A9;
        Thu, 23 Aug 2018 08:31:21 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7EFB3F2EA;
        Thu, 23 Aug 2018 08:31:16 -0700 (PDT)
Date:   Thu, 23 Aug 2018 16:31:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: Fix various entry-method properties to
 reflect documentation
Message-ID: <20180823153110.GA19131@e107155-lin>
References: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

Thanks for fixing this.

On Thu, Aug 23, 2018 at 02:23:29PM +0530, Amit Kucheria wrote:
> The idle-states binding documentation[1] mentions that the
> 'entry-method' property is required on 64-bit platforms and must be
> set to "psci".
>
> commit a13f18f59d26 ("Documentation: arm: Fix typo in the idle-states
> bindings examples") attempted to fix this earlier but clearly more is
> needed.
>

In fact, I assumed I fixed things with commit 978fa436231a ("drivers:
firmware: psci: unify enable-method binding on ARM {64,32}-bit systems"),
but I was wrong. I left quite a few instances including juno dtbs.

> Fix the cpu-capacity.txt documentation that uses the incorrect value so
> we don't get copy-paste errors like these. Clarify the language in
> idle-states.txt by removing the reference to the psci bindings that
> might be causing this confusion.
>
> Finally, fix devicetrees of various boards to reflect current
> documentation.
>
> [1] Documentation/devicetree/bindings/arm/idle-states.txt (see
> idle-states node)
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
>  Documentation/devicetree/bindings/arm/idle-states.txt  | 4 ++--
>  arch/arm64/boot/dts/arm/juno-r1.dts                    | 2 +-
>  arch/arm64/boot/dts/arm/juno-r2.dts                    | 2 +-
>  arch/arm64/boot/dts/arm/juno.dts                       | 2 +-

For all the above files,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

How do you plan to merge ? I prefer if you can send it via arm-soc as
fixes for this cycle with all the necessary acks. Otherwise you may have
to split this to send via platform maintainers which is bit mundane.

--
Regards,
Sudeep
