Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D0C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A00520835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026627;
	bh=LsK7omSp9/B3EHP4Se8H0UsHklqvEVYTkx+mJSL0+wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CcFZTULip0Wp1ChIPODzhvvlBCJYsMcKu47BLuteko9Rj7U+I+ze9aiVHH4fnQbth
	 CegQO+o49wIsMFch0ApXIvHGfzcT6wCCfGXk6pyxeDhEdN/hoRXkUlVvG3faJ0ECFE
	 JBOzgkNVykGgCml4YoclT8C3LbBxDevNHEgqt7u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbfBMC5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:57:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388244AbfBMChM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8A1222C2;
        Wed, 13 Feb 2019 02:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025431;
        bh=LsK7omSp9/B3EHP4Se8H0UsHklqvEVYTkx+mJSL0+wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nc42F2TciOmgoQlVAAKMJ7fl3TWjsQurYtBcFvSwNvz26o3KPDsIrd/15KovPqxJ3
         AbOPXVYfFhGT5aPeZAWjqjG3WAQH5cyVcGJUxiUv6iMb4zLVCZwsF/+FE3ulJbLTeL
         zFoRv9NMsgARfpxxXce0eN5bmgnr+Jxgr1U+yp0w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 08/83] mfd: db8500-prcmu: Fix some section annotations
Date:   Tue, 12 Feb 2019 21:35:46 -0500
Message-Id: <20190213023701.20286-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit a3888f62fe66429fad3be7f2ba962e1e08c26fd6 ]

When building the kernel with Clang, the following section mismatch
warnings appear:

WARNING: vmlinux.o(.text+0x7239cc): Section mismatch in reference from
the function db8500_prcmu_probe() to the function
.init.text:init_prcm_registers()
The function db8500_prcmu_probe() references
the function __init init_prcm_registers().
This is often because db8500_prcmu_probe lacks a __init
annotation or the annotation of init_prcm_registers is wrong.

WARNING: vmlinux.o(.text+0x723e28): Section mismatch in reference from
the function db8500_prcmu_probe() to the function
.init.text:fw_project_name()
The function db8500_prcmu_probe() references
the function __init fw_project_name().
This is often because db8500_prcmu_probe lacks a __init
annotation or the annotation of fw_project_name is wrong.

db8500_prcmu_probe should not be marked as __init so remove the __init
annotation from fw_project_name and init_prcm_registers.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/db8500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 5970b8def548..aec20e1c7d3d 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2584,7 +2584,7 @@ static struct irq_chip prcmu_irq_chip = {
 	.irq_unmask	= prcmu_irq_unmask,
 };
 
-static __init char *fw_project_name(u32 project)
+static char *fw_project_name(u32 project)
 {
 	switch (project) {
 	case PRCMU_FW_PROJECT_U8500:
@@ -2732,7 +2732,7 @@ void __init db8500_prcmu_early_init(u32 phy_base, u32 size)
 	INIT_WORK(&mb0_transfer.mask_work, prcmu_mask_work);
 }
 
-static void __init init_prcm_registers(void)
+static void init_prcm_registers(void)
 {
 	u32 val;
 
-- 
2.19.1

