Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815B3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE592070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFEDariz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfBVPH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:07:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41827 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfBVPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:07:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so1237391pfn.8;
        Fri, 22 Feb 2019 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HSIeB4k5ZuogmL6MUD/u+Ar8YyEEuP4vsoidGitcBOo=;
        b=VFEDarizmQAexjrnIXw10DNn/NEU/q3swR8bwAjLeGeWR5tr50z2EvERNhdjvyBtb4
         VqcDze6oJyEG2pknFT+FiETqiVnE0DZHnLwja3h0uY8qOOjM21+Dp6SLpG/BC3cE4h81
         SF/psiWa1QApresuj0e8ND3u+47m/GWHAnUBUNUC7nvhjODQgJkjJ6VL5W9Z5qzpBEql
         aj+3/jBXo1eCh94oYlGSFb8sc69YJn3TYkh/EmPjUsk5AMD6kLLfgTmUnd3sAw1vBVnr
         hJaY7uoZAfxkdaMxF06564Gne0Mr7a2eQI5ZiDFFUQvgZkp3OVmUBVZyCVYSG/kRWDXN
         qDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HSIeB4k5ZuogmL6MUD/u+Ar8YyEEuP4vsoidGitcBOo=;
        b=LfkCJR/JdbuCXVEMq/MSzBOi8cuezfKkTWDoin8H2Yb4hjzhLv5dleDJ6sLaw2Yxbt
         ffRIuDY+I/0j0dGSKpWLPe62lOP+vRq0eNIH7ZM7wJPdkCL5e4KpW04oPt0PHBJJ8Oxj
         321bKu/vSMIoxLvD6XVTw0reE+TrkdhF8OoOJ07QydMhWZRTOC5a6HljXbs7N4ySI1KS
         ljQTW2NGEWQ8pmniCopt1mws9QhtLDbrSV0W8wPycUvvtOhhJZdU9Ih4KCzRGz7dvyGO
         ea3afExj7q+fur2WsT5AjaOwzb76BvmIEg2elU+6mHR0Kk3PSRhqwfmRgSgHNuTLuFrZ
         AsNw==
X-Gm-Message-State: AHQUAublPNughAlHtmTeAIPh0hOmIL1XuZiUgGmjnioaEaePxcyzmyeJ
        wXTaPXY83CPyl8xaGE7DCTo=
X-Google-Smtp-Source: AHgI3IYeKFBy5DfEgi7+NoEfVT1WeWulgurOSdqM73OPfGXKYCvFjRfn6bTV8zsuwtVzgFf4mlVMaQ==
X-Received: by 2002:a63:2ccb:: with SMTP id s194mr4379235pgs.214.1550848047046;
        Fri, 22 Feb 2019 07:07:27 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:07:26 -0800 (PST)
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
Subject: [PATCH V3 4/10] KVM/MMU: Use range flush in sync_page()
Date:   Fri, 22 Feb 2019 23:06:31 +0800
Message-Id: <20190222150637.2337-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to use range flush to flush tlbs of input struct
kvm_mmu_page in the sync_page(). If range flush is not available,
kvm_flush_remote_tlbs_with_address() will call kvm_flush_remote_tlbs().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/paging_tmpl.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39829bc..768c5c64e3f8 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -1033,8 +1033,9 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 					 true, false, host_writable);
 	}
 
-	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+
+	kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
+			KVM_PAGES_PER_HPAGE(sp->role.level + 1));
 
 	return nr_present;
 }
-- 
2.14.4

