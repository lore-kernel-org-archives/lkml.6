Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07002C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EB22089F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EB22089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeKHItG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:49:06 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:8614 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeKHItF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:49:05 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id AB7F119F576;
        Thu,  8 Nov 2018 00:16:20 +0100 (CET)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v2 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
To:     arm-soc <arm@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
Message-ID: <a9127a79-ca84-6d39-8910-cc34db526534@free.fr>
Date:   Wed, 7 Nov 2018 23:40:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
which is not set.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8e181cca0a05..e4957df18f23 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -727,4 +727,3 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
-CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=y
-- 
2.17.1
