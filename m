Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D6AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5279420851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj7NeSAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5279420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbeKTMGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:06:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36406 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeKTMGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:06:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id y6-v6so163757plt.3;
        Mon, 19 Nov 2018 17:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15hb+grtbNcFaezMlYRQbvLicdDt/2EpkoKzaIMYkUs=;
        b=Tj7NeSAsbaM3AE2IbOLB1BWKiHzB+602VF8pFqffmX/x9dZYO0858JOgHXnxkuVFoQ
         YO8cWVyhis0nhOT7r9W7hpQDAd8K2XLcTNy0srXEcdExtIiZQhoRYDnxdnS8WFZc0xWb
         LBcGu5PFRAFj6X/1G8KON84f2KY4EfD0BQvJNsvHslkSfu+L9QaLzM8nL2X4gdCnUU21
         KdvYlm8txhunqldHQ1yoPhu1D+QObl8izK8XEsZetjTUNMY9U9hZuni0FQlYIFuW0t6T
         rNveQ95raJI14KDkMpQKxKNDhyKIIp5aQ/79EOU/colFvA6RJ+N4gwDGG49KsAlG1xCe
         3yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15hb+grtbNcFaezMlYRQbvLicdDt/2EpkoKzaIMYkUs=;
        b=Z8yjjgDiu8niHjWoStmoZiSmjCEM+Ngls4OplOPRvjLuyELV3zneTSB5f7F+rf9acT
         fQ2rnCT3I1Yi5k8/2rH3sWasChL0F1nfZ/I7Mddx1aUOAccXikR7Tgl5aAO2n6DYqfdc
         zAp3pER/Jz6WDdXtib2FkXREI5krkgt1fYkLEm8yiwznMB8LjlUlrNzvHMu/VQy9UnlV
         8lzrnyNOrVLxS95aK6pOVFB7Cdd6Zs7ICBCbcNnl9QMh7Ma6uL54Adp42/JY8+ICDvyi
         94gISdB0/Fp+eKxa0Vxugppdr9FxxOvsHhFdSb4HX7f/cKup2My9og/Gu7RMQlNozrpT
         wK1w==
X-Gm-Message-State: AA+aEWare6bbnzqiJ13prVqNVMYuoOnK+f/7kgrTslYh+W/+4MzdzJgv
        P184Qxsbyv6cBLOIeq+P7VS+U1Hw
X-Google-Smtp-Source: AFSGD/XIOBrDfs3rb3ipXGNlKd9P18gvmWsspPi/pqbUQDAdzCGEVEIa8O3D+JjgifBImuuA0ob9aQ==
X-Received: by 2002:a17:902:aa08:: with SMTP id be8-v6mr82401plb.294.1542677975479;
        Mon, 19 Nov 2018 17:39:35 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id u78sm56397924pfi.2.2018.11.19.17.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 17:39:34 -0800 (PST)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wei Wu <ww9210@gmail.com>
Subject: [PATCH] KVM: LAPIC: Fix pv ipis use-before-initialization
Date:   Tue, 20 Nov 2018 09:39:30 +0800
Message-Id: <1542677970-5627-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by syzkaller:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000014
 PGD 800000040410c067 P4D 800000040410c067 PUD 40410d067 PMD 0 
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 3 PID: 2567 Comm: poc Tainted: G           OE     4.19.0-rc5 #16
 RIP: 0010:kvm_pv_send_ipi+0x94/0x350 [kvm]
 Call Trace:
  kvm_emulate_hypercall+0x3cc/0x700 [kvm]
  handle_vmcall+0xe/0x10 [kvm_intel]
  vmx_handle_exit+0xc1/0x11b0 [kvm_intel]
  vcpu_enter_guest+0x9fb/0x1910 [kvm]
  kvm_arch_vcpu_ioctl_run+0x35c/0x610 [kvm]
  kvm_vcpu_ioctl+0x3e9/0x6d0 [kvm]
  do_vfs_ioctl+0xa5/0x690
  ksys_ioctl+0x6d/0x80
  __x64_sys_ioctl+0x1a/0x20
  do_syscall_64+0x83/0x6e0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The reason is that the apic map has not yet been initialized, the testcase 
triggers pv_send_ipi interface by vmcall which results in kvm->arch.apic_map
is dereferenced. This patch fixes it by checking whether or not apic map is 
NULL and bailing out immediately if that is the case.

Fixes: 4180bf1b65 (KVM: X86: Implement "send IPI" hypercall)
Reported-by: Wei Wu <ww9210@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wei Wu <ww9210@gmail.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3cd227f..09e3a12 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -576,6 +576,11 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 	rcu_read_lock();
 	map = rcu_dereference(kvm->arch.apic_map);
 
+	if (unlikely(!map)) {
+		count = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (min > map->max_apic_id)
 		goto out;
 	/* Bits above cluster_size are masked in the caller.  */
-- 
2.7.4

