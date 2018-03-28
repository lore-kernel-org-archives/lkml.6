Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeC1RqC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:46:02 -0400
Received: from relay2.sgi.com ([192.48.180.65]:48787 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752349AbeC1RqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:46:01 -0400
Message-Id: <20180328174011.041801248@stormcage.americas.sgi.com>
References: <20180328174010.882366342@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Wed, 28 Mar 2018 12:40:11 -0500
From: <mike.travis@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/platform/UV: Fix critical UV MMR address error
Content-Disposition: inline; filename=fix-gam-mmioh-config1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A critical error was found testing the fixed UV4 HUB in that an MMR
address was found to be incorrect.  This causes the virtual address
space for accessing the MMIOH1 region to be allocated with the
incorrect size.

Signed-off-by: Mike Travis <travis@sgi.com>
---
 arch/x86/include/asm/uv/uv_mmrs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-4.4.orig/arch/x86/include/asm/uv/uv_mmrs.h
+++ linux-4.4/arch/x86/include/asm/uv/uv_mmrs.h
@@ -3833,7 +3833,7 @@ union uvh_rh_gam_mmioh_overlay_config0_m
 #define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
 #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
 #define UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x1603000UL
-#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x483000UL
+#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x484000UL
 #define UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR (				\
 	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\

-- 
