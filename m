Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ECFC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8CB214C5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jR4SilVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8CB214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeHBKkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:40:31 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:58711 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeHBKkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:40:31 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AEF6710C0D5E;
        Thu,  2 Aug 2018 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533199821; bh=ipUZHF4yZpqXVbgJ7wfp4x/Twrz9NCJXSd5/EVZMR4U=;
        h=From:To:Cc:Subject:Date:From;
        b=jR4SilVlN1srLDT0FguPFNZQ8+zAZFZ6fyyN6IBNd02uHvgj2LGMV2Tnge+Ag6LZt
         kf3FVevIsLBVmYt3LNQEpfbCPFt6ZjUdKOUyOq97PQr9MlN66XjlCV1g0XdCw+LaDJ
         U5kamlJFrFNgYtJg4LhiHxtFB8CQ6HETf+MRUY76eJrfifLbvYQ6IQV42mc/z1Rrp9
         ayioOuaeVPTlotQnT0egJ/rWfE8br3rj4HUHtpG6K1lRasZuW7N8ArjvSJrvP5KPgQ
         VEAHU4vwVEnv/6Pqd/NIgre46/ILwfxEemyLP3s9WKBZHWu+uq8gAwWXpSsdk/uk1g
         icp7sHBMhk5sQ==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id 50C9A3E55;
        Thu,  2 Aug 2018 01:50:20 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARC: [plat-axs10x] Enable SWAP
Date:   Thu,  2 Aug 2018 11:50:16 +0300
Message-Id: <20180802085016.16000-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWAP support on ARC was fixed earlier by
commit 6e3761145a9b ("ARC: Fix CONFIG_SWAP")
so now we may safely enable it on platforms that
have external media like USB and SD-card.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: stable@vger.kernel.org # 6e3761145a9b: ARC: Fix CONFIG_SWAP
---
 arch/arc/configs/axs101_defconfig     | 1 -
 arch/arc/configs/axs103_defconfig     | 1 -
 arch/arc/configs/axs103_smp_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 3dbb2b3f60af..96b7258a76be 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 4d7b85d4b2dc..72fc21ef1334 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 92417e2e39f3..2ac89bd00e28 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -1,4 +1,3 @@
-# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
-- 
2.17.1

