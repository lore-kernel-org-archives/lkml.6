Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2866C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1F120893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyytlyFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1F120893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbeG2Aia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:38:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51146 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeG2Ai2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so9104939wmc.0;
        Sat, 28 Jul 2018 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UevnEAypVyBMvNpG91oE7ELxnnQxszElRrbC7nVJWHM=;
        b=nyytlyFoFn/UmczYOL52KZHf/oMnGTarK8lUW/HZXYOWG9Z2OGmoF6nKjBFnO3v6JR
         M4OV8yFmFg9Lvo5Kif5XZMZNOGpIijxKHquw3gfe9lojM04L5nUK2gZWKHlRxPilXfHl
         c/6P3NzhQFfnMdedTxRIHrviJ/U2/3unCRDc6isreEsu8kegqYJVnkk71et0SVzu05gr
         A4r92XDzlWAHue4of7XGpPdgH3ZX1rgJlHYMUWvJMja2JNMOQsGBs16jf72XyuwmFpCv
         QdRiEa0uNyhO4sLMPyxWTLCoVShlgtDFqDpD7d2uPDURJU4P4uXT7O4nAPSxrxixiq5D
         mOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=UevnEAypVyBMvNpG91oE7ELxnnQxszElRrbC7nVJWHM=;
        b=p0XGIlXl1bBIzZMaX7yaCJ5E2OkTv9PHNCH4asU+VwxmcuH+7tEbik/Tl015nMbhpC
         DZdgT6scS1VnZ54lpbHCi/T/hOXc9yOh+hRY6yRNna8Xts7q0MAFpF7muF+7s1AARRzY
         FCM2OY8H9wmVavHh3eu53pNYlgTrgL7jwQYE1aoC3/Wapx6kqlPVXOmTAMTtiXreOrDx
         M1qLATptGr7WK3ULUjpgS/Da6lClyh1kwcJ5Y5mdOaLkocLvRddChfpLYTkca9Z2gIOD
         UkA9uiEYqCQPtEAvRvfVrSxDaRYY0oU2Rxkb9Lk0hYjTOhHpBRQElfl7zlErRnbzR7yI
         cMPg==
X-Gm-Message-State: AOUpUlEHjYe/1/HuYeCXVmr72I6/812HUDpuJ1GRMH0pDjRf7BOR7a9q
        +uRD1P9hHDMVYKK4R8mX09NFWz73
X-Google-Smtp-Source: AAOMgpdWktMh+wwGZ2y2Zb12W0cCGXpDHa20Hhw3rRGG4NwpJ7QQ3OS7knYjM+U30Q9pMxl+o3jUYw==
X-Received: by 2002:a1c:3282:: with SMTP id y124-v6mr9488552wmy.11.1532819416821;
        Sat, 28 Jul 2018 16:10:16 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:16 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH 01/10] KVM: x86: ensure all MSRs can always be KVM_GET/SET_MSR'd
Date:   Sun, 29 Jul 2018 01:10:03 +0200
Message-Id: <1532819412-51357-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the MSRs returned by GET_MSR_INDEX_LIST currently cannot be sent back
to KVM_GET_MSR and/or KVM_SET_MSR; either they can never be sent back, or you
they are only accepted under special conditions.  This makes the API a pain to
use.

To avoid this pain, this patch makes it so that the result of the get-list
ioctl can always be used for host-initiated get and set.  Since we don't have
a separate way to check for read-only MSRs, this means some Hyper-V MSRs are
ignored when written.  Arguably they should not even be in the result of
GET_MSR_INDEX_LIST, but I am leaving there in case userspace is using the
outcome of GET_MSR_INDEX_LIST to derive the support for the corresponding
Hyper-V feature.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c | 27 ++++++++++++++++++++-------
 arch/x86/kvm/hyperv.h |  2 +-
 arch/x86/kvm/x86.c    | 15 +++++++++------
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index af8caf965baa..01d209ab5481 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -235,7 +235,7 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
 	int ret;
 
-	if (!synic->active)
+	if (!synic->active && !host)
 		return 1;
 
 	trace_kvm_hv_synic_set_msr(vcpu->vcpu_id, msr, data, host);
@@ -295,11 +295,12 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 	return ret;
 }
 
-static int synic_get_msr(struct kvm_vcpu_hv_synic *synic, u32 msr, u64 *pdata)
+static int synic_get_msr(struct kvm_vcpu_hv_synic *synic, u32 msr, u64 *pdata,
+			 bool host)
 {
 	int ret;
 
-	if (!synic->active)
+	if (!synic->active && !host)
 		return 1;
 
 	ret = 0;
@@ -1014,6 +1015,11 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		hv->hv_tsc_emulation_status = data;
 		break;
+	case HV_X64_MSR_TIME_REF_COUNT:
+		/* read-only, but still ignore it if host-initiated */
+		if (!host)
+			return 1;
+		break;
 	default:
 		vcpu_unimpl(vcpu, "Hyper-V uhandled wrmsr: 0x%x data 0x%llx\n",
 			    msr, data);
@@ -1101,6 +1107,12 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		return stimer_set_count(vcpu_to_stimer(vcpu, timer_index),
 					data, host);
 	}
+	case HV_X64_MSR_TSC_FREQUENCY:
+	case HV_X64_MSR_APIC_FREQUENCY:
+		/* read-only, but still ignore it if host-initiated */
+		if (!host)
+			return 1;
+		break;
 	default:
 		vcpu_unimpl(vcpu, "Hyper-V uhandled wrmsr: 0x%x data 0x%llx\n",
 			    msr, data);
@@ -1156,7 +1168,8 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 	return 0;
 }
 
-static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
+static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
+			  bool host)
 {
 	u64 data = 0;
 	struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
@@ -1183,7 +1196,7 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 	case HV_X64_MSR_SIMP:
 	case HV_X64_MSR_EOM:
 	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
-		return synic_get_msr(vcpu_to_synic(vcpu), msr, pdata);
+		return synic_get_msr(vcpu_to_synic(vcpu), msr, pdata, host);
 	case HV_X64_MSR_STIMER0_CONFIG:
 	case HV_X64_MSR_STIMER1_CONFIG:
 	case HV_X64_MSR_STIMER2_CONFIG:
@@ -1229,7 +1242,7 @@ int kvm_hv_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		return kvm_hv_set_msr(vcpu, msr, data, host);
 }
 
-int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
+int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 {
 	if (kvm_hv_msr_partition_wide(msr)) {
 		int r;
@@ -1239,7 +1252,7 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 		mutex_unlock(&vcpu->kvm->arch.hyperv.hv_lock);
 		return r;
 	} else
-		return kvm_hv_get_msr(vcpu, msr, pdata);
+		return kvm_hv_get_msr(vcpu, msr, pdata, host);
 }
 
 static __always_inline int get_sparse_bank_no(u64 valid_bank_mask, int bank_no)
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 837465d69c6d..d6aa969e20f1 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -48,7 +48,7 @@ static inline struct kvm_vcpu *synic_to_vcpu(struct kvm_vcpu_hv_synic *synic)
 }
 
 int kvm_hv_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host);
-int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
+int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host);
 
 bool kvm_hv_hypercall_enabled(struct kvm *kvm);
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5dd67d184b17..6cc29dd21519 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2166,10 +2166,11 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.mcg_status = data;
 		break;
 	case MSR_IA32_MCG_CTL:
-		if (!(mcg_cap & MCG_CTL_P))
+		if (!(mcg_cap & MCG_CTL_P) &&
+		    (data || !msr_info->host_initiated))
 			return 1;
 		if (data != 0 && data != ~(u64)0)
-			return -1;
+			return 1;
 		vcpu->arch.mcg_ctl = data;
 		break;
 	default:
@@ -2557,7 +2558,7 @@ int kvm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 }
 EXPORT_SYMBOL_GPL(kvm_get_msr);
 
-static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
+static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 {
 	u64 data;
 	u64 mcg_cap = vcpu->arch.mcg_cap;
@@ -2572,7 +2573,7 @@ static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 		data = vcpu->arch.mcg_cap;
 		break;
 	case MSR_IA32_MCG_CTL:
-		if (!(mcg_cap & MCG_CTL_P))
+		if (!(mcg_cap & MCG_CTL_P) && !host)
 			return 1;
 		data = vcpu->arch.mcg_ctl;
 		break;
@@ -2705,7 +2706,8 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_MCG_CTL:
 	case MSR_IA32_MCG_STATUS:
 	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
-		return get_msr_mce(vcpu, msr_info->index, &msr_info->data);
+		return get_msr_mce(vcpu, msr_info->index, &msr_info->data,
+				   msr_info->host_initiated);
 	case MSR_K7_CLK_CTL:
 		/*
 		 * Provide expected ramp-up count for K7. All other
@@ -2726,7 +2728,8 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case HV_X64_MSR_TSC_EMULATION_CONTROL:
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		return kvm_hv_get_msr_common(vcpu,
-					     msr_info->index, &msr_info->data);
+					     msr_info->index, &msr_info->data,
+					     msr_info->host_initiated);
 		break;
 	case MSR_IA32_BBL_CR_CTL3:
 		/* This legacy MSR exists but isn't fully documented in current
-- 
1.8.3.1

