Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6EAC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E38120830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="steZiVVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfAFTZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:25:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44770 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfAFTZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:25:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so35985919edd.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=juz3/8ubyO70o/WwTakdDVvsVYAiN+8d71XTlXhc8d0=;
        b=steZiVVlp0a+SY0QZj98+HUEpB+SGU2fbQS7H3wpS+ptnLLFDoHHCjCQOVZVKKqUVW
         OUGZ+Xns0jjpiAHyw0qb/o2V2bmJnriImE0hdzUF3+hYfUoTcmU59muqVRwZB/HwKGS+
         fYomN2joLB5sxf6SR9hqc3A9et/eLYq9lhoiMp4T72DurvYOnlWDNThCnDuW8nwu9vsW
         uvxgYFXC0dNSGFI1L5z6HptxxxabfaXFRhC9Q+ZHuFr+pHOLn+vMPczC0hVuCpmMVc7Z
         tp4eH0JJSCsyHAsgJ2JLLRAm6QRgObMJ62BvxkC7U6zw2XYEmQmAFLxUs3m3MnZOJW9/
         cKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=juz3/8ubyO70o/WwTakdDVvsVYAiN+8d71XTlXhc8d0=;
        b=kLxTYtfoLNrdNljYl68UGeuhPPbrc5R8aO6AnpEPEKX/DD2ZfvY/T8lcsqSKXj23mS
         Us7DvwtVEB3DtT+6F+ZnsxLeCyK/vP6LeH7DEH/08WMFX/AxaCVHSvGL4NiZ0q9G7N3r
         hSXhPKzLgnLv4dqr36Zhzi/UYIO3wRekH0DS5Yr5iRq+DeaCbDVYr/cV9nr17cei9dc/
         UiiwiTC1ncWvYD/1+NoxOP7rfREGhcDYVx1oouzaOGZEOC5tGhmxP+Q1DY41mnXUdC8K
         WhycWye3hBkWKQ0Nia4k51dnaSj97A2Ea6gpcHraim9tfNVIkxyL4fcrSKfaj3GsGhBW
         ctEA==
X-Gm-Message-State: AA+aEWYEWdXLc3oRoXVGz6yEqpx4NmFTt+O9WhqEoEXx1EIZQzs70vOs
        NXgYM9XZrETXt6KRRD0PNQLq1Q==
X-Google-Smtp-Source: AFSGD/UvYgbKU5xyrz93gZaOyQ+KFy6uO5zf3YP7d8coLvYHSjYPA5V+eFF+u48ZvYMDUhQKtHjMkQ==
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr54305747edq.30.1546802709581;
        Sun, 06 Jan 2019 11:25:09 -0800 (PST)
Received: from localhost.localdomain ([156.212.65.252])
        by smtp.gmail.com with ESMTPSA id b46sm29994035edd.94.2019.01.06.11.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 11:25:09 -0800 (PST)
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
Subject: [PATCH V8 03/11] KVM: X86: Add helper function to convert SPTE to GFN
Date:   Sun,  6 Jan 2019 21:23:37 +0200
Message-Id: <20190106192345.13578-4-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
References: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
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

