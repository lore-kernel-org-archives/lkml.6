Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 16C4BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC419208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0mPA9Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC419208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936275AbeFNO5E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936192AbeFNOGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FA3208DA;
        Thu, 14 Jun 2018 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985162;
        bh=2SCwG76hya/qM4Bdh55BTWcujO8PAkyfOrRWm5KZIr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0mPA9MrsGL3tJuzaOhJuw5sNUACmopbqte5MGG1YLuHh9Mnr6nc4JLNRO0ZcjIT1
         b0ydYc9YwkpRiWj4rWQMfHfxQq30sUyC1fRIgUSTPkJoAVhaf1Z4QeaV4SFUDG5vsB
         aOYUFSdNZGfyONS68yX0whlF+7h/vaP/tcjsuzX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.17 05/45] kvm: fix typo in flag name
Date:   Thu, 14 Jun 2018 16:03:56 +0200
Message-Id: <20180614132127.064130332@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 766d3571d8e50d3a73b77043dc632226f9e6b389 upstream.

KVM_X86_DISABLE_EXITS_HTL really refers to exit on halt.
Obviously a typo: should be named KVM_X86_DISABLE_EXITS_HLT.

Fixes: caa057a2cad ("KVM: X86: Provide a capability to disable HLT intercepts")
Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c             |    4 ++--
 include/uapi/linux/kvm.h       |    4 ++--
 tools/include/uapi/linux/kvm.h |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2894,7 +2894,7 @@ int kvm_vm_ioctl_check_extension(struct
 		r = KVM_CLOCK_TSC_STABLE;
 		break;
 	case KVM_CAP_X86_DISABLE_EXITS:
-		r |=  KVM_X86_DISABLE_EXITS_HTL | KVM_X86_DISABLE_EXITS_PAUSE;
+		r |=  KVM_X86_DISABLE_EXITS_HLT | KVM_X86_DISABLE_EXITS_PAUSE;
 		if(kvm_can_mwait_in_guest())
 			r |= KVM_X86_DISABLE_EXITS_MWAIT;
 		break;
@@ -4248,7 +4248,7 @@ split_irqchip_unlock:
 		if ((cap->args[0] & KVM_X86_DISABLE_EXITS_MWAIT) &&
 			kvm_can_mwait_in_guest())
 			kvm->arch.mwait_in_guest = true;
-		if (cap->args[0] & KVM_X86_DISABLE_EXITS_HTL)
+		if (cap->args[0] & KVM_X86_DISABLE_EXITS_HLT)
 			kvm->arch.hlt_in_guest = true;
 		if (cap->args[0] & KVM_X86_DISABLE_EXITS_PAUSE)
 			kvm->arch.pause_in_guest = true;
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -677,10 +677,10 @@ struct kvm_ioeventfd {
 };
 
 #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
-#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
-                                              KVM_X86_DISABLE_EXITS_HTL | \
+                                              KVM_X86_DISABLE_EXITS_HLT | \
                                               KVM_X86_DISABLE_EXITS_PAUSE)
 
 /* for KVM_ENABLE_CAP */
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -677,10 +677,10 @@ struct kvm_ioeventfd {
 };
 
 #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
-#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
-                                              KVM_X86_DISABLE_EXITS_HTL | \
+                                              KVM_X86_DISABLE_EXITS_HLT | \
                                               KVM_X86_DISABLE_EXITS_PAUSE)
 
 /* for KVM_ENABLE_CAP */


