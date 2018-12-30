Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D12C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B701F20836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546199783;
	bh=EBi0Eikby8jwxk/bavaKlEF1qmeWvDD2yPVUcPIK9eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YBqNlvgn/PIMgRfpUzHx999V2xSJ41HVTfihZat0iND5xp11sWfih292TQlZwILAP
	 dLGJBgwAs93PQUBIbqv51SQOVhdzZD2W0gKIiXQ1bfEIzf36B0nsycQ/w6IqoF0EkD
	 NfBOuYeeCm6sUMP71anhtKPj+hCWvgNqmluy7D10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeL3T4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbeL3T4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:56:18 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44442087F;
        Sun, 30 Dec 2018 19:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546199777;
        bh=EBi0Eikby8jwxk/bavaKlEF1qmeWvDD2yPVUcPIK9eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUX9zzJMUouT96VeenqUq2KL/swf5tAGrAfk7ldhNPsrWdhGbLRW2B+fJsiCdfKZ1
         MHjemNm6LdlvNyWcLeL6p2vWSQiwup+Td8DNcf8iwkhfdtKp/X+V03NtGj3slas6WB
         ptS/QIXnk7lSwuJI+fTZhem1KkCYDdMrDbq/Tyag=
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
Subject: [PATCH v4 03/11] vga-switcheroo: make PCI dependency explicit
Date:   Sun, 30 Dec 2018 19:56:04 +0000
Message-Id: <20181230195612.6657-4-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver depends on the PCI infrastructure but the dependency has not
been explicitly called out.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
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

