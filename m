Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7BFC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E2420821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738421;
	bh=5JJJPxS26lzE02anREPdzinU9aDVX3YiL8NtuzVz4EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PV4VPgje2r97lAVvNxXA5igUQmdWDMwgN9uXs8v4WzEXswXxqKLW1Oagv/gD0V4/j
	 f13gIW0jEUA55aCjagj5M62IV6lk2YqJXX3WedYErWFxECq+Lgq8xoUQktRbihoo06
	 DJQ88vT9Ds7fn28dFTCH4I2ewgN4M2KpMqZMTgYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfBISxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbfBIStP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D2D21919;
        Sat,  9 Feb 2019 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738154;
        bh=5JJJPxS26lzE02anREPdzinU9aDVX3YiL8NtuzVz4EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMv1meMxPjAKscVQS0NL1tNW6tGqmQp/j/5bVXC0hsNJeOQ4OF+2SeUkO5sMw+UNh
         xW/jfLxCQofghn91V0ZUFkR96tOGLLmNDZwaFsUnE/dP6dXjayR/Og9GPcUPcUvfQF
         H3Bf4WKvsghFvT3hH8iLod6GsjzAkhRtI8TPyv1Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 20/28] ARM: dts: da850-evm: Correct the sound card name
Date:   Sat,  9 Feb 2019 13:48:28 -0500
Message-Id: <20190209184840.126418-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
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
index e0ac195950b1..016616cc036c 100644
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

