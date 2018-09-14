Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C968AECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DC120882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DC120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeINXKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:10:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46182 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbeINXKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:10:55 -0400
Received: from p57b774c9.dip0.t-ipconnect.de ([87.183.116.201] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g0sJF-0006ps-0a; Fri, 14 Sep 2018 19:55:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        robh+dt@kernel.org, vicencb@gmail.com, shawn.lin@rock-chips.com,
        enric.balletbo@collabora.com, pbrobinson@gmail.com, tom@vamrs.com,
        dev@vamrs.com, stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add 96Boards Rock960 CE board support
Date:   Fri, 14 Sep 2018 19:55:12 +0200
Message-ID: <3932568.1d4PiNsIum@phil>
In-Reply-To: <a40ed76f22fd43f68af07d9bb56a0ff38171eef9.camel@collabora.com>
References: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org> <a40ed76f22fd43f68af07d9bb56a0ff38171eef9.camel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 14. September 2018, 19:42:51 CEST schrieb Ezequiel Garcia:
> On Thu, 2018-09-13 at 23:35 +0530, Manivannan Sadhasivam wrote:
> > This patchset adds 96Boards Rock960 CE board support. Rock960 CE
> > (Consumer Edition) board is one of the member of 96Boards Consumer
> > Edition and AI platform and is manufactured by Vamrs Limited. Most of
> > the board configuration is shared with the Ficus board manufactured by
> > vamrs, which is an Enterprise 96Board.
> > 
> > For the sake of avoiding code duplication, a common rock960.dtsi file
> > with common DT nodes for both boards and separate board specific DTS
> > files has been added.
> > 
> > To be specific, below are some of the key differences between both
> > boards:
> > 
> > 1. Different host enable GPIO for USB
> > 2. Different power and reset GPIO for PCI-E
> > 3. No Ethernet port on Rock960
> > 
> > While adding the board support, SD card Chip detection support is also
> > added to the common dtsi file, shared by both boards.
> > 
> > This series has been tested on Rock960 CE v1.2 board.
> > 
> > Thanks,
> > Mani
> > 
> > Changes in v3:
> > 
> > * Moved usb and pcie nodes to common dtsi and kept only the properties
> >   which differ in board specific dts.
> > * Updated the common dtsi commit description.
> > 
> > Changes in v2:
> > 
> > * Changed the board compatible to "vamrs,rock960"
> > 
> > Manivannan Sadhasivam (4):
> >   arm64: dts: rockchip: Split out common nodes for Rock960 based boards
> >   dt-bindings: arm: rockchip: Add binding for Rock960 board
> >   arm64: boot: dts: rockchip: Add support for Rock960 board
> >   arm64: dts: rockchip: Enable SD card detection for Rock960 boards
> > 
> >  .../devicetree/bindings/arm/rockchip.txt      |   4 +
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 524 +----------------
> >  .../boot/dts/rockchip/rk3399-rock960.dts      |  52 ++
> >  .../boot/dts/rockchip/rk3399-rock960.dtsi     | 542 ++++++++++++++++++
> >  5 files changed, 604 insertions(+), 519 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > 
> 
> Looks pretty good!
> 
> When applying this series, I noticed that it conflicts with
> 
> commit 8bb878cf20ae10809c36db96993bfce7026d062b
> Author: Levin Du <djw@t-chip.com.cn>
> Date:   Mon Jul 30 10:12:01 2018 +0800
> 
>     arm64: dts: rockchip: add support for ROC-RK3399-PC board
> 
> resolution is trivial, but you might want to rebase and resend,
> to make Heiko's life easier.

nah, that's ok as it is ;-)
Such a Makefile conflict I can fix up myself.

As it looks pretty good, I'd like to just give Rob a chance
to look at the added binding before applying.


