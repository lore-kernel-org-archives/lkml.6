Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4215CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTUqdySY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A1F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbeKFW4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:56:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45389 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbeKFW4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:56:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id o19-v6so6194274pll.12;
        Tue, 06 Nov 2018 05:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d2McZSXwt6dnZ/S3u9iWxjpoLuzHhty/pzpLjGCbAmc=;
        b=VTUqdySY6Wk5m+Qn836wTfnbCXiFwrgck7H0bYf0E5qMZVgA+7CxDvV8JYTFTYvIbq
         ffBX0exphKFgaBVuJAmfzAGuKTSWNnTW/3dzEpxoKcX2zCgsJbtUkXf7mzhmhM6RWXYM
         uA/Gds4+Eagb0uDMim0mX2lRncLquO9m2maA3JY8kt7FPn6713Fabpjg/k3vLp9n1jDu
         R4ZKE0C5zhsN5AD9rmWCCaz0F7WahCWJ96FhTBysgDT2bZQCQeSsHgrpIqDTdpu/bNKs
         4f+y7qSJlHEx/eY2LwvBiwTUnpLpy1M7M4CieY1cTNGl9qdDiwtL8OyKZzBdueXi704i
         g2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d2McZSXwt6dnZ/S3u9iWxjpoLuzHhty/pzpLjGCbAmc=;
        b=q9TP4ip+4RBC85WufV8Qzv6AdJdRT9ToW4ZlrVBkJTfSS9SF69arLYlYYYhuq1B79E
         o5vMggTo83Us8fyq19tPsOdEMSqUn3G+Y3nezrSA6fBqqk7lX0BYyux6Cjc0qV7nvpH7
         fIeWAoflrz2bjiYr8hqWRXq7MwvuLhK5mmcNT+wfsuqlI/47vIBFw9q2J9dst2QzzjY5
         Oyn4OcWA99Uzq7tTHRw+SjZYDu5y8nTUoMpI0PO3MQ8gvlfBJzADGybAGDdxUU16fYId
         D8D9MQlIcbNEpYG5pmmz8yL54yHXMVOGQlNiDYUaffBsj0eRP9p9B0tNDAaAFaNoFzOo
         8jOQ==
X-Gm-Message-State: AGRZ1gLBIy0a1mAMZTO0Q5lrphRFicxQuQFaH97gKc0igddENKaTGa5A
        URKEPE8nYL6U08QDcXmYT1U=
X-Google-Smtp-Source: AJdET5fodvlQUJG4aMilhuexUyk1LqqrAfSrmirMqkHk9Sr7H+mgBu17dXv3iXoNqVxQyYmgmgFdZA==
X-Received: by 2002:a17:902:a5c6:: with SMTP id t6-v6mr26687769plq.31.1541511052238;
        Tue, 06 Nov 2018 05:30:52 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i88-v6sm46499030pfi.66.2018.11.06.05.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 05:30:51 -0800 (PST)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH] KVM/VMX: Check ept_pointer before flushing ept tlb
Date:   Tue,  6 Nov 2018 21:30:43 +0800
Message-Id: <20181106133043.83570-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to initialize ept_pointer to INVALID_PAGE and check it
before flushing ept tlb. If ept_pointer is invalidated, bypass the flush
request.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4555077d69ce..edbc96cb990a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1580,14 +1580,22 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 	/*
 	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
 	 * base of EPT PML4 table, strip off EPT configuration information.
+	 * If ept_pointer is invalid pointer, bypass the flush request.
 	 */
 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
-		kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_for_each_vcpu(i, vcpu, kvm) {
+			if (!VALID_PAGE(to_vmx(vcpu)->ept_pointer))
+				return 0;
+
 			ret |= hyperv_flush_guest_mapping(
-				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer & PAGE_MASK);
+				to_vmx(vcpu)->ept_pointer & PAGE_MASK);
+		}
 	} else {
+		if (!VALID_PAGE(to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer))
+			return 0;
+
 		ret = hyperv_flush_guest_mapping(
-				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
+			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
 	}
 
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
@@ -11568,6 +11576,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
 	vmx->pi_desc.sn = 1;
 
+	vmx->ept_pointer = INVALID_PAGE;
+
 	return &vmx->vcpu;
 
 free_vmcs:
-- 
2.14.4

