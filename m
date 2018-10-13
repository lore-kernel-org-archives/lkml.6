Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BECC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B83020877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEGPa6QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B83020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeJMWc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:32:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40418 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeJMWc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:32:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so7160985pgm.7;
        Sat, 13 Oct 2018 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xfRQSfuAnDwpnOZIhNPY62J4SefIE5r3CvTTeCEiYqw=;
        b=kEGPa6QJhdMHlGHes7FOLSyU0rDOjoeamuSKvaf+coDqupnJrSDNQRDrzS7q53a/Z5
         EN6Nt7Y22s9Nmaocti3wGyH563gtz2RKfb1KxaR0SuWJHpWvEJAlOdlGK7x4/cjQZmi1
         nDt7/gWfEljVzI0IDxRYo3QYzGDiiOjfEEt1UxaEg5wqOf7LuK2TomFcqWgLZ38vJIxC
         D+CKBK/5qQCR2YvWoVKhbQzwBH5+hyHPhH2wUgnVt4gDGdUVWnEnx9dpry90Hb9lgxlx
         JDccZzyHuorSPVrX1Tn00yiipQQBgokGg9odBcmd3eAz7HMcS7wJvW4Ft2KeqA2b/bZc
         uc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xfRQSfuAnDwpnOZIhNPY62J4SefIE5r3CvTTeCEiYqw=;
        b=He005Zo4zWSkBmTZjJwki5olZ21+ACcnRA2vKcEl8ezsEebiWmHJMSOBrtT5sZJERI
         rpq4Y7G5mppPFAm2pwka4+p0jEo92drgdOHv9hLx1uAV7ZzGQqm99zalYusl8RKwmWxz
         kAeL3HdPe52NIrKxgbONzkdIGGOawtAVgmkRdh2L2I1Vjr2LQsFTEUOUZyJK9poRoElH
         wVQK/0ly/4kWOjFyzaUJ8cU3jUfykXOeceoVNYzQqdT2sjfh/s4sn7SzoNH3cL0s+YlV
         TfCN2LWzchO/YWB6pkGQrwLCl2whUPDr4pC2OdTa9QCxgO6qitdLDPf1aXTZgtyD7CmO
         a2hw==
X-Gm-Message-State: ABuFfogBqjOnnb4JT6sDAKQUbgu8OZ+68cOpOSULiaeqMdZ5OdC6bGvL
        lhK/tT5dmxJJrmyKvBeSaD4=
X-Google-Smtp-Source: ACcGV633MgP2AR9dFAN09KFqFM/iiL4+YwpQcy51rm9ZiZRF1JKK0idSdE4JVatp10eY+XqRqDk5+Q==
X-Received: by 2002:a63:7d2:: with SMTP id 201-v6mr9785713pgh.129.1539442503414;
        Sat, 13 Oct 2018 07:55:03 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:02 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 6/15] KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
Date:   Sat, 13 Oct 2018 22:53:57 +0800
Message-Id: <20181013145406.4911-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb directly in the kvm_set_pte_rmapp()
and return 0.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 5d3a180c57e2..f3742ff4ec18 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1781,6 +1781,11 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		}
 	}
 
+	if (need_flush && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		return 0;
+	}
+
 	return need_flush;
 }
 
-- 
2.14.4

