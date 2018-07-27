Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE4EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE174208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEDFp9mS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE174208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbeG0SLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:11:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52755 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbeG0SLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:11:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so5881651wmh.2;
        Fri, 27 Jul 2018 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Vy8VD7B4rzSu0yTMk+oUJo3FnKatxkXk/dBQGrbvE18=;
        b=mEDFp9mSDPw1D6nuP9QrbevKR7PkprWR7gCgPrHP+fCzqn8NmCgzlyqCsCLhxvUy5U
         CLrngnfE73WwGOhqwvfVxe3JcKnSxIZhu862cFu3qE3Cb7VZ7c++UUvc3R9Xt5WRCdAK
         UzDQEccQvLVGxY4+BF2MBOoyG3mCq2wNjvfkToTBcox4vM1jlkocdQwntgSmz084C30W
         ORy1eczuQX4Xwv9zfhh+Bejn2iyxQ+dBulVz+YPfTGNugte7uBKDtIRLf3J5jPyg9JZ2
         Z4R9qud0k31v4w6VCBgDRRAqMqkDqyWbZrYIE+FvpQXn11Ev7Hewuc9aU5/6sZFfF51w
         OuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Vy8VD7B4rzSu0yTMk+oUJo3FnKatxkXk/dBQGrbvE18=;
        b=D0FmPai9lKesTVv3IS0GSqQcmH9D2MUKaosm/mCtXtcTbscQHeyPptvrvyYOErhYFL
         p7qRIE9KUUgFXlwCjDi50wtA7Ww6C6pXtYy9xAPGUJaihb73p7pZHAkcWEcPpp2Bxao9
         AIxvwu4NcL9YCoyOG4v7A7VcPV+tkH2PFRihiAOo3th8shiYhOnJ/UkUfrezq0wU1pll
         214DdhUXe/S0d6qyvjwRD2amQuQZK0egHKxLNEVbKBbmLPLpk+keBvegtpqQR69pafoc
         T4ByjEO6/a/ga0ChK5EySKW++x8PNWx9MAVCkovx+T5WlzYmawDTX+Ki7pw4vV/8UTo1
         bcNQ==
X-Gm-Message-State: AOUpUlFy49TL9ExFyLEXa7EhWOxi0bDXeRs35/ZO1oN4VxNtAt3Fyydt
        h7B+BMb6sJfg/UEDByGatgrc2z2Y
X-Google-Smtp-Source: AAOMgpeNVx9DyX/V0kCjsn/2xdcvRFYNCWj6R6QraAooIo52W5Ni6ll7JyHULCMJjsMJagjdhGR9xA==
X-Received: by 2002:a1c:c95:: with SMTP id 143-v6mr5272307wmm.50.1532710138827;
        Fri, 27 Jul 2018 09:48:58 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id s124-v6sm5783896wmf.47.2018.07.27.09.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 09:48:58 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com
Subject: [PATCH] x86/kvm/mmu: get rid of redundant kvm_mmu_setup()
Date:   Fri, 27 Jul 2018 18:48:56 +0200
Message-Id: <1532710136-43288-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just inline the contents into the sole caller, kvm_init_mmu is now
public.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/mmu.c              | 7 -------
 arch/x86/kvm/x86.c              | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ea3dff36ab00..164b578f66f4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1182,7 +1182,6 @@ static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_mmu_create(struct kvm_vcpu *vcpu);
-void kvm_mmu_setup(struct kvm_vcpu *vcpu);
 void kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index aae76cec3311..f2d85043cf91 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5432,13 +5432,6 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	return alloc_mmu_pages(vcpu);
 }
 
-void kvm_mmu_setup(struct kvm_vcpu *vcpu)
-{
-	MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
-
-	kvm_init_mmu(vcpu, true);
-}
-
 static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
 			struct kvm_memory_slot *slot,
 			struct kvm_page_track_notifier_node *node)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b49091a55865..5b53237148c8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8398,7 +8398,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_vcpu_mtrr_init(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);
-	kvm_mmu_setup(vcpu);
+	kvm_init_mmu(vcpu, true);
 	vcpu_put(vcpu);
 	return 0;
 }
-- 
1.8.3.1

