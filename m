Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F077C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2EB2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1Yx2Tu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2EB2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeI1Me2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:34:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45413 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1Me2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:34:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23-v6so3538868pfi.12;
        Thu, 27 Sep 2018 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgwFuKjgGYJdfcbFJ9WgTJf9FMxvKKHLJcVvrNVKkRM=;
        b=O1Yx2Tu5PxBdWNtoTImkJn6DE6gNwmV9Oqo0LiCzvwT6VMjOUJ2QF1Qb7fiPFo8mN5
         9CDHxbijIlXJYzEGuZUXjaBaCdDgsqMUvRW/+sKKzRCTAeaWtDFhaxA/fd9xA98VrR36
         tEsVIUreZozDguVtUJHcLkeGUWBlW4+/OkLkELDIHpWV40VnZ//qTH9L8Cp3MJ7MrSC3
         rhsK6GBlZ+ETkUSLso2PsHsNLLTepmmVM246TuWmlT4p2qUxX4ybeBS++Lr/PqRhL2Em
         i9xxSG8GXipIAsVzeIaDsoUjKTu1FNAzw9XjLtMdyH3lr70+J7O5MOB1qu0Ldtlj+ZJ4
         Bz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgwFuKjgGYJdfcbFJ9WgTJf9FMxvKKHLJcVvrNVKkRM=;
        b=pZxx/R6YaGgHClaeflHdJUZF/kfXESLuOlW7Wh2NYsoVquhLxjI7X6YnB49eZoCwHI
         5TF1vbrYceCJdz7B3AopOJ2v1fMHKcuooay7srj9RoQkBbTS/U/TvgTf5PHUJwIzAzIn
         2djT2F0lstaCZpd16qpi8PkJlTxVsZxSEmh+x+1MSBHO+9t4d0JdKmef+KnM9L/Xjm3h
         jjfxkXMmr3qXWEvssTP1VEBfLyyRF35kRav2sivAzJfpxKpVADkQ4jpnZGdj7UmWDcW5
         4MoV4tKb2OF7GB4Hh4hcGY2bDgQ/J/j8R7pVWxl/nMrYFRt2b7YD4M1lLMZU42RUTJA2
         TOgQ==
X-Gm-Message-State: ABuFfoinx3jw0LBguwaQAatEfctatcNEh7De6yA8ZWgpVlfL0sYiqxBt
        KyvOIADcdJ87Mk54yQvcq4vAR2py
X-Google-Smtp-Source: ACcGV61sWaQyxPwLZfAPLIWv/znJQprJToF6O5PuIuyNxUJnsaKp8tAKevl9nf+KmU4qD8EUr1iAxA==
X-Received: by 2002:a65:5286:: with SMTP id y6-v6mr13132923pgp.65.1538115140988;
        Thu, 27 Sep 2018 23:12:20 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id 71-v6sm5602767pfx.182.2018.09.27.23.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 23:12:20 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] KVM: LAPIC: Tune lapic_timer_advance_ns automatically
Date:   Fri, 28 Sep 2018 14:12:16 +0800
Message-Id: <1538115136-20092-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

In cloud environment, lapic_timer_advance_ns is needed to be tuned for every CPU 
generations, and every host kernel versions(the kvm-unit-tests/tscdeadline_latency.flat 
is 5700 cycles for upstream kernel and 9600 cycles for our 3.10 product kernel, 
both preemption_timer=N, Skylake server).

This patch adds the capability to automatically tune lapic_timer_advance_ns
step by step, the initial value is 1000ns as d0659d946be05 (KVM: x86: add 
option to advance tscdeadline hrtimer expiration) recommended, it will be 
reduced when it is too early, and increased when it is too late. The guest_tsc 
and tsc_deadline are hard to equal, so we assume we are done when the delta 
is within a small scope e.g. 100 cycles. This patch reduces latency 
(kvm-unit-tests/tscdeadline_latency, busy waits, preemption_timer enabled)
from ~2600 cyles to ~1200 cyles on our Skylake server.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/lapic.c | 7 +++++++
 arch/x86/kvm/x86.c   | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index fbb0e6d..b756f12 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -70,6 +70,8 @@
 #define APIC_BROADCAST			0xFF
 #define X2APIC_BROADCAST		0xFFFFFFFFul
 
+static bool __read_mostly lapic_timer_advance_adjust_done = false;
+
 static inline int apic_test_vector(int vec, void *bitmap)
 {
 	return test_bit(VEC_POS(vec), (bitmap) + REG_POS(vec));
@@ -1492,6 +1494,11 @@ void wait_lapic_expire(struct kvm_vcpu *vcpu)
 	if (guest_tsc < tsc_deadline)
 		__delay(min(tsc_deadline - guest_tsc,
 			nsec_to_cycles(vcpu, lapic_timer_advance_ns)));
+	if (!lapic_timer_advance_adjust_done) {
+		lapic_timer_advance_ns += (s64)(guest_tsc - tsc_deadline) / 8;
+		if (abs(guest_tsc - tsc_deadline) < 100)
+			lapic_timer_advance_adjust_done = true;
+	}
 }
 
 static void start_sw_tscdeadline(struct kvm_lapic *apic)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index edbf00e..e865d12 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -136,7 +136,7 @@ static u32 __read_mostly tsc_tolerance_ppm = 250;
 module_param(tsc_tolerance_ppm, uint, S_IRUGO | S_IWUSR);
 
 /* lapic timer advance (tscdeadline mode only) in nanoseconds */
-unsigned int __read_mostly lapic_timer_advance_ns = 0;
+unsigned int lapic_timer_advance_ns = 1000;
 module_param(lapic_timer_advance_ns, uint, S_IRUGO | S_IWUSR);
 EXPORT_SYMBOL_GPL(lapic_timer_advance_ns);
 
-- 
2.7.4

