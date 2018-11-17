Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAF3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DB820815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cikczi9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DB820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeKQVLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:11:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54845 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeKQVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:11:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so913127wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 02:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=12VOXCg3RYRVKjzmnyfmBkNN8gvpmJRnAHiRAJSefc0=;
        b=cikczi9saDF6rmDZVeteeoMPRMWifSht8/OhW8rouY7I/n8/wnNF/RWDgobErSGZc6
         pWSy58OFNxiCF9Xo0RJYsGJl9QkyDw0MH+aMbfN36546XptNtMII9XxZMFygGrS/3nLO
         E4RN7erxNkbwmMBGdeSgE4I/MSV/45bR9S0Ni4A8KqwQG6a5Q0v8zvEP+ait0Cf4OGbv
         n+toAuG0glumXezDx5wI1WtNEXAcHEePMkMARLCIV2cxhd2e8yLAAWt98Jovd+H5a1K1
         v/y3tPVtrkt3SC9Aw88jk6EdJgFoDGMxtNzblWAePLAjJElqZj3zLtpRsX8ogpCKowy2
         Gh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=12VOXCg3RYRVKjzmnyfmBkNN8gvpmJRnAHiRAJSefc0=;
        b=thOkOBIZdihjqpGt214Caydg0xdAud5dnxh0jn+CM16IE6vTicvrR/axRFgT6BgOX8
         e3/6MJJ9x5R6MCteN91yZ95/Y8WR8JaxbvvB9B/XHBaL2wEGhtWGsvipDRqC0lfTY+91
         ob/o9VZ0UV8Pr182u2+Hkg6c9ql8NiJM/0EZnDRXP8owrGhV0jBL49PkQyaJa76c4/FR
         BxePWhEzqPup0iZdwhUUYw9JZWr9BwXnacX8hlX/3PobsHbyrUvW4CAkncUkgCABjKYD
         V822KmU6CFm0ghFt/ka+oQxYKRVO4VyKmp+iWcg1eMlYTwpGgQYxqnot4f+Hwdy8UhZG
         JgOA==
X-Gm-Message-State: AGRZ1gK70dRjq6aAGYvFziriBHjE2hwNOgpktiwKpLP8cI1AIif11Nxy
        VeR+6hrspFM+NjL48mRsejU=
X-Google-Smtp-Source: AJdET5cJVeFgGjVKPVDEUd/84UTG0WZvoeO0riuwolIJkqFDtPKVCjEzxRSFZIHPIUWKQi1CRLFfig==
X-Received: by 2002:a7b:ca53:: with SMTP id m19-v6mr1226266wml.47.1542452121651;
        Sat, 17 Nov 2018 02:55:21 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l123-v6sm12249621wma.10.2018.11.17.02.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 02:55:21 -0800 (PST)
Date:   Sat, 17 Nov 2018 11:55:18 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20181117105518.GA14865@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 4d47d6407ac7b4b442a4e717488a3bb137398b6c perf/x86/intel/uncore: Support CoffeeLake 8th CBOX

Fix uncore PMU enumeration for CofeeLake CPUs.

 Thanks,

	Ingo

------------------>
Kan Liang (2):
      perf/x86/intel/uncore: Add more IMC PCI IDs for KabyLake and CoffeeLake CPUs
      perf/x86/intel/uncore: Support CoffeeLake 8th CBOX


 arch/x86/events/intel/uncore.h     |  33 +++++++---
 arch/x86/events/intel/uncore_snb.c | 121 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 144 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index e17ab885b1e9..cb46d602a6b8 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -129,8 +129,15 @@ struct intel_uncore_box {
 	struct intel_uncore_extra_reg shared_regs[0];
 };
 
-#define UNCORE_BOX_FLAG_INITIATED	0
-#define UNCORE_BOX_FLAG_CTL_OFFS8	1 /* event config registers are 8-byte apart */
+/* CFL uncore 8th cbox MSRs */
+#define CFL_UNC_CBO_7_PERFEVTSEL0		0xf70
+#define CFL_UNC_CBO_7_PER_CTR0			0xf76
+
+#define UNCORE_BOX_FLAG_INITIATED		0
+/* event config registers are 8-byte apart */
+#define UNCORE_BOX_FLAG_CTL_OFFS8		1
+/* CFL 8th CBOX has different MSR space */
+#define UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS	2
 
 struct uncore_event_desc {
 	struct kobj_attribute attr;
@@ -297,17 +304,27 @@ unsigned int uncore_freerunning_counter(struct intel_uncore_box *box,
 static inline
 unsigned uncore_msr_event_ctl(struct intel_uncore_box *box, int idx)
 {
-	return box->pmu->type->event_ctl +
-		(box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
-		uncore_msr_box_offset(box);
+	if (test_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags)) {
+		return CFL_UNC_CBO_7_PERFEVTSEL0 +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx);
+	} else {
+		return box->pmu->type->event_ctl +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
+		       uncore_msr_box_offset(box);
+	}
 }
 
 static inline
 unsigned uncore_msr_perf_ctr(struct intel_uncore_box *box, int idx)
 {
-	return box->pmu->type->perf_ctr +
-		(box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
-		uncore_msr_box_offset(box);
+	if (test_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags)) {
+		return CFL_UNC_CBO_7_PER_CTR0 +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx);
+	} else {
+		return box->pmu->type->perf_ctr +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
+		       uncore_msr_box_offset(box);
+	}
 }
 
 static inline
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 8527c3e1038b..2593b0d7aeee 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -15,6 +15,25 @@
 #define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC	0x1910
 #define PCI_DEVICE_ID_INTEL_SKL_SD_IMC	0x190f
 #define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC	0x191f
+#define PCI_DEVICE_ID_INTEL_KBL_Y_IMC	0x590c
+#define PCI_DEVICE_ID_INTEL_KBL_U_IMC	0x5904
+#define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC	0x5914
+#define PCI_DEVICE_ID_INTEL_KBL_SD_IMC	0x590f
+#define PCI_DEVICE_ID_INTEL_KBL_SQ_IMC	0x591f
+#define PCI_DEVICE_ID_INTEL_CFL_2U_IMC	0x3ecc
+#define PCI_DEVICE_ID_INTEL_CFL_4U_IMC	0x3ed0
+#define PCI_DEVICE_ID_INTEL_CFL_4H_IMC	0x3e10
+#define PCI_DEVICE_ID_INTEL_CFL_6H_IMC	0x3ec4
+#define PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC	0x3e0f
+#define PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC	0x3e1f
+#define PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC	0x3ec2
+#define PCI_DEVICE_ID_INTEL_CFL_8S_D_IMC	0x3e30
+#define PCI_DEVICE_ID_INTEL_CFL_4S_W_IMC	0x3e18
+#define PCI_DEVICE_ID_INTEL_CFL_6S_W_IMC	0x3ec6
+#define PCI_DEVICE_ID_INTEL_CFL_8S_W_IMC	0x3e31
+#define PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC	0x3e33
+#define PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC	0x3eca
+#define PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC	0x3e32
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -202,6 +221,10 @@ static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
 		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL,
 			SNB_UNC_GLOBAL_CTL_EN | SKL_UNC_GLOBAL_CTL_CORE_ALL);
 	}
+
+	/* The 8th CBOX has different MSR space */
+	if (box->pmu->pmu_idx == 7)
+		__set_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags);
 }
 
 static void skl_uncore_msr_enable_box(struct intel_uncore_box *box)
@@ -228,7 +251,7 @@ static struct intel_uncore_ops skl_uncore_msr_ops = {
 static struct intel_uncore_type skl_uncore_cbox = {
 	.name		= "cbox",
 	.num_counters   = 4,
-	.num_boxes	= 5,
+	.num_boxes	= 8,
 	.perf_ctr_bits	= 44,
 	.fixed_ctr_bits	= 48,
 	.perf_ctr	= SNB_UNC_CBO_0_PER_CTR0,
@@ -569,7 +592,82 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_SQ_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
-
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_Y_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_UQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SD_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4H_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6H_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_W_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_W_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_W_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -618,6 +716,25 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(SKL_HQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core H Quad Core */
 	IMC_DEV(SKL_SD_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Dual Core */
 	IMC_DEV(SKL_SQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Quad Core */
+	IMC_DEV(KBL_Y_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core Y */
+	IMC_DEV(KBL_U_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U */
+	IMC_DEV(KBL_UQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U Quad Core */
+	IMC_DEV(KBL_SD_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Dual Core */
+	IMC_DEV(KBL_SQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Quad Core */
+	IMC_DEV(CFL_2U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 2 Cores */
+	IMC_DEV(CFL_4U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 4 Cores */
+	IMC_DEV(CFL_4H_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core H 4 Cores */
+	IMC_DEV(CFL_6H_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core H 6 Cores */
+	IMC_DEV(CFL_2S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 2 Cores Desktop */
+	IMC_DEV(CFL_4S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Desktop */
+	IMC_DEV(CFL_6S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Desktop */
+	IMC_DEV(CFL_8S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Desktop */
+	IMC_DEV(CFL_4S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Work Station */
+	IMC_DEV(CFL_6S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Work Station */
+	IMC_DEV(CFL_8S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Work Station */
+	IMC_DEV(CFL_4S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Server */
+	IMC_DEV(CFL_6S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Server */
+	IMC_DEV(CFL_8S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Server */
 	{  /* end marker */ }
 };
 
