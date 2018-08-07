Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB153C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C32B21731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C32B21731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbeHGUaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:30:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727572AbeHGUah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:30:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 061A1ADB1;
        Tue,  7 Aug 2018 18:15:03 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     will.deacon@arm.com, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robert.richter@cavium.com, cwu@amperecomputing.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH 6/6] arm64: enable generic CPU vulnerabilites support
Date:   Tue,  7 Aug 2018 20:14:19 +0200
Message-Id: <20180807181419.15690-7-ykaukab@suse.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180807181419.15690-1-ykaukab@suse.de>
References: <20180807181419.15690-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU vulnerabilty show functions for spectre_v1, spectre_v2,
meltdown and store-bypass.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0dec01a0c81c..ffd97bc0f5d5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -84,6 +84,7 @@ config ARM64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_MULTI_HANDLER
-- 
2.11.0

