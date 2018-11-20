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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03825C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886BB206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSXx8DNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886BB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeKTTCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:02:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43756 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTTCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:02:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so639159pfk.10;
        Tue, 20 Nov 2018 00:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEUuM/rVCGpKf9HIRFgoVjNxLFzhHYtsg0fwYdBher4=;
        b=nSXx8DNQTYvMnoxzhoCt7PXYw3e/mt64S9+B2B+GI4n7555ejmmP0JeS3c5EpAnfxZ
         ndXBFygblRQ0iOpJHk9V/5MmAhQwKM9PqWm19L3Ft8IDcMVn40n9HYiwSUpgKUb0zGXh
         COkzRp2C3WePEnPJTbxj8SN0NCfVmm3IzRn1ZxmJiU8f1S/g8LVoAA4eOsuYroyIRw8y
         yFqdFwzYajwVbJNjTElelRvF9LzQjxmL+VoQekeDH5nPo545MSAd4ABAE5K7zUrnFzBj
         ASmKJMsu2fJ2OTf24xxe3RU+X8yxnpj9kffKgVtrTUFxvt8eyNvcCtFaRRxZWncSBXMM
         SFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEUuM/rVCGpKf9HIRFgoVjNxLFzhHYtsg0fwYdBher4=;
        b=WIkeMKYVDua6bqVk0VjBQraD4JozOc26bioF1zUqVOlAYMycmk/ys1FLO8a4DxwjWV
         mrc9IJCad6/nL7m5WYZ3saG1nMmFh26it/H2LhCgdWMnqAc3hYQeFRFVHWATe6rQGu8n
         7o4DvYeFGJVCY892iMLzly4j/CWVTTB8vELh444s3jVjHOvTvHoQoEDkjMLhBo95dBJV
         xyCZJNbGwb1ZRsmOf6qHAE6FwoEBkHiGSuQLbTL0YKO6vjeY9e2UwqRFNyguS3O9XfjU
         k1M3q415nBX9hcVAtZCeRWzcjF/IaCX7hKFPdXRb+KeksbO7Midu9xZiguQpt/JH8E19
         QqEQ==
X-Gm-Message-State: AA+aEWZRfVtZySWP3yJfQmviuLBwKdY8XDLcIWuqoDmS23NRPFkrpmJT
        yFL8QHvUEsWeiIUrHT8lnupn2uY4
X-Google-Smtp-Source: AFSGD/W2dq3BkiiQoa1UL0w/2SDF+VScEHlTK5+ZT7flfQ6KDDobkxDkDtO4z1zeo9NnQ+AE88QdGw==
X-Received: by 2002:a63:e754:: with SMTP id j20mr1053698pgk.228.1542702862933;
        Tue, 20 Nov 2018 00:34:22 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id r130sm5036544pfr.48.2018.11.20.00.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 00:34:22 -0800 (PST)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wei Wu <ww9210@gmail.com>
Subject: [PATCH] KVM: X86: Fix scan ioapic use-before-initialization
Date:   Tue, 20 Nov 2018 16:34:18 +0800
Message-Id: <1542702858-4318-1-git-send-email-wanpengli@tencent.com>
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

 BUG: unable to handle kernel NULL pointer dereference at 00000000000001c8
 PGD 80000003ec4da067 P4D 80000003ec4da067 PUD 3f7bfa067 PMD 0 
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 7 PID: 5059 Comm: debug Tainted: G           OE     4.19.0-rc5 #16
 RIP: 0010:__lock_acquire+0x1a6/0x1990
 Call Trace:
  lock_acquire+0xdb/0x210
  _raw_spin_lock+0x38/0x70
  kvm_ioapic_scan_entry+0x3e/0x110 [kvm]
  vcpu_enter_guest+0x167e/0x1910 [kvm]
  kvm_arch_vcpu_ioctl_run+0x35c/0x610 [kvm]
  kvm_vcpu_ioctl+0x3e9/0x6d0 [kvm]
  do_vfs_ioctl+0xa5/0x690
  ksys_ioctl+0x6d/0x80
  __x64_sys_ioctl+0x1a/0x20
  do_syscall_64+0x83/0x6e0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The reason is that the testcase writes hyperv synic HV_X64_MSR_SINT6 msr 
and triggers scan ioapic logic to load synic vectors into EOI exit bitmap. 
However, irqchip is not initialized by this simple testcase, ioapic/apic 
objects should not be accessed.
This can be triggered by the following program:

    #define _GNU_SOURCE
    
    #include <endian.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/syscall.h>
    #include <sys/types.h>
    #include <unistd.h>
    
    uint64_t r[3] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff};
    
    int main(void)
    {
    	syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
    	long res = 0;
    	memcpy((void*)0x20000040, "/dev/kvm", 9);
    	res = syscall(__NR_openat, 0xffffffffffffff9c, 0x20000040, 0, 0);
    	if (res != -1)
    		r[0] = res;
    	res = syscall(__NR_ioctl, r[0], 0xae01, 0);
    	if (res != -1)
    		r[1] = res;
    	res = syscall(__NR_ioctl, r[1], 0xae41, 0);
    	if (res != -1)
    		r[2] = res;
    	memcpy(
    			(void*)0x20000080,
    			"\x01\x00\x00\x00\x00\x5b\x61\xbb\x96\x00\x00\x40\x00\x00\x00\x00\x01\x00"
    			"\x08\x00\x00\x00\x00\x00\x0b\x77\xd1\x78\x4d\xd8\x3a\xed\xb1\x5c\x2e\x43"
    			"\xaa\x43\x39\xd6\xff\xf5\xf0\xa8\x98\xf2\x3e\x37\x29\x89\xde\x88\xc6\x33"
    			"\xfc\x2a\xdb\xb7\xe1\x4c\xac\x28\x61\x7b\x9c\xa9\xbc\x0d\xa0\x63\xfe\xfe"
    			"\xe8\x75\xde\xdd\x19\x38\xdc\x34\xf5\xec\x05\xfd\xeb\x5d\xed\x2e\xaf\x22"
    			"\xfa\xab\xb7\xe4\x42\x67\xd0\xaf\x06\x1c\x6a\x35\x67\x10\x55\xcb",
    			106);
    	syscall(__NR_ioctl, r[2], 0x4008ae89, 0x20000080);
    	syscall(__NR_ioctl, r[2], 0xae80, 0);
    	return 0;
    }

This patch fixes it by bailing out scan ioapic if ioapic is not initialized in 
kernel.

Reported-by: Wei Wu <ww9210@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wei Wu <ww9210@gmail.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 66d66d7..14b2bc4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7455,7 +7455,8 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 	else {
 		if (vcpu->arch.apicv_active)
 			kvm_x86_ops->sync_pir_to_irr(vcpu);
-		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
+		if (ioapic_in_kernel(vcpu->kvm))
+			kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 	}
 
 	if (is_guest_mode(vcpu))
-- 
2.7.4

