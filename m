Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55841C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 10:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8D021A00
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 10:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FUYLoTsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8D021A00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeHKNFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 09:05:17 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49816 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeHKNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 09:05:17 -0400
Received: from trochilidae.toradex.int (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id BB0665C0487;
        Sat, 11 Aug 2018 12:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533983488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=FAFyJRQOnOqNrtK8rCe4J2HMowQZBUPj6BUvhK2jXdY=;
        b=FUYLoTscRzzxS/YomUj0H+Jqc4tqibPmuaS+wOgDtwuO55fhF1sIFpzJHhE7r4/t3C/oM2
        l9Z/8y27Bdrwkm1WXoT+U0Nj4OZFLXMW0fMAYtWNPPSW6ub5Xz5wx9kkmtJghFhna9sfSD
        W+eEE7qsyh48w1zMlJ/qKiJ/e6ItLqk=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     catalin.marinas@arm.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: drop experimental mark for ARM stack unwinding
Date:   Sat, 11 Aug 2018 12:31:27 +0200
Message-Id: <20180811103127.21485-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM stack unwinding is upstream since 2009 and has been proven
working well. At this time it is the preferred stack unwinding
support since it also supports Thumb 2. Do not scare people
and drop the EXPERIMENTAL mark.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index cb65cf67dfa2..ba2d94555e06 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -63,7 +63,7 @@ config FRAME_POINTER
 	  reported is severely limited.
 
 config ARM_UNWIND
-	bool "Enable stack unwinding support (EXPERIMENTAL)"
+	bool "Enable stack unwinding support"
 	depends on AEABI
 	default y
 	help
-- 
2.18.0

