Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B76C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17E52081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17E52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbeKFBkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:40:15 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:54811 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387436AbeKFBkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:40:15 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Nov 2018 20:40:14 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wA5Fftih023227;
        Mon, 5 Nov 2018 17:41:55 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 2B6F6630C9; Mon,  5 Nov 2018 18:11:54 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, yuenn@google.com,
        venture@google.com, benjaminfair@google.com,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1] watchdog: npcm: Modify npcm watchdog kconfig arch parameter
Date:   Mon,  5 Nov 2018 18:11:52 +0200
Message-Id: <20181105161152.205524-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify Nuvoton watchdog Kconfig default supported architecture
name to ARCH_NPCM7XX because ARCH_NPCM750 architecture name
is not supported.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2d64333f4782..746759ec8960 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -538,7 +538,7 @@ config COH901327_WATCHDOG
 config NPCM7XX_WATCHDOG
 	bool "Nuvoton NPCM750 watchdog"
 	depends on ARCH_NPCM || COMPILE_TEST
-	default y if ARCH_NPCM750
+	default y if ARCH_NPCM7XX
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include Watchdog timer support for the
-- 
2.14.1

