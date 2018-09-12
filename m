Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07948C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3978D204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV2ZfDZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3978D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeIMBMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:12:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39709 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMBMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:12:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so3322356wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k7/r1/F/sP6E9d/A3Tvp/VrKcto0InhSTpMYtnmQYMY=;
        b=pV2ZfDZA4LJ7VbuLQG41tJ9L4OvHIuni0YYOl3cWlaJ638ziNxyWc/6Ym1nxx3x2j/
         nEmMDoG5Fy2IxtX8MXV/G9TNGaIZ9MY/k62HyhEFZBU9bLXYBgB6k6e26rrR3d6V7jjZ
         8LELh2DL00TIFOuLY5M33ppT7VXx62pxF/e0MnreUQfsh2i8tp85P8/uaGkxHR3JIEoX
         bsWDgMNpngnkK7kdp/UigU7LWPn4DccTOZnSP7xKPGMq4uBqxSkX6j8NjEMSDeukV/QA
         QWDxWg0fG9ULJOZNUSyAmXbNL9Pm3e3bMPKZ5jmxjVjVcySX2vJ31q07y60u4fxSRk6s
         P+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k7/r1/F/sP6E9d/A3Tvp/VrKcto0InhSTpMYtnmQYMY=;
        b=RNHC6Oad77Vwk4MqgLxjIAhjHREW8zoT04r3TA8OnlMwh3oKPc24i37W9abCWwxMO8
         gk+wOU0zPEDtlTLQDwH6q25ABIjO4+uFLMbhAxeTMU6WtE6M580nn3yqRjmSzcqSbKgr
         RUZhkBOH4z3/NFmIAbepwX2mSh6Iog6TxQjq+nfbw+R8lIWgJRh5fhWPmUzTRqP+5wmR
         snlLNZ9IRYCfAg2cgcEsOhwYNMNqYG2qmTqhYBvZJ7A9SnF4mN9QNSVyrHLBzX3Bmpwi
         dlH/FBBZIgpJ0wG+6IAEcuKMVogjhs6idVvzCKNifVAG7jiKqOIEP/UDpENhbtiv647X
         dweA==
X-Gm-Message-State: APzg51AA72FzDBUOHtwQAZKCZSohtvi9bBgKYR4BAzCYpq0KU95j+6DG
        xrEUHhJxmjYunwjC2dTkHFg=
X-Google-Smtp-Source: ANB0VdbpkkjC2+4pKnWr+yexha/37LUbP0j67Tgzqj9Ul16Nu1LT0bjscLk+1hbFl/6O9akVUdn9mw==
X-Received: by 2002:a5d:4fc3:: with SMTP id h3-v6mr2792795wrw.261.1536782774969;
        Wed, 12 Sep 2018 13:06:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z11-v6sm1986664wrm.94.2018.09.12.13.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 13:06:14 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] drm/amd: Properly initialize all subobjects in structures
Date:   Wed, 12 Sep 2018 13:05:58 -0700
Message-Id: <20180912200558.7899-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns if there are missing braces around a subobject
initializer. Adding these braces only initializes the first
subobject; an empty set of braces initializes the structure
and all of its subobjects.

drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
around initialization of subobject [-Wmissing-braces]
                struct amdgpu_task_info task_info = { 0 };
                                                      ^
                                                      {}
1 warning generated.

drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
around initialization of subobject [-Wmissing-braces]
                struct amdgpu_task_info task_info = { 0 };
                                                      ^
                                                      {}
1 warning generated.

The warnings above are the only ones of this type in drm/amd but do
this conversion for all instances of this idiom for consistency (also
used by several other locations in the kernel tree).

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Use empty braces for initialization as suggested by Nick
* Convert all users of the sets of braces + 0 idiom to single set of
  empty braces as suggested by Alex

If this patchset is too large or incorrectly done, please let me know.
Seemed like a logical thing to do in one patch but I'm happy to break it
down.

Thanks,
Nathan

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c           |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  8 +--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  8 +--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  4 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 14 ++---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  4 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    | 10 ++--
 .../amd/display/dc/bios/bios_parser_common.c  |  2 +-
 .../drm/amd/display/dc/bios/command_table.c   | 22 ++++----
 .../drm/amd/display/dc/bios/command_table2.c  | 12 ++---
 .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  |  4 +-
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  | 10 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 25 +++++----
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 52 +++++++++----------
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 ++---
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  2 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c | 12 ++---
 .../gpu/drm/amd/display/dc/dce/dce_clocks.c   | 14 ++---
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 16 +++---
 .../amd/display/dc/dce/dce_stream_encoder.c   |  8 +--
 .../drm/amd/display/dc/dce/dce_transform.c    |  2 +-
 .../amd/display/dc/dce100/dce100_resource.c   |  2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 22 ++++----
 .../amd/display/dc/dce110/dce110_resource.c   |  6 +--
 .../display/dc/dce110/dce110_transform_v.c    |  6 +--
 .../amd/display/dc/dce112/dce112_resource.c   | 10 ++--
 .../amd/display/dc/dce120/dce120_resource.c   |  6 +--
 .../drm/amd/display/dc/dce80/dce80_resource.c |  6 +--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 22 ++++----
 .../amd/display/dc/dcn10/dcn10_link_encoder.c | 16 +++---
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  8 +--
 .../gpu/drm/amd/display/dc/i2caux/i2caux.c    |  6 +--
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h |  2 +-
 .../amd/display/modules/freesync/freesync.c   |  6 +--
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c |  2 +-
 .../gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  2 +-
 .../gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c  |  4 +-
 .../drm/amd/powerplay/hwmgr/vega10_hwmgr.c    | 10 ++--
 .../drm/amd/powerplay/hwmgr/vega12_hwmgr.c    |  2 +-
 .../gpu/drm/amd/powerplay/smumgr/ci_smumgr.c  |  2 +-
 .../drm/amd/powerplay/smumgr/iceland_smumgr.c |  2 +-
 .../amd/powerplay/smumgr/polaris10_smumgr.c   | 10 ++--
 .../drm/amd/powerplay/smumgr/smu7_smumgr.c    |  6 +--
 .../drm/amd/powerplay/smumgr/smu8_smumgr.c    |  4 +-
 .../drm/amd/powerplay/smumgr/vega10_smumgr.c  |  2 +-
 .../drm/amd/powerplay/smumgr/vega12_smumgr.c  |  2 +-
 .../drm/amd/powerplay/smumgr/vegam_smumgr.c   | 10 ++--
 65 files changed, 241 insertions(+), 242 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 353993218f21..55aeaa6b547f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -219,7 +219,7 @@ static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
 static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
 {
 	acpi_handle handle = NULL;
-	char acpi_method_name[255] = { 0 };
+	char acpi_method_name[255] = {};
 	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
 	acpi_status status;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index a028661d9e20..6c74ffcfc218 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -604,7 +604,7 @@ static void amdgpu_atpx_get_quirks(struct pci_dev *pdev)
  */
 static bool amdgpu_atpx_detect(void)
 {
-	char acpi_method_name[255] = { 0 };
+	char acpi_method_name[255] = {};
 	struct acpi_buffer buffer = {sizeof(acpi_method_name), acpi_method_name};
 	struct pci_dev *pdev = NULL;
 	bool has_atpx = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index a5df80d50d44..6f72605c9ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -151,7 +151,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
 
 static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 {
-	u8 header[AMD_VBIOS_SIGNATURE_END+1] = {0};
+	u8 header[AMD_VBIOS_SIGNATURE_END+1] = {};
 	int len;
 
 	if (!adev->asic_funcs->read_bios_from_rom)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 693ec5ea4950..b8f9090cbae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -237,7 +237,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		info->fw_version = amdgpu_get_firmware_version(cgs_device, type);
 		info->feature_version = (uint16_t)le32_to_cpu(header->ucode_feature_version);
 	} else {
-		char fw_name[30] = {0};
+		char fw_name[30] = {};
 		int err = 0;
 		uint32_t ucode_size;
 		uint32_t ucode_start_address;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 78ab939ae5d8..37a4c192f7ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1233,7 +1233,7 @@ static void kv_restore_regs_for_reset(struct amdgpu_device *adev,
 
 static int cik_gpu_pci_config_reset(struct amdgpu_device *adev)
 {
-	struct kv_reset_save_regs kv_save = { 0 };
+	struct kv_reset_save_regs kv_save = {};
 	u32 i;
 	int r = -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ef00d14f8645..5b0a1b06aa07 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4196,7 +4196,7 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
 
 static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
 {
-	struct v9_ce_ib_state ce_payload = {0};
+	struct v9_ce_ib_state ce_payload = {};
 	uint64_t csa_addr;
 	int cnt;
 
@@ -4215,7 +4215,7 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
 
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
 {
-	struct v9_de_ib_state de_payload = {0};
+	struct v9_de_ib_state de_payload = {};
 	uint64_t csa_addr, gds_addr;
 	int cnt;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9333109b210d..8db247d58cd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info = { 0 };
+		struct amdgpu_task_info task_info = {};
 
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 72f8018fa2a8..18fd6f53fcb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info = { 0 };
+		struct amdgpu_task_info task_info = {};
 
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index 1de96995e690..7ac372318b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -4785,7 +4785,7 @@ static int si_do_program_memory_timing_parameters(struct amdgpu_device *adev,
 {
 	struct si_power_info *si_pi = si_get_pi(adev);
 	struct  si_ps *state = si_get_ps(amdgpu_state);
-	SMC_SIslands_MCArbDramTimingRegisterSet arb_regs = { 0 };
+	SMC_SIslands_MCArbDramTimingRegisterSet arb_regs = {};
 	int i, ret = 0;
 
 	for (i = 0; i < state->performance_level_count; i++) {
@@ -5124,7 +5124,7 @@ static int si_program_ulv_memory_timing_parameters(struct amdgpu_device *adev)
 {
 	struct si_power_info *si_pi = si_get_pi(adev);
 	struct si_ulv_param *ulv = &si_pi->ulv;
-	SMC_SIslands_MCArbDramTimingRegisterSet arb_regs = { 0 };
+	SMC_SIslands_MCArbDramTimingRegisterSet arb_regs = {};
 	int ret;
 
 	ret = si_populate_memory_timing_parameters(adev, &ulv->pl,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 9b7f8469bc5c..848686569c5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -767,10 +767,10 @@ static int uvd_v7_0_sriov_start(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	uint32_t offset, size, tmp;
 	uint32_t table_size = 0;
-	struct mmsch_v1_0_cmd_direct_write direct_wt = { {0} };
-	struct mmsch_v1_0_cmd_direct_read_modify_write direct_rd_mod_wt = { {0} };
-	struct mmsch_v1_0_cmd_direct_polling direct_poll = { {0} };
-	struct mmsch_v1_0_cmd_end end = { {0} };
+	struct mmsch_v1_0_cmd_direct_write direct_wt = {};
+	struct mmsch_v1_0_cmd_direct_read_modify_write direct_rd_mod_wt = {};
+	struct mmsch_v1_0_cmd_direct_polling direct_poll = {};
+	struct mmsch_v1_0_cmd_end end = {};
 	uint32_t *init_table = adev->virt.mm_table.cpu_addr;
 	struct mmsch_v1_0_init_header *header = (struct mmsch_v1_0_init_header *)init_table;
 	uint8_t i = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 2e4d1b5f6243..bc7f857a5e62 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -206,10 +206,10 @@ static int vce_v4_0_sriov_start(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	uint32_t offset, size;
 	uint32_t table_size = 0;
-	struct mmsch_v1_0_cmd_direct_write direct_wt = { { 0 } };
-	struct mmsch_v1_0_cmd_direct_read_modify_write direct_rd_mod_wt = { { 0 } };
-	struct mmsch_v1_0_cmd_direct_polling direct_poll = { { 0 } };
-	struct mmsch_v1_0_cmd_end end = { { 0 } };
+	struct mmsch_v1_0_cmd_direct_write direct_wt = {};
+	struct mmsch_v1_0_cmd_direct_read_modify_write direct_rd_mod_wt = {};
+	struct mmsch_v1_0_cmd_direct_polling direct_poll = {};
+	struct mmsch_v1_0_cmd_end end = {};
 	uint32_t *init_table = adev->virt.mm_table.cpu_addr;
 	struct mmsch_v1_0_init_header *header = (struct mmsch_v1_0_init_header *)init_table;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index f836897bbf58..73510063383e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -86,7 +86,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		kfd_signal_hw_exception_event(pasid);
 	else if (client_id == SOC15_IH_CLIENTID_VMC ||
 		 client_id == SOC15_IH_CLIENTID_UTCL2) {
-		struct kfd_vm_fault_info info = {0};
+		struct kfd_vm_fault_info info = {};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
 
 		info.vmid = vmid;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 3bc25ab84f34..468aeaddd32d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -54,7 +54,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		uint32_t *se_mask)
 {
 	struct kfd_cu_info cu_info;
-	uint32_t cu_per_sh[4] = {0};
+	uint32_t cu_per_sh[4] = {};
 	int i, se, cu = 0;
 
 	mm->dev->kfd2kgd->get_cu_info(mm->dev->kgd, &cu_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 47243165a082..ea1866d87f72 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -45,7 +45,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q)
 {
 	struct cik_mqd *m;
-	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
+	uint32_t se_mask[4] = {}; /* 4 is the max # of SEs */
 
 	if (q->cu_mask_count == 0)
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index f5fc3675f21e..fa0633eadbb3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -45,7 +45,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q)
 {
 	struct v9_mqd *m;
-	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
+	uint32_t se_mask[4] = {}; /* 4 is the max # of SEs */
 
 	if (q->cu_mask_count == 0)
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index b81fda3754da..488e2ff76a5c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -47,7 +47,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q)
 {
 	struct vi_mqd *m;
-	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
+	uint32_t se_mask[4] = {}; /* 4 is the max # of SEs */
 
 	if (q->cu_mask_count == 0)
 		return;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index af6adffba788..5f5d819d3300 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -952,7 +952,7 @@ static void handle_hpd_irq(void *param)
 
 static void dm_handle_hpd_rx_irq(struct amdgpu_dm_connector *aconnector)
 {
-	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
+	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = {};
 	uint8_t dret;
 	bool new_irq_handled = false;
 	int dpcd_addr;
@@ -1077,7 +1077,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 	struct drm_connector *connector;
 	struct amdgpu_dm_connector *aconnector;
 	const struct dc_link *dc_link;
-	struct dc_interrupt_params int_params = {0};
+	struct dc_interrupt_params int_params = {};
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
@@ -1115,7 +1115,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 {
 	struct dc *dc = adev->dm.dc;
 	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
+	struct dc_interrupt_params int_params = {};
 	int r;
 	int i;
 	unsigned client_id = AMDGPU_IH_CLIENTID_LEGACY;
@@ -1202,7 +1202,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 {
 	struct dc *dc = adev->dm.dc;
 	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
+	struct dc_interrupt_params int_params = {};
 	int r;
 	int i;
 
@@ -1341,7 +1341,7 @@ static void
 amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
 {
 	char bl_name[16];
-	struct backlight_properties props = { 0 };
+	struct backlight_properties props = {};
 
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.brightness = AMDGPU_MAX_BL_LEVEL;
@@ -2038,8 +2038,8 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
 {
 	enum amdgpu_rmx_type rmx_type;
 
-	struct rect src = { 0 }; /* viewport in composition space*/
-	struct rect dst = { 0 }; /* stream addressable area */
+	struct rect src = {}; /* viewport in composition space*/
+	struct rect dst = {}; /* stream addressable area */
 
 	/* no mode. nothing to be done */
 	if (!mode)
@@ -2350,7 +2350,7 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 static struct dc_sink *
 create_fake_sink(struct amdgpu_dm_connector *aconnector)
 {
-	struct dc_sink_init_data sink_init_data = { 0 };
+	struct dc_sink_init_data sink_init_data = {};
 	struct dc_sink *sink = NULL;
 	sink_init_data.link = aconnector->dc_link;
 	sink_init_data.sink_signal = aconnector->dc_link->connector_signal;
@@ -3932,9 +3932,9 @@ static void amdgpu_dm_do_flip(struct drm_crtc *crtc,
 	struct amdgpu_bo *abo = gem_to_amdgpu_bo(fb->obj[0]);
 	struct amdgpu_device *adev = crtc->dev->dev_private;
 	bool async_flip = (crtc->state->pageflip_flags & DRM_MODE_PAGE_FLIP_ASYNC) != 0;
-	struct dc_flip_addrs addr = { {0} };
+	struct dc_flip_addrs addr = {};
 	/* TODO eliminate or rename surface_update */
-	struct dc_surface_update surface_updates[1] = { {0} };
+	struct dc_surface_update surface_updates[1] = {};
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
 
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 8403b6a9a77b..b79d70db4bbd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -519,8 +519,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
 				edid_status,
 				aconnector->base.name);
 	if (link->aux_mode) {
-		union test_request test_request = { {0} };
-		union test_response test_response = { {0} };
+		union test_request test_request = {};
+		union test_response test_response = {};
 
 		dm_helpers_dp_read_dpcd(ctx,
 					link,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 18a3a6e5ffa0..c8d4cfbc261d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -42,7 +42,7 @@
 
 static inline char *side_band_msg_type_to_str(uint32_t address)
 {
-	static char str[10] = {0};
+	static char str[10] = {};
 
 	if (address < DP_SIDEBAND_MSG_UP_REP_BASE)
 		strcpy(str, "DOWN_REQ");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 4ba0003a9d32..116b26c78983 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -306,8 +306,8 @@ bool dm_pp_get_clock_levels_by_type(
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct amd_pp_clocks pp_clks = { 0 };
-	struct amd_pp_simple_clock_info validation_clks = { 0 };
+	struct amd_pp_clocks pp_clks = {};
+	struct amd_pp_simple_clock_info validation_clks = {};
 	uint32_t i;
 
 	if (adev->powerplay.pp_funcs->get_clock_by_type) {
@@ -378,7 +378,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct pp_clock_levels_with_latency pp_clks = { 0 };
+	struct pp_clock_levels_with_latency pp_clks = {};
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
 	if (!pp_funcs || !pp_funcs->get_clock_by_type_with_latency)
@@ -401,7 +401,7 @@ bool dm_pp_get_clock_levels_by_type_with_voltage(
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct pp_clock_levels_with_voltage pp_clk_info = {0};
+	struct pp_clock_levels_with_voltage pp_clk_info = {};
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
 	if (pp_funcs->get_clock_by_type_with_voltage(pp_handle,
@@ -435,7 +435,7 @@ bool dm_pp_apply_clock_for_voltage_request(
 	struct dm_pp_clock_for_voltage_req *clock_for_voltage_req)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct pp_display_clock_request pp_clock_request = {0};
+	struct pp_display_clock_request pp_clock_request = {};
 	int ret = 0;
 
 	pp_clock_request.clock_type = dc_to_pp_clock_type(clock_for_voltage_req->clk_type);
@@ -458,7 +458,7 @@ bool dm_pp_get_static_clocks(
 	struct dm_pp_static_clock_info *static_clk_info)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct amd_pp_clock_info pp_clk_info = {0};
+	struct amd_pp_clock_info pp_clk_info = {};
 	int ret = 0;
 
 	if (adev->powerplay.pp_funcs->get_current_clocks)
@@ -482,7 +482,7 @@ void pp_rv_set_display_requirement(struct pp_smu *pp,
 	struct amdgpu_device *adev = ctx->driver_context;
 	void *pp_handle = adev->powerplay.pp_handle;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	struct pp_display_clock_request clock = {0};
+	struct pp_display_clock_request clock = {};
 
 	if (!pp_funcs || !pp_funcs->display_clock_voltage_request)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index be8a2494355a..cfc1d3b2e9d1 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -414,7 +414,7 @@ static enum bp_result bios_parser_get_voltage_ddc_info(struct dc_bios *dcb,
 	enum bp_result result = BP_RESULT_NORECORD;
 	uint8_t *voltage_info_address;
 	ATOM_COMMON_TABLE_HEADER *header;
-	struct atom_data_revision revision = {0};
+	struct atom_data_revision revision = {};
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
 	if (!DATA_TABLES(VoltageObjectInfo))
@@ -4042,7 +4042,7 @@ static bool bios_parser_construct(
 	uint16_t *rom_header_offset = NULL;
 	ATOM_ROM_HEADER *rom_header = NULL;
 	ATOM_OBJECT_HEADER *object_info_tbl;
-	struct atom_data_revision tbl_rev = {0};
+	struct atom_data_revision tbl_rev = {};
 
 	if (!init)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index eab007e1793c..0bed1df029c9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -231,7 +231,7 @@ static enum bp_result bios_parser_get_src_obj(struct dc_bios *dcb,
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	unsigned int i;
 	enum bp_result  bp_result = BP_RESULT_BADINPUT;
-	struct graphics_object_id obj_id = {0};
+	struct graphics_object_id obj_id = {};
 	struct object_info_table *tbl = &bp->object_info_tbl;
 
 	if (!src_object_id)
@@ -290,7 +290,7 @@ static enum bp_result bios_parser_get_dst_obj(struct dc_bios *dcb,
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	unsigned int i;
 	enum bp_result  bp_result = BP_RESULT_BADINPUT;
-	struct graphics_object_id obj_id = {0};
+	struct graphics_object_id obj_id = {};
 	struct object_info_table *tbl = &bp->object_info_tbl;
 
 	if (!dest_object_id)
@@ -331,7 +331,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
 	struct graphics_object_id id)
 {
 	unsigned int i;
-	struct graphics_object_id obj_id = {0};
+	struct graphics_object_id obj_id = {};
 
 	switch (id.type) {
 	case OBJECT_TYPE_ENCODER:
@@ -552,7 +552,7 @@ static enum bp_result bios_parser_get_voltage_ddc_info(struct dc_bios *dcb,
 	enum bp_result result = BP_RESULT_NORECORD;
 	uint8_t *voltage_info_address;
 	struct atom_common_table_header *header;
-	struct atom_data_revision revision = {0};
+	struct atom_data_revision revision = {};
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
 	if (!DATA_TABLES(voltageobject_info))
@@ -2151,7 +2151,7 @@ static bool bios_parser_construct(
 	uint16_t *rom_header_offset = NULL;
 	struct atom_rom_header_v2_2 *rom_header = NULL;
 	struct display_object_info_table_v1_4 *object_info_tbl;
-	struct atom_data_revision tbl_rev = {0};
+	struct atom_data_revision tbl_rev = {};
 
 	if (!init)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c
index a8cb039d2572..275aee24116a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c
@@ -267,7 +267,7 @@ struct graphics_object_id object_id_from_bios_object_id(uint32_t bios_object_id)
 {
 	enum object_type type;
 	enum object_enum_id enum_id;
-	struct graphics_object_id go_id = { 0 };
+	struct graphics_object_id go_id = {};
 
 	type = object_type_from_bios_object_id(bios_object_id);
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index a558bfaa0c46..46e6637a8f2b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -199,7 +199,7 @@ static enum bp_result encoder_control_dig1_v1(
 	struct bp_encoder_control *cntl)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	DIG_ENCODER_CONTROL_PARAMETERS_V2 params = {0};
+	DIG_ENCODER_CONTROL_PARAMETERS_V2 params = {};
 
 	bp->cmd_helper->assign_control_parameter(bp->cmd_helper, cntl, &params);
 
@@ -214,7 +214,7 @@ static enum bp_result encoder_control_dig2_v1(
 	struct bp_encoder_control *cntl)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	DIG_ENCODER_CONTROL_PARAMETERS_V2 params = {0};
+	DIG_ENCODER_CONTROL_PARAMETERS_V2 params = {};
 
 	bp->cmd_helper->assign_control_parameter(bp->cmd_helper, cntl, &params);
 
@@ -229,7 +229,7 @@ static enum bp_result encoder_control_digx_v3(
 	struct bp_encoder_control *cntl)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	DIG_ENCODER_CONTROL_PARAMETERS_V3 params = {0};
+	DIG_ENCODER_CONTROL_PARAMETERS_V3 params = {};
 
 	if (LANE_COUNT_FOUR < cntl->lanes_number)
 		params.acConfig.ucDPLinkRate = 1; /* dual link 2.7GHz */
@@ -258,7 +258,7 @@ static enum bp_result encoder_control_digx_v4(
 	struct bp_encoder_control *cntl)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	DIG_ENCODER_CONTROL_PARAMETERS_V4 params = {0};
+	DIG_ENCODER_CONTROL_PARAMETERS_V4 params = {};
 
 	if (LANE_COUNT_FOUR < cntl->lanes_number)
 		params.acConfig.ucDPLinkRate = 1; /* dual link 2.7GHz */
@@ -287,7 +287,7 @@ static enum bp_result encoder_control_digx_v5(
 	struct bp_encoder_control *cntl)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	ENCODER_STREAM_SETUP_PARAMETERS_V5 params = {0};
+	ENCODER_STREAM_SETUP_PARAMETERS_V5 params = {};
 
 	params.ucDigId = (uint8_t)(cntl->engine_id);
 	params.ucAction = bp->cmd_helper->encoder_action_to_atom(cntl->action);
@@ -1459,7 +1459,7 @@ static enum bp_result adjust_display_pll_v2(
 	struct bp_adjust_pixel_clock_parameters *bp_params)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	ADJUST_DISPLAY_PLL_PS_ALLOCATION params = { 0 };
+	ADJUST_DISPLAY_PLL_PS_ALLOCATION params = {};
 
 	/* We need to convert from KHz units into 10KHz units and then convert
 	 * output pixel clock back 10KHz-->KHz */
@@ -1745,7 +1745,7 @@ static enum bp_result set_crtc_timing_v1(
 	struct bp_hw_crtc_timing_parameters *bp_params)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	SET_CRTC_TIMING_PARAMETERS_PS_ALLOCATION params = {0};
+	SET_CRTC_TIMING_PARAMETERS_PS_ALLOCATION params = {};
 	uint8_t atom_controller_id;
 
 	if (bp->cmd_helper->controller_id_to_atom(
@@ -1818,7 +1818,7 @@ static enum bp_result set_crtc_using_dtd_timing_v3(
 	struct bp_hw_crtc_timing_parameters *bp_params)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	SET_CRTC_USING_DTD_TIMING_PARAMETERS params = {0};
+	SET_CRTC_USING_DTD_TIMING_PARAMETERS params = {};
 	uint8_t atom_controller_id;
 
 	if (bp->cmd_helper->controller_id_to_atom(
@@ -2043,7 +2043,7 @@ static enum bp_result enable_crtc_v1(
 	bool enable)
 {
 	bool result = BP_RESULT_FAILURE;
-	ENABLE_CRTC_PARAMETERS params = {0};
+	ENABLE_CRTC_PARAMETERS params = {};
 	uint8_t id;
 
 	if (bp->cmd_helper->controller_id_to_atom(controller_id, &id))
@@ -2093,7 +2093,7 @@ static enum bp_result enable_crtc_mem_req_v1(
 	bool enable)
 {
 	bool result = BP_RESULT_BADINPUT;
-	ENABLE_CRTC_PARAMETERS params = {0};
+	ENABLE_CRTC_PARAMETERS params = {};
 	uint8_t id;
 
 	if (bp->cmd_helper->controller_id_to_atom(controller_id, &id)) {
@@ -2375,7 +2375,7 @@ static enum bp_result enable_disp_power_gating_v2_1(
 {
 	enum bp_result result = BP_RESULT_FAILURE;
 
-	ENABLE_DISP_POWER_GATING_PS_ALLOCATION params = {0};
+	ENABLE_DISP_POWER_GATING_PS_ALLOCATION params = {};
 	uint8_t atom_crtc_id;
 
 	if (bp->cmd_helper->controller_id_to_atom(crtc_id, &atom_crtc_id))
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 2b5dc499a35e..162d5e348826 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -108,7 +108,7 @@ static enum bp_result encoder_control_digx_v1_5(
 	struct bp_encoder_control *cntl)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	struct dig_encoder_stream_setup_parameters_v1_5 params = {0};
+	struct dig_encoder_stream_setup_parameters_v1_5 params = {};
 
 	params.digid = (uint8_t)(cntl->engine_id);
 	params.action = bp->cmd_helper->encoder_action_to_atom(cntl->action);
@@ -197,7 +197,7 @@ static enum bp_result transmitter_control_v1_6(
 {
 	enum bp_result result = BP_RESULT_FAILURE;
 	const struct command_table_helper *cmd = bp->cmd_helper;
-	struct dig_transmitter_control_ps_allocation_v1_6 ps = { { 0 } };
+	struct dig_transmitter_control_ps_allocation_v1_6 ps = {};
 
 	ps.param.phyid = cmd->phy_id_to_atom(cntl->transmitter);
 	ps.param.action = (uint8_t)cntl->action;
@@ -371,7 +371,7 @@ static enum bp_result set_crtc_using_dtd_timing_v3(
 	struct bp_hw_crtc_timing_parameters *bp_params)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	struct set_crtc_using_dtd_timing_parameters params = {0};
+	struct set_crtc_using_dtd_timing_parameters params = {};
 	uint8_t atom_controller_id;
 
 	if (bp->cmd_helper->controller_id_to_atom(
@@ -562,7 +562,7 @@ static enum bp_result enable_crtc_v1(
 	bool enable)
 {
 	bool result = BP_RESULT_FAILURE;
-	struct enable_crtc_parameters params = {0};
+	struct enable_crtc_parameters params = {};
 	uint8_t id;
 
 	if (bp->cmd_helper->controller_id_to_atom(controller_id, &id))
@@ -662,7 +662,7 @@ static enum bp_result enable_disp_power_gating_v2_1(
 	enum bp_result result = BP_RESULT_FAILURE;
 
 
-	struct enable_disp_power_gating_ps_allocation ps = { { 0 } };
+	struct enable_disp_power_gating_ps_allocation ps = {};
 	uint8_t atom_crtc_id;
 
 	if (bp->cmd_helper->controller_id_to_atom(crtc_id, &atom_crtc_id))
@@ -784,7 +784,7 @@ static void init_get_smu_clock_info(struct bios_parser *bp)
 
 static unsigned int get_smu_clock_info_v3_1(struct bios_parser *bp, uint8_t id)
 {
-	struct atom_get_smu_clock_info_parameters_v3_1 smu_input = {0};
+	struct atom_get_smu_clock_info_parameters_v3_1 smu_input = {};
 	struct atom_get_smu_clock_info_output_parameters_v3_1 smu_output;
 
 	smu_input.command = GET_SMU_CLOCK_INFO_V3_1_GET_PLLVCO_FREQ;
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index 160d11a15eac..f15e429966bd 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -2027,8 +2027,8 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
 	struct bw_calcs_vbios *bw_vbios,
 	struct hw_asic_id asic_id)
 {
-	struct bw_calcs_dceip dceip = { 0 };
-	struct bw_calcs_vbios vbios = { 0 };
+	struct bw_calcs_dceip dceip = {};
+	struct bw_calcs_vbios vbios = {};
 
 	enum bw_calcs_version version = bw_calcs_version_from_asic_id(asic_id);
 
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index bd039322f697..69ab6ac87e45 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -434,9 +434,9 @@ static void dcn_bw_calc_rq_dlg_ttu(
 	struct _vcs_dpi_display_dlg_regs_st *dlg_regs = &pipe->dlg_regs;
 	struct _vcs_dpi_display_ttu_regs_st *ttu_regs = &pipe->ttu_regs;
 	struct _vcs_dpi_display_rq_regs_st *rq_regs = &pipe->rq_regs;
-	struct _vcs_dpi_display_rq_params_st rq_param = {0};
-	struct _vcs_dpi_display_dlg_sys_params_st dlg_sys_param = {0};
-	struct _vcs_dpi_display_e2e_pipe_params_st input = { { { 0 } } };
+	struct _vcs_dpi_display_rq_params_st rq_param = {};
+	struct _vcs_dpi_display_dlg_sys_params_st dlg_sys_param = {};
+	struct _vcs_dpi_display_e2e_pipe_params_st input = {};
 	float total_active_bw = 0;
 	float total_prefetch_bw = 0;
 	int total_flip_bytes = 0;
@@ -1344,7 +1344,7 @@ static bool verify_clock_values(struct dm_pp_clock_levels_with_voltage *clks)
 void dcn_bw_update_from_pplib(struct dc *dc)
 {
 	struct dc_context *ctx = dc->ctx;
-	struct dm_pp_clock_levels_with_voltage fclks = {0}, dcfclks = {0};
+	struct dm_pp_clock_levels_with_voltage fclks = {}, dcfclks = {};
 	bool res;
 
 	kernel_fpu_begin();
@@ -1391,7 +1391,7 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 void dcn_bw_notify_pplib_of_wm_ranges(struct dc *dc)
 {
 	struct pp_smu_funcs_rv *pp = dc->res_pool->pp_smu;
-	struct pp_smu_wm_range_sets ranges = {0};
+	struct pp_smu_wm_range_sets ranges = {};
 	int min_fclk_khz, min_dcfclk_khz, socclk_khz;
 	const int overdrive = 5000000; /* 5 GHz to cover Overdrive */
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6ae050dc3220..76c007af5cc0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -109,7 +109,7 @@ static bool create_links(
 		num_virtual_links);
 
 	for (i = 0; i < connectors_num; i++) {
-		struct link_init_data link_init_params = {0};
+		struct link_init_data link_init_params = {};
 		struct dc_link *link;
 
 		link_init_params.ctx = dc->ctx;
@@ -128,7 +128,7 @@ static bool create_links(
 
 	for (i = 0; i < num_virtual_links; i++) {
 		struct dc_link *link = kzalloc(sizeof(*link), GFP_KERNEL);
-		struct encoder_init_data enc_init = {0};
+		struct encoder_init_data enc_init = {};
 
 		if (link == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -875,7 +875,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	struct pipe_ctx *pipe;
 	int i, k, l;
-	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
+	struct dc_stream_state *dc_streams[MAX_STREAMS] = {};
 
 	disable_dangling_plane(dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 37eaf72ace54..a6324b98f9a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -587,8 +587,8 @@ static bool is_same_edid(struct dc_edid *old_edid, struct dc_edid *new_edid)
 
 bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 {
-	struct dc_sink_init_data sink_init_data = { 0 };
-	struct display_sink_capability sink_caps = { 0 };
+	struct dc_sink_init_data sink_init_data = {};
+	struct display_sink_capability sink_caps = {};
 	uint8_t i;
 	bool converter_disable_audio = false;
 	struct audio_support *aud_support = &link->dc->res_pool->audio_support;
@@ -1024,10 +1024,10 @@ static bool construct(
 {
 	uint8_t i;
 	struct gpio *hpd_gpio = NULL;
-	struct ddc_service_init_data ddc_service_init_data = { { 0 } };
+	struct ddc_service_init_data ddc_service_init_data = {};
 	struct dc_context *dc_ctx = init_params->ctx;
-	struct encoder_init_data enc_init_data = { 0 };
-	struct integrated_info info = {{{ 0 }}};
+	struct encoder_init_data enc_init_data = {};
+	struct integrated_info info = {};
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
 	DC_LOGGER_INIT(dc_ctx->logger);
@@ -1316,7 +1316,7 @@ static enum dc_status enable_link_dp(
 	enum dc_status status;
 	bool skip_video_pattern;
 	struct dc_link *link = stream->sink->link;
-	struct dc_link_settings link_settings = {0};
+	struct dc_link_settings link_settings = {};
 	enum dp_panel_mode panel_mode;
 	enum dc_link_rate max_link_rate = LINK_RATE_HIGH2;
 
@@ -1515,8 +1515,8 @@ static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
 static bool i2c_write(struct pipe_ctx *pipe_ctx,
 		uint8_t address, uint8_t *buffer, uint32_t length)
 {
-	struct i2c_command cmd = {0};
-	struct i2c_payload payload = {0};
+	struct i2c_command cmd = {};
+	struct i2c_payload payload = {};
 
 	memset(&payload, 0, sizeof(payload));
 	memset(&cmd, 0, sizeof(cmd));
@@ -1811,7 +1811,7 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->sink->link;
 	enum dc_color_depth display_color_depth;
 	enum engine_id eng_id;
-	struct ext_hdmi_settings settings = {0};
+	struct ext_hdmi_settings settings = {};
 	bool is_over_340mhz = false;
 	bool is_vga_mode = (stream->timing.h_addressable == 640)
 			&& (stream->timing.v_addressable == 480);
@@ -2193,8 +2193,7 @@ static void update_mst_stream_alloc_table(
 	struct stream_encoder *stream_enc,
 	const struct dp_mst_stream_allocation_table *proposed_table)
 {
-	struct link_mst_stream_allocation work_table[MAX_CONTROLLER_NUM] = {
-			{ 0 } };
+	struct link_mst_stream_allocation work_table[MAX_CONTROLLER_NUM] = {};
 	struct link_mst_stream_allocation *dc_alloc;
 
 	int i;
@@ -2246,7 +2245,7 @@ static enum dc_status allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->sink->link;
 	struct link_encoder *link_encoder = link->link_enc;
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
-	struct dp_mst_stream_allocation_table proposed_table = {0};
+	struct dp_mst_stream_allocation_table proposed_table = {};
 	struct fixed31_32 avg_time_slots_per_mtp;
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
@@ -2326,7 +2325,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->sink->link;
 	struct link_encoder *link_encoder = link->link_enc;
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
-	struct dp_mst_stream_allocation_table proposed_table = {0};
+	struct dp_mst_stream_allocation_table proposed_table = {};
 	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
 	uint8_t i;
 	bool mst_mode = (link->type == dc_connection_mst_branch);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 8def0d9fa0ff..d1dbefd90b6d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -708,7 +708,7 @@ void dal_ddc_service_write_scdc_data(struct ddc_service *ddc_service,
 	uint8_t slave_address = HDMI_SCDC_ADDRESS;
 	uint8_t offset = HDMI_SCDC_SINK_VERSION;
 	uint8_t sink_version = 0;
-	uint8_t write_buffer[2] = {0};
+	uint8_t write_buffer[2] = {};
 	/*Lower than 340 Scramble bit from SCDC caps*/
 
 	dal_ddc_service_query_ddc_data(ddc_service, slave_address, &offset,
@@ -743,7 +743,7 @@ void dal_ddc_service_read_scdc_data(struct ddc_service *ddc_service)
 	dal_ddc_service_query_ddc_data(ddc_service, slave_address, &offset,
 			sizeof(offset), &tmds_config, sizeof(tmds_config));
 	if (tmds_config & 0x1) {
-		union hdmi_scdc_status_flags_data status_data = { {0} };
+		union hdmi_scdc_status_flags_data status_data = {};
 		uint8_t scramble_status = 0;
 
 		offset = HDMI_SCDC_SCRAMBLER_STATUS;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index a7553b6d59c2..6e88c70a1100 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -94,8 +94,8 @@ static void dpcd_set_link_settings(
 	uint8_t rate = (uint8_t)
 	(lt_settings->link_settings.link_rate);
 
-	union down_spread_ctrl downspread = { {0} };
-	union lane_count_set lane_count_set = { {0} };
+	union down_spread_ctrl downspread = {};
+	union lane_count_set lane_count_set = {};
 	uint8_t link_set_buffer[2];
 
 	downspread.raw = (uint8_t)
@@ -165,11 +165,11 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	const struct link_training_settings *lt_settings,
 	enum hw_dp_training_pattern pattern)
 {
-	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = { { {0} } };
+	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = {};
 	const uint32_t dpcd_base_lt_offset =
 	DP_TRAINING_PATTERN_SET;
-	uint8_t dpcd_lt_buffer[5] = {0};
-	union dpcd_training_pattern dpcd_pattern = { {0} };
+	uint8_t dpcd_lt_buffer[5] = {};
+	union dpcd_training_pattern dpcd_pattern = {};
 	uint32_t lane;
 	uint32_t size_in_bytes;
 	bool edp_workaround = false; /* TODO link_prop.INTERNAL */
@@ -428,9 +428,9 @@ static void get_lane_status_and_drive_settings(
 	union lane_align_status_updated *ln_status_updated,
 	struct link_training_settings *req_settings)
 {
-	uint8_t dpcd_buf[6] = {0};
-	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-	struct link_training_settings request_settings = { {0} };
+	uint8_t dpcd_buf[6] = {};
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {};
+	struct link_training_settings request_settings = {};
 	uint32_t lane;
 
 	memset(req_settings, '\0', sizeof(struct link_training_settings));
@@ -504,7 +504,7 @@ static void dpcd_set_lane_settings(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting)
 {
-	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = {{{0}}};
+	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = {};
 	uint32_t lane;
 
 	for (lane = 0; lane <
@@ -535,7 +535,7 @@ static void dpcd_set_lane_settings(
 	/*
 	if (LTSettings.link.rate == LinkRate_High2)
 	{
-		DpcdTrainingLaneSet2 dpcd_lane2[lane_count_DPMax] = {0};
+		DpcdTrainingLaneSet2 dpcd_lane2[lane_count_DPMax] = {};
 		for ( uint32_t lane = 0;
 		lane < lane_count_DPMax; lane++)
 		{
@@ -725,8 +725,8 @@ static enum link_training_result perform_channel_equalization_sequence(
 	enum hw_dp_training_pattern hw_tr_pattern;
 	uint32_t retries_ch_eq;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
-	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_align_status_updated dpcd_lane_status_updated = {};
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {};
 
 	hw_tr_pattern = get_supported_tp(link);
 
@@ -891,8 +891,8 @@ static inline enum link_training_result perform_link_training_int(
 	struct link_training_settings *lt_settings,
 	enum link_training_result status)
 {
-	union lane_count_set lane_count_set = { {0} };
-	union dpcd_training_pattern dpcd_pattern = { {0} };
+	union lane_count_set lane_count_set = {};
+	union dpcd_training_pattern dpcd_pattern = {};
 
 	/* 3. set training not in progress*/
 	dpcd_pattern.v1_4.TRAINING_PATTERN_SET = DPCD_TRAINING_PATTERN_VIDEOIDLE;
@@ -1094,10 +1094,10 @@ bool dp_verify_link_cap(
 	struct dc_link_settings *known_limit_link_setting,
 	int *fail_count)
 {
-	struct dc_link_settings max_link_cap = {0};
-	struct dc_link_settings cur_link_setting = {0};
+	struct dc_link_settings max_link_cap = {};
+	struct dc_link_settings cur_link_setting = {};
 	struct dc_link_settings *cur = &cur_link_setting;
-	struct dc_link_settings initial_link_settings = {0};
+	struct dc_link_settings initial_link_settings = {};
 	bool success;
 	bool skip_link_training;
 	bool skip_video_pattern;
@@ -1201,7 +1201,7 @@ static struct dc_link_settings get_common_supported_link_settings(
 		struct dc_link_settings link_setting_a,
 		struct dc_link_settings link_setting_b)
 {
-	struct dc_link_settings link_settings = {0};
+	struct dc_link_settings link_settings = {};
 
 	link_settings.lane_count =
 		(link_setting_a.lane_count <=
@@ -1721,7 +1721,7 @@ static bool handle_hpd_irq_psr_sink(const struct dc_link *link)
 
 
 	if (psr_configuration.bits.ENABLE) {
-		unsigned char dpcdbuf[3] = {0};
+		unsigned char dpcdbuf[3] = {};
 		union psr_error_status psr_error_status;
 		union psr_sink_psr_status psr_sink_psr_status;
 
@@ -1767,7 +1767,7 @@ static bool handle_hpd_irq_psr_sink(const struct dc_link *link)
 
 static void dp_test_send_link_training(struct dc_link *link)
 {
-	struct dc_link_settings link_settings = {0};
+	struct dc_link_settings link_settings = {};
 
 	core_link_read_dpcd(
 			link,
@@ -1798,7 +1798,7 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	unsigned char dpcd_post_cursor_2_adjustment = 0;
 	unsigned char test_80_bit_pattern[
 			(DP_TEST_80BIT_CUSTOM_PATTERN_79_72 -
-			DP_TEST_80BIT_CUSTOM_PATTERN_7_0)+1] = {0};
+			DP_TEST_80BIT_CUSTOM_PATTERN_7_0)+1] = {};
 	enum dp_test_pattern test_pattern;
 	struct dc_link_training_settings link_settings;
 	union lane_adjust dpcd_lane_adjust;
@@ -2011,8 +2011,8 @@ static void handle_automated_test(struct dc_link *link)
 
 bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss)
 {
-	union hpd_irq_data hpd_irq_dpcd_data = { { { {0} } } };
-	union device_service_irq device_service_clear = { { 0 } };
+	union hpd_irq_data hpd_irq_dpcd_data = {};
+	union device_service_irq device_service_clear = {};
 	enum dc_status result;
 
 	bool status = false;
@@ -2293,7 +2293,7 @@ static void dp_wa_power_up_0010FA(struct dc_link *link, uint8_t *dpcd_data,
 		int length)
 {
 	int retry = 0;
-	union dp_downstream_port_present ds_port = { 0 };
+	union dp_downstream_port_present ds_port = {};
 
 	if (!link->dpcd_caps.dpcd_rev.raw) {
 		do {
@@ -2337,7 +2337,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	struct dp_device_vendor_id sink_id;
 	union down_stream_port_count down_strm_port_count;
 	union edp_configuration_cap edp_config_cap;
-	union dp_downstream_port_present ds_port = { 0 };
+	union dp_downstream_port_present ds_port = {};
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	uint32_t read_dpcd_retry_cnt = 3;
 	int i;
@@ -2592,7 +2592,7 @@ bool dc_link_dp_set_test_pattern(
 	struct pipe_ctx *pipe_ctx = &pipes[0];
 	unsigned int lane;
 	unsigned int i;
-	unsigned char link_qual_pattern[LANE_COUNT_DP_MAX] = {0};
+	unsigned char link_qual_pattern[LANE_COUNT_DP_MAX] = {};
 	union dpcd_training_pattern training_pattern;
 	enum dpcd_phy_test_patterns pattern;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 82cd1d6e6e59..35d1137d9d16 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -256,7 +256,7 @@ void dp_set_hw_test_pattern(
 	uint8_t *custom_pattern,
 	uint32_t custom_pattern_size)
 {
-	struct encoder_set_dp_phy_pattern_param pattern_param = {0};
+	struct encoder_set_dp_phy_pattern_param pattern_param = {};
 	struct link_encoder *encoder = link->link_enc;
 
 	pattern_param.dp_phy_pattern = test_pattern;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ea6beccfd89d..a08249a2b986 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -148,7 +148,7 @@ struct resource_pool *dc_create_resource_pool(
 		break;
 	}
 	if (res_pool != NULL) {
-		struct dc_firmware_info fw_info = { { 0 } };
+		struct dc_firmware_info fw_info = {};
 
 		if (dc->ctx->dc_bios->funcs->get_firmware_info(
 				dc->ctx->dc_bios, &fw_info) == BP_RESULT_OK) {
@@ -207,7 +207,7 @@ bool resource_construct(
 	const struct resource_caps *caps = pool->res_cap;
 	int i;
 	unsigned int num_audio = caps->num_audio;
-	struct resource_straps straps = {0};
+	struct resource_straps straps = {};
 
 	if (create_funcs->read_dce_straps)
 		create_funcs->read_dce_straps(dc->ctx, &straps);
@@ -480,7 +480,7 @@ static void calculate_viewport(struct pipe_ctx *pipe_ctx)
 	const struct dc_stream_state *stream = pipe_ctx->stream;
 	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
 	struct rect surf_src = plane_state->src_rect;
-	struct rect clip = { 0 };
+	struct rect clip = {};
 	int vpc_div = (data->format == PIXEL_FORMAT_420BPP8
 			|| data->format == PIXEL_FORMAT_420BPP10) ? 2 : 1;
 	bool pri_split = pipe_ctx->bottom_pipe &&
@@ -1043,7 +1043,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
-	struct rect recout_full = { 0 };
+	struct rect recout_full = {};
 	bool res = false;
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 	/* Important: scaling ratio calculation requires pixel format,
@@ -1442,7 +1442,7 @@ bool dc_rem_all_planes_for_stream(
 {
 	int i, old_plane_count;
 	struct dc_stream_status *stream_status = NULL;
-	struct dc_plane_state *del_planes[MAX_SURFACE_NUM] = { 0 };
+	struct dc_plane_state *del_planes[MAX_SURFACE_NUM] = {};
 
 	for (i = 0; i < context->stream_count; i++)
 			if (context->streams[i] == stream) {
@@ -2079,7 +2079,7 @@ static void set_avi_info_frame(
 	uint8_t *check_sum = NULL;
 	uint8_t byte_index = 0;
 	union hdmi_info_packet hdmi_info;
-	union display_content_support support = {0};
+	union display_content_support support = {};
 	unsigned int vic = pipe_ctx->stream->timing.vic;
 	enum dc_timing_3d_format format;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 7f6d724686f1..345649626304 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -778,7 +778,7 @@ void dce_aud_wall_dto_setup(
 {
 	struct dce_audio *aud = DCE_AUD(audio);
 
-	struct azalia_clock_info clock_info = { 0 };
+	struct azalia_clock_info clock_info = {};
 
 	if (dc_is_hdmi_signal(signal)) {
 		uint32_t src_sel;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index ca137757a69e..f7cb8a8605bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -693,7 +693,7 @@ static uint32_t dce110_get_pix_rate_in_hz(
 static bool disable_spread_spectrum(struct dce110_clk_src *clk_src)
 {
 	enum bp_result result;
-	struct bp_spread_spectrum_parameters bp_ss_params = {0};
+	struct bp_spread_spectrum_parameters bp_ss_params = {};
 
 	bp_ss_params.pll_id = clk_src->base.id;
 
@@ -775,7 +775,7 @@ static bool enable_spread_spectrum(
 		struct dce110_clk_src *clk_src,
 		enum signal_type signal, struct pll_settings *pll_settings)
 {
-	struct bp_spread_spectrum_parameters bp_params = {0};
+	struct bp_spread_spectrum_parameters bp_params = {};
 	struct delta_sigma_data d_s_data;
 	const struct spread_spectrum_data *ss_data = NULL;
 
@@ -907,7 +907,7 @@ static bool dce110_program_pix_clk(
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
-	struct bp_pixel_clock_parameters bp_pc_params = {0};
+	struct bp_pixel_clock_parameters bp_pc_params = {};
 
 #if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
@@ -1017,7 +1017,7 @@ static bool dce110_clock_source_power_down(
 {
 	struct dce110_clk_src *dce110_clk_src = TO_DCE110_CLK_SRC(clk_src);
 	enum bp_result bp_result;
-	struct bp_pixel_clock_parameters bp_pixel_clock_params = {0};
+	struct bp_pixel_clock_parameters bp_pixel_clock_params = {};
 
 	if (clk_src->dp_clk_src)
 		return true;
@@ -1191,7 +1191,7 @@ static bool calc_pll_max_vco_construct(
 			struct calc_pll_clock_source_init_data *init_data)
 {
 	uint32_t i;
-	struct dc_firmware_info fw_info = { { 0 } };
+	struct dc_firmware_info fw_info = {};
 	if (calc_pll_cs == NULL ||
 			init_data == NULL ||
 			init_data->bp == NULL)
@@ -1273,7 +1273,7 @@ bool dce110_clk_src_construct(
 	const struct dce110_clk_src_shift *cs_shift,
 	const struct dce110_clk_src_mask *cs_mask)
 {
-	struct dc_firmware_info fw_info = { { 0 } };
+	struct dc_firmware_info fw_info = {};
 	struct calc_pll_clock_source_init_data calc_pll_cs_init_data_hdmi;
 	struct calc_pll_clock_source_init_data calc_pll_cs_init_data;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
index fb1f373d08a1..ebb9e0e2ab32 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
@@ -242,7 +242,7 @@ static int dce_set_clock(
 	int requested_clk_khz)
 {
 	struct dce_dccg *clk_dce = TO_DCE_CLOCKS(clk);
-	struct bp_pixel_clock_parameters pxl_clk_params = { 0 };
+	struct bp_pixel_clock_parameters pxl_clk_params = {};
 	struct dc_bios *bp = clk->ctx->dc_bios;
 	int actual_clock = requested_clk_khz;
 
@@ -345,8 +345,8 @@ static void dce_clock_read_integrated_info(struct dce_dccg *clk_dce)
 {
 	struct dc_debug_options *debug = &clk_dce->base.ctx->dc->debug;
 	struct dc_bios *bp = clk_dce->base.ctx->dc_bios;
-	struct integrated_info info = { { { 0 } } };
-	struct dc_firmware_info fw_info = { { 0 } };
+	struct integrated_info info = {};
+	struct dc_firmware_info fw_info = {};
 	int i;
 
 	if (bp->integrated_info)
@@ -406,7 +406,7 @@ static void dce_clock_read_ss_info(struct dce_dccg *clk_dce)
 			bp, AS_SIGNAL_TYPE_GPU_PLL);
 
 	if (ss_info_num) {
-		struct spread_spectrum_info info = { { 0 } };
+		struct spread_spectrum_info info = {};
 		enum bp_result result = bp->funcs->get_spread_spectrum_info(
 				bp, AS_SIGNAL_TYPE_GPU_PLL, 0, &info);
 
@@ -464,7 +464,7 @@ static void dce12_update_clocks(struct dccg *dccg,
 			struct dc_clocks *new_clocks,
 			bool safe_to_lower)
 {
-	struct dm_pp_clock_for_voltage_req clock_voltage_req = {0};
+	struct dm_pp_clock_for_voltage_req clock_voltage_req = {};
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, dccg->clks.dispclk_khz)) {
 		clock_voltage_req.clk_type = DM_PP_CLOCK_TYPE_DISPLAY_CLK;
@@ -572,7 +572,7 @@ static void dcn1_update_clocks(struct dccg *dccg,
 			&dc->res_pool->pp_smu_req;
 	struct pp_smu_display_requirement_rv smu_req = *smu_req_cur;
 	struct pp_smu_funcs_rv *pp_smu = dc->res_pool->pp_smu;
-	struct dm_pp_clock_for_voltage_req clock_voltage_req = {0};
+	struct dm_pp_clock_for_voltage_req clock_voltage_req = {};
 	bool send_request_to_increase = false;
 	bool send_request_to_lower = false;
 
@@ -834,7 +834,7 @@ struct dccg *dcn1_dccg_create(struct dc_context *ctx)
 {
 	struct dc_debug_options *debug = &ctx->dc->debug;
 	struct dc_bios *bp = ctx->dc_bios;
-	struct dc_firmware_info fw_info = { { 0 } };
+	struct dc_firmware_info fw_info = {};
 	struct dce_dccg *clk_dce = kzalloc(sizeof(*clk_dce), GFP_KERNEL);
 
 	if (clk_dce == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index eff7d22d78fb..08ad9bfe52bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -686,7 +686,7 @@ void dce110_link_encoder_construct(
 	const struct dce110_link_enc_aux_registers *aux_regs,
 	const struct dce110_link_enc_hpd_registers *hpd_regs)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 
@@ -833,7 +833,7 @@ void dce110_link_encoder_hw_init(
 	struct link_encoder *enc)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	cntl.action = TRANSMITTER_CONTROL_INIT;
@@ -926,7 +926,7 @@ void dce110_link_encoder_enable_tmds_output(
 	uint32_t pixel_clock)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -962,7 +962,7 @@ void dce110_link_encoder_enable_dp_output(
 	enum clock_source_id clock_source)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1001,7 +1001,7 @@ void dce110_link_encoder_enable_dp_mst_output(
 	enum clock_source_id clock_source)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1041,7 +1041,7 @@ void dce110_link_encoder_disable_output(
 	enum signal_type signal)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	if (!dce110_is_dig_enabled(enc)) {
@@ -1084,9 +1084,9 @@ void dce110_link_encoder_dp_set_lane_settings(
 	const struct link_training_settings *link_settings)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	union dpcd_training_lane_set training_lane_set = { { 0 } };
+	union dpcd_training_lane_set training_lane_set = {};
 	int32_t lane = 0;
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 
 	if (!link_settings) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 91642e684858..838348ce4ddd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -542,7 +542,7 @@ static void dce110_stream_encoder_hdmi_set_stream_attribute(
 	bool enable_audio)
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
-	struct bp_encoder_control cntl = {0};
+	struct bp_encoder_control cntl = {};
 
 	cntl.action = ENCODER_CONTROL_SETUP;
 	cntl.engine_id = enc110->base.id;
@@ -655,7 +655,7 @@ static void dce110_stream_encoder_dvi_set_stream_attribute(
 	bool is_dual_link)
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
-	struct bp_encoder_control cntl = {0};
+	struct bp_encoder_control cntl = {};
 
 	cntl.action = ENCODER_CONTROL_SETUP;
 	cntl.engine_id = enc110->base.id;
@@ -1178,7 +1178,7 @@ static const struct audio_clock_info audio_clock_info_table_48bpc[14] = {
 static union audio_cea_channels speakers_to_channels(
 	struct audio_speaker_flags speaker_flags)
 {
-	union audio_cea_channels cea_channels = {0};
+	union audio_cea_channels cea_channels = {};
 
 	/* these are one to one */
 	cea_channels.channels.FL = speaker_flags.FL_FR;
@@ -1322,7 +1322,7 @@ static void dce110_se_setup_hdmi_audio(
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
 
-	struct audio_clock_info audio_clock_info = {0};
+	struct audio_clock_info audio_clock_info = {};
 	uint32_t max_packets_per_line;
 
 	/* For now still do calculation, although this field is ignored when
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index ab63d0d0304c..9ed2c7d6c3be 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -343,7 +343,7 @@ static void dce_transform_set_scaler(
 
 	if (is_scaling_required) {
 		/* 3. Calculate and program ratio, filter initialization */
-		struct scl_ratios_inits inits = { 0 };
+		struct scl_ratios_inits inits = {};
 
 		calculate_inits(xfm_dce, data, &inits);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 3f76e6019546..64274b7e86be 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -817,7 +817,7 @@ static bool construct(
 	struct dc_context *ctx = dc->ctx;
 	struct dc_firmware_info info;
 	struct dc_bios *bp;
-	struct dm_pp_static_clock_info static_clk_info = {0};
+	struct dm_pp_static_clock_info static_clk_info = {};
 
 	ctx->dc_bios->regs = &bios_regs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 14384d9675a8..10b0d6c1f00e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -266,7 +266,7 @@ dce110_set_input_transfer_func(struct pipe_ctx *pipe_ctx,
 {
 	struct input_pixel_processor *ipp = pipe_ctx->plane_res.ipp;
 	const struct dc_transfer_func *tf = NULL;
-	struct ipp_prescale_params prescale_params = { 0 };
+	struct ipp_prescale_params prescale_params = {};
 	bool result = true;
 
 	if (ipp == NULL)
@@ -621,7 +621,7 @@ static enum dc_status bios_parser_crtc_source_select(
 	/* call VBIOS table to set CRTC source for the HW
 	 * encoder block
 	 * note: video bios clears all FMT setting here. */
-	struct bp_crtc_source_select crtc_source_select = {0};
+	struct bp_crtc_source_select crtc_source_select = {};
 	const struct dc_sink *sink = pipe_ctx->stream->sink;
 
 	crtc_source_select.engine_id = pipe_ctx->stream_res.stream_enc->id;
@@ -849,7 +849,7 @@ void hwss_edp_power_control(
 {
 	struct dc_context *ctx = link->ctx;
 	struct dce_hwseq *hwseq = ctx->dc->hwseq;
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result bp_result;
 
 
@@ -931,7 +931,7 @@ void hwss_edp_backlight_control(
 {
 	struct dc_context *ctx = link->ctx;
 	struct dce_hwseq *hws = ctx->dc->hwseq;
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
 		!= CONNECTOR_ID_EDP) {
@@ -1071,7 +1071,7 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx, int option)
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings)
 {
-	struct encoder_unblank_param params = { { 0 } };
+	struct encoder_unblank_param params = {};
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->sink->link;
 
@@ -1248,7 +1248,7 @@ static void get_surface_visual_confirm_color(const struct pipe_ctx *pipe_ctx,
 static void program_scaler(const struct dc *dc,
 		const struct pipe_ctx *pipe_ctx)
 {
-	struct tg_color color = {0};
+	struct tg_color color = {};
 
 #if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	/* TOFPGA */
@@ -1285,7 +1285,7 @@ static enum dc_status dce110_enable_stream_timing(
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *pipe_ctx_old = &dc->current_state->res_ctx.
 			pipe_ctx[pipe_ctx->pipe_idx];
-	struct tg_color black_color = {0};
+	struct tg_color black_color = {};
 
 	if (!pipe_ctx_old->stream) {
 
@@ -1718,7 +1718,7 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 		int num_pipes, int vmin, int vmax)
 {
 	int i = 0;
-	struct drr_params params = {0};
+	struct drr_params params = {};
 
 	params.vertical_total_max = vmax;
 	params.vertical_total_min = vmin;
@@ -2091,7 +2091,7 @@ enum dc_status dce110_apply_ctx_to_hw(
  ******************************************************************************/
 static void set_default_colors(struct pipe_ctx *pipe_ctx)
 {
-	struct default_adjustment default_adjust = { 0 };
+	struct default_adjustment default_adjust = {};
 
 	default_adjust.force_hw_default = false;
 	default_adjust.in_color_space = pipe_ctx->plane_state->color_space;
@@ -2265,7 +2265,7 @@ static void dce110_enable_timing_synchronization(
 		struct pipe_ctx *grouped_pipes[])
 {
 	struct dc_context *dc_ctx = dc->ctx;
-	struct dcp_gsl_params gsl_params = { 0 };
+	struct dcp_gsl_params gsl_params = {};
 	int i;
 
 	DC_SYNC_INFO("GSL: Setting-up...\n");
@@ -2310,7 +2310,7 @@ static void dce110_enable_per_frame_crtc_position_reset(
 		struct pipe_ctx *grouped_pipes[])
 {
 	struct dc_context *dc_ctx = dc->ctx;
-	struct dcp_gsl_params gsl_params = { 0 };
+	struct dcp_gsl_params gsl_params = {};
 	int i;
 
 	gsl_params.gsl_group = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index e5e9e92521e9..ac77464f8888 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -983,7 +983,7 @@ static struct pipe_ctx *dce110_acquire_underlay(
 	pipe_ctx->stream = stream;
 
 	if (!dc->current_state->res_ctx.pipe_ctx[underlay_idx].stream) {
-		struct tg_color black_color = {0};
+		struct tg_color black_color = {};
 		struct dc_bios *dcb = dc->ctx->dc_bios;
 
 		dc->hwss.enable_display_power_gating(
@@ -1081,7 +1081,7 @@ static bool underlay_create(struct dc_context *ctx, struct resource_pool *pool)
 
 static void bw_calcs_data_update_from_pplib(struct dc *dc)
 {
-	struct dm_pp_clock_levels clks = {0};
+	struct dm_pp_clock_levels clks = {};
 
 	/*do system clock*/
 	dm_pp_get_clock_levels_by_type(
@@ -1154,7 +1154,7 @@ static bool construct(
 	struct dc_context *ctx = dc->ctx;
 	struct dc_firmware_info info;
 	struct dc_bios *bp;
-	struct dm_pp_static_clock_info static_clk_info = {0};
+	struct dm_pp_static_clock_info static_clk_info = {};
 
 	ctx->dc_bios->regs = &bios_regs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
index aa8d6b10d2c3..b73898ba3d9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
@@ -527,8 +527,8 @@ static void dce110_xfmv_set_scaler(
 	bool is_scaling_required = false;
 	bool filter_updated = false;
 	const uint16_t *coeffs_v, *coeffs_h, *coeffs_h_c, *coeffs_v_c;
-	struct rect luma_viewport = {0};
-	struct rect chroma_viewport = {0};
+	struct rect luma_viewport = {};
+	struct rect chroma_viewport = {};
 
 	dce110_xfmv_power_up_line_buffer(xfm);
 	/* 1. Calculate viewport, viewport programming should happen after init
@@ -546,7 +546,7 @@ static void dce110_xfmv_set_scaler(
 	if (is_scaling_required) {
 		/* 4. Calculate and program ratio, filter initialization */
 
-		struct sclv_ratios_inits inits = { 0 };
+		struct sclv_ratios_inits inits = {};
 
 		calculate_inits(
 			xfm_dce,
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 288129343c77..098885d0612b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -928,10 +928,10 @@ static const struct resource_funcs dce112_res_pool_funcs = {
 
 static void bw_calcs_data_update_from_pplib(struct dc *dc)
 {
-	struct dm_pp_clock_levels_with_latency eng_clks = {0};
-	struct dm_pp_clock_levels_with_latency mem_clks = {0};
-	struct dm_pp_wm_sets_with_clock_ranges clk_ranges = {0};
-	struct dm_pp_clock_levels clks = {0};
+	struct dm_pp_clock_levels_with_latency eng_clks = {};
+	struct dm_pp_clock_levels_with_latency mem_clks = {};
+	struct dm_pp_wm_sets_with_clock_ranges clk_ranges = {};
+	struct dm_pp_clock_levels clks = {};
 
 	/*do system clock  TODO PPLIB: after PPLIB implement,
 	 * then remove old way
@@ -1087,7 +1087,7 @@ static bool construct(
 {
 	unsigned int i;
 	struct dc_context *ctx = dc->ctx;
-	struct dm_pp_static_clock_info static_clk_info = {0};
+	struct dm_pp_static_clock_info static_clk_info = {};
 
 	ctx->dc_bios->regs = &bios_regs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index d43f37d99c7d..6aeb4be4f9d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -726,9 +726,9 @@ static const struct resource_funcs dce120_res_pool_funcs = {
 
 static void bw_calcs_data_update_from_pplib(struct dc *dc)
 {
-	struct dm_pp_clock_levels_with_latency eng_clks = {0};
-	struct dm_pp_clock_levels_with_latency mem_clks = {0};
-	struct dm_pp_wm_sets_with_clock_ranges clk_ranges = {0};
+	struct dm_pp_clock_levels_with_latency eng_clks = {};
+	struct dm_pp_clock_levels_with_latency mem_clks = {};
+	struct dm_pp_wm_sets_with_clock_ranges clk_ranges = {};
 	int i;
 	unsigned int clk;
 	unsigned int latency;
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 604c62969ead..ec6b4fb3bc7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -795,7 +795,7 @@ static bool dce80_construct(
 	struct dc_context *ctx = dc->ctx;
 	struct dc_firmware_info info;
 	struct dc_bios *bp;
-	struct dm_pp_static_clock_info static_clk_info = {0};
+	struct dm_pp_static_clock_info static_clk_info = {};
 
 	ctx->dc_bios->regs = &bios_regs;
 
@@ -988,7 +988,7 @@ static bool dce81_construct(
 	struct dc_context *ctx = dc->ctx;
 	struct dc_firmware_info info;
 	struct dc_bios *bp;
-	struct dm_pp_static_clock_info static_clk_info = {0};
+	struct dm_pp_static_clock_info static_clk_info = {};
 
 	ctx->dc_bios->regs = &bios_regs;
 
@@ -1174,7 +1174,7 @@ static bool dce83_construct(
 	struct dc_context *ctx = dc->ctx;
 	struct dc_firmware_info info;
 	struct dc_bios *bp;
-	struct dm_pp_static_clock_info static_clk_info = {0};
+	struct dm_pp_static_clock_info static_clk_info = {};
 
 	ctx->dc_bios->regs = &bios_regs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index cfcc54f2ce65..7217c54188b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -282,7 +282,7 @@ void dcn10_log_hw_state(struct dc *dc)
 
 	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE\n");
 	for (i = 0; i < pool->pipe_count; i++) {
-		struct mpcc_state s = {0};
+		struct mpcc_state s = {};
 
 		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
 		if (s.opp_id != 0xf)
@@ -298,7 +298,7 @@ void dcn10_log_hw_state(struct dc *dc)
 
 	for (i = 0; i < pool->timing_generator_count; i++) {
 		struct timing_generator *tg = pool->timing_generators[i];
-		struct dcn_otg_state s = {0};
+		struct dcn_otg_state s = {};
 
 		optc1_read_otg_state(DCN10TG_FROM_TG(tg), &s);
 
@@ -627,7 +627,7 @@ static enum dc_status dcn10_enable_stream_timing(
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	enum dc_color_space color_space;
-	struct tg_color black_color = {0};
+	struct tg_color black_color = {};
 
 	/* by upper caller loop, pipe0 is parent pipe and be called first.
 	 * back end is set up by for pipe0. Other children pipe share back end
@@ -1570,8 +1570,8 @@ static void mmhub_read_vm_context0_settings(struct dcn10_hubp *hubp1,
 static void dcn10_program_pte_vm(struct dce_hwseq *hws, struct hubp *hubp)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
-	struct vm_system_aperture_param apt = { {{ 0 } } };
-	struct vm_context0_param vm0 = { { { 0 } } };
+	struct vm_system_aperture_param apt = {};
+	struct vm_context0_param vm0 = {};
 
 	mmhub_read_vm_system_aperture_settings(hubp1, &apt, hws);
 	mmhub_read_vm_context0_settings(hubp1, &vm0, hws);
@@ -1882,7 +1882,7 @@ void build_prescale_params(struct  dc_bias_and_scale *bias_and_scale,
 
 static void update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state)
 {
-	struct dc_bias_and_scale bns_params = {0};
+	struct dc_bias_and_scale bns_params = {};
 
 	// program the input csc
 	dpp->funcs->dpp_setup(dpp,
@@ -1900,7 +1900,7 @@ static void update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state)
 static void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	struct mpcc_blnd_cfg blnd_cfg = {0};
+	struct mpcc_blnd_cfg blnd_cfg = {};
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
 	int mpcc_id;
 	struct mpcc *new_mpcc;
@@ -2112,7 +2112,7 @@ static void dcn10_blank_pixel_data(
 		bool blank)
 {
 	enum dc_color_space color_space;
-	struct tg_color black_color = {0};
+	struct tg_color black_color = {};
 	struct stream_resource *stream_res = &pipe_ctx->stream_res;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 
@@ -2387,7 +2387,7 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 		int num_pipes, int vmin, int vmax)
 {
 	int i = 0;
-	struct drr_params params = {0};
+	struct drr_params params = {};
 
 	params.vertical_total_max = vmax;
 	params.vertical_total_min = vmin;
@@ -2469,7 +2469,7 @@ static void dcn10_config_stereo_parameters(
 
 static void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
 {
-	struct crtc_stereo_flags flags = { 0 };
+	struct crtc_stereo_flags flags = {};
 	struct dc_stream_state *stream = pipe_ctx->stream;
 
 	dcn10_config_stereo_parameters(stream, &flags);
@@ -2617,7 +2617,7 @@ static void dcn10_set_cursor_sdr_white_level(struct pipe_ctx *pipe_ctx)
 {
 	uint32_t sdr_white_level = pipe_ctx->stream->cursor_attributes.sdr_white_level;
 	struct fixed31_32 multiplier;
-	struct dpp_cursor_attributes opt_attr = { 0 };
+	struct dpp_cursor_attributes opt_attr = {};
 	uint32_t hw_scale = 0x3c00; // 1.0 default multiplier
 	struct custom_float_format fmt;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 6f675206a136..768cfc6e8619 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -634,7 +634,7 @@ void dcn10_link_encoder_construct(
 	const struct dcn10_link_enc_shift *link_shift,
 	const struct dcn10_link_enc_mask *link_mask)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 
@@ -781,7 +781,7 @@ void dcn10_link_encoder_hw_init(
 	struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	cntl.action = TRANSMITTER_CONTROL_INIT;
@@ -875,7 +875,7 @@ void dcn10_link_encoder_enable_tmds_output(
 	uint32_t pixel_clock)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -911,7 +911,7 @@ void dcn10_link_encoder_enable_dp_output(
 	enum clock_source_id clock_source)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -950,7 +950,7 @@ void dcn10_link_encoder_enable_dp_mst_output(
 	enum clock_source_id clock_source)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -990,7 +990,7 @@ void dcn10_link_encoder_disable_output(
 	enum signal_type signal)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 	enum bp_result result;
 
 	if (!dcn10_is_dig_enabled(enc)) {
@@ -1037,9 +1037,9 @@ void dcn10_link_encoder_dp_set_lane_settings(
 	const struct link_training_settings *link_settings)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	union dpcd_training_lane_set training_lane_set = { { 0 } };
+	union dpcd_training_lane_set training_lane_set = {};
 	int32_t lane = 0;
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = {};
 
 	if (!link_settings) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 6f9078f3c4d3..6155648be930 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -482,7 +482,7 @@ void enc1_stream_encoder_hdmi_set_stream_attribute(
 	bool enable_audio)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	struct bp_encoder_control cntl = {0};
+	struct bp_encoder_control cntl = {};
 
 	cntl.action = ENCODER_CONTROL_SETUP;
 	cntl.engine_id = enc1->base.id;
@@ -587,7 +587,7 @@ void enc1_stream_encoder_dvi_set_stream_attribute(
 	bool is_dual_link)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	struct bp_encoder_control cntl = {0};
+	struct bp_encoder_control cntl = {};
 
 	cntl.action = ENCODER_CONTROL_SETUP;
 	cntl.engine_id = enc1->base.id;
@@ -1060,7 +1060,7 @@ static const struct audio_clock_info audio_clock_info_table_48bpc[14] = {
 static union audio_cea_channels speakers_to_channels(
 	struct audio_speaker_flags speaker_flags)
 {
-	union audio_cea_channels cea_channels = {0};
+	union audio_cea_channels cea_channels = {};
 
 	/* these are one to one */
 	cea_channels.channels.FL = speaker_flags.FL_FR;
@@ -1183,7 +1183,7 @@ static void enc1_se_setup_hdmi_audio(
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	struct audio_clock_info audio_clock_info = {0};
+	struct audio_clock_info audio_clock_info = {};
 
 	/* HDMI_AUDIO_PACKET_CONTROL */
 	REG_UPDATE(HDMI_AUDIO_PACKET_CONTROL,
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c b/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c
index 9b0bcc6b769b..8f0fdc8d0b37 100644
--- a/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c
+++ b/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c
@@ -162,7 +162,7 @@ bool dal_i2caux_submit_i2c_command(
 
 		struct i2c_payload *payload = cmd->payloads + index_of_payload;
 
-		struct i2caux_transaction_request request = { 0 };
+		struct i2caux_transaction_request request = {};
 
 		request.operation = payload->write ?
 			I2CAUX_TRANSACTION_WRITE :
@@ -221,7 +221,7 @@ bool dal_i2caux_submit_aux_command(
 
 	while (index_of_payload < cmd->number_of_payloads) {
 		struct aux_payload *payload = cmd->payloads + index_of_payload;
-		struct i2caux_transaction_request request = { 0 };
+		struct i2caux_transaction_request request = {};
 
 		if (cmd->mot == I2C_MOT_UNDEF)
 			mot = (index_of_payload != cmd->number_of_payloads - 1);
@@ -325,7 +325,7 @@ void dal_i2caux_destroy(
 uint32_t dal_i2caux_get_reference_clock(
 		struct dc_bios *bios)
 {
-	struct dc_firmware_info info = { { 0 } };
+	struct dc_firmware_info info = {};
 
 	if (bios->funcs->get_firmware_info(bios, &info) != BP_RESULT_OK)
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h b/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
index 39ee8eba3c31..f78a1b7499ef 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
@@ -86,7 +86,7 @@ struct bw_fixed bw_frc_to_fixed(int64_t num, int64_t denum);
 
 static inline struct bw_fixed fixed31_32_to_bw_fixed(int64_t raw)
 {
-	struct bw_fixed result = { 0 };
+	struct bw_fixed result = {};
 
 	if (raw < 0) {
 		raw = -raw;
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index fa344ceafc17..1a146b8e2c3f 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -772,7 +772,7 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 	unsigned int min_frame_duration_in_ns, vmax, vmin = 0;
 	struct freesync_state *state;
 	struct core_freesync *core_freesync = NULL;
-	struct dc_static_screen_events triggers = {0};
+	struct dc_static_screen_events triggers = {};
 
 	if (mod_freesync == NULL)
 		return;
@@ -882,7 +882,7 @@ void mod_freesync_update_state(struct mod_freesync *mod_freesync,
 	unsigned int stream_index;
 	struct freesync_state *state;
 	struct core_freesync *core_freesync = NULL;
-	struct dc_static_screen_events triggers = {0};
+	struct dc_static_screen_events triggers = {};
 
 	if (mod_freesync == NULL)
 		return;
@@ -1218,7 +1218,7 @@ void mod_freesync_notify_mode_change(struct mod_freesync *mod_freesync,
 	unsigned int stream_index, map_index;
 	struct freesync_state *state;
 	struct core_freesync *core_freesync = NULL;
-	struct dc_static_screen_events triggers = {0};
+	struct dc_static_screen_events triggers = {};
 	unsigned long long temp = 0;
 
 	if (mod_freesync == NULL)
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 7a646f94b478..1ffa88dd0e80 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -998,7 +998,7 @@ static int pp_get_display_power_level(void *handle,
 static int pp_get_current_clocks(void *handle,
 		struct amd_pp_clock_info *clocks)
 {
-	struct amd_pp_simple_clock_info simple_clocks = { 0 };
+	struct amd_pp_simple_clock_info simple_clocks = {};
 	struct pp_clock_info hw_clocks;
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index a63e00653324..5a61e615ddbc 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -198,7 +198,7 @@ static int smu10_construct_boot_state(struct pp_hwmgr *hwmgr)
 
 static int smu10_set_clock_limit(struct pp_hwmgr *hwmgr, const void *input)
 {
-	struct PP_Clocks clocks = {0};
+	struct PP_Clocks clocks = {};
 	struct pp_display_clock_request clock_req;
 
 	clocks.dcefClock = hwmgr->display_config->min_dcef_set_clk;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 052e60dfaf9f..2b3108c695de 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -2884,7 +2884,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 				cast_phw_smu7_power_state(&request_ps->hardware);
 	uint32_t sclk;
 	uint32_t mclk;
-	struct PP_Clocks minimum_clocks = {0};
+	struct PP_Clocks minimum_clocks = {};
 	bool disable_mclk_switching;
 	bool disable_mclk_switching_for_frame_lock;
 	const struct phm_clock_and_voltage_limits *max_limits;
@@ -3580,7 +3580,7 @@ static int smu7_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, cons
 	struct smu7_single_dpm_table *mclk_table = &(data->dpm_table.mclk_table);
 	uint32_t mclk = smu7_ps->performance_levels
 			[smu7_ps->performance_level_count - 1].memory_clock;
-	struct PP_Clocks min_clocks = {0};
+	struct PP_Clocks min_clocks = {};
 	uint32_t i;
 
 	for (i = 0; i < sclk_table->count; i++) {
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index fb86c24394ff..b6afcdf8e3e9 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -289,7 +289,7 @@ static int vega10_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 	struct phm_ppt_v1_voltage_lookup_table *vddc_lookup_table;
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_table[3];
 	struct phm_ppt_v1_clock_voltage_dependency_table *od_table[3];
-	struct pp_atomfwctrl_avfs_parameters avfs_params = {0};
+	struct pp_atomfwctrl_avfs_parameters avfs_params = {};
 	uint32_t i;
 	int result;
 
@@ -2070,7 +2070,7 @@ static int vega10_populate_avfs_parameters(struct pp_hwmgr *hwmgr)
 			(struct phm_ppt_v2_information *)(hwmgr->pptable);
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_table =
 			table_info->vdd_dep_on_sclk;
-	struct pp_atomfwctrl_avfs_parameters avfs_params = {0};
+	struct pp_atomfwctrl_avfs_parameters avfs_params = {};
 	int result = 0;
 	uint32_t i;
 
@@ -2302,7 +2302,7 @@ static int vega10_populate_gpio_parameters(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
-	struct pp_atomfwctrl_gpio_parameters gpio_params = {0};
+	struct pp_atomfwctrl_gpio_parameters gpio_params = {};
 	int result;
 
 	result = pp_atomfwctrl_get_gpio_information(hwmgr, &gpio_params);
@@ -3101,7 +3101,7 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 				cast_phw_vega10_power_state(&request_ps->hardware);
 	uint32_t sclk;
 	uint32_t mclk;
-	struct PP_Clocks minimum_clocks = {0};
+	struct PP_Clocks minimum_clocks = {};
 	bool disable_mclk_switching;
 	bool disable_mclk_switching_for_frame_lock;
 	bool disable_mclk_switching_for_vr;
@@ -3796,7 +3796,7 @@ static int vega10_notify_smc_display_config_after_ps_adjustment(
 			(struct phm_ppt_v2_information *)hwmgr->pptable;
 	struct phm_ppt_v1_clock_voltage_dependency_table *mclk_table = table_info->vdd_dep_on_mclk;
 	uint32_t idx;
-	struct PP_Clocks min_clocks = {0};
+	struct PP_Clocks min_clocks = {};
 	uint32_t i;
 	struct pp_display_clock_request clock_req;
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index 0789d64246ca..85cecdd9e0db 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -1385,7 +1385,7 @@ static int vega12_notify_smc_display_config_after_ps_adjustment(
 {
 	struct vega12_hwmgr *data =
 			(struct vega12_hwmgr *)(hwmgr->backend);
-	struct PP_Clocks min_clocks = {0};
+	struct PP_Clocks min_clocks = {};
 	struct pp_display_clock_request clock_req;
 
 	if ((hwmgr->display_config->num_display > 1) &&
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index fbe3ef4ee45c..9ffa98d0f77d 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2307,7 +2307,7 @@ static int ci_load_smc_ucode(struct pp_hwmgr *hwmgr)
 	uint8_t *src;
 	uint32_t data;
 
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	cgs_get_firmware_info(hwmgr->device, CGS_UCODE_ID_SMU, &info);
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 9299b93aa09a..59c5faa22cd9 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -183,7 +183,7 @@ static int iceland_upload_smc_firmware_data(struct pp_hwmgr *hwmgr,
 static int iceland_smu_upload_firmware_image(struct pp_hwmgr *hwmgr)
 {
 	uint32_t val;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	if (hwmgr == NULL || hwmgr->device == NULL)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 1276f168ff68..e4a7d0ced2a2 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -800,7 +800,7 @@ static void polaris10_get_sclk_range_table(struct pp_hwmgr *hwmgr,
 	struct polaris10_smumgr *smu_data = (struct polaris10_smumgr *)(hwmgr->smu_backend);
 	uint32_t i, ref_clk;
 
-	struct pp_atom_ctrl_sclk_range_table range_table_from_vbios = { { {0} } };
+	struct pp_atom_ctrl_sclk_range_table range_table_from_vbios = {};
 
 	ref_clk = amdgpu_asic_get_xclk((struct amdgpu_device *)hwmgr->adev);
 
@@ -911,7 +911,7 @@ static int polaris10_populate_single_graphic_level(struct pp_hwmgr *hwmgr,
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
-	SMU_SclkSetting curr_sclk_setting = { 0 };
+	SMU_SclkSetting curr_sclk_setting = {};
 	phm_ppt_v1_clock_voltage_dependency_table *vdd_dep_table = NULL;
 
 	result = polaris10_calculate_sclk_params(hwmgr, clock, &curr_sclk_setting);
@@ -1629,9 +1629,9 @@ static int polaris10_populate_avfs_parameters(struct pp_hwmgr *hwmgr)
 
 	SMU74_Discrete_DpmTable  *table = &(smu_data->smc_state_table);
 	int result = 0;
-	struct pp_atom_ctrl__avfs_parameters avfs_params = {0};
-	AVFS_meanNsigma_t AVFS_meanNsigma = { {0} };
-	AVFS_Sclk_Offset_t AVFS_SclkOffset = { {0} };
+	struct pp_atom_ctrl__avfs_parameters avfs_params = {};
+	AVFS_meanNsigma_t AVFS_meanNsigma = {};
+	AVFS_Sclk_Offset_t AVFS_SclkOffset = {};
 	uint32_t tmp, i;
 
 	struct phm_ppt_v1_information *table_info =
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index a029e47c2319..fd1c1ba723d3 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -51,7 +51,7 @@ int smu7_copy_bytes_from_smc(struct pp_hwmgr *hwmgr, uint32_t smc_start_address,
 	uint32_t data;
 	uint32_t addr;
 	uint8_t *dest_byte;
-	uint8_t i, data_byte[4] = {0};
+	uint8_t i, data_byte[4] = {};
 	uint32_t *pdata = (uint32_t *)&data_byte;
 
 	PP_ASSERT_WITH_CODE((0 == (3 & smc_start_address)), "SMC address must be 4 byte aligned.", return -EINVAL);
@@ -345,7 +345,7 @@ static int smu7_populate_single_firmware_entry(struct pp_hwmgr *hwmgr,
 						struct SMU_Entry *entry)
 {
 	int result = 0;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	result = cgs_get_firmware_info(hwmgr->device,
 				smu7_convert_fw_type_to_cgs(fw_type),
@@ -522,7 +522,7 @@ int smu7_upload_smu_firmware_image(struct pp_hwmgr *hwmgr)
 	int result = 0;
 	struct smu7_smumgr *smu_data = (struct smu7_smumgr *)(hwmgr->smu_backend);
 
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	if (smu_data->security_hard_key == 1)
 		cgs_get_firmware_info(hwmgr->device,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index f7e3bc22bb93..88857107e33c 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -175,7 +175,7 @@ static int smu8_load_mec_firmware(struct pp_hwmgr *hwmgr)
 	uint32_t reg_data;
 	uint32_t tmp;
 	int ret = 0;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 	struct smu8_smumgr *smu8_smu;
 
 	if (hwmgr == NULL || hwmgr->device == NULL)
@@ -551,7 +551,7 @@ static int smu8_smu_populate_firmware_entries(struct pp_hwmgr *hwmgr)
 	uint32_t i;
 	int ret;
 	enum cgs_ucode_id ucode_id;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	smu8_smu->driver_buffer_length = 0;
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
index 5d19115f410c..01971719458b 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
@@ -162,7 +162,7 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 	struct vega10_smumgr *priv;
 	unsigned long tools_size;
 	int ret;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	ret = cgs_get_firmware_info(hwmgr->device,
 				    CGS_UCODE_ID_SMU,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
index 7f0e2109f40d..768e94c1b95a 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
@@ -199,7 +199,7 @@ static int vega12_smu_init(struct pp_hwmgr *hwmgr)
 {
 	struct vega12_smumgr *priv;
 	unsigned long tools_size;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 	int ret;
 
 	ret = cgs_get_firmware_info(hwmgr->device, CGS_UCODE_ID_SMU,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 57420d7caa4e..b8fe6da2fb98 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -670,7 +670,7 @@ static void vegam_get_sclk_range_table(struct pp_hwmgr *hwmgr,
 	struct vegam_smumgr *smu_data = (struct vegam_smumgr *)(hwmgr->smu_backend);
 	uint32_t i, ref_clk;
 
-	struct pp_atom_ctrl_sclk_range_table range_table_from_vbios = { { {0} } };
+	struct pp_atom_ctrl_sclk_range_table range_table_from_vbios = {};
 
 	ref_clk = amdgpu_asic_get_xclk((struct amdgpu_device *)hwmgr->adev);
 
@@ -813,7 +813,7 @@ static int vegam_populate_single_graphic_level(struct pp_hwmgr *hwmgr,
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
-	SMU_SclkSetting curr_sclk_setting = { 0 };
+	SMU_SclkSetting curr_sclk_setting = {};
 
 	result = vegam_calculate_sclk_params(hwmgr, clock, &curr_sclk_setting);
 
@@ -1572,9 +1572,9 @@ static int vegam_populate_avfs_parameters(struct pp_hwmgr *hwmgr)
 
 	SMU75_Discrete_DpmTable  *table = &(smu_data->smc_state_table);
 	int result = 0;
-	struct pp_atom_ctrl__avfs_parameters avfs_params = {0};
-	AVFS_meanNsigma_t AVFS_meanNsigma = { {0} };
-	AVFS_Sclk_Offset_t AVFS_SclkOffset = { {0} };
+	struct pp_atom_ctrl__avfs_parameters avfs_params = {};
+	AVFS_meanNsigma_t AVFS_meanNsigma = {};
+	AVFS_Sclk_Offset_t AVFS_SclkOffset = {};
 	uint32_t tmp, i;
 
 	struct phm_ppt_v1_information *table_info =
-- 
2.18.0

