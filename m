Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08FAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675BA214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lulArsmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfAHUoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:44:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfAHUoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G+YKGmYVhN8Htzyk+jHaPl5L6C1T7CXTSOzHye9Yca4=; b=lulArsmEPn2pbzA4SfjdlGJuHC
        B23OMo0b8ZNQSxVnfH5NpWaRdptwVoR3ANsV8+FTxRijy6CaVeOiRnYJbciuDtdgKnS1Z0uE0+xkI
        Y7KT5KiUMMERr69GYVndPZ1Kwwr3KEV40r7mc9/5fKud1EdvcVUy2FKcQzU2m9mDZVq1JB2dC/esQ
        khtGRLiRyur2DDVW2T6jVI+SIAIt1yTHgaiQkVUT/YPbK33hobF7MaOHmgUcT8Sx2pY698zoPYq8k
        ad3F95rxbEeorMKeOYePXo81wyVc335de6yMhZo2wF63Yfh5PnshtDeHrG6UwKZm3N8aJZa2MdrHO
        OaLbsqDg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggyE8-0004yp-Gk; Tue, 08 Jan 2019 20:43:56 +0000
Date:   Tue, 8 Jan 2019 12:43:56 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Build etnaviv on non-ARM architectures
Message-ID: <20190108204356.GF6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I wanted to test-compile etnaviv on x86 after making a tree-wide change
to it.  Unfortunately, Kconfig has a bad dependency, so I couldn't.

Signed-off-by: Matthew Wilcox <willy@infradead.org>

diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
index 041a77e400d4..342591a1084e 100644
--- a/drivers/gpu/drm/etnaviv/Kconfig
+++ b/drivers/gpu/drm/etnaviv/Kconfig
@@ -2,7 +2,7 @@
 config DRM_ETNAVIV
 	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
 	depends on DRM
-	depends on ARCH_MXC || ARCH_DOVE || (ARM && COMPILE_TEST)
+	depends on ARCH_MXC || ARCH_DOVE || ARM || COMPILE_TEST
 	depends on MMU
 	select SHMEM
 	select SYNC_FILE

