Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739ABECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CBE20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CBE20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeKIBxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:53:09 -0500
Received: from anholt.net ([50.246.234.109]:33366 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeKIBxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:53:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DDEB010A135B;
        Thu,  8 Nov 2018 08:16:56 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id unvb3EfBPcGW; Thu,  8 Nov 2018 08:16:55 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5220910A1218;
        Thu,  8 Nov 2018 08:16:55 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 072BE2FE1B8F; Thu,  8 Nov 2018 08:16:54 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/4] V3D TFU engine support
Date:   Thu,  8 Nov 2018 08:16:50 -0800
Message-Id: <20181108161654.19888-1-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for V3D's TFU engine (a little texture
tiling/YUV import/mipmap generation block).  Corresponding Mesa
userspace is at
https://gitlab.freedesktop.org/anholt/mesa/commits/v3d-tfu

Once we have TFU, the next step will be compute shaders, which are a
lot more interesting.

Eric Anholt (4):
  drm/v3d: Fix whitespace inconsistency in the header.
  drm/v3d: Update a comment about what uses v3d_job_dependency().
  drm/v3d: Clean up the reservation object setup.
  drm/v3d: Add support for submitting jobs to the TFU.

 drivers/gpu/drm/v3d/v3d_drv.c   |  12 +-
 drivers/gpu/drm/v3d/v3d_drv.h   |  32 +++++-
 drivers/gpu/drm/v3d/v3d_gem.c   | 193 ++++++++++++++++++++++++++------
 drivers/gpu/drm/v3d/v3d_irq.c   |  12 +-
 drivers/gpu/drm/v3d/v3d_regs.h  |  58 ++++++++++
 drivers/gpu/drm/v3d/v3d_sched.c | 149 ++++++++++++++++++++----
 drivers/gpu/drm/v3d/v3d_trace.h |  20 ++++
 include/uapi/drm/v3d_drm.h      |  29 ++++-
 8 files changed, 437 insertions(+), 68 deletions(-)

-- 
2.19.1

