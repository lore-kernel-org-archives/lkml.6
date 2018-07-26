Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD82B2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIqwJfFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD82B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeGZMnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:43:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53365 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbeGZMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:43:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so1610781wmh.3;
        Thu, 26 Jul 2018 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dG+ez3dosdkLAhEufpO7nehNuqEnaXsI/soSdQt5kH0=;
        b=tIqwJfFCkaUw+2hQ+Hmpg5DLgRJu6VwZkooWeR2Q2TS6qs29PnWh/ZLtkB3e/9DzZf
         8Fn5rQyIB5/q9zegzhMCr4GipUkaKRlNwPvpRrWezkm3/wr5et3SATzs9mB9/57vlqf6
         sOIdBlnThHiXOT9I44BHfO8BdRGkhGIn1XttYxq9PSzRoEh+faVR19fSYgq12hrHzzSv
         MN8g2thY18k32FJbTuQc0fH/l3g+Ph7ikcOnXaCb7hboRbWZawzQR9FPpgS8VVgpzHLA
         n93JFqFRyTB04TZ0sabLIsrcb5dQCFREcv3o1hSvLTHa4Yn+aMmH8oTpljDH5DCqFuzN
         P6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dG+ez3dosdkLAhEufpO7nehNuqEnaXsI/soSdQt5kH0=;
        b=o8Lj/vh3RC4OUXM68U/u7ibQDEg7HFYylN8t0I+Cxy4YLgssWk3kWI6X23VZc6dtqU
         sF/fZnlPIzpzVT7im/BzXMMUG22cHqM7JUzy+FUpC64cA6uIFkyOf5hAjmmnhikBtDNv
         mnYcSVnLXLmzqi5Ixl/ejV1Z5fUfRKNiGVAlZHquREs1tlwkdJeitSwk3EBWy0ajD2kn
         fFwsoTyBCUUXN0Xz4nOxBbhRXHFzELpMoQ1NpvFo4TXca6Zyb0KtPao8bf4ZsAzXUVjF
         DZbXZDdMkIGqSmIH7u+QagCR4yMXC09K/16IJNUgdPjme3837OKB14cxXix/SDRtZQog
         CdUQ==
X-Gm-Message-State: AOUpUlG8twxhrHrJRHdTnaTAarJ8ZJB4bFmF4GEuoH8N/PIDaIvcQqh+
        4kOY7mMhyAMxVaepwXr+q2HktFmE
X-Google-Smtp-Source: AAOMgpffSOPHAAZQpRska1uGcW0XIc2ZtjVR3QORKV41rJp0YQZQtIZIZiHfkyS7qJLSQYKkPv6ijQ==
X-Received: by 2002:a1c:d6cf:: with SMTP id n198-v6mr1352015wmg.61.1532604411022;
        Thu, 26 Jul 2018 04:26:51 -0700 (PDT)
Received: from donizetti.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id t70-v6sm1793683wmt.30.2018.07.26.04.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 04:26:50 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, stable@vger.kernel.org
Subject: [PATCH 1/3] KVM: x86: ensures all MSRs can always be KVM_GET/SET_MSR'd
Date:   Thu, 26 Jul 2018 13:26:45 +0200
Message-Id: <20180726112647.6272-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726112647.6272-1-pbonzini@redhat.com>
References: <20180726112647.6272-1-pbonzini@redhat.com>
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
index 153564db7980..f2876053e28b 100644
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
2.17.1


