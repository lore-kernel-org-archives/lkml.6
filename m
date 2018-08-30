Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CFEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A36D20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A36D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeHaBQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:16:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55358 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbeHaBQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:16:26 -0400
Received: from ip5f5a866f.dynamic.kabel-deutschland.de ([95.90.134.111] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fvUEh-00009T-EM; Thu, 30 Aug 2018 23:12:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com
Cc:     seanpaul@chromium.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 0/3] Add support rockchip RGB output interface
Date:   Thu, 30 Aug 2018 23:12:04 +0200
Message-Id: <20180830211207.10480-1-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches add support rockchip RGB output, Some Rockchip CRTCs, like
rv1108 and px30 can directly output parallel and serial RGB data to panel
or to conversion chip.
So add a feature-bit for vops to mark the ability for these direct outputs
and add an internal encoder in that case, that can attach to bridge chips
or panels.


Hi Sandy,

while reviewing my own code in patch1, I found that it was missing
correct put calls for node and pdev and also made it behave better
if no device is present.

While we don't need that right now, it makes it possible to
distinguish between subdriver, external bridge or no device later
on if needed.

I've also updated the documentation of the function a bit, so that
people looking at it can grasp it hopefully easier :-)

And finally I've dropped the Review tag from Mark. He isn't at
Rockchip for a while now and the driver did change over time a bit.

So if you have time, please take a final look at it.

Thanks
Heiko


Heiko Stuebner (1):
  drm/rockchip: add function to check if endpoint is a subdriver

Sandy Huang (2):
  drm/rockchip: Add support for Rockchip Soc RGB output interface
  drm/rockchip: Add directly output rgb feature for px30

 drivers/gpu/drm/rockchip/Kconfig            |  11 ++
 drivers/gpu/drm/rockchip/Makefile           |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  48 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  16 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   1 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c     | 173 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_rgb.h     |  20 +++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
 9 files changed, 273 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.h

-- 
2.17.0

