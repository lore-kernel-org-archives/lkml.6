Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A3BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164F220830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164F220830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbeKGHt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:49:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44299 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeKGHt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:49:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6MLrU3983308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 14:21:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6MLqp7983305;
        Tue, 6 Nov 2018 14:21:52 -0800
Date:   Tue, 6 Nov 2018 14:21:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-81bd415c91eb966118d773dddf254aebf3022411@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, malat@debian.org,
        babu.moger@oracle.com, mingo@kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          babu.moger@oracle.com, malat@debian.org, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <20180606194232.17653-1-malat@debian.org>
References: <20180606194232.17653-1-malat@debian.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] watchdog/core: Add missing prototypes for weak
 functions
Git-Commit-ID: 81bd415c91eb966118d773dddf254aebf3022411
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  81bd415c91eb966118d773dddf254aebf3022411
Gitweb:     https://git.kernel.org/tip/81bd415c91eb966118d773dddf254aebf3022411
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Wed, 6 Jun 2018 21:42:32 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 6 Nov 2018 21:58:00 +0100

watchdog/core: Add missing prototypes for weak functions

The split out of the hard lockup detector exposed two new weak functions,
but no prototypes for them, which triggers the build warning:

  kernel/watchdog.c:109:12: warning: no previous prototype for ‘watchdog_nmi_enable’ [-Wmissing-prototypes]
  kernel/watchdog.c:115:13: warning: no previous prototype for ‘watchdog_nmi_disable’ [-Wmissing-prototypes]

Add the prototypes.

Fixes: 73ce0511c436 ("kernel/watchdog.c: move hardlockup detector to separate file")
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Babu Moger <babu.moger@oracle.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180606194232.17653-1-malat@debian.org
---
 include/linux/nmi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 08f9247e9827..9003e29cde46 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -119,6 +119,8 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
 int watchdog_nmi_probe(void);
+int watchdog_nmi_enable(unsigned int cpu);
+void watchdog_nmi_disable(unsigned int cpu);
 
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
