Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39014ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E600C20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKYEiZ6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E600C20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbeGWHjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:39:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42266 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388085AbeGWHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:39:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so696395pff.9;
        Sun, 22 Jul 2018 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVOb+vFJlwfEy9YaU1RuD0B68qKfBVjS/jc+VgEZqW0=;
        b=AKYEiZ6grUztwCK8Bdvk9/GjbxzIm/JU2nCbghqXoh2bUfAWX+pIyiSZo7AIBCTAqV
         uWNbCixFhOLnDaoObnAoI4d/jO8fM5uN3hyJfpvwqui4hwhQkx22tQFzy770n3fEF2ru
         P5bZBsqb7DNGUDxvIt8NzUeHfm1PcxqMauNBC4G1PWCn9m1FshB6iKCQg1b86lb5WQxs
         cCUXp3a6ggfLHEIB79iO2fbG7Qz0rJjYUK/iglH79Kh+njzZcjzyFsCq3hBT0P5yJjA0
         lvZUJHhaGbCcAlLkKU8PLA4GmY2gcqFqD1DSotvIPptzVhiISFubUW8JAaXGg1kPds3h
         O99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVOb+vFJlwfEy9YaU1RuD0B68qKfBVjS/jc+VgEZqW0=;
        b=S+/AO07SLmiqNPVkWMeapIjltpdbOxZK7OjQIBkb9waY15mcKt7PqV5todbx1BJHFQ
         FOT3uoYfmoqxFmvQF+FXyl7OqqlnAGCEWHdxiQ4MeCkTWr23Rlmmcdao0bC6HzGQe9tk
         Lp0uWtpxckzNs4Ggv++h4CR7o8328KB1zhXIaxaC2wXbGDc0ufadL9fSVBie+YrOSaYm
         jteczyY7z3X+y6YHPfmeZMvIFmv8+GaLIbtMpBlwya0VsWeyx9KxzmLh11m9Q/ljPxVS
         HbieY64j/REn87Qn5xew0RSCYWjURPayYMZZ9RQ+ZbW+CaREhuHsR8L9OtbPL+o8wZqi
         soiQ==
X-Gm-Message-State: AOUpUlEW/npwCCKnM40MHJapILVbm4xeEQkZS0+fTLo3h929AMUf/8WF
        rfUTof4UV3x0KV3fm4phc/PkSU2Q
X-Google-Smtp-Source: AAOMgpc7MSMywQAZcU8M7GrhtX/q4Vk7GEwmgK6Lj/fIFlLn4fSw3m5R0maPJwkrQv65A9JHO0aJKw==
X-Received: by 2002:a62:9c17:: with SMTP id f23-v6mr12020643pfe.209.1532328013683;
        Sun, 22 Jul 2018 23:40:13 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm8165598pgv.26.2018.07.22.23.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:40:13 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 6/6] KVM: X86: Expose PV_SEND_IPI CPUID feature bit to guest
Date:   Mon, 23 Jul 2018 14:39:56 +0800
Message-Id: <1532327996-17619-7-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532327996-17619-1-git-send-email-wanpengli@tencent.com>
References: <1532327996-17619-1-git-send-email-wanpengli@tencent.com>
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

