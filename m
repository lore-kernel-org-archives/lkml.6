Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B036BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5D22089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5D22089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934225AbeFLOJc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:09:32 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:18862 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933748AbeFLOIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:08:36 -0400
Received: from e110455-lin.cambridge.arm.com (e110455-lin.cambridge.arm.com [10.2.131.61])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id w5CE8DwO031673;
        Tue, 12 Jun 2018 15:08:13 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Mali DP Maintainers <malidp@foss.arm.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>
Subject: [PATCH v8 0/5] drm/mali-dp: Add support for memory writeback engine
Date:   Tue, 12 Jun 2018 15:08:08 +0100
Message-Id: <20180612140813.20419-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Updating the Mali DP memory writeback engine support series to match
the v10 generic writeback connector support posted here [1].

Changelog:
 - v8: Addressed feedback from Brian wrt the state tracking that we deploy
   for DP500 and the timing of the CVAL setting. Also added SPDX license
   identifiers for the newly added files.
 - v7: Added support for DP500 writeback. It behaves differently from
   the rest of the IP portfolio, but because customers are asking for
   it to be supported in mainline, we're adding it here.
 - v6: skipped, in order to align with latest generic series numbers.
 - v5: https://lists.freedesktop.org/archives/dri-devel/2017-May/141799.html

Best regards,
Liviu

[1] https://lists.freedesktop.org/archives/dri-devel/2018-June/179753.html

Brian Starkey (2):
  drm: mali-dp: Add RGB writeback formats for DP550/DP650
  drm: mali-dp: Add writeback connector

Liviu Dudau (3):
  drm: mali-dp: Add support for writeback on DP550/DP650
  drm/mali-dp: Add writeback support for DP500.
  drm/mali-dp: Add RGB writeback formats for DP500.

 drivers/gpu/drm/arm/Makefile      |   1 +
 drivers/gpu/drm/arm/malidp_crtc.c |  10 ++
 drivers/gpu/drm/arm/malidp_drv.c  |  35 +++--
 drivers/gpu/drm/arm/malidp_drv.h  |   7 +
 drivers/gpu/drm/arm/malidp_hw.c   | 176 ++++++++++++++++++---
 drivers/gpu/drm/arm/malidp_hw.h   |  21 +++
 drivers/gpu/drm/arm/malidp_mw.c   | 250 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/arm/malidp_mw.h   |  14 ++
 drivers/gpu/drm/arm/malidp_regs.h |  18 ++-
 drivers/gpu/drm/drm_atomic.c      |   4 +
 10 files changed, 504 insertions(+), 32 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/malidp_mw.c
 create mode 100644 drivers/gpu/drm/arm/malidp_mw.h

-- 
2.17.1

