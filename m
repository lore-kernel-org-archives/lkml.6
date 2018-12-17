Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE59C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9745020896
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1JLes0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeLQCn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:43:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42587 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeLQCn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 21:43:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so5353390pga.9;
        Sun, 16 Dec 2018 18:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8+ummLCtRqGGD8qCTL9INcTH4UiAYtPFKbsoKJo8KU=;
        b=s1JLes0TitLirAJe510U8q5Fb3cIFdcrLMnqYcF82S19osHkxxD9rOgJnmP+kJMDHS
         kYh2UU73qP4nP8JH3tLwKsPsB6O10y9u/JtE7fQ1amvuZlCOU0VC4olleRIXgnLBvefm
         yTnVjq4Nu/vbcAezT1s5yt+xD717nybyh8WU59fUY7pk1DFddBneKYeYnAmKE44d0SM0
         QauInP14/d267wcVmhOfW3Ei1t5ovWXNp6k6/pC/WbFIIdcbNTNeVrXUtdZMVU0yuAkQ
         K4MDBZtCUrFwB7zFVj2scWuW/nZqjV0raqy1l9RKl2AEpajSEP63gatteC9qWpomEov7
         BQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8+ummLCtRqGGD8qCTL9INcTH4UiAYtPFKbsoKJo8KU=;
        b=EhLb/Bm6/0im71LxvIrJbl/SIhOr1dA778mSEdtJOzeqolQcSY/c626xR0YRjOiAyP
         ZeFzakDfBULQn1WCXg+vdkvbSEOmYnxmlLQlOh9+MVNzM4ccfg/07z9TSSbKeZWJrkl+
         OLH0TtFF77Qg/5aY7gaZmwItQ+PXGVB3LhzzgSeN2C6UWygylbTYfijl4lYVJ+1WTiAx
         gqCHhfKlrfZ6T9+7+F/xaMTlKp4jQfPJbxTAIVssPLZ9reNETiOyxHvkyRrNhaS6gX8N
         uUjpmIAAk11tklTK4pj2afKFVyK0qClzzu42DLQ8rZMkxnulIYr/LviGO4QP8MIsYNOP
         Lq4Q==
X-Gm-Message-State: AA+aEWYsr+kHYr+sHJOwTRKaekZZqfU1YrTrVh8Z5uUic37+r7BbBsHP
        4vKwwRxpE2r9l3Ir122M5t8zUYa0
X-Google-Smtp-Source: AFSGD/Xo+u9J9RmVMGCm7CW8KKLtreC6u8eTGNaQVC9kBYRIbUHpCWYu78VPenqCrAWUiFokr5BGdQ==
X-Received: by 2002:a62:55c4:: with SMTP id j187mr7164226pfb.129.1545014607625;
        Sun, 16 Dec 2018 18:43:27 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id k191sm13088466pgd.9.2018.12.16.18.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 18:43:27 -0800 (PST)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] KVM: X86: Fix NULL deref in vcpu_scan_ioapic
Date:   Mon, 17 Dec 2018 10:43:23 +0800
Message-Id: <1545014603-4109-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Reported by syzkaller:

    CPU: 1 PID: 5962 Comm: syz-executor118 Not tainted 4.20.0-rc6+ #374
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
    RIP: 0010:kvm_apic_hw_enabled arch/x86/kvm/lapic.h:169 [inline]
    RIP: 0010:vcpu_scan_ioapic arch/x86/kvm/x86.c:7449 [inline]
    RIP: 0010:vcpu_enter_guest arch/x86/kvm/x86.c:7602 [inline]
    RIP: 0010:vcpu_run arch/x86/kvm/x86.c:7874 [inline]
    RIP: 0010:kvm_arch_vcpu_ioctl_run+0x5296/0x7320 arch/x86/kvm/x86.c:8074
    Call Trace:
	 kvm_vcpu_ioctl+0x5c8/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2596
	 vfs_ioctl fs/ioctl.c:46 [inline]
	 file_ioctl fs/ioctl.c:509 [inline]
	 do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
	 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
	 __do_sys_ioctl fs/ioctl.c:720 [inline]
	 __se_sys_ioctl fs/ioctl.c:718 [inline]
	 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
	 do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe 

The reason is that the testcase writes hyperv synic HV_X64_MSR_SINT14 msr
and triggers scan ioapic logic to load synic vectors into EOI exit bitmap.
However, irqchip is not initialized by this simple testcase, ioapic/apic
objects should not be accessed.

This patch fixes it by also considering whether or not apic is present.

Reported-by: syzbot+39810e6c400efadfef71@syzkaller.appspotmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4f786fc..c7c1197 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7510,7 +7510,7 @@ void kvm_make_scan_ioapic_request(struct kvm *kvm)
 
 static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
+	if (!kvm_apic_present(vcpu))
 		return;
 
 	bitmap_zero(vcpu->arch.ioapic_handled_vectors, 256);
-- 
2.7.4

