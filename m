Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429FEECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC1B21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC1B21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIWCwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:52:32 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42988 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeIWCwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:52:32 -0400
Received: from p5b1273f1.dip0.t-ipconnect.de ([91.18.115.241] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g3oxz-0002T9-2o; Sat, 22 Sep 2018 22:57:27 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add 96Boards Rock960 CE board support
Date:   Sat, 22 Sep 2018 22:57:26 +0200
Message-ID: <1927657.aQyVdf9HM0@phil>
In-Reply-To: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
References: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 13. September 2018, 20:05:41 CEST schrieb Manivannan Sadhasivam:
> This patchset adds 96Boards Rock960 CE board support. Rock960 CE
> (Consumer Edition) board is one of the member of 96Boards Consumer
> Edition and AI platform and is manufactured by Vamrs Limited. Most of
> the board configuration is shared with the Ficus board manufactured by
> vamrs, which is an Enterprise 96Board.
> 
> For the sake of avoiding code duplication, a common rock960.dtsi file
> with common DT nodes for both boards and separate board specific DTS
> files has been added.
> 
> To be specific, below are some of the key differences between both
> boards:
> 
> 1. Different host enable GPIO for USB
> 2. Different power and reset GPIO for PCI-E
> 3. No Ethernet port on Rock960
> 
> While adding the board support, SD card Chip detection support is also
> added to the common dtsi file, shared by both boards.
> 
> This series has been tested on Rock960 CE v1.2 board.
> 
> Thanks,
> Mani
> 
> Changes in v3:
> 
> * Moved usb and pcie nodes to common dtsi and kept only the properties
>   which differ in board specific dts.
> * Updated the common dtsi commit description.
> 
> Changes in v2:
> 
> * Changed the board compatible to "vamrs,rock960"
> 
> Manivannan Sadhasivam (4):
>   arm64: dts: rockchip: Split out common nodes for Rock960 based boards
>   dt-bindings: arm: rockchip: Add binding for Rock960 board
>   arm64: boot: dts: rockchip: Add support for Rock960 board
>   arm64: dts: rockchip: Enable SD card detection for Rock960 boards

applied all 4 for 4.20, after fixing the subject of patch3 (-boot:)
and adapting to recent Makefile changes as pointed out by
Ezequiel.

Heiko


