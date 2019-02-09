Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E002C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BE92192D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738207;
	bh=0lO0iit06TzLXRolfipUZG6VCbfOCP/c6uw+U1foLAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xp4kjca+GzJ88tJ59aEDbSIuFtb4d5yqPhJq6hGalzu7aWUxtpKWn70EUE8Kn3tUf
	 5Ew2q1lPhtTsU6/f04tFw+/1389mVN0leTI3+TTJ0bitvhtFQ7dCTaapzrZ9OW46Pw
	 dDhuQz7dxAwLJOnIt3qui7xJXSMWmhxma4YQsLAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfBISuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbfBISuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:50:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A0FB21916;
        Sat,  9 Feb 2019 18:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738202;
        bh=0lO0iit06TzLXRolfipUZG6VCbfOCP/c6uw+U1foLAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZd+63d+e0CFqkHqJpbOpmc0DUXxDjuxBlkNN5tJ+hHwG74ELvqQ7v6zYVv9tdP5f
         1Z5688zZX7l/H58RK21YLPDf2cC7ohdq40RdhrA7q14HTa/ZZ/45nmUniJDQPL/fjA
         1xQv5xbPJEQ/Eqkjhst1uSigbaXgQZNmd69B1zOY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 08/12] ARM: dts: da850-evm: Correct the sound card name
Date:   Sat,  9 Feb 2019 13:49:48 -0500
Message-Id: <20190209184952.127009-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184952.127009-1-sashal@kernel.org>
References: <20190209184952.127009-1-sashal@kernel.org>
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
index 78492a0bbbab..3c58ec707ea9 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -156,7 +156,7 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "DA850/OMAP-L138 EVM";
+		simple-audio-card,name = "DA850-OMAPL138 EVM";
 		simple-audio-card,widgets =
 			"Line", "Line In",
 			"Line", "Line Out";
-- 
2.19.1

