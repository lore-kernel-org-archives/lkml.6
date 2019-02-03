Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F72C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527F62084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfBCOZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:25:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55662 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730319AbfBCOVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:04 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdq-0006O3-OT; Sun, 03 Feb 2019 14:21:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9u-0007Rr-LG; Sun, 03 Feb 2019 14:50:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Ladi Prosek" <lprosek@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.327775223@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 293/305] KVM: x86: Add MSR_AMD64_DC_CFG to the list
 of ignored MSRs
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ladi Prosek <lprosek@redhat.com>

commit 405a353a0e20d09090ad96147da6afad9b0ce056 upstream.

Hyper-V writes 0x800000000000 to MSR_AMD64_DC_CFG when running on AMD CPUs
as recommended in erratum 383, analogous to our svm_init_erratum_383.

By ignoring the MSR, this patch enables running Hyper-V in L1 on AMD.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2085,6 +2085,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
 	case MSR_VM_HSAVE_PA:
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
+	case MSR_AMD64_DC_CFG:
 		break;
 
 	case MSR_EFER:
@@ -2462,6 +2463,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_FAM10H_MMIO_CONF_BASE:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
+	case MSR_AMD64_DC_CFG:
 		msr_info->data = 0;
 		break;
 	case MSR_P6_PERFCTR0:

