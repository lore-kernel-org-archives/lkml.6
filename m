Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE02AECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6959720875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlgELKSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6959720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbeGWBqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 21:46:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33988 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbeGWBqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 21:46:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so10974646pgv.1;
        Sun, 22 Jul 2018 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVOb+vFJlwfEy9YaU1RuD0B68qKfBVjS/jc+VgEZqW0=;
        b=RlgELKSSZvKk8mNvtoULRSysBEm80g7dWK8AaK5v9JZHG0aHusnNw0+ibu2su7ko9N
         dDrS9Sk4bwkRLvw/4iWqnw7ob4ZbitlgfwhQ02Djb6V6SHm5fRU2PHuDjRR4T2+wFg9r
         niIL4EmxVMJAqvFREIOgLecnGDXiweVHc8jZ6Q+8hJ4wyJJijAEDOQYFiDi6OgYh+fvC
         T2Exs5mxIZBoQGhrrjsRmNWt7DxU2YRps5B8w88F7nddg63Uwh+2T8h88LQ1/CDmCub5
         4TBG9VjGPgQy4X/Lyozr7GXRrY5myr1Dq1i0osCz1/GYPCjT6OKdKco9DUjkZZnQI5c1
         pvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVOb+vFJlwfEy9YaU1RuD0B68qKfBVjS/jc+VgEZqW0=;
        b=jvX7jqqMdAaWxNI0QkuCiKdkKuTLvkqdbGekdURNiiCeORHEXhxRN5HZCG+KGyb7IP
         k32uI9Nodn9eyfhXXtPivTAXzdGiIvkDS4G/PPDyePGDdy+Z+xNYDwBHoton2ZFLVFFM
         TgLkUYoCT7ZTL5i8aberY35F0lig2G7rXUDZYp1JgiBPkz59loXDbdYPXyF4p5Z7Hfth
         nhbKd/cVghJe0DGwUUHhbcbM3q54fqLMeR/WevoHJxLG94R3MPzTksbYCZ57Y581iMbG
         edCEEm+9UOEqLMEIINm8N5HCjDAJHLjeKlgn7motdpB3Ide9MmdIqpviiv8oO6uewdkY
         EPrw==
X-Gm-Message-State: AOUpUlFz5fjjYSDSe8nRzgyh4UibkX6ZmIc7d/69V8/Zn9j1t7HWYl58
        zZgBrCcCDvguj2KTTMSZTPf3EZxd
X-Google-Smtp-Source: AAOMgpd2IISaPVLgsQcw9cQE9Hq7yiV45bGe8ZDguJ1f2hvIYEjnHDx16f8A4RNrGZUyKyFDmN4HHg==
X-Received: by 2002:a63:e914:: with SMTP id i20-v6mr10275686pgh.10.1532306876324;
        Sun, 22 Jul 2018 17:47:56 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id e82-v6sm11646069pfk.87.2018.07.22.17.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 17:47:55 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 RESEND 6/6] KVM: X86: Expose PV_SEND_IPI CPUID feature bit to guest
Date:   Mon, 23 Jul 2018 08:47:39 +0800
Message-Id: <1532306859-31166-7-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532306859-31166-1-git-send-email-wanpengli@tencent.com>
References: <1532306859-31166-1-git-send-email-wanpengli@tencent.com>
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

