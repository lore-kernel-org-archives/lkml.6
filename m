Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeCYVEj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 17:04:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42660 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeCYVEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 17:04:32 -0400
X-Google-Smtp-Source: AG47ELt6q86V2vbrWzxIExALWKRNvA7AnzKnEF4jx81hbCNgNJZ/ABwUBbfCWNyXvsqPutFOThKWDg==
Date: Sun, 25 Mar 2018 14:04:30 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
cc: Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [patch] x86/apic: Finish removing unused callbacks
Message-ID: <alpine.DEB.2.20.1803251403540.80485@chino.kir.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->cpu_mask_to_apicid() and ->vector_allocation_domain() callbacks are
now unused, so remove them.

Fixes: baab1e84b112 ("x86/apic: Remove unused callbacks")
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/include/asm/apic.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
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
