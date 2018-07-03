Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0295E24B6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKWRrL0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0295E24B6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933398AbeGCGVw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:21:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42633 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932767AbeGCGVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:21:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id v9-v6so486403pff.9;
        Mon, 02 Jul 2018 23:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVOb+vFJlwfEy9YaU1RuD0B68qKfBVjS/jc+VgEZqW0=;
        b=PKWRrL0DcBRZZKToQLn/A/ZchISxXwjMT/yB8kjCrUthzbBI9tcmDhtJ+lanz/ntZs
         uXAnqvJ5sxXlOITSrrIFQpUxRb4xTRmuuVVXGAGaw1dvtag5Bq1M+mXdFJCHAiQmPek2
         IVWMIoFkvliQo8y09TpY0cYbpiXl4SlJofWGwQ7JUa1YPJe5gymhctt/mnAj9XCs7tHH
         G4XoRBkQh9Rk+PA807TouGwbFaNCb+I4bNOiHE9rxmoEeTEXQbQWjoWm8wn/APLE+vcS
         HXRIoshmaoSxwoRzk0rw4ciwJFFHzZlCDSmzX4w2+SNKiJRmjacPMS5ske5UFeHHjrXx
         wgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVOb+vFJlwfEy9YaU1RuD0B68qKfBVjS/jc+VgEZqW0=;
        b=cQkAGFJpsKiokVwxRPXNn3H0LFrIyo/DFnDK35n62UO91j6FSYjZbfr/9FXJYbHQkD
         WtIo+1yd8+GLgMjOpZmVzTNYm/uhDX4ydz9fzUIiOyhvSqPH7T7ICg8ZguuCOiYwUrwk
         q8o4jr1QnumOIupnlRYLRcYJ8objR+t+obQ3MmPcxV8W1x8z3a5C+M1MAONVEnZVCJ6B
         5UKlhkrHmRojAiU3rMUtenrmNafb1RzY/Cn56njHxtKbXFVxtySjcArk9Bk7SA2N+It+
         Bw+qi8M1b2KKyVRug9wPkP0O0irrIiCrfjstuOSPNwgS90HzvgZfTXn8PSSmxa9cw1Ll
         0y5w==
X-Gm-Message-State: APt69E3+IIxKrIsW+P/AdUgcQi/ZAz6cnve+0HEeE5+Gg8Z7DdtXXcQC
        4yP34DMoAGd8SGp/BMEVZ+VitA==
X-Google-Smtp-Source: ADUXVKK/54PEcLPPOV+v/97C8p+y7iViarfH1/j1okrhiZLSEsDSfwHpGUaup0N7rxRpP7ZEmOJxOQ==
X-Received: by 2002:a63:8c5:: with SMTP id 188-v6mr23989672pgi.97.1530598907850;
        Mon, 02 Jul 2018 23:21:47 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id v89-v6sm1766427pfd.64.2018.07.02.23.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 23:21:47 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 6/6] KVM: X86: Expose PV_SEND_IPI CPUID feature bit to guest
Date:   Tue,  3 Jul 2018 14:21:31 +0800
Message-Id: <1530598891-21370-7-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
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

