Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCZH6O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:58:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeCZH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:58:13 -0400
Date: Mon, 26 Mar 2018 00:57:46 -0700
From: tip-bot for David Rientjes <tipbot@zytor.com>
Message-ID: <tip-e25283bf83bd97a61007ab383695f4872e2eb43f@git.kernel.org>
Cc: jgross@suse.com, mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        rientjes@google.com, linux-kernel@vger.kernel.org
Reply-To: jgross@suse.com, hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, peterz@infradead.org,
        rientjes@google.com, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.20.1803251403540.80485@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803251403540.80485@chino.kir.corp.google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Finish removing unused callbacks
Git-Commit-ID: e25283bf83bd97a61007ab383695f4872e2eb43f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e25283bf83bd97a61007ab383695f4872e2eb43f
Gitweb:     https://git.kernel.org/tip/e25283bf83bd97a61007ab383695f4872e2eb43f
Author:     David Rientjes <rientjes@google.com>
AuthorDate: Sun, 25 Mar 2018 14:04:30 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 26 Mar 2018 08:49:38 +0200

x86/apic: Finish removing unused callbacks

The ->cpu_mask_to_apicid() and ->vector_allocation_domain() callbacks are
now unused, so remove them.

Signed-off-by: David Rientjes <rientjes@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: baab1e84b112 ("x86/apic: Remove unused callbacks")
Link: http://lkml.kernel.org/r/alpine.DEB.2.20.1803251403540.80485@chino.kir.corp.google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/apic.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index c6a32019ff54..40a3d3642f3a 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -304,12 +304,6 @@ struct apic {
 	u32	irq_delivery_mode;
 	u32	irq_dest_mode;
 
-	/* Functions and data related to vector allocation */
-	void	(*vector_allocation_domain)(int cpu, struct cpumask *retmask,
-					    const struct cpumask *mask);
-	int	(*cpu_mask_to_apicid)(const struct cpumask *cpumask,
-				      struct irq_data *irqdata,
-				      unsigned int *apicid);
 	u32	(*calc_dest_apicid)(unsigned int cpu);
 
 	/* ICR related functions */
@@ -499,17 +493,7 @@ extern void default_setup_apic_routing(void);
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 
-extern int flat_cpu_mask_to_apicid(const struct cpumask *cpumask,
-				   struct irq_data *irqdata,
-				   unsigned int *apicid);
-extern int default_cpu_mask_to_apicid(const struct cpumask *cpumask,
-				      struct irq_data *irqdata,
-				      unsigned int *apicid);
 extern bool default_check_apicid_used(physid_mask_t *map, int apicid);
-extern void flat_vector_allocation_domain(int cpu, struct cpumask *retmask,
-				   const struct cpumask *mask);
-extern void default_vector_allocation_domain(int cpu, struct cpumask *retmask,
-				      const struct cpumask *mask);
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern int default_cpu_present_to_apicid(int mps_cpu);
 extern int default_check_phys_apicid_present(int phys_apicid);
