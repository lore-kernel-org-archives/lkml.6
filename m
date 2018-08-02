Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C724C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABCE2150B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABCE2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbeHBNuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:50:03 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41758 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732357AbeHBNuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:50:02 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1flCFp-0001em-BI; Thu, 02 Aug 2018 13:58:53 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     cl@rock-chips.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, hjc@rock-chips.com,
        jagan@amarulasolutions.com, djw@t-chip.com.cn,
        jacob-chen@iotwrt.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com
Subject: Re: [PATCH v3 3/4] arm64: dts: rockchip: add core dtsi file for PX30 SoCs
Date:   Thu, 02 Aug 2018 13:58:51 +0200
Message-ID: <5420010.G1GNdo6K2G@phil>
In-Reply-To: <1533113116-8820-4-git-send-email-cl@rock-chips.com>
References: <1533113116-8820-1-git-send-email-cl@rock-chips.com> <1533113116-8820-4-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 1. August 2018, 10:45:15 CEST schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds core dtsi file for Rockchip PX30 SoCs.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

applied with the following changes:
- some reordering
- cpu properties should be present in all cpu nodes (clocks etc)
- added dma-names to uarts
- dropped #dma-cells from uarts+spi (only for dma-controllers)
- dropped phy-names from usb nodes without actual phys
  (please readd once you have phy support)
- dropped the gamma_lut + reg-names and spanned the
  registers till below the iommu, similar to all other socs we have
- dropped the high_speed pinctrl state from the spi nodes
  (not part of mainline dt-binding)
- dropped peripherals-req-type-burst from the dmac
  (not part of mainline dt-binding)
- split out dwc2 into separate patch to be applied once the binding lands
- set #sound-dai-cells in px30.dtsi ... property of the i2s controller
  and doesn't change per board


Heiko



