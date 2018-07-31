Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BD2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E14208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSjBxnQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E14208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeGaKsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:48:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37935 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbeGaKsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:48:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so5826994pfh.5;
        Tue, 31 Jul 2018 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPZy/b6eKage80HTzUF1LOnlyLHY9Ot7/cUJYnTCj+c=;
        b=dSjBxnQ+SGhWpbDY44kc3e7LFvqx1Z3pJ6LXgsK0G8tLgAN1jsC+dP1p3nZAr1xjAM
         +VUzyJ0dnFwEfSdD5hIx8j6swpIFAzS1XyIfyT9fU/VDW9yDuhQNBPHlMvZHjNxi0teX
         qXOX9IwwfHoBdgkVFEW3R8tserfC8uw0fjlV2n7Kh+RZirp6//PU3xIGortTrgk2/CXO
         r6N7ClnIC11OYHaU5AW4uTH2Gblemu+E8Na8QDAMwWRO9ox9wUFc5a1mt/QJwM07Y5Jg
         0QgkKo2TMM2lismYN83HQmqnf+JJ2+gBrPOPDX/88O1VFRJ9BrpJExkeMdsx5NlnUroI
         LRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPZy/b6eKage80HTzUF1LOnlyLHY9Ot7/cUJYnTCj+c=;
        b=q4qn7i7F5J9lVHlVQY5p7O5IBMUzNapC/AOlRN1cedo7pWV1zOpDtY3eUGuSovr6WP
         soQvv5M8XmKp1ffBcDWcZWHRaPIU3OsB+Eq1sUXNDJW8AKZdxc2+8RldDQkSUHZFim5+
         tCUFw9fA7uJ0lQbn92Z3mERwiIGh+mGM1H4g4PpKZlXj1kUbXsX4iEHoSoMvb/jMX5vV
         YcmbD9Ik5u9PP3EQytnuu2N3vnc59FxDd1dTSE4mP/CH/KEz0F2Vl2n5v9AatA7OdXd1
         I3hUJWQumkJPFOqSdkiWviRGQRNTwxcvNrVJ5Hda7Gz9ODaT5gZ5UBs4vA5XUrP3qzma
         hO9g==
X-Gm-Message-State: AOUpUlFzTqSbLbB9ubAc0WyNbIrZ/uDguvI9ocg0UlP3DLXak+GLIAT2
        frlO2WcMD9CRAZ6VqZ2142w=
X-Google-Smtp-Source: AAOMgpcocVqK13KpiFbKWcoLWYMLWNT2kAnXyMLTLi36TmShNMCkOfobVPwRpzXLEE/dUiq7c8rNzA==
X-Received: by 2002:a63:c80e:: with SMTP id z14-v6mr19242432pgg.77.1533028122920;
        Tue, 31 Jul 2018 02:08:42 -0700 (PDT)
Received: from VM_0_3_centos.localdomain ([193.112.143.122])
        by smtp.gmail.com with ESMTPSA id c142-v6sm18059301pfb.62.2018.07.31.02.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 02:08:42 -0700 (PDT)
From:   Chen Xiao <abigwc@gmail.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Xiao <abigwc@163.com>, Chen Xiao <abigwc@gmail.com>
Subject: [PATCH] KVM: X86: Disable KVM_FEATURE_STEAL_TIME when both delayacct_on added to cmdline and CONFIG_SCHEDSTATS is set
Date:   Tue, 31 Jul 2018 17:08:15 +0800
Message-Id: <1533028095-4773-1-git-send-email-abigwc@gmail.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Xiao <abigwc@163.com>

When sched_info_on returns 1，KVM_FEATURE_STEAL_TIME will be set,
steal% can be seen in the virtual machine.The returned value of
sched_info_on depends on delayacct_on. If nodelayacct is added to
kernel boot cmdline,the KVM_FEATURE_STEAL_TIME will be turned off
by setting delayacct_on to 0.When CONFIG_SCHEDSTATS is set, sched_info_on
always returns 1, and adding nodelayacct to the cmdline cannot turn
off the KVM_FEATURE_STEAL_TIME Sometimes the users do not want the
running state of host to be perceived in the virtual machine, and 
intend to turn off KVM_FEATURE_STEAL_TIME. The requirement is not
available, however, when CONFIG_SCHEDSTATS has been set.Modify the
judgment criteria for being set up from KVM_FEATURE_STEAL_TIME, and
it is only be judged by the value of delayacct_on.

Signed-off-by: Chen Xiao <abigwc@gmail.com>
---
 arch/x86/kvm/cpuid.c |  2 +-
 arch/x86/kvm/x86.c   |  8 ++++----
 arch/x86/kvm/x86.h   | 10 ++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7e042e3..d38da09 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -623,7 +623,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			     (1 << KVM_FEATURE_PV_TLB_FLUSH) |
 			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT);
 
-		if (sched_info_on())
+		if (kvm_feature_steal_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
 
 		entry->ebx = 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2b812b3..8371d5c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2424,8 +2424,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		break;
 	case MSR_KVM_STEAL_TIME:
-
-		if (unlikely(!sched_info_on()))
+		if (unlikely(!kvm_feature_steal_on()))
 			return 1;
 
 		if (data & KVM_STEAL_RESERVED_MASK)
@@ -3101,7 +3100,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		vcpu->cpu = cpu;
 	}
 
-	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
+	if (kvm_feature_steal_on())
+		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 }
 
 static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
@@ -7291,7 +7291,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			r = 1;
 			goto out;
 		}
-		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
+		if (kvm_feature_steal_on()
+		&& kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
 			record_steal_time(vcpu);
 		if (kvm_check_request(KVM_REQ_SMI, vcpu))
 			process_smi(vcpu);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 257f276..9e7c078 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -338,4 +338,14 @@ static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
 	__this_cpu_write(current_vcpu, NULL);
 }
 
+static inline int kvm_feature_steal_on(void)
+{
+#ifdef CONFIG_TASK_DELAY_ACCT
+	extern int delayacct_on;
+	return delayacct_on;
+#else
+	return 0;
+#endif
+}
+
 #endif
-- 
1.8.3.1

