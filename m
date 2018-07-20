Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215D8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB5120856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVYGzr1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB5120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbeGTRYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:24:48 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35129 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGTRYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:24:48 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so5415747plq.2;
        Fri, 20 Jul 2018 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HVOb+vFJlwfEy9YaU1RuD0B68qKfBVjS/jc+VgEZqW0=;
        b=IVYGzr1PM5y15J1KmhJAms/qMWxuTvoAstTZcDuwfLhhuCzaH7Q0Kdsc5u6019s2MQ
         dx62gu33J0UxfVclczqiSvezRiBv06QIQgLicKpNTB9mpcb/ckyiJFxfneaZd3oYYCuE
         naxUOsefS9YviJ7W4Yp+TDF94frfCqt+F8yVucXao6HUwBZewItFNUvGKHS8JKDxVsZ6
         7mDT5u9H1sIsyCbjHleP4SNZSV7NPBpAbTSHDDNJcdt7t/HtEuiYGtOgJS98+QstG0Qz
         YUH4T6L+RG3c/0T67qr3oJqHbddplsAtMsK6rJWjkhOL+pi1pFix9kmG3GrFuTbnvIQd
         Ya0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HVOb+vFJlwfEy9YaU1RuD0B68qKfBVjS/jc+VgEZqW0=;
        b=nDwsNFVSf3la2g0jWhZecQXA4AD+0usFytIii9ew+bPtpP8n9CP5jgaKngXOFMzBCV
         Ru5W1nkqYl7yMggZO9URlHXEdLAKQowhZU6rX7LuQpbgtnUYZfOyKPDvn05c61ImilGb
         uc2fYe1sdhFNHOjxBFwrV0cheqj3UfkRDVcgfxLQDHMtEG4cNn9Erx2xDoTHsM4ulKeE
         Gq2GOeaxDiYXmpXGuEwBd2AGOlACHYCeKxSddUwOJmhrzi2uEbp1L8wzEstlhjmTsIbo
         KFkUVYszqz1d5Yfiyv4bUvlE1Vq0/qJLWhpE6vnC/3OPWwYYCU/rkarsW8d5gyhg0V4K
         GMRg==
X-Gm-Message-State: AOUpUlF32oMinOBeNApRknmGCW5peII8xZn2BQb0DK2CThHOhgWwguxR
        qCJ8drbQMWzofIUCrFp7wg1G9rQpt9I=
X-Google-Smtp-Source: AAOMgpdLoqjPwxb9+ftdvpvh481Tp8lEpUatiQKUgoVJO+xH+/lTOs0m6VHglgF3krU91DMAUHKWGA==
X-Received: by 2002:a17:902:9b82:: with SMTP id y2-v6mr2768795plp.69.1532104544616;
        Fri, 20 Jul 2018 09:35:44 -0700 (PDT)
Received: from localhost ([223.72.65.191])
        by smtp.gmail.com with ESMTPSA id a77-v6sm8642687pfj.38.2018.07.20.09.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:35:44 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 6/6] KVM: X86: Expose PV_SEND_IPI CPUID feature bit to guest
Date:   Sat, 21 Jul 2018 00:35:39 +0800
Message-Id: <1532104539-16075-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Expose PV_SEND_IPI feature bit to guest, the guest can check this feature
bit before using paravirtualized send IPIs.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/cpuid.txt | 4 ++++
 arch/x86/kvm/cpuid.c                | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
index ab022dc..97ca194 100644
--- a/Documentation/virtual/kvm/cpuid.txt
+++ b/Documentation/virtual/kvm/cpuid.txt
@@ -62,6 +62,10 @@ KVM_FEATURE_ASYNC_PF_VMEXIT        ||    10 || paravirtualized async PF VM exit
                                    ||       || can be enabled by setting bit 2
                                    ||       || when writing to msr 0x4b564d02
 ------------------------------------------------------------------------------
+KVM_FEATURE_PV_SEND_IPI            ||    11 || guest checks this feature bit
+                                   ||       || before using paravirtualized
+                                   ||       || send IPIs.
+------------------------------------------------------------------------------
 KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
                                    ||       || per-cpu warps are expected in
                                    ||       || kvmclock.
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7e042e3..7bcfa61 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -621,7 +621,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
 			     (1 << KVM_FEATURE_PV_UNHALT) |
 			     (1 << KVM_FEATURE_PV_TLB_FLUSH) |
-			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT);
+			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT) |
+			     (1 << KVM_FEATURE_PV_SEND_IPI);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
-- 
2.7.4

