Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165785AbeE1Odw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161516AbeE1Kcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:32:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 141/329] kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds
Date: Mon, 28 May 2018 12:01:10 +0200
Message-Id: <20180528100254.320331925@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

[ Upstream commit 076467490b8176eb96eddc548a14d4135c7b5852 ]

Move the kvm_arch_irq_routing_update() prototype outside of
ifdef CONFIG_HAVE_KVM_EVENTFD guards to fix the following sparse warning:

arch/s390/kvm/../../../virt/kvm/irqchip.c:171:28: warning: symbol 'kvm_arch_irq_routing_update' was not declared. Should it be static?

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kvm_host.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1070,7 +1070,6 @@ static inline void kvm_irq_routing_updat
 {
 }
 #endif
-void kvm_arch_irq_routing_update(struct kvm *kvm);
 
 static inline int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 {
@@ -1079,6 +1078,8 @@ static inline int kvm_ioeventfd(struct k
 
 #endif /* CONFIG_HAVE_KVM_EVENTFD */
 
+void kvm_arch_irq_routing_update(struct kvm *kvm);
+
 static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
 {
 	/*
