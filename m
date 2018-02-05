Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753978AbeBESu3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:50:29 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18534 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753835AbeBESuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:50:05 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="593308251"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 12/12] KVM/VMX: Remove kvm_vcpu_gpa_to_page as it is now unused
Date: Mon,  5 Feb 2018 19:47:31 +0100
Message-Id: <1517856451-2932-13-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 include/linux/kvm_host.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 45d2854..44db14a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1008,12 +1008,6 @@ static inline bool kvm_vcpu_gpa_to_host_mapping(struct kvm_vcpu *vcpu, gpa_t gpa
 					    kernel_access);
 }
 
-static inline struct page *kvm_vcpu_gpa_to_page(struct kvm_vcpu *vcpu,
-						gpa_t gpa)
-{
-	return kvm_vcpu_gfn_to_page(vcpu, gpa_to_gfn(gpa));
-}
-
 static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
 {
 	unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
-- 
2.7.4
