Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88851C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463DD20643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738557;
	bh=jauBVuEMV0QV6+oecCgNQMEU3pLaZdlqhBWT1G9Cnzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MlFsfYIfOiyvGGcckVYB6OIKqru16pK0DixLP0y2E0zAYBZYf/OK6z1hYzGOWN3mQ
	 vq0Irh4FK3PdUDqZxi57GroMXmKWyyYkM97eZfryMCpsIQg6bsY+/4H4hgmYJ1lNYW
	 /fmwpXfLI19oW8mObw0/qm7B/1gth7b78Xe9hKpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfBISz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:55:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfBISsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0AE321929;
        Sat,  9 Feb 2019 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738095;
        bh=jauBVuEMV0QV6+oecCgNQMEU3pLaZdlqhBWT1G9Cnzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qq/IouXMDPP9153ah16MgNrvUvmR9UpemeOynRWNBeOBa+wXU4Y6tbzC5U6G0jxpp
         OJAzo/tpaIpPw4W3JE2ZhR2tNRGqZQZjOby4U9qFMqWL2efcJ3BLyTqN0ZOj7nmevQ
         9WeOe550XpZlFIwxx1UEvRdz1OP3GAmwWd5cOTtw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 30/42] ARM: dts: da850-evm: Correct the sound card name
Date:   Sat,  9 Feb 2019 13:47:22 -0500
Message-Id: <20190209184734.125935-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
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
index 482a54587b44..f04bc3e15332 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -127,7 +127,7 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "DA850/OMAP-L138 EVM";
+		simple-audio-card,name = "DA850-OMAPL138 EVM";
 		simple-audio-card,widgets =
 			"Line", "Line In",
 			"Line", "Line Out";
-- 
2.19.1

