Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98685C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEDD20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEDD20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeGVOZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:25:48 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:38091 "EHLO
        mail01.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbeGVOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:25:48 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.vps.ablenet.jp [61.195.96.97])
        (Authenticated sender: PQ4Y-STU)
        by mail01.asahi-net.or.jp (Postfix) with ESMTPA id B568180CB3;
        Sun, 22 Jul 2018 22:29:05 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM028236.ppp.dion.ne.jp [222.8.28.236])
        by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 8B1A5240070;
        Sun, 22 Jul 2018 22:29:02 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] checksyscalls.sh: Add ignore rseq.
Date:   Sun, 22 Jul 2018 22:28:53 +0900
Message-Id: <20180722132853.21816-1-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This syscall depend on HAVE_RSEQ.
So, if HAVE_RSEQ is not defined, it should be ignored.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 scripts/checksyscalls.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ee3dfb5be6cd..ff0a8c51e126 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -199,6 +199,10 @@ cat << EOF
 #define __IGNORE_getpmsg
 #define __IGNORE_putpmsg
 #define __IGNORE_vserver
+
+#ifndef CONFIG_HAVE_RSEQ
+#define __IGNORE_rseq
+#endif
 EOF
 }
 
-- 
2.11.0

