Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A62C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1572D20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1572D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeICPuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:50:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeICPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:50:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83BUu113285621
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 04:30:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83BUuoe3285618;
        Mon, 3 Sep 2018 04:30:56 -0700
Date:   Mon, 3 Sep 2018 04:30:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christian Borntraeger <tipbot@zytor.com>
Message-ID: <tip-c43c5e9f524ec914e7e202f9c5ab91779629ccc6@git.kernel.org>
Cc:     pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          borntraeger@de.ibm.com, linux-kernel@vger.kernel.org,
          pasha.tatashin@oracle.com
In-Reply-To: <20180903081533.34366-1-borntraeger@de.ibm.com>
References: <20180903081533.34366-1-borntraeger@de.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] timekeeping: Fix declaration of
 read_persistent_wall_and_boot_offset()
Git-Commit-ID: c43c5e9f524ec914e7e202f9c5ab91779629ccc6
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

Commit-ID:  c43c5e9f524ec914e7e202f9c5ab91779629ccc6
Gitweb:     https://git.kernel.org/tip/c43c5e9f524ec914e7e202f9c5ab91779629ccc6
Author:     Christian Borntraeger <borntraeger@de.ibm.com>
AuthorDate: Mon, 3 Sep 2018 10:15:33 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 13:26:44 +0200

timekeeping: Fix declaration of read_persistent_wall_and_boot_offset()

It is read_persistent_wall_and_boot_offset() and not
read_persistent_clock_and_boot_offset()

Fixes: 3eca993740b8eb40f51 ("timekeeping: Replace read_boot_clock64() with read_persistent_wall_and_boot_offset()")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Link: https://lkml.kernel.org/r/20180903081533.34366-1-borntraeger@de.ibm.com

---
 include/linux/timekeeping.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 5d738804e3d6..a5a3cfc3c2fa 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -258,8 +258,8 @@ extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 extern int persistent_clock_is_local;
 
 extern void read_persistent_clock64(struct timespec64 *ts);
-void read_persistent_clock_and_boot_offset(struct timespec64 *wall_clock,
-					   struct timespec64 *boot_offset);
+void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
+					  struct timespec64 *boot_offset);
 extern int update_persistent_clock64(struct timespec64 now);
 
 /*
