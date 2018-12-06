Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC709C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9351120892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7rsbS4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9351120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbeLFNWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:22:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41468 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbeLFNWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:22:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so164652plm.8;
        Thu, 06 Dec 2018 05:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05eCuYloh9Px3MuyXZuyo4N1nE/OSde0RiSxjQ3fyfU=;
        b=h7rsbS4e96rnTjDpf+wPccTiP+a9FLsRCMkXZUiO0QBUaBGO8vnn11qj9ZRHJX2ELq
         KS1Bcz7+LuLHVpL45k72IfK0qGczLcPCOdblW2EKuuT1Ip/eowtE5C9alh/FT7KAPMcA
         2iH0lTULOvtlGL+QbrrMNCzmCTRGkyYHeq3HTM72qI4vwd6stXEgZPjwd6nQLmaYtS7H
         AXhE8ncCQlt8PzR0NsxRwq/8wHrkrS0gzDLuUtv8QMIdWaUQ8PsOHFSZy9GkvA7iGAat
         O7A5KSTlKtMW/K0GCr76FIRPFRfsVd1Vd6t9BViTFe20ZSEzpWQeKzb06HQghDv0c161
         bEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=05eCuYloh9Px3MuyXZuyo4N1nE/OSde0RiSxjQ3fyfU=;
        b=T8MVZ67H4W1qe9NToNuGSb6Vq+t6OICjM7RY6Vpw9Un7S7GrB6/syJtSSnQKpznSGV
         lEXXX7zXc/8VGfvGYLKDaRfGsc1Vq8dHZAAokaGA+u/EYM1yDTLOwU0nWvdT1XcSDJIP
         DisjJWJiszUIuViHRmXUFrEKoc8mileNI/s1vho4sABRsTCc3BQH2/H8Dpc/mFGjGQJu
         H/bjSIRh81JgqBKHdIA2HzC/XlB3vD0KL/FuQ1dWq6GXyBy/ILJOX02manJym/jRhGaK
         SkiCUktRbr6UEcnwqHPQsTOtuOse1b3T51DWEzwJWuqcFYuXCPTIGYUtuMb/MTeJY3Kl
         nJIA==
X-Gm-Message-State: AA+aEWYySwFekGrzXl7+aGhXANiU+hRYqArpkvDBC51J0iJjuVHbpPh3
        FG22/2rtwgdON7fxi1mbDoigVmDkrk8=
X-Google-Smtp-Source: AFSGD/UPjdCn4mwhXpkuPC8huNPrCqsha4pL5d8i5xHpTxt4gRenWUU3IPUUfSArm1BjNQHXwkvRxQ==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr28177158pld.236.1544102549975;
        Thu, 06 Dec 2018 05:22:29 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 05:22:29 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [Resend PATCH V5 9/10] KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
Date:   Thu,  6 Dec 2018 21:21:12 +0800
Message-Id: <20181206132113.2691-10-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
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
index 3b0f60e88f54..64bd848f021e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1776,6 +1776,11 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
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

