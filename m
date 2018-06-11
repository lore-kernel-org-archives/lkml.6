Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4JAvBBYnHlvyAgAAmS7hNA
	; Mon, 11 Jun 2018 07:39:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9B587602FC; Mon, 11 Jun 2018 07:39:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol5pV7f0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 03B40602FC;
	Mon, 11 Jun 2018 07:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03B40602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeFKHjP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:39:15 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40260 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeFKHi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:38:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id l2-v6so9322774pgc.7;
        Mon, 11 Jun 2018 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F5FAyvqFcUxt5nLk8zYwAG/hfXKeRDgWfiR11vwNRZM=;
        b=Ol5pV7f0gm2O3GvAPkl5nexkSxboHHwEpJnVEL5n4tbl5lenojTb2y22s4cgfS8bfz
         rbSaV7tiyQOXwsWU2c9xsxvMLk+ZK1QgrponPr27fHJk1u4Rvn02aSgtyw8Ct+xmlR0k
         yaYcuqIrs/zjgIQsb8F/atUe3fKRdZaRfw+e7onbdYVCu34WLKh1jGuLrhd7xPnte1cg
         qEO0cepKNHDuCZsPfGEA2F0r8E8I0knBqjc3iUPUNW94vj4jygmsXcgxB0ovjTIBlu8c
         1xPRxUGZNZLlm9gh4WY5BEanIAeS5w/utCUIPSA68PsZEaZhVyoqW5NEZHfWND90SHxB
         1UTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F5FAyvqFcUxt5nLk8zYwAG/hfXKeRDgWfiR11vwNRZM=;
        b=WJP9z2W4Z6lB3PLinTIFSKjr/gWeMGEgMFpRGz6iTaqc4vYv6P7bs3PvKe4DK3MUII
         maOwniWPCf6qZTOZk1CrmTo5LqbrzyDts8oHbQCVngXi+n66KpM0mrwgUZgKvSKmbrHv
         iYxpDOjGEuPI+MzRIXpGmQj0am1weenpH45Wj1V2Ak7gIWNklT6QI4l4cSOkMVpyC1PO
         Ugg30QbCo3Vm6vpb1REHVjjrjPFtOP3V5imPkelu1Bb0FHCbcx6SEnd8D71IZxtuwS2D
         IAYnrLs7rk650tUWai//K5ngaKGeHOcx3aYyC0d95djDe8dvxQXeFcHpEzNQybatcw6Y
         cYUg==
X-Gm-Message-State: APt69E2drU0CSVWT2VnXYcX9kWQhQEhxTqUj7eMiqKKBfmZSVQG6kPpB
        Cwq3tKc5g2+iFAs57Li2Oyp08g==
X-Google-Smtp-Source: ADUXVKKXW3kiOyjTi6ijvp2c2e+4+xdYEZ84MUR1BT6vUOvQ5ZEQ2pNSZChIIvksIYtUrGWssh2cEg==
X-Received: by 2002:a65:5246:: with SMTP id q6-v6mr13697356pgp.152.1528702737479;
        Mon, 11 Jun 2018 00:38:57 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id c27-v6sm78323076pfl.63.2018.06.11.00.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 00:38:56 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/2] sched/core: Consider afffinity constrain when yield to a task
Date: Mon, 11 Jun 2018 15:38:50 +0800
Message-Id: <1528702730-7538-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528702730-7538-1-git-send-email-wanpengli@tencent.com>
References: <1528702730-7538-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Consider the task afffinity constrain when yield to a task.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 092f7c4..11001ff 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5102,6 +5102,9 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 	if (task_running(p_rq, p) || p->state)
 		goto out_unlock;
 
+	if (!cpumask_test_cpu(smp_processor_id(), &p->cpus_allowed))
+		goto out_unlock;
+
 	yielded = curr->sched_class->yield_to_task(rq, p, preempt);
 	if (yielded) {
 		schedstat_inc(rq->yld_count);
-- 
2.7.4
