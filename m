Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABEC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23ED20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrnk74D7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23ED20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933090AbeGIMTx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:19:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34497 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeGIMTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:19:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id e10-v6so13574800pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ithf93De8cGFAkg/NX65Cngg7QcfIJzGaVdHVtCJ3DM=;
        b=Mrnk74D7Ev/fBQBRiI+Rp9NiFOqXbiC22ghc//Yszynsdr2agBREbGMJn+dvd8GiiN
         ZDszWmhH563pFCC6nKZU1uV3OzFNTtdRRupkv38cBKfkOPppuar9/W78KH3YHK2OjFIp
         az85D0FsnMG/d4bi06RoxQ0sStOnzBLnlWIY1aZyRLLtM7IBe/PEHD5y69bq5emrKyFw
         1zA5GZ+pYt34UALvpaWRoZzZvGnWsZU4WVBgYIhBji5buuRUMGKmYYp7HP/hVjJ0dhsa
         CtXEgZP+UTE1oMHBRP1GBpAlIYdVYu4UoUcayaZbnvLTEiNxHJzohUWthBueShPPYoW4
         kYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ithf93De8cGFAkg/NX65Cngg7QcfIJzGaVdHVtCJ3DM=;
        b=knSLzTUFv9xVRFwAxjKVpH8K7o/ijvR818GCjYU3Ht/zyq7kw/cjCVLyoMzMLQ+6b/
         23tKvNxV5rRkhc2EE3PQXjDeWHjXeZTj7IWc9v+P6bFfn81fQQVeRG908lnbUkPD2X14
         H3IPJ/t6SDjfvjSZj4rs/Xjgktk6ZBoej+GGoS6VLtIUO2tFfYOxuJ0bsvbezMENnNYR
         8HFcD5+0hJ9EX5TKQZ7DqZ9VI/cIdt2Z492augZjq3WaSmTyssf9s/4WDhJZMQZvRMCd
         3fxe1TDGYZ8eWvRB0UDcMnr/y3jGM8vTiWQMWRndARY+gFOT3BrXf8mDR9Buodo9s9HA
         t3Ew==
X-Gm-Message-State: APt69E0hENb7IKaSwuqLcimUkL2q7/OWGNX4qDxgHUMdPUiMa/IQfWKY
        +pf37Vb/zPdFROsHSHQfqjWjGwWr
X-Google-Smtp-Source: AAOMgpe/r/FecE9ZUtUXuOkhy8IJmH7bQUS+s7Ube2xoZ4e+k3zXil2bn1pvL2CwGSBWO+zW81ZpqA==
X-Received: by 2002:a63:3d41:: with SMTP id k62-v6mr6604493pga.254.1531138791509;
        Mon, 09 Jul 2018 05:19:51 -0700 (PDT)
Received: from bj03003pcul8.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y3-v6sm32767850pgr.44.2018.07.09.05.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 05:19:50 -0700 (PDT)
From:   "Yandong.Zhao" <yandong77520@gmail.com>
To:     Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org
Cc:     zhaoxb@thundersoft.com, fanlc0801@thundersoft.com,
        Yandong Zhao <yandong77520@gmail.com>
Subject: [PATCH] arm64: neon: Add preemption protection for kernel_neon_busy
Date:   Mon,  9 Jul 2018 20:19:43 +0800
Message-Id: <1531138783-21418-1-git-send-email-yandong77520@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yandong Zhao <yandong77520@gmail.com>

Dear Dave,

The scenario for this bug is:
The A process is sched out when the CPU0 executes the function
raw_cpu_read(kernel_neon_busy) and just gets the address of
kernel_neon_busy without reading.
The B process starts running kernel_neon_begin() on CPU0, and the variable
kernel_neon_busy on CPU0 becomes true. At this time, the A process is
executed on CPU1 and the kernel_neon_busy value is CPU0 (true),so BUG_ON()!

crash64> kernel_neon_busy
PER-CPU DATA TYPE:
  bool kernel_neon_busy;
PER-CPU ADDRESSES:
  [0]: ffffffc07fee30a0
  [1]: ffffffc07fef90a0
  [2]: ffffffc07ff0f0a0
  [3]: ffffffc07ff250a0

          CPU0                                       CPU1
           |                                          |
A task have get addr ffffffc07fee30a0                 |
      and sched out                                   |
           |                                          |
B task kernel_neon_begin()                            |
	[ffffffc07fee30a0]=1                              |
           |                                          |
           |                               A task sched in and read
		   |                            [ffffffc07fee30a0]==1,so BUG_ON.
           |                                          |
B task kernel_neon_end()                              |
 [ffffffc07fee30a0]=0                                 |
           |                                          |

Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
---
 arch/arm64/include/asm/simd.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index fa8b3fe..6580dcd 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,20 +29,12 @@
 static __must_check inline bool may_use_simd(void)
 {
 	/*
-	 * The raw_cpu_read() is racy if called with preemption enabled.
-	 * This is not a bug: kernel_neon_busy is only set when
-	 * preemption is disabled, so we cannot migrate to another CPU
-	 * while it is set, nor can we migrate to a CPU where it is set.
-	 * So, if we find it clear on some CPU then we're guaranteed to
-	 * find it clear on any CPU we could migrate to.
-	 *
-	 * If we are in between kernel_neon_begin()...kernel_neon_end(),
-	 * the flag will be set, but preemption is also disabled, so we
-	 * can't migrate to another CPU and spuriously see it become
-	 * false.
+	 * Operations for contexts where we do not want to do any checks for
+	 * preemptions.  Unless strictly necessary, always use this_cpu_*()
+	 * instead.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!raw_cpu_read(kernel_neon_busy);
+		!this_cpu_read(kernel_neon_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
1.9.1

