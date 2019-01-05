Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C1EC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16D3217D6
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAERsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:48:53 -0500
Received: from kozue.soulik.info ([108.61.200.231]:40136 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfAERsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:48:53 -0500
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
        by kozue.soulik.info (Postfix) with ESMTPA id C92E5100F5C;
        Sun,  6 Jan 2019 02:49:27 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     linux-rockchip@lists.infradead.org
Cc:     Randy Li <ayaka@soulik.info>, mturquette@baylibre.com,
        sboyd@kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, zhangqing@rock-chips.com,
        geert+renesas@glider.be
Subject: [PATCH 0/3] The basic patches for rockchip video codec
Date:   Sun,  6 Jan 2019 01:48:34 +0800
Message-Id: <20190105174837.19378-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will post a driver for video codec using the vendor userspace
interface. It is not used for merging but checking the work status of
the other devices and pre-patches need to be merged.

Without the following modification, video codec can't work properly.
I check the status of the upstream kernel for rockchip, network, eMMC,
USB and VOP work much worse and slow than the vendor kernel. I think the
video codec driver would be a good example to verify the other drivers.

Randy Li (3):
  clk: rockchip: add video clk parents for rk3399
  arm64: dts: rockchip: add power domain to iommu rk3399
  soc: rockchip: power-domain: export idle request

 arch/arm64/boot/dts/rockchip/rk3399.dtsi |  2 ++
 drivers/clk/rockchip/clk-rk3399.c        |  5 +++--
 drivers/soc/rockchip/pm_domains.c        | 23 +++++++++++++++++++++++
 include/dt-bindings/clock/rk3399-cru.h   |  2 ++
 include/soc/rockchip/pm_domains.h        | 18 ++++++++++++++++++
 5 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 include/soc/rockchip/pm_domains.h

-- 
2.20.1

