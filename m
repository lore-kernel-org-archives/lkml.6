Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D280F2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D280F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeH2Dvm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:51:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39572 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727094AbeH2Dvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:51:42 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1funre-0000kp-Ip; Wed, 29 Aug 2018 00:57:38 +0100
Date:   Wed, 29 Aug 2018 00:57:38 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Bastian Blank <waldi@debian.org>
Message-ID: <20180828235738.GI18030@decadent.org.uk>
References: <20180828235656.GH18030@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180828235656.GH18030@decadent.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH 1/2] liblockdep: Stub NMI watchdog reset
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bastian Blank <waldi@debian.org>

lockdep.c now includes <linux/nmi.h> and requires touch_nmi_watchdog(),
so provide those for liblockdep.

Fixes: 88f1c87de11a ("locking/lockdep: Avoid triggering hardlockup from ...")
[bwh: Write a longer description]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/include/linux/nmi.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 tools/include/linux/nmi.h

diff --git a/tools/include/linux/nmi.h b/tools/include/linux/nmi.h
new file mode 100644
index 000000000000..81ffb39343cc
--- /dev/null
+++ b/tools/include/linux/nmi.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  linux/include/linux/nmi.h
+ */
+#ifndef LINUX_NMI_H
+#define LINUX_NMI_H
+
+static inline void touch_nmi_watchdog(void)
+{
+}
+
+#endif

