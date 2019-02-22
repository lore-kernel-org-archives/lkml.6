Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884BBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5413A2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESb80kNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfBVPHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:07:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37415 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfBVPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:07:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so1261762pgq.4;
        Fri, 22 Feb 2019 07:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YM3seOtHGatq4lqSEDt4Wr16opyBlW43DUEP6U3tUmw=;
        b=ESb80kNiQ9yog25hPeo9L5hKj8CkvoWsClwvZnFApBr+huWEHDWQTXqNuizJjyoiLZ
         CiXdav6OWZyQC9tqLSnqze0GiMae/oOAqV9Ud+Bd0ydew6/OsD/5XGOh4zoWPCGpyzum
         RvRhzwTNo7shXmgxFxA0oErxpGAnGACXRAIV2H/5+tE9/MOPelqqfgFQgoPkHrPGJcva
         OFNYA0CbwxPF4AS95pELF6Np+sXag6o6tqlsTWOYsfVykohWQxclNwxjcwzsbz78YRtX
         ArQsaIhAhxE+H3rU76V/GO1lQSdXD6+ZWGqrTKkUG1aU8t+bF50qLOCpSMN2Xyqn7kh1
         JrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YM3seOtHGatq4lqSEDt4Wr16opyBlW43DUEP6U3tUmw=;
        b=PAqQjnLQc1VwXDxXXONuyW5VOZMpu/TcGnrjoMcVLTob94tCpLkKd9UQI29Kzj9tct
         6ml61tAIopscMKD1LwI/h+9+q+XoypcVNfiAeLvHWFhnUVnRU4NENilQs/Zj+WmeUdhE
         EWIdyhW8brFqptmyZ6U44+HaFayC2rHJ4dTyfTlWsRFi/5t8wUop4rWy+EqIBdLKJnor
         U2beh6K8QSeROi5nkLaAsNcx4OKCAk/3WuW3NQhmMlTUmMsB98kaNjoBprxa1DbPKxPD
         Y/gaql5M5ZD3EozHN/X1y/AwLJSsj/KQ2o9fbVDP55lOq30BRqM7Uyij0jJH98ps7fDe
         hYJg==
X-Gm-Message-State: AHQUAuZx1JpN9g1x2yiaTtZykbjNlfl7IyzNQA6GZqemBIPCrrU/abLJ
        mpR4aS68siYOH/yj4WXUSWc=
X-Google-Smtp-Source: AHgI3IZ4Yi0roB+29f2OCEvwvH3n/OYYmCvsm0Fts14g6RKRhp0fOWP4XzYAgutWF3KiQlBf5I9nbw==
X-Received: by 2002:a62:48c1:: with SMTP id q62mr4660304pfi.113.1550848054699;
        Fri, 22 Feb 2019 07:07:34 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:07:33 -0800 (PST)
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
Subject: [PATCH V3 5/10] KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
Date:   Fri, 22 Feb 2019 23:06:32 +0800
Message-Id: <20190222150637.2337-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 7a862c56b954..60b1771e400e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1729,6 +1729,11 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
 	}
 
+	if (write_protected && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		write_protected = false;
+	}
+
 	return write_protected;
 }
 
-- 
2.14.4

