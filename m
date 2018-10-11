Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E66C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A6020644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVhM963C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A6020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeJKH60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:58:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39455 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJKH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:58:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so3459849pfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7I8uQBwvQwQPCWsOCDQ1JjECVBe7wg+PmolciyWINOw=;
        b=sVhM963CoTr62IICJiv55HLySdPuo7F8I3AuXG53HzQR9VYRp5VtzwVOjBnT1ip3Cu
         7t+lz3dhd++f4bUl1NtORcTFL4rPkyIY3mFuywUzDpWkY5NM/njPa2jSjI38Z1A0Voks
         u07vfo64h8gW3sVAvWwVZT61TTkxk0jl+w/gSmZcqOJ5oCg4cr3j+qkuG2mR6Qsudq5k
         YTELDmpKe39or8PrzjWwelvQaLQCllO1+018GBVafqotF8JQfo0J+5035VuZbGgP1LDX
         1GdefxxCwI1kRtPAAOAw8LcUa1vGHdoTk8jn/sSrn1tyPiP+2kQRplkk/SQc9UvzjJ5q
         Y93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7I8uQBwvQwQPCWsOCDQ1JjECVBe7wg+PmolciyWINOw=;
        b=Jn7KDM6C2LCElx6wU/QjdM4aHV+QE9TmPuzS1nqJewk8mLCIZeAYDgufgb+M7zDla1
         Kd6I3eNppikZ1w52pQxrl/szXbDZyrOw04ACR9OAn6tZD1KSfJbxJBhnfEcDirJRiGOp
         UzcUn4EgBuiwjsu9jv9xLg6aiTsxBvRNihJgT+TA4vkm2R5kEFtkmJsIM7lWpcTEIosn
         Vr00zFjJkG9n4t/9aZD+DGI7jpHcbm6P4l3GF2QHpD3KAJlHZN3jXXoQgDtMblnyqajs
         Tg8u9xMippq9RCfPnDdHom4pnNSiKkfQ0nXZMnlmcnB6QpHCTkXvfxejbVzuZtKU5IBB
         m6FQ==
X-Gm-Message-State: ABuFfoiEjm1jn4P774cP2nRUiv1har7oiL70ulKpIj+ZimlJrksZ6iHG
        3bqqBE+MvpST8ABrO1kbv4xBvUisq08=
X-Google-Smtp-Source: ACcGV60zoFi2WZ0IDNJ8tAuYe240DsFiGpQj3WQRQTN+6SQjb+8pX/Ibu9mTx0keB23comTUUOCMNA==
X-Received: by 2002:a62:1f9d:: with SMTP id l29-v6mr36286479pfj.121.1539218026468;
        Wed, 10 Oct 2018 17:33:46 -0700 (PDT)
Received: from localhost ([2620:15c:2c4:201:f5a:7eca:440a:3ead])
        by smtp.gmail.com with ESMTPSA id l26-v6sm36554668pfg.161.2018.10.10.17.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:33:44 -0700 (PDT)
From:   Eric Dumazet <edumazet@google.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/tsc: use real seqcount_latch in cyc2ns_read_begin()
Date:   Wed, 10 Oct 2018 17:33:36 -0700
Message-Id: <20181011003336.168941-1-edumazet@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at native_sched_clock() disassembly I had
the surprise to see the compiler (gcc 7.3 here) had
optimized out the loop, meaning the code is broken.

Using the documented and approved API not only fixes the bug,
it also makes the code more readable.

Replacing five this_cpu_read() by one this_cpu_ptr() makes
the generated code smaller.

Fixes: 59eaef78bfea ("x86/tsc: Remodel cyc2ns to use seqcount_latch()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/tsc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index b52bd2b6cdb443ba0c89d78aaa52b02b82a10b6e..b039ae0f358a4f78cc830c069ad90e4fb108489e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -60,19 +60,16 @@ static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
 void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
-	int seq, idx;
+	const struct cyc2ns *c2n;
+	int seq;
 
 	preempt_disable_notrace();
 
+	c2n = this_cpu_ptr(&cyc2ns);
 	do {
-		seq = this_cpu_read(cyc2ns.seq.sequence);
-		idx = seq & 1;
-
-		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
-		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
-		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
-
-	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
+		seq = raw_read_seqcount_latch(&c2n->seq);
+		*data = c2n->data[seq & 1];
+	} while (read_seqcount_retry(&c2n->seq, seq));
 }
 
 void cyc2ns_read_end(void)
-- 
2.19.0.605.g01d371f741-goog

