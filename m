Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeBYTOA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:14:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42968 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbeBYTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:13:56 -0500
Date: Sun, 25 Feb 2018 20:14:10 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] core updates for 4.16
Message-ID: <alpine.DEB.2.21.1802252004550.1468@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

A single commit removing a bunch of bogus double semicolons all over the
tree.

Thanks,

	tglx

------------------>
Ingo Molnar (1):
      treewide/trivial: Remove ';;$' typo noise


 arch/arc/kernel/setup.c                          | 2 +-
 arch/arc/kernel/unwind.c                         | 2 +-
 arch/arm/kernel/time.c                           | 2 +-
 arch/arm64/kernel/ptrace.c                       | 2 +-
 arch/powerpc/kvm/book3s_xive.c                   | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c        | 2 +-
 arch/x86/boot/compressed/eboot.c                 | 4 ++--
 block/sed-opal.c                                 | 2 +-
 drivers/clocksource/mips-gic-timer.c             | 4 ++--
 drivers/clocksource/timer-sun5i.c                | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c    | 2 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c          | 2 +-
 drivers/gpu/drm/scheduler/gpu_scheduler.c        | 2 +-
 drivers/iommu/intel-svm.c                        | 2 +-
 drivers/md/raid1.c                               | 2 +-
 drivers/soc/imx/gpc.c                            | 2 +-
 17 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 9d27331fe69a..ec12fe1c2f07 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -373,7 +373,7 @@ static void arc_chk_core_config(void)
 {
 	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
 	int saved = 0, present = 0;
-	char *opt_nm = NULL;;
+	char *opt_nm = NULL;
 
 	if (!cpu->extn.timer0)
 		panic("Timer0 is not present!\n");
diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 333daab7def0..183391d4d33a 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -366,7 +366,7 @@ static void init_unwind_hdr(struct unwind_table *table,
 	return;
 
 ret_err:
-	panic("Attention !!! Dwarf FDE parsing errors\n");;
+	panic("Attention !!! Dwarf FDE parsing errors\n");
 }
 
 #ifdef CONFIG_MODULES
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 629f8e9981f1..cf2701cb0de8 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -83,7 +83,7 @@ static void dummy_clock_access(struct timespec64 *ts)
 }
 
 static clock_access_fn __read_persistent_clock = dummy_clock_access;
-static clock_access_fn __read_boot_clock = dummy_clock_access;;
+static clock_access_fn __read_boot_clock = dummy_clock_access;
 
 void read_persistent_clock64(struct timespec64 *ts)
 {
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6618036ae6d4..9ae31f7e2243 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1419,7 +1419,7 @@ static int compat_ptrace_hbp_get(unsigned int note_type,
 	u64 addr = 0;
 	u32 ctrl = 0;
 
-	int err, idx = compat_ptrace_hbp_num_to_idx(num);;
+	int err, idx = compat_ptrace_hbp_num_to_idx(num);
 
 	if (num & 1) {
 		err = ptrace_hbp_get_addr(note_type, tsk, idx, &addr);
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index f0f5cd4d2fe7..f9818d7d3381 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -188,7 +188,7 @@ static int xive_provision_queue(struct kvm_vcpu *vcpu, u8 prio)
 	if (!qpage) {
 		pr_err("Failed to allocate queue %d for VCPU %d\n",
 		       prio, xc->server_num);
-		return -ENOMEM;;
+		return -ENOMEM;
 	}
 	memset(qpage, 0, 1 << xive->q_order);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 496e47696ed0..a6c92c78c9b2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1854,7 +1854,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 	s64 rc;
 
 	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
-		return -ENODEV;;
+		return -ENODEV;
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	if (pe->tce_bypass_enabled) {
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 353e20c3f114..886a9115af62 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -439,7 +439,7 @@ setup_uga32(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 	struct efi_uga_draw_protocol *uga = NULL, *first_uga;
 	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
-	u32 *handles = (u32 *)uga_handle;;
+	u32 *handles = (u32 *)uga_handle;
 	efi_status_t status = EFI_INVALID_PARAMETER;
 	int i;
 
@@ -484,7 +484,7 @@ setup_uga64(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 	struct efi_uga_draw_protocol *uga = NULL, *first_uga;
 	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
-	u64 *handles = (u64 *)uga_handle;;
+	u64 *handles = (u64 *)uga_handle;
 	efi_status_t status = EFI_INVALID_PARAMETER;
 	int i;
 
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9ed51d0c6b1d..e4929eec547f 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -490,7 +490,7 @@ static int opal_discovery0_end(struct opal_dev *dev)
 
 	if (!found_com_id) {
 		pr_debug("Could not find OPAL comid for device. Returning early\n");
-		return -EOPNOTSUPP;;
+		return -EOPNOTSUPP;
 	}
 
 	dev->comid = comid;
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index a04808a21d4e..65e18c86d9b9 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -205,12 +205,12 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	} else if (of_property_read_u32(node, "clock-frequency",
 					&gic_frequency)) {
 		pr_err("GIC frequency not specified.\n");
-		return -EINVAL;;
+		return -EINVAL;
 	}
 	gic_timer_irq = irq_of_parse_and_map(node, 0);
 	if (!gic_timer_irq) {
 		pr_err("GIC timer IRQ not specified.\n");
-		return -EINVAL;;
+		return -EINVAL;
 	}
 
 	ret = __gic_clocksource_init();
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 2a3fe83ec337..3b56ea3f52af 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -334,7 +334,7 @@ static int __init sun5i_timer_init(struct device_node *node)
 	timer_base = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(timer_base)) {
 		pr_err("Can't map registers\n");
-		return PTR_ERR(timer_base);;
+		return PTR_ERR(timer_base);
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 61e8c3e02d16..33d91e4474ea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -718,7 +718,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 	uint32_t retries_ch_eq;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_align_status_updated dpcd_lane_status_updated = {{0}};
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {{{0}}};;
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {{{0}}};
 
 	hw_tr_pattern = get_supported_tp(link);
 
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 4c3223a4d62b..adb6e7b9280c 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -162,7 +162,7 @@ static int pp_hw_init(void *handle)
 		if(hwmgr->smumgr_funcs->start_smu(pp_handle->hwmgr)) {
 			pr_err("smc start failed\n");
 			hwmgr->smumgr_funcs->smu_fini(pp_handle->hwmgr);
-			return -EINVAL;;
+			return -EINVAL;
 		}
 		if (ret == PP_DPM_DISABLED)
 			goto exit;
diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
index 3e9bba4d6624..6d8e3a9a6fc0 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
@@ -680,7 +680,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
 	} else {
 		dev_info(&pdev->dev,
 			 "no iommu, fallback to phys contig buffers for scanout\n");
-		aspace = NULL;;
+		aspace = NULL;
 	}
 
 	pm_runtime_put_sync(&pdev->dev);
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
index 2c18996d59c5..0d95888ccc3e 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
@@ -461,7 +461,7 @@ void drm_sched_hw_job_reset(struct drm_gpu_scheduler *sched, struct drm_sched_jo
 {
 	struct drm_sched_job *s_job;
 	struct drm_sched_entity *entity, *tmp;
-	int i;;
+	int i;
 
 	spin_lock(&sched->job_list_lock);
 	list_for_each_entry_reverse(s_job, &sched->ring_mirror_list, node) {
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 35a408d0ae4f..99bc9bd64b9e 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -205,7 +205,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 			 * for example, an "address" value of 0x12345f000 will
 			 * flush from 0x123440000 to 0x12347ffff (256KiB). */
 			unsigned long last = address + ((unsigned long)(pages - 1) << VTD_PAGE_SHIFT);
-			unsigned long mask = __rounddown_pow_of_two(address ^ last);;
+			unsigned long mask = __rounddown_pow_of_two(address ^ last);
 
 			desc.high = QI_DEV_EIOTLB_ADDR((address & ~mask) | (mask - 1)) | QI_DEV_EIOTLB_SIZE;
 		} else {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index b2eae332e1a2..f978eddc7a21 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1108,7 +1108,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 
 	bio_copy_data(behind_bio, bio);
 skip_copy:
-	r1_bio->behind_master_bio = behind_bio;;
+	r1_bio->behind_master_bio = behind_bio;
 	set_bit(R1BIO_BehindIO, &r1_bio->state);
 
 	return;
diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 53f7275d6cbd..cfb42f5eccb2 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -348,7 +348,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 		if (i == 1) {
 			domain->supply = devm_regulator_get(dev, "pu");
 			if (IS_ERR(domain->supply))
-				return PTR_ERR(domain->supply);;
+				return PTR_ERR(domain->supply);
 
 			ret = imx_pgc_get_clocks(dev, domain);
 			if (ret)
