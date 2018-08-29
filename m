Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DFB20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBUFRvNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DFB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeH2Jrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 05:47:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42448 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeH2Jrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 05:47:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so1767270pff.9;
        Tue, 28 Aug 2018 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FBBmYQo2gjQcj76Pad8AczJYBn60zPEEEVl8fB1c34=;
        b=hBUFRvNUKBNPdEarhavgQAwsRTkiwYHqWlvEV9ZVj8xRvFUjwMquGtwSqUf1FXhsog
         J6Q+zgr40exOe4uYGgUBbRaGdvcDboQIfGVE14UMH1QWOWyp+LbIJkN9OauNeVOQ4mfe
         Xx0mhRS5+XU/WLlje66kdjKsGy2gwrZBIRmBhbeJLdPBhR8W9XdezBhpl+VDukHBkPfo
         LQdY4X+QOPWIPlHpLeWu+hyVeUS0aBhEqFoNVoKuSbXVfSndLjwuPPrXVqVsjM6YA6Ub
         vL646Ac2vn9gmMzey+wBsStSN3pwgl7MsPSbB4aW7ntDN+0Lyt4py/SogdDRJ+RF5x0c
         qjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FBBmYQo2gjQcj76Pad8AczJYBn60zPEEEVl8fB1c34=;
        b=IFdpDkjXzMR96j6mPdgNy5lIRZ7EIFGnGf5/SKpyzzSebLnkP64bkmu2715uhkix7B
         7DfjEIk6OT0fKYTN05kVgh3Lz1PhpRGAKiCl/41gts+72bfsbb60Ku5CYnHJWcZ/G+1g
         5eKn3s6mUYQK0VtbZgIt73XlEMsYIVCDgvuaax0o4/e11rzHIM1H1unldNI/OIAYkXcx
         RGIJ/NDRPKmPg+I8gehrsA3eKO+0T0XPSfn0swlZpIwWp8Xc4ofXfN/RvfLF/5jEISY+
         w+PMkOrvpcmFNF72d+IuH+NmHoA14X1Fzt0pLl+PmVjtZcABYvVuIz19mFIZBVoWIYx4
         ZlkQ==
X-Gm-Message-State: APzg51DIrQeuDMopkNnQ1WfuuJkKPdrE6vtVkrUDx3OYMfd/F5wP9A43
        jX5t3/MfOF2zG4ecSreVmXd1X33b
X-Google-Smtp-Source: ANB0VdZZ6ax0d+TLTe4M78j5td3gATH03zBHhOGIqeDMUv3SBJ1GQAVuw+SwfkaxYV//OvqZwgmV6Q==
X-Received: by 2002:a63:d857:: with SMTP id k23-v6mr4383581pgj.106.1535521949222;
        Tue, 28 Aug 2018 22:52:29 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id b21-v6sm5762749pfe.148.2018.08.28.22.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 22:52:28 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
Date:   Wed, 29 Aug 2018 13:52:23 +0800
Message-Id: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Dan Carpenter reported that the untrusted data returns from kvm_register_read()
results in the following static checker warning:
  arch/x86/kvm/lapic.c:576 kvm_pv_send_ipi()
  error: buffer underflow 'map->phys_map' 's32min-s32max'

KVM guest can easily trigger this by executing the following assembly sequence 
in Ring0:

mov $10, %rax
mov $0xFFFFFFFF, %rbx
mov $0xFFFFFFFF, %rdx
mov $0, %rsi
vmcall

As this will cause KVM to execute the following code-path:
vmx_handle_exit() -> handle_vmcall() -> kvm_emulate_hypercall() -> kvm_pv_send_ipi()
which will reach out-of-bounds access.

This patch fixes it by adding a check to kvm_pv_send_ipi() against map->max_apic_id 
and also checking whether or not map->phys_map[min + i] is NULL since the max_apic_id 
is set according to the max apic id, however, some phys_map maybe NULL when apic id 
is sparse, in addition, kvm also unconditionally set max_apic_id to 255 to reserve 
enough space for any xAPIC ID.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0cefba2..86e933c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 	rcu_read_lock();
 	map = rcu_dereference(kvm->arch.apic_map);
 
+	if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)) < min))
+		goto out;
 	/* Bits above cluster_size are masked in the caller.  */
 	for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
-		vcpu = map->phys_map[min + i]->vcpu;
-		count += kvm_apic_set_irq(vcpu, &irq, NULL);
+		if (map->phys_map[min + i]) {
+			vcpu = map->phys_map[min + i]->vcpu;
+			count += kvm_apic_set_irq(vcpu, &irq, NULL);
+		}
 	}
 
 	min += cluster_size;
+	if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_high)) < min))
+		goto out;
 	for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
-		vcpu = map->phys_map[min + i]->vcpu;
-		count += kvm_apic_set_irq(vcpu, &irq, NULL);
+		if (map->phys_map[min + i]) {
+			vcpu = map->phys_map[min + i]->vcpu;
+			count += kvm_apic_set_irq(vcpu, &irq, NULL);
+		}
 	}
 
+out:
 	rcu_read_unlock();
 	return count;
 }
-- 
2.7.4

