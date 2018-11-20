Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A8C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1B8206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha98a2m8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1B8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeKUAkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:40:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38482 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeKUAkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:40:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so1058837pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eGYN2BPY37v13Rg3NjxK4qsF50VEz3v0EMRZPiym5n4=;
        b=Ha98a2m8K7ohlwqvlA0xstek3AeiT8WP/n67Q2310y9rO82DskaTb1WdtTCWH+Pjok
         Qwt4GLk0SNC5cJ7ACDRMFGr2QVH4N8DQ4eHSR7NeLJDTbpjTVPjwpgYgKrNf+PD3K0cw
         3Jhkt0IS6CHw/5sohyb3kpq+MuzIzxvxrbvFuav3gbbv9RzW2j/iyxEUYvx14BkFeLoU
         wKJTJl8FlJq8wH3RPuFSgNntCMB1cKKUtk88zrDmeSo/wF208BG5TuSsKMuWpITv6O6a
         MT6TDedpgy2N+vCYMhwihjGhx1japJ/QrmLVEltclxpV4V4C9zdmMR6DUUPDrKPDklEf
         CHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eGYN2BPY37v13Rg3NjxK4qsF50VEz3v0EMRZPiym5n4=;
        b=des8amzdvzTJYtT7gELD9tiQJikdYhP0lqd/eaO3qfltOIUVIJ8mseH2zr90Qxw39F
         NUBE6AsC8sBmfDKi+0KfYPBcUBcNByzi33i5ldYy2oZpf5Mdj4vCuA6bZIQwZQnF14pC
         XCOBmLucbLfjxcZwuyxdVFaesOihr5FxKBKpkqeQJ587zZwuWeFqyLknEZCxJYHWFu8D
         LfcFIZZr7v0LScGWRO9Kuae9nu9ikypyKkT4uH86za/S5GoYOC9mUDvV01VVwTY3dr+v
         CFmuVEeHW8ncosYEuNIJCbRPeao671gtWh1oVG6NTwWUBM9KC7k0zAInX5EJRS2XBTSX
         xgmg==
X-Gm-Message-State: AA+aEWYnmSW0c1ldrVbsIU7mPux5kUqk+DWFC7+MswJdbGe66kq26TBH
        8Sn3hmd4vgUejrv3HBMt+oxMTFKfHDE=
X-Google-Smtp-Source: AJdET5cq8YKRyvS88OQlia88CfWqOuA4TqTxjGqO4Ci0MtRm5IDj2hH4vXyoL4UBF4aZ5X7KMFZqzg==
X-Received: by 2002:a63:7306:: with SMTP id o6mr1981923pgc.343.1542723065170;
        Tue, 20 Nov 2018 06:11:05 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n7sm9913809pff.36.2018.11.20.06.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 06:11:04 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu, dmitriy@oss-tech.org,
        atish.patra@wdc.com, tglx@linutronix.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] RISC-V: add of_node_put()
Date:   Tue, 20 Nov 2018 09:11:02 -0500
Message-Id: <20181120141102.20534-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/riscv/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 1911c8f6b8a6..40470e669a35 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -26,6 +26,7 @@ void __init time_init(void)
 	cpu = of_find_node_by_path("/cpus");
 	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
 		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
+	of_node_put(cpu);
 	riscv_timebase = prop;
 
 	lpj_fine = riscv_timebase / HZ;
-- 
2.17.0

