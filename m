Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9ACC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B9D2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500909;
	bh=IC0QHOCuYBIkcJa5bve4qxPYzYe++Vwe8EFIT9D7JBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gt6LRUoTu87UVAqwv4VjV4iDY7m2eQD/mEa7q3T8i4TD+Itx8FSk2gJiVcQSV1DDF
	 zMMVTJGM/WF/gSVgYLR0Nfoz0Ib1a5CeM64WZT1Y4z7xLvhEHcyGmn9IH9f14SK1xP
	 FkjviBISagDgF4ebuAJvUuN9cpqGPDbpvzhJcHHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392683AbeLVRsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389982AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.9.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C732197E;
        Sat, 22 Dec 2018 09:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545469649;
        bh=IC0QHOCuYBIkcJa5bve4qxPYzYe++Vwe8EFIT9D7JBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nohul/iuFwrq1votFDyhWilE9UGovv18dXdT9shfUB1Aik168abRSROOCqICu7cjo
         chjLOayV9m0VWGtiQvLw536tsJs07lbAyBnj61LUtxGw9eI1+fu/ZCdh49pNndGUPI
         4T8N0ymAQbOlcs+nlshB54fa9Hr8yt2+y0DDQKCI=
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
Subject: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
Date:   Sat, 22 Dec 2018 09:07:12 +0000
Message-Id: <20181222090720.19234-4-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222090720.19234-1-okaya@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver depends on the PCI infrastructure but the dependency has not
been explicitly called out.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
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

