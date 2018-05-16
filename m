Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeEPPYg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:24:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750772AbeEPPVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:21:39 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] x86/hyperv: fix typo in 'HV_GENERIC_SET_SPARCE_4K' definition
Date: Wed, 16 May 2018 17:21:25 +0200
Message-Id: <20180516152131.30689-3-vkuznets@redhat.com>
In-Reply-To: <20180516152131.30689-1-vkuznets@redhat.com>
References: <20180516152131.30689-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should really be HV_GENERIC_SET_SPARSE_4K.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/mmu.c              | 2 +-
 arch/x86/include/asm/hyperv-tlfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 528a1f34df96..6cd3a08bb449 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -219,7 +219,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.valid_bank_mask = 0;
 
 	if (!cpumask_equal(cpus, cpu_present_mask)) {
-		flush->hv_vp_set.format = HV_GENERIC_SET_SPARCE_4K;
+		flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 		nr_bank = cpumask_to_vp_set(flush, cpus);
 	}
 
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 3d4ce3935a62..c69891e721b6 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -363,7 +363,7 @@ struct hv_tsc_emulation_status {
 #define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
 
 enum HV_GENERIC_SET_FORMAT {
-	HV_GENERIC_SET_SPARCE_4K,
+	HV_GENERIC_SET_SPARSE_4K,
 	HV_GENERIC_SET_ALL,
 };
 
-- 
2.14.3
