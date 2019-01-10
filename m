Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E836CC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F3D206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfAJQQg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:16:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51302 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfAJQQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:16:35 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C85E7209BD; Thu, 10 Jan 2019 17:16:32 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr [109.213.145.18])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7BDFF20898;
        Thu, 10 Jan 2019 17:16:22 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v3 0/6] Add CPU clock support for Armada 7K/8K
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
Date:   Thu, 10 Jan 2019 17:16:22 +0100
In-Reply-To: <20181216094147.6468-1-gregory.clement@bootlin.com> (Gregory
        CLEMENT's message of "Sun, 16 Dec 2018 10:41:41 +0100")
Message-ID: <87a7k8o5d5.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On dim., déc. 16 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Hello,
>
> This is the third version of a series allowing to manage the cpu
> clock for Armada 7K/8K. For these SoCs, the CPUs share the same clock
> by cluster, so actually the clock management is done at cluster level.
>
> As for the other Armada 7K/8K clocks it is possible to have multiple
> AP so here again we need to have unique name: the purpose of the second
> patch is to share a common code which will be used in 3 drivers.
>
> The last 2 patch enable the driver at dt and platform level and will
> be applied through the mvebu subsystem.

What is the status of this series?

The only comments I had was from Rob about the binding and I answered
them 3 weeks ago. Do you have any other comments? Do you expect a rebase
of this series on v5.0-rc1?

Thanks,

Gregory

>
> Changelog v2->v3:
>  - Add back the first patch documenting the binding
>
> Changelog v1->v2:
>  - Header cleanup
>  - Use unsigned int instead of it for cluster member of the ap_cpu_clk struct
>  - Use clk_hw instead of clk
>  - Use regmap_read_poll_timeout
>  - Use for_each_of_cpu_node
>  - Remove unnecessary WARN_ON()
>  - Remove headers from armada_ap_cp_helper.h
>  - Few other minor cleanup
>
> Gregory CLEMENT (6):
>   dt-bindings: ap806: add the cluster clock node in the syscon file
>   clk: mvebu: add helper file for Armada AP and CP clocks
>   clk: mvebu: add CPU clock driver for Armada 7K/8K
>   clk: mvebu: ap806: Fix clock name for the cluster
>   arm64: marvell: enable the  Armada 7K/8K CPU clk driver
>   arm64: dts: marvell: Add cpu clock node on Armada 7K/8K
>
>  .../arm/marvell/ap806-system-controller.txt   |  22 ++
>  arch/arm64/Kconfig.platforms                  |   1 +
>  .../boot/dts/marvell/armada-ap806-quad.dtsi   |   4 +
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi |   6 +
>  drivers/clk/mvebu/Kconfig                     |   8 +
>  drivers/clk/mvebu/Makefile                    |   2 +
>  drivers/clk/mvebu/ap-cpu-clk.c                | 259 ++++++++++++++++++
>  drivers/clk/mvebu/ap806-system-controller.c   |  24 +-
>  drivers/clk/mvebu/armada_ap_cp_helper.c       |  30 ++
>  drivers/clk/mvebu/armada_ap_cp_helper.h       |  11 +
>  drivers/clk/mvebu/cp110-system-controller.c   |  32 +--
>  11 files changed, 357 insertions(+), 42 deletions(-)
>  create mode 100644 drivers/clk/mvebu/ap-cpu-clk.c
>  create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.c
>  create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.h
>
> -- 
> 2.19.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
