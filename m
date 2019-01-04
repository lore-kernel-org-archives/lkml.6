Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D3CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6307721871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bERgKUKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfADIzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:55:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45647 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfADIzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:55:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so17213827pgc.12;
        Fri, 04 Jan 2019 00:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3CQvyPlxafLLMYYmnidZXL6MopPPAyOd1R4OKDK3Tg8=;
        b=bERgKUKu51PAzYg3Rrzv52DBjdnCcfNkUuGl0QEWhiWj6W0MmP1KserqG3gw+V0uOz
         717BaRsb17KQy9DlLpRwN73NDF+JlNIwIa6Vtid3Wn7/unsJsMpEWzLVhDoWsO+jPqBK
         CXzhbDQK4O0iY5rU0gimk9NZuMJOLue/IM7psgZOst2rkKV6QjkUQ+xy9R5CHlRtE0yf
         6eYDVGquJEt/gVb0OBEtL7uwYx/NIUXuq7ZJAts2E7VLsvPLZYf9o1OEXSsCvqx1R+Fm
         FOz/j9UPfBj3duCoLjjODwHV5/2+j1i4jVT/zc46j+B8Sqj4H5cNFpIum3Jq9ABDTfbu
         UfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3CQvyPlxafLLMYYmnidZXL6MopPPAyOd1R4OKDK3Tg8=;
        b=tvJ42Ds9o0dmfO3COqfxvZvWQA3UTpvqrH9CYNr2N5A3zi+RmugjrlC1jmZPAYKR19
         wTNT2M+FP3wuv4J8GPJFqI7oSlJduPrqGOkiQEo9GjCY14Y7DphEMN7ETtiLdhICH5Nd
         RvnahsfKmwpak0Y/b87hzJSud7OrTHhtvL/Ab4NKw9rDxKyoYbxI7wYoE08HbrU4kaL4
         H+rhBQDe4ImFGdejc4VIlGfjkfZ4wxQH+TFi+xQgLFj3I/wdHcuiNwXrTS8u0fmlM7Bz
         3lL58YDl/TnWVu0E1gzCS7cMhrvQx77z2cQ1z9kLEVao8WSr5Jayu2D6FZ3jdXsOwfav
         Oc/A==
X-Gm-Message-State: AJcUukdcqJhcStxj6ijhzJ47/OmYxS2CLHjgAUtbzCrZrLCBK/NTnjLA
        89KogFCFAQAAnz0ZoLb8Mv8=
X-Google-Smtp-Source: ALg8bN52JNWJUY4wd3KWz56nhScCreos1hBMy4NTN0TRzwOHpvOyEaRyBz6+s+XGkePV/idoh2nHEQ==
X-Received: by 2002:a63:557:: with SMTP id 84mr19472589pgf.411.1546592112418;
        Fri, 04 Jan 2019 00:55:12 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:55:11 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH 7/11] KVM: Remove redundant check in the kvm_get_dirty_log_protect()
Date:   Fri,  4 Jan 2019 16:54:01 +0800
Message-Id: <20190104085405.40356-8-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

The dirty bits have already been checked in the previous check of
"dirty_bitmap" and mask must be non-zero value at this point.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 virt/kvm/kvm_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf7cc0554094..e75dbb15fd09 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1206,11 +1206,9 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			mask = xchg(&dirty_bitmap[i], 0);
 			dirty_bitmap_buffer[i] = mask;
 
-			if (mask) {
-				offset = i * BITS_PER_LONG;
-				kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-									offset, mask);
-			}
+			offset = i * BITS_PER_LONG;
+			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
+								offset, mask);
 		}
 		spin_unlock(&kvm->mmu_lock);
 	}
-- 
2.14.4

