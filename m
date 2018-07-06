Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4177DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABB724061
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Si5TBdwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABB724061
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbeGFFNT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:13:19 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:41845 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeGFFNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:13:18 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w665CE5q000672;
        Fri, 6 Jul 2018 14:12:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w665CE5q000672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530853935;
        bh=KUkzLJ1bVTWGE5rgDCoZofkAOKaedlG2zQQ+pIQY5Qs=;
        h=From:To:Cc:Subject:Date:From;
        b=Si5TBdwDDhdg0PR2IgddtMERTYE/igDbshwEoTEaiGAZTmtw/X9D/StERLA3YddOm
         E9ZEiWHSIi3c/he7ReH+E2/jYPwuKUI7GO2jLrsxKCfAeggeIjkoFbVCzpyKRl3g5P
         adhYroNvQtcnoUUHUxm0DwK38ezlCCMzF/zUMudrhL4AtWnbuPb6WKSAUttCkZClcB
         QfF3MVwbohfO3Zruyg3ABXWYNXxxD07LqmIuqJMX3Y2d/EP2FoNLb4Z/WmnxPo1p7j
         BS1G/ZUoWy3o0y4XRn/d4NQNwz0P9prHJwPQIVeNnFo+udqzzoJz5eFnVEIVGAz4rz
         LCmUJnfczQ/lw==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org, Chunming Zhou <david1.zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/sched: remove unneeded -Iinclude/drm compiler flag
Date:   Fri,  6 Jul 2018 14:12:11 +0900
Message-Id: <1530853931-12061-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I refactored the include directives under include/drm/ some time ago.
This flag is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpu/drm/scheduler/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/Makefile b/drivers/gpu/drm/scheduler/Makefile
index bd0377c..7665883 100644
--- a/drivers/gpu/drm/scheduler/Makefile
+++ b/drivers/gpu/drm/scheduler/Makefile
@@ -20,7 +20,6 @@
 # OTHER DEALINGS IN THE SOFTWARE.
 #
 #
-ccflags-y := -Iinclude/drm
 gpu-sched-y := gpu_scheduler.o sched_fence.o
 
 obj-$(CONFIG_DRM_SCHED) += gpu-sched.o
-- 
2.7.4

