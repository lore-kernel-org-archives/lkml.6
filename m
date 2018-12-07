Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F780C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1551520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="eBzgdhkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1551520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeLGMtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:49:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42839 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeLGMtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:49:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so3673700wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qskwDCENsUJ4XJZgk7mw/D1NJ3EoY/jK2YNM77334Jg=;
        b=eBzgdhktIQ137s6FC7u+gCPBBBDYqLbuh6vzpN/BbPDS8ZmYTwukPjotz750UMPraN
         9HElqnTsb3BVtqBDTmatcs6c5vRRC6ySaruowAOc/ZDEVkf8Ba0b6lh1zZwRFTrY9hhr
         5MsheYQX6J4rTN0AyUyjB6thGWbLL3fcwC++9dqW6NJncg/te3AAKOIsfaPNXs4ON0TN
         O2EPUrg5aM3H2zIUOwdZgzNB7y3LJeDGitoPb514EJhQFRWIAT6hVpiuu7F8dMDWc4tM
         d3pVVADpadqjuH41NgKjOei5dzGkHqnjGFJpWPZyxQVktCEUlB44/Gy6K2LTYgOP5nv7
         2MjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qskwDCENsUJ4XJZgk7mw/D1NJ3EoY/jK2YNM77334Jg=;
        b=XjqbwZBrzqlkw1AZWX/cLEINdxACNMufnS0LmJpWyt2xzKBEGC+1TalHzvMhCb6uFR
         YqlgV1B2SE4rxBSu5mB6KYPlVwRQ/bcBJUk9nbELrJDPL/FaS/NB+Db733vqKNh3yj7t
         aV1UA9LHhVn1xltHnveb4HYP/y7XcyTgdhG7g4P+g2cN7KgBsWxXHbojO5/8IONdYxMF
         8rzlaoOktOHU6tA/o1smJKyGKSDN1Iq/ogONSIdiTH8aam42PHonfC7+9aHgkW4wkzSd
         b0FQvvEd65XEgzEr6zNbA97biYgIrZGTwt5uVZwu+em/epQP3UVzOjvxyAANcjQJR0Ud
         FApg==
X-Gm-Message-State: AA+aEWaUdZG1xl84ZRM9FsR+KcUBu0wqHC7wj4O3cjkb3+dgt/IEGsZt
        mTLvbkBigbTXU9CZ17NUz6tj/A==
X-Google-Smtp-Source: AFSGD/XonZe40VF9RnZ4mhjjnNirD7PlzbAwQIiqaTMt5AApa7uw7RM0qOskDpWMLKRL1BmCis9VEA==
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr1582875wrb.167.1544186942211;
        Fri, 07 Dec 2018 04:49:02 -0800 (PST)
Received: from localhost.localdomain ([156.213.98.90])
        by smtp.gmail.com with ESMTPSA id i192sm4362949wmg.7.2018.12.07.04.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:49:01 -0800 (PST)
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
Subject: [PATCH 03/10] KVM: X86: Add helper function to convert SPTE to GFN
Date:   Fri,  7 Dec 2018 14:47:56 +0200
Message-Id: <20181207124803.10828-4-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
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
index b67d743c33..a300e4acb8 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1024,6 +1024,13 @@ static gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index)
 
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

