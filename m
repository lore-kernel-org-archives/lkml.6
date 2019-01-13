Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221BFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91A820873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfAMJYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:24:49 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:60651
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbfAMJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:24:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,473,1539640800"; 
   d="scan'208";a="291725798"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 13 Jan 2019 10:24:46 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] add missing of_node_puts
Date:   Sun, 13 Jan 2019 09:47:40 +0100
Message-Id: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

The patches for drivers/gpu/drm/imx/imx-ldb.c and
drivers/gpu/drm/sun4i/sun4i_backend.c contain some added of_node_puts for
which the need was identified manually.  Details are in the patch logs.

---

 drivers/gpu/drm/imx/imx-ldb.c           |   25 +++++++++++++++++--------
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |    5 ++++-
 drivers/gpu/drm/rockchip/rockchip_rgb.c |    4 +++-
 drivers/gpu/drm/sun4i/sun4i_backend.c   |    1 +
 4 files changed, 25 insertions(+), 10 deletions(-)
