Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CECFC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDED2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="gnuyvR2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfAUI2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:28:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34121 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfAUI2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:28:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so5545087wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=juz3/8ubyO70o/WwTakdDVvsVYAiN+8d71XTlXhc8d0=;
        b=gnuyvR2bnuLilcd7+9IZF+J+o8w0XrNB/1Xkz7HCGSUq9qPW+NOUi/WjYSQqOIbFY6
         zLE2d9gMubbXqFn/RyND6TvDIfdb/L+z0gY/VXI5CSIrtblIhzSkrwfO9Z3V+IZ3pvOf
         OgWoTmijDHQtTrwB5UKFvw62XDi3VPUnfQJz+ZgdTCd6RSzSyBC7iwapfZxpAHiNfiBX
         pBvS382M8jVHkBZVPVELstfsb3pvL6o7J+IpQFEUIL3qZGuiRXIiQ8eWV08tqCEpZ3k+
         StfsIH+p6gK7RZjheXduzukbYDmmTJja/NEELPCmFu5nVOPQKZ38nUuJFdcfezgwc4gg
         o3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=juz3/8ubyO70o/WwTakdDVvsVYAiN+8d71XTlXhc8d0=;
        b=p5itO4r/BrhtPf/+IShzaE7Kf5ZpEbLhCnW0BHItRZOQ9S33BwbDqsiSZiofi+5ozh
         ohnrvO1OAmsTKpsdH6JmUvcCkCUM3E2SFOm3SM/hS+lsYCShiQbjk7SN/X8rIZ+bnLtr
         6Qv7tRA6Aw4z/AWrkXoDuKEnx8HD35r+VhJSLyElonaQ0QRUa8ciwVFNNRKxGKlvKdbK
         jOEbtgxG+gD3O556+PujWB7aqM1zMfAgaj2mWGZh8Bd+X7jYjhnp6dtLH1BMNU67NZeD
         CU377qJYxeR+QHxnDMBU7jqUeW4dEafZseuw5820nKbCketzDVsb7WrgHp17yYzFFzKa
         cJBg==
X-Gm-Message-State: AJcUukcZjdFjr/YxMToVWEM9wE8AP/OtcawyV32zmdI9FpAWBDlGtf2h
        bD0hX9Ffux+X0prkIcO0e4LNvzZm9lU=
X-Google-Smtp-Source: ALg8bN4jEjW9am+Xzj8QcDzzmQ0pxFo+cktjow7q+YKP8Hur7vhk7wc+PrdAJwB7Juu+8w+lON7BAA==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr22057938wmc.21.1548027673915;
        Sun, 20 Jan 2019 15:41:13 -0800 (PST)
Received: from localhost.localdomain ([156.212.82.83])
        by smtp.gmail.com with ESMTPSA id e9sm76576753wro.16.2019.01.20.15.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 15:41:13 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [RESEND PATCH V8 03/11] KVM: X86: Add helper function to convert SPTE to GFN
Date:   Mon, 21 Jan 2019 01:39:32 +0200
Message-Id: <20190120233940.15282-4-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190120233940.15282-1-ahmedsoliman@mena.vt.edu>
References: <20190120233940.15282-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 arch/x86/kvm/mmu.c | 7 +++++++
 arch/x86/kvm/mmu.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 098df7d135..bbfe3f2863 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1053,6 +1053,13 @@ static gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index)
 
 	return sp->gfn + (index << ((sp->role.level - 1) * PT64_LEVEL_BITS));
 }
+gfn_t spte_to_gfn(u64 *spte)
+{
+	struct kvm_mmu_page *sp;
+
+	sp = page_header(__pa(spte));
+	return kvm_mmu_page_get_gfn(sp, spte - sp->spt);
+}
 
 static void kvm_mmu_page_set_gfn(struct kvm_mmu_page *sp, int index, gfn_t gfn)
 {
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index c7b333147c..49d7f2f002 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -211,4 +211,5 @@ void kvm_mmu_gfn_allow_lpage(struct kvm_memory_slot *slot, gfn_t gfn);
 bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 				    struct kvm_memory_slot *slot, u64 gfn);
 int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
+gfn_t spte_to_gfn(u64 *sptep);
 #endif
-- 
2.19.2

