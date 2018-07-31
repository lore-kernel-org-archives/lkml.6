Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ADD20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dugeo-com.20150623.gappssmtp.com header.i=@dugeo-com.20150623.gappssmtp.com header.b="tUebcs3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02ADD20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dugeo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbeGaQfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:35:41 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:38515 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbeGaQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:35:41 -0400
Received: by mail-pf1-f169.google.com with SMTP id x17-v6so6242086pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dugeo-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vQH6T0bqpSjfV7dGMfdnWWjA0NyS9DJmowVyxjlUlTU=;
        b=tUebcs3YnmB7LUr4PwxZqfHdb67FKXh9+/L1BYcLFyFePFOeAXf9rp7uyBA9E9KjWB
         8VPYrMOucI+evQlc13R1t8kESm4i7UOsmz9AQBbHVJfo6lC4qr2Ncc6AfM3wTq98CGXH
         KJF+w8KN5O6jC3a5hz2APylgiKBTlcvUZ7rUKhWIVlvhEXOOALPlHf94xZi8krQDPOaF
         FnoLXzl2JG0+CPJa+nJamj1az7tPpZEWusfijHlO8Wpnrx7xYkjlTNAforBTSVznUChV
         zM5VlSQnR/XfVyFzdS+T6Q5TSj5SatY/9TdxrqzJdPrPGzMFSV+AgjQL3pWYVz5atpr5
         QdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vQH6T0bqpSjfV7dGMfdnWWjA0NyS9DJmowVyxjlUlTU=;
        b=WK4ju25VtVMzr1uKcuLasIbPUabHN/k2X78MrYNTkCxyQz2opv4a1u1XOwfhXEGwCt
         LM2TshylXqK/LLOLrHmvkNXEkPiWmNGhOPMOjghgn/TPQW1kIoV826kCrkIY6IEU1EQC
         scwlcQxrNXkoALFDvt3pHHfpRZ0vrtxeLNA7tv5uSZWN569ImuNDi76YesuBytUzzUGP
         sN7qRxWxZr3+Y+qzD4WJNXMiFtomgAYg89tTacUU6qKuYrhxMNXD52ySZDPlS986Bd+o
         +DD5sarXGQe2LDK4Hpw3rRRIltv/V4PWPWQ8YSSi2SiRMNoDf5mS/FEloMCETG5+kxcq
         U0gA==
X-Gm-Message-State: AOUpUlGVCyD7dpPw2tfH2OrejMM8xOyE7gg1AU6adCMTmRY+eI1VbvRf
        rIN3m8G0NQWzRrCsvG7CTPv+/A==
X-Google-Smtp-Source: AAOMgpd4LbrHm5JNiCaY3k5NQwF/9/stIm3Pb8UqzJHbXb2rQPZJebD474QK04brjx37zeEbA6jPiQ==
X-Received: by 2002:a63:d613:: with SMTP id q19-v6mr20742470pgg.327.1533048898672;
        Tue, 31 Jul 2018 07:54:58 -0700 (PDT)
Received: from bud178.dugeo.com ([116.212.202.58])
        by smtp.gmail.com with ESMTPSA id i25-v6sm35800596pfi.150.2018.07.31.07.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:54:57 -0700 (PDT)
From:   Jacek Tomaka <jacekt@dugeo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: [PATCH v3] perf/x86/intel: Add support for MISPREDICT bit on Knights Landing cpus
Date:   Tue, 31 Jul 2018 22:54:14 +0800
Message-Id: <20180731145414.8568-1-jacekt@dugeo.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacek Tomaka <jacek.tomaka@poczta.fm>

Problem: perf did not show branch predicted/mispredicted bit in brstack.

Output of perf -F brstack for profile collected

Before:
0x4fdbcd/0x4fdc03/-/-/-/0
0x45f4c1/0x4fdba0/-/-/-/0
0x45f544/0x45f4bb/-/-/-/0
0x45f555/0x45f53c/-/-/-/0
0x7f66901cc24b/0x45f555/-/-/-/0
0x7f66901cc22e/0x7f66901cc23d/-/-/-/0
0x7f66901cc1ff/0x7f66901cc20f/-/-/-/0
0x7f66901cc1e8/0x7f66901cc1fc/-/-/-/0

After:
0x4fdbcd/0x4fdc03/P/-/-/0
0x45f4c1/0x4fdba0/P/-/-/0
0x45f544/0x45f4bb/P/-/-/0
0x45f555/0x45f53c/P/-/-/0
0x7f66901cc24b/0x45f555/P/-/-/0
0x7f66901cc22e/0x7f66901cc23d/P/-/-/0
0x7f66901cc1ff/0x7f66901cc20f/P/-/-/0
0x7f66901cc1e8/0x7f66901cc1fc/P/-/-/0

Cause:
As mentioned in Software Development Manual vol 3, 17.4.8.1,
IA32_PERF_CAPABILITIES[5:0] indicates the format of the address that is
stored in the LBR stack. Knights Landing reports 1 (LBR_FORMAT_LIP) as
its format. Despite that, registers containing FROM address of the branch,
do have MISPREDICT bit but because of the format indicated in
IA32_PERF_CAPABILITIES[5:0], LBR did not read MISPREDICT bit.

Solution:
Teach LBR about above Knights Landing quirk and make it read MISPREDICT bit.
---
 arch/x86/events/intel/lbr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index cf372b9055..81fe5047c6 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1230,4 +1230,8 @@ void intel_pmu_lbr_init_knl(void)
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
+
+	/* Knights Landing does have MISPREDICT bit */
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
+		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }
-- 
2.17.0

