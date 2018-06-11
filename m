Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2pAvBBYnHlvyAgAAmS7hNA
	; Mon, 11 Jun 2018 07:39:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DD636607BB; Mon, 11 Jun 2018 07:39:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os1XdAYq"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D5BEC602FC;
	Mon, 11 Jun 2018 07:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5BEC602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeFKHi7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:38:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33618 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbeFKHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:38:56 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so11823424plp.0;
        Mon, 11 Jun 2018 00:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PiLu2ZxWRMZJOvBPKohYadl8DFhEGf0OmCUEg064/nM=;
        b=Os1XdAYqznQooSWEnZM5TeC8urtkkfH6r/5E6lgGSahXRtwAKaBEIscI9aA62PjPv4
         TTZ01no7CHcyauYCtmVFjdicVswivTQCQTjPETKKlb7iunELAXntZop0T/Fdu64iXPoW
         TJgna+B6zycyv3D0fid1rZjM0GsDOi8JR+krLULHjkYX918nU/0EvAW+NMDXPQdfnnMK
         VoCzhkUXUHq7EX26PDm0G5C235mX3vLeDTCpX6AZ9IZkPLLGwq6qqTTk5TMu1Ui3Pa+T
         sRGOxeq1WUT1ZaniXPZJQDRjmn7+v3H+GcDX5fCuNwZlMQm2fP5cRHESepN+9iQY3KUw
         dbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PiLu2ZxWRMZJOvBPKohYadl8DFhEGf0OmCUEg064/nM=;
        b=Fv8DSsAXuB0zNdBRJwyqTzY0p0d+jcCJKI0lAq2kWo10xAIAh8xzYt0IElI/Yqv1Nb
         ErzZgLwihrLNL1mRwg4ksktAFIogltpqV3OxNrge7DQmEw0uFEjaEVoAlOMF3wiqx75P
         Gt/CMDSKunx9Ex35pGRUApUulnO/Axpl9dSyONSdOaJWjkm7GzTO4Y8NQ8GIDKLV3sr8
         ERCYAST+H/qnNhEHFJXLkuxPFZ6cBTh4+iu6ZnJOfGmW/bhmPmQxzh8RlCOe75TSDDuk
         nc46Fr6IEYZJfwGhpeiE1W7Fe4iJcTD+FcBqQ1jWSb87ZIpXMQ5dRYPMJtDcuxWvwUXW
         U4Tw==
X-Gm-Message-State: APt69E1v18hBwKPSVvhGm6L9WpOJLgVzubXyuZCp0VWDaDdDqw8zCgSc
        GE5IBbSFsXVjqIvpnq6UOiUcQQ==
X-Google-Smtp-Source: ADUXVKJGvzXPqUy5W9Rw9/4EFFoIMDIGMn+8n6Lv9MeC68XRJhQfHXg+XbU/oTUQX8OmKCDSmVwdeg==
X-Received: by 2002:a17:902:8a82:: with SMTP id p2-v6mr17606187plo.244.1528702735274;
        Mon, 11 Jun 2018 00:38:55 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id c27-v6sm78323076pfl.63.2018.06.11.00.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 00:38:54 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/2] KVM: Fix lock holder candidate yield
Date: Mon, 11 Jun 2018 15:38:49 +0800
Message-Id: <1528702730-7538-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

After detecting pause loop which is executed by a Lock Waiter in the 
guest, the pCPU will be yielded to a Lock Holder candidate, the Lock 
Holder candidate may have its own task affinity constrain, however, 
current yield logic yield to the Lock Holder condidate unconditionally 
w/o checking the affinity constrain and set the task to the next buddy 
of cfs, this will break the scheduler. This patch fixes it by skipping 
the candidate vCPU if the current pCPU doesn't meat the affinity constrain.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 virt/kvm/kvm_main.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index aa7da1d8e..ccf8907 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2239,17 +2239,40 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 EXPORT_SYMBOL_GPL(kvm_vcpu_kick);
 #endif /* !CONFIG_S390 */
 
-int kvm_vcpu_yield_to(struct kvm_vcpu *target)
+struct task_struct *vcpu_to_task(struct kvm_vcpu *target)
 {
 	struct pid *pid;
 	struct task_struct *task = NULL;
-	int ret = 0;
 
 	rcu_read_lock();
 	pid = rcu_dereference(target->pid);
 	if (pid)
 		task = get_pid_task(pid, PIDTYPE_PID);
 	rcu_read_unlock();
+	return task;
+}
+
+bool kvm_vcpu_allow_yield(struct kvm_vcpu *target)
+{
+	struct task_struct *task = NULL;
+	bool ret = false;
+
+	task = vcpu_to_task(target);
+	if (!task)
+		return ret;
+	if (cpumask_test_cpu(raw_smp_processor_id(), &task->cpus_allowed))
+		ret = true;
+	put_task_struct(task);
+
+	return ret;
+}
+
+int kvm_vcpu_yield_to(struct kvm_vcpu *target)
+{
+	struct task_struct *task = NULL;
+	int ret = 0;
+
+	task = vcpu_to_task(target);
 	if (!task)
 		return ret;
 	ret = yield_to(task, 1);
@@ -2333,6 +2356,8 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;
+			if (!kvm_vcpu_allow_yield(vcpu))
+				continue;
 
 			yielded = kvm_vcpu_yield_to(vcpu);
 			if (yielded > 0) {
-- 
2.7.4
