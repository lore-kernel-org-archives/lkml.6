Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309B6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BF1205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BF1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeGSXOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:14:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeGSXOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:14:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMSi4X2439211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:28:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMSioZ2439208;
        Thu, 19 Jul 2018 15:28:44 -0700
Date:   Thu, 19 Jul 2018 15:28:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-be2e0e4257678408b0ab00ea9e743b9094e393e8@git.kernel.org>
Cc:     schwidefsky@de.ibm.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, pasha.tatashin@oracle.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, pasha.tatashin@oracle.com,
          linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
          hpa@zytor.com
In-Reply-To: <20180719205545.16512-15-pasha.tatashin@oracle.com>
References: <20180719205545.16512-15-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] s390/time: Add
 read_persistent_wall_and_boot_offset()
Git-Commit-ID: be2e0e4257678408b0ab00ea9e743b9094e393e8
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

Commit-ID:  be2e0e4257678408b0ab00ea9e743b9094e393e8
Gitweb:     https://git.kernel.org/tip/be2e0e4257678408b0ab00ea9e743b9094e393e8
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:33 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:40 +0200

s390/time: Add read_persistent_wall_and_boot_offset()

read_persistent_wall_and_boot_offset() will replace read_boot_clock64()
because on some architectures it is more convenient to read both sources
as one may depend on the other. For s390, implementation is the same
as read_boot_clock64() but also calling and returning value of
read_persistent_clock64()

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-15-pasha.tatashin@oracle.com

---
 arch/s390/kernel/time.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index cf561160ea88..d1f5447d5687 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -221,6 +221,24 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ext_to_timespec64(clk, ts);
 }
 
+void __init read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
+						 struct timespec64 *boot_offset)
+{
+	unsigned char clk[STORE_CLOCK_EXT_SIZE];
+	struct timespec64 boot_time;
+	__u64 delta;
+
+	delta = initial_leap_seconds + TOD_UNIX_EPOCH;
+	memcpy(clk, tod_clock_base, STORE_CLOCK_EXT_SIZE);
+	*(__u64 *)&clk[1] -= delta;
+	if (*(__u64 *)&clk[1] > delta)
+		clk[0]--;
+	ext_to_timespec64(clk, &boot_time);
+
+	read_persistent_clock64(wall_time);
+	*boot_offset = timespec64_sub(*wall_time, boot_time);
+}
+
 void read_boot_clock64(struct timespec64 *ts)
 {
 	unsigned char clk[STORE_CLOCK_EXT_SIZE];
