Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B549CC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781A021470
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm2sWbFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781A021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeJMWdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:33:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37124 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeJMWdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:33:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id u6-v6so4524253plz.4;
        Sat, 13 Oct 2018 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=byTks6Uml08Lo+qLgYsZ5PYGqWDLW22IQ+rNseBWblk=;
        b=Jm2sWbFhTSLnXc8wJHNiDD4qKyZ9uTfBBfLKLhsDQanJKmPIOxpJPHRuCI0Y8w0fiq
         Hj6CTbNDDvo4EQSJkU6qtmtc2uPSbj1sGRIHF9wCrMVRN4sjzuQtmrTiiuOtrrRjVa9R
         3f/RfTGGpHpeCu+S9S6db0MHOIIJZ9nTvxiNxqDtqq/SH04gPlCs/08fbYYVDiP8+Ynv
         cXm+KvUiXXVYqJmf/qvnfRWAfEaVV+xKvj3QgP+qiVHUEUJZKe7LHnmiCNF5w3HDKtMB
         /3g43znyWaIv4R1bN2fW5bzgR4KuOS9xSw4IJrWZbMv5mkY/+lzpZ7WzJhIipjQm0W7F
         +bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=byTks6Uml08Lo+qLgYsZ5PYGqWDLW22IQ+rNseBWblk=;
        b=F8A4zcX90tM6wq6JNpJM4YWWKWC3cfz6fnl3NBcRUbjI9aoogWtWJMmwGUljswM2Dl
         M1nXn6BhG54eyOiJOtTad4k/lhkeH/L7I98bXd1+CYtq1Gvh2kWKsd155t3RJBSwU3b0
         P7Qkm4BZMxIZjSkaxv3+jfA8l1UxrqXLniDR9jiAC4TX0LOxtYJkUalzl+BLiNRUQd8D
         LgMuIMQNyRy1rQXthVNgZoM4jG2/YBtr8SKkvG+RAhDh8AXU6r1HM9bfsTOstz4lwvM3
         92QM5o7cmCgvSNmFLkQ9G9IKwyTXvefSS7sFkXBVCcM6tMAiUYRhzGnjUPP7KZLf3v/d
         uqSA==
X-Gm-Message-State: ABuFfojmcm7JHTjbiCcD2hSAYEw+00dlfsk4yHmI+fH4/0SA8028XqFK
        Ni/7fDwnFum2tcoJ7D4Exrg=
X-Google-Smtp-Source: ACcGV60nYZslKlVtd7hgQT0HDfZDEb1RqNOgenH/UTeUu9CMKkGOcsHfyItf+f1kDIeXkAFH7qa+xQ==
X-Received: by 2002:a17:902:5a8b:: with SMTP id r11-v6mr10429812pli.305.1539442539565;
        Sat, 13 Oct 2018 07:55:39 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:38 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V4 14/15] KVM/VMX: Change hv flush logic when ept tables are mismatched.
Date:   Sat, 13 Oct 2018 22:54:05 +0800
Message-Id: <20181013145406.4911-15-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

If ept table pointers are mismatched, flushing tlb for each vcpus via
hv flush interface still helps to reduce vmexits which are triggered
by IPI and INEPT emulation.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6f44d3a63434..8ff13f3aed11 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1571,7 +1571,8 @@ static void check_ept_pointer_match(struct kvm *kvm)
 
 static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 {
-	int ret;
+	struct kvm_vcpu *vcpu;
+	int ret = -ENOTSUPP, i;
 
 	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 
@@ -1579,14 +1580,14 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 		check_ept_pointer_match(kvm);
 
 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
-		ret = -ENOTSUPP;
-		goto out;
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			ret |= hyperv_flush_guest_mapping(
+				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer);
+	} else {
+		ret = hyperv_flush_guest_mapping(
+				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
 	}
 
-	ret = hyperv_flush_guest_mapping(
-			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
-
-out:
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 	return ret;
 }
-- 
2.14.4

