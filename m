Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A770EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2F1218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="f8+N+ldV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbeLUIwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:52:47 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:23352 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbeLUIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:52:47 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id wBL8q1cB025260;
        Fri, 21 Dec 2018 17:52:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com wBL8q1cB025260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545382322;
        bh=4wBOauSbCObGTdNo4+TZtfYp3enMB0EtNCfMkAj8iWs=;
        h=From:To:Cc:Subject:Date:From;
        b=f8+N+ldVCXJZfteTHEqVoQ4NxXNQXTpyzhtBrnMEF6SiIDYBjgaQTZUZZg6gKKKxX
         lBWKTPXnTi+lkkYofn4hXPbf79Bxt2ZPd9ObDJuvIDM5iFfyHe1B0RQ3TrwE4sIxKH
         +/PjV37cCi4PruEP1rHq1wDfYPY+1VSwIQufqg464lsT1EInqqiUuL6r0XHJ4uEpaz
         XUwiYYpiN8KS7r7XFU2qchSEfOX/BgaZSZ0b9Blk8+M4fr2Ty77cqH1ZrhpI9nSD01
         XJ4yexzhWqaQ+6dj9lhMFkuLbPnhM+FmSCEDgbBvvjXYqSFsUSJ+ezj77ODliw2ZUP
         FRmhiBP6+nrRQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RESEND PATCH] ARM: multi_v7_defconfig: enable CONFIG_UNIPHIER_MDMAC
Date:   Fri, 21 Dec 2018 17:51:24 +0900
Message-Id: <1545382284-7290-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the UniPhier MIO DMAC driver. This is used as the DMA engine
for accelerating the SD/eMMC controller drivers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

When I sent this last time, Olof asked me to resend it later
to avoid accidental drop.

I think the patches for v5.0 have been almost queued up.
So, I am resending it on top of that.

The insert context was decided by savedefconfig
based on next-20181221.


 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 63af623..715da88 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -862,6 +862,7 @@ CONFIG_STM32_DMA=y
 CONFIG_STM32_DMAMUX=y
 CONFIG_STM32_MDMA=y
 CONFIG_TEGRA20_APB_DMA=y
+CONFIG_UNIPHIER_MDMAC=y
 CONFIG_XILINX_DMA=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_DW_DMAC=y
-- 
2.7.4

