Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D04AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E730721927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437770;
	bh=b4GDJSnPgE697ZATEUZ5ghkyV04y2gqW0krSz6m3sTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YiPsQWLyazUqp5XMgUpgPZW4Hie+Fe/xSrD9Gy4mOlGD4LEGy4HQ5xCBZd2Gx39Lf
	 H1lahexk4MthgjbMJ499miiEywWiVom03V2Ne5TYxnpIOG6DmJNiycARqTaZnrK44B
	 p1Lci2SZGF9MPEtLGMKPlGjtoTRo0BZDnxHepaRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404839AbeLVAQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:16:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390972AbeLVAPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:15:02 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.82.132.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5367521934;
        Sat, 22 Dec 2018 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437702;
        bh=b4GDJSnPgE697ZATEUZ5ghkyV04y2gqW0krSz6m3sTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjZocuCf9mYqxaOatWUEug8fxYsybFFngfxjG5oAhUfrC3U5paJjLRG0inrvc63XU
         JkBHjn1jsSLS3AdpJf26wGf9ayNP3Ngs8YMzIo0ybpH/nMNuGMLsJW76gDntQ6zoyh
         GCBb9DZKpAiJoy0AwwkYwDvJ8+1VGTTyFijybjQo=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 03/11] vga-switcheroo: make PCI dependency explicit
Date:   Sat, 22 Dec 2018 00:14:44 +0000
Message-Id: <20181222001452.7474-4-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver depends on the PCI infrastructure but the dependency has not
been explicitly called out.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/gpu/vga/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index b677e5d524e6..d5f1d8e1c6f8 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -21,6 +21,7 @@ config VGA_SWITCHEROO
 	bool "Laptop Hybrid Graphics - GPU switching support"
 	depends on X86
 	depends on ACPI
+	depends on PCI
 	select VGA_ARB
 	help
 	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
-- 
2.19.0

