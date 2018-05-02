Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbeEBKyQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:54:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57070 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbeEBKyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:54:14 -0400
From: Valentin Schneider <valentin.schneider@arm.com>
To: linux-kernel@vger.kernel.org
Cc: kvmarm@lists.cs.columbia.edu, trivial@kernel.org,
        christoffer.dall@arm.com, marc.zyngier@arm.com
Subject: [PATCH 1/1] KVM: arm/arm64: vgic_init: Cleanup reference to process_maintenance
Date: Wed,  2 May 2018 11:53:03 +0100
Message-Id: <1525258383-14178-1-git-send-email-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One comment still mentioned process_maintenance operations after
commit af0614991ab6 ("KVM: arm/arm64: vgic: Get rid of unnecessary
process_maintenance operation") 

Update the comment to point to vgic_fold_lr_state instead, which
is where maintenance interrupts are taken care of.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 virt/kvm/arm/vgic/vgic-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 743ca5c..7f1a467 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -440,7 +440,7 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
 	 * We cannot rely on the vgic maintenance interrupt to be
 	 * delivered synchronously. This means we can only use it to
 	 * exit the VM, and we perform the handling of EOIed
-	 * interrupts on the exit path (see vgic_process_maintenance).
+	 * interrupts on the exit path (see vgic_fold_lr_state).
 	 */
 	return IRQ_HANDLED;
 }
--
2.7.4
