Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD30B20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKWDzWg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD30B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbeGTRRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:17:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34218 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbeGTRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:17:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so5410746plo.1;
        Fri, 20 Jul 2018 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDljZacJxZG2OWdhiAliNYhkc3j//3d2iZVEuKfWFo4=;
        b=VKWDzWg4BP3O0Vna+Lbn6/drPlGNHhZqLOeBmsdmN8nYRyNabC/gGIpHqvXx4cI5if
         DW5zZXiRHXqG9R5Z3JEFDTmZ8WMJsS0AEcTSdIWyE3AyTYq4ptWi7glmRuYkJqfPueuD
         HFnLUOGnQQwXajCJ7swrzqK2VnvqEUfj/Wm3uimJXEUJYXpOQXT6au5VUArfah5SFlZ2
         cY4qrsMYgTjSyCKlfta5QBoE3G64kiViySRDyhCEEHenModjl41UO5IARMvmpsj/hqxM
         EZrwc7RZ86MdSefaJx1PaG+WwRtqrw5acFyyt83cgorCoMUZPCeGyeGxSdNis6QFSEEk
         FKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDljZacJxZG2OWdhiAliNYhkc3j//3d2iZVEuKfWFo4=;
        b=dcqj8Xa62s7/Kkm8jgCHyguZff3YPCJxgKj72efdFe+Vi6suPSkOHbBdVyx9JUpZWD
         ibJgYDdRO8jAnS21uehLv0VGF7vBmf9TVbMfbWBBHK6ENfr/KIeSyZMkpiut2+J2u1A8
         jVOtJ0M6ssDIoz9pvbgWshFYUB9s4u2h1pfVFYtq6t5at1104k8teW4kmTUpjG/I92tl
         EI/zLSRuzIyZXRhfTMrs2cWmWCC9wmeTZq8NxJx3BeAc1dDM6ynkgFZZ9bUAVMnuCk2p
         cz4Dbhj7VWZizse++0iaduLfJaP1/11kWGK4Xeb7TW65BaUobKryGOOmuryno8jaZ/Xr
         xRWQ==
X-Gm-Message-State: AOUpUlGVQolCuGudjhc9pwbcNmWBb4XTi+jgtlMvmjcyQEt/jBMPPYyg
        M1pV8a8wZqXK9hS1AqY4WC1bAlhNFvk=
X-Google-Smtp-Source: AAOMgpf6W8lpgxf3Vhppst+YlAlrOOXmH7Zk8DecoUCoGUtVPVEatgoxgx8Wpcp6Cejt9mAgi2rGSw==
X-Received: by 2002:a17:902:143:: with SMTP id 61-v6mr2708528plb.171.1532104084028;
        Fri, 20 Jul 2018 09:28:04 -0700 (PDT)
Received: from localhost ([223.72.65.191])
        by smtp.gmail.com with ESMTPSA id w5-v6sm3035061pfn.44.2018.07.20.09.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:28:03 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 1/6] KVM: X86: Add kvm hypervisor init time platform setup callback
Date:   Sat, 21 Jul 2018 00:25:33 +0800
Message-Id: <1532103933-15617-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Add kvm hypervisor init time platform setup callback which
will be used to replace native apic hooks by pararvirtual
hooks.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5b2300b..591bcf2 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -624,12 +624,22 @@ static uint32_t __init kvm_detect(void)
 	return kvm_cpuid_base();
 }
 
+static void __init kvm_apic_init(void)
+{
+}
+
+static void __init kvm_init_platform(void)
+{
+	x86_platform.apic_post_init = kvm_apic_init;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_kvm = {
 	.name			= "KVM",
 	.detect			= kvm_detect,
 	.type			= X86_HYPER_KVM,
 	.init.guest_late_init	= kvm_guest_init,
 	.init.x2apic_available	= kvm_para_available,
+	.init.init_platform	= kvm_init_platform,
 };
 
 static __init int activate_jump_labels(void)
-- 
2.7.4

