Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF2DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A0720852
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A0720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeH2Gdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:33:55 -0400
Received: from regular1.263xmail.com ([211.150.99.138]:46196 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeH2Gdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:33:55 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.242])
        by regular1.263xmail.com (Postfix) with ESMTP id 7926939D;
        Wed, 29 Aug 2018 10:39:12 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id ED464399;
        Wed, 29 Aug 2018 10:39:09 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <d4f6b576a62fb211e7d557341b63369a>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 22575KBSY05;
        Wed, 29 Aug 2018 10:39:11 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     hjc@rock-chips.com, heiko@sntech.de, seanpaul@chromium.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v6 0/3]  Add support rockchip RGB output interface
Date:   Wed, 29 Aug 2018 10:38:58 +0800
Message-Id: <1535510338-32543-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
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

Heiko Stuebner (1):
  drm/tockchip: add function to check if endpoint is a subdriver

Sandy Huang (2):
  drm/rockchip: Add support for Rockchip Soc RGB output interface
  drm/rockchip: Add directly output rgb feature for px30

 drivers/gpu/drm/rockchip/Kconfig            |  11 ++
 drivers/gpu/drm/rockchip/Makefile           |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  29 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  16 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   1 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c     | 173 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_rgb.h     |  20 ++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
 9 files changed, 255 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.h

-- 
2.7.4


