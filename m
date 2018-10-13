Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9928CC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3305120652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="bhObMskX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3305120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJMOYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:24:09 -0400
Received: from sonic301-20.consmr.mail.gq1.yahoo.com ([98.137.64.146]:42368
        "EHLO sonic301-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbeJMOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1539413291; bh=aF4jRDazcsfXCj+3qeySSCYQGyoCj/3c9w3WhmODcBc=; h=From:To:Cc:Subject:Date:From:Subject; b=bhObMskXM1jN6aFgCBinEGs6d1nV4bDetMmWSReWJd3hzNwR2ZmppGZocs1+IotaBIwvqiIh+gFfp0y2qt6HUhHrDYvsvCcNl39u0pwL9g/nbONjfbCj2GbU56+2qY9RGdykVwxI7Bg0zw6eU4R9PfWUWvgIwB9jbNW8HilpbuXoXAC9ymbrJHpt/T0F8yPFcgs3XzSlaONM6T1Mbf2YC8AGMhrK2kW94Jv+QE0aCMd0gyiOmOQFmmYwKIBOA4Lw9Ty+4BN8h2qByY4vADNiirOdalguvJFcgSCoc84raaH8NSKnoi7gTMgVa/L9OrOxeJNIcTASoIW0iJyMFtp8iQ==
X-YMail-OSG: ko1Oi64VM1mhkUaRU_Z1_2eL8coZdR.sXEwU6NG_RBeqUt338.2_6bnyjMwK3W_
 quTi2OuIjZtfXIqBSah3v_IsJ2y0XH6sgYG.LJtOdyPo9Cf7FVgAUY264WLQ9.j29oH3Y1S_ScNL
 DM_6G3cnM4ddXcg89w5c4pTf62ONNccyyIEYNcCBCkCqGozfFCzFI29oXSiYzSE4S682vkLAzjcS
 YdSflOpRIvWySO.Q4ybb1f12WBwDZJojvO09AeJTlHj3lmkGkm5XqQ8zQmh6flLs5NflmbvT7EQK
 i0gwB8mhMcsepyfv7d8lYp7l1a2hDK5wLM6GR2c3RhUapO31yGlbjNED0s6ThrwKM.1zdJh4HcaO
 su51dDBmN4CAG5pYVHLSxYy_vXLbzH08Q39QvgrAW1ULTnsCHr6qQF8OgMuTLE37TCdCDvNVw0cl
 XvP5jtEN7bWv3lN.g1PKcaPlfJMwYCTpdV8DxXEDOOPLo.zcT7NcfBt9QDajQlVgAyxJkv9cG8d8
 uZNZnzHeb54D2iRlnnh3Z5RKrgzDOq.CSeSjUj91vi7GEkJ2UMfaJbHmZnjAxM6rw.L8epi0JmN6
 o1QBgsQGv2eWPSlUzRJ8pFW3ZZVvPPETGgAVTRsFY_H.epK9EGijqdPbo0YioRl6O4IPllWzgibq
 DznIyGbIs8SLF_Pt.J.DYSv.P9k_js1v7WluTKwKVV7Hri.sICRCgi3DL8Kyox4KyFZFGp.x2EJx
 3FYKtbUey7Zg2YtDvlva7cVBVGvEmvpP3DNs1gKBkNbWH2nKCdko1Go.52ZZrcyQAfJoUhSDpJ8Q
 oLWusk6CbLTV9HgnilGADyxzDTIlTcPzQFehO4gCrIqmrbZd1EEDGnwtw6Zh12SIFYJNLcOF3vkQ
 yccpFOsHt3VC1f1qJNiMC.PTLV96a2CAam2Pu9TR7Iu8DrzS8jJjynDQGc5qTdqbe0jeDFsR3bJU
 wDyPeRRfGxo1jLCoTLVd8o60vlGlmvOB02JukfF5Hymh5PKJFHzOCnrS6mM_E8l8WpyZTyaxvF_s
 sFqlg7A1XAJ7HQg2ctNGISEuugrQUgG2q9bQ219ChOXnovW0zhso1M744tcTWDWsmAvFP.bsoxHr
 WiiAfxP50MW2hFJzDlJU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Oct 2018 06:48:11 +0000
Received: from 183.156.49.100 (EHLO localhost.localdomain) ([183.156.49.100])
          by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3e653e8a28045e705c6727372602aa39;
          Sat, 13 Oct 2018 06:48:08 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>, Gao Xiang <hsiangkao@aol.com>
Subject: [RFC PATCH] bit_spinlock: introduce smp_cond_load_relaxed
Date:   Sat, 13 Oct 2018 14:47:29 +0800
Message-Id: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to use smp_cond_load_relaxed instead
of busy waiting for bit_spinlock.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/linux/bit_spinlock.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730..713efc4 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -15,22 +15,17 @@
  */
 static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 {
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
-		preempt_enable();
-		do {
-			cpu_relax();
-		} while (test_bit(bitnum, addr));
+	while (1) {
+		smp_cond_load_relaxed(&addr[BIT_WORD(bitnum)],
+				      !(VAL >> (bitnum & (BITS_PER_LONG-1))));
 		preempt_disable();
+		if (!test_and_set_bit_lock(bitnum, addr))
+			break;
+		preempt_enable();
 	}
+#else
+	preempt_disable();
 #endif
 	__acquire(bitlock);
 }
-- 
2.7.4

