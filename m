Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B0C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7FE2192D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738213;
	bh=SdfRR7/jnqxFnT8kHQQFflPutM47ouGdpNlR4d38/88=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QgA4gNzhJWegJOK7yg0u1ZI60/spWq+ZZj72fLrVBgKc8he8rn4KgjK33s3k8mulj
	 MKRjkv+N8A9A1h/PA3gf0cOLVm1+qEGvp3/yNxQucK4BS5gWvM+7Lo0I3sc/3YtEXD
	 1HsakKPhbG9t+qXvAAYdIa8VkqrPJh2jwhrbkcwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfBISuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfBISuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:50:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F08422192D;
        Sat,  9 Feb 2019 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738209;
        bh=SdfRR7/jnqxFnT8kHQQFflPutM47ouGdpNlR4d38/88=;
        h=From:To:Cc:Subject:Date:From;
        b=wKOTkeWG8WzztIQw5g3AaUK1BKbN4nTVm4AbzSrz1yMSHNtK/KR9u/Hs5Dl+g8AZO
         WVDDMcRWJB9vzVS1+MaA9y0YbXZfrcKRU586SSm6gWWfklINp7MKs9XLgQJQ0g/Mce
         Nutz2fwTgrnE1CEJV3HSUbngTbwgBdhXhOxoeXbk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 1/4] ARM: dts: da850-evm: Correct the sound card name
Date:   Sat,  9 Feb 2019 13:50:04 -0500
Message-Id: <20190209185007.127176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 7fca69d4e43fa1ae9cb4f652772c132dc5a659c6 ]

To avoid  the following error:
asoc-simple-card sound: ASoC: Failed to create card debugfs directory

Which is because the card name contains '/' character, which can not be
used in file or directory names.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/da850-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 6881757b03e8..67369f284b91 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -147,7 +147,7 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "DA850/OMAP-L138 EVM";
+		simple-audio-card,name = "DA850-OMAPL138 EVM";
 		simple-audio-card,widgets =
 			"Line", "Line In",
 			"Line", "Line Out";
-- 
2.19.1

