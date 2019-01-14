Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B79C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0C5206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UId8R3qL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfANQcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:32:04 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35918 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfANQcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:32:03 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1F91210C11BA;
        Mon, 14 Jan 2019 08:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547483523; bh=Uiarnd/AZYqSEKWyBTGbSETG5y5PcDZLaBDo8nTgcqU=;
        h=From:To:Cc:Subject:Date:From;
        b=UId8R3qL6qPeqn3gLLEODHi0PVZQto77+JyjNUbYsGsskTLri4jYAjz3ID9ph8jLq
         Els9uVfoeMHYhpQ702fNrQtil7jEiL0V43aqiTpispgmhwAKJOOODYTQUWKmV0IVrU
         RJjaL3zePxgVCFpD2CWYYQen/38PQ/ESgc0zdsMnGndtI6J9QaRIxyC/fJSkDAGAEr
         rLqwF+reS1mOPJLlv37IKeGqKG1Ndgll2oPSNXs6PmP2DOfrttln34yU3dh9cWD9sE
         fRtLaxHTAU90CiLTKOrYySToyspYl0VrKLZ18/oFHxVToNTJ0/JNDPMe+J+ayvfhfX
         CA4Q+B2AqeJmw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id C7955337C;
        Mon, 14 Jan 2019 08:31:59 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     etnaviv@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] etnaviv: allow to build on ARC
Date:   Mon, 14 Jan 2019 19:31:57 +0300
Message-Id: <20190114163157.20114-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC HSDK SoC has Vivante GPU IP so allow build etnaviv for ARC.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/etnaviv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
index 342591a1084e..49a9957c3373 100644
--- a/drivers/gpu/drm/etnaviv/Kconfig
+++ b/drivers/gpu/drm/etnaviv/Kconfig
@@ -2,7 +2,7 @@
 config DRM_ETNAVIV
 	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
 	depends on DRM
-	depends on ARCH_MXC || ARCH_DOVE || ARM || COMPILE_TEST
+	depends on ARCH_MXC || ARCH_DOVE || ARM || ARC || COMPILE_TEST
 	depends on MMU
 	select SHMEM
 	select SYNC_FILE
-- 
2.14.5

