Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC13ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9022321473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9022321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeJRQ4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:56:08 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:20538 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727360AbeJRQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:56:08 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w9I8ao6R003410
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:36:50 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9I8agRu003389;
        Thu, 18 Oct 2018 16:36:42 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 18 Oct 2018
 16:34:46 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <deanbo422@gmail.com>, <zong@andestech.com>,
        <ebiederm@xmission.com>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH 2/3] nds32: Add 'HAVE_EFFICIENT_UNALIGNED_ACCESS' config
Date:   Thu, 18 Oct 2018 16:34:33 +0800
Message-ID: <37e0f2b4530ba551a53a967ff4aa2e88aba2f486.1539654057.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1539654056.git.nickhu@andestech.com>
References: <cover.1539654056.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9I8agRu003389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to my understanding, this config will optimize the code generate.
When there is an unaligned access happened, the load word instruction
still can be used if there is unaligned access support or the load byte
instruction is used. So this config need unaligned access support.

'HAVE_EFFICIENT_UNALIGNED_ACCESS' and 'HW_SUPPORT_UNALIGNMENT_ACCESS' are
default configs in nds32.

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/Kconfig.cpu | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index b8c8984d1456..b8eecd0cde6b 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -111,8 +111,9 @@ config ALIGNMENT_TRAP
 
 config HW_SUPPORT_UNALIGNMENT_ACCESS
 	bool "Kernel support unaligned access handling by hw"
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	depends on !ALIGNMENT_TRAP
-	default n
+	default y
 	help
 	  Andes processors load/store world/half-word instructions can access
 	  unaligned memory locations without generating the Data Alignment
-- 
2.17.0

