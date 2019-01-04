Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E3BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6794218DE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gubBCJse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfADTKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:10:35 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:39089 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfADTKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:10:35 -0500
Received: by mail-qt1-f180.google.com with SMTP id u47so36839848qtj.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=xPQJ5Y3KAvZd5TneaMLP9ybYNujHfhJF4JAr4gOb03g=;
        b=gubBCJsexabzOkh7cnTv+ugqX2RLumiLCplcqg9gk13ihNW7nnqULtt1eiiIqbj3bU
         DDEVSw/GmR9dtP/tXwybeTGA49S2xxLaZMz3tu/OVVQhEXCwWayzizc9H7Dey4SKu7g4
         7/VtZKU+/UmTBgHBKXhLNQsgPMGUQd5enf0edtE9Ihv4K4bdwCR/Jaojz72PTzZAkWOb
         ktkMibbhU12oqLPACrFQrAzRRYuKQhJiMCj0XRbd9JyC64sKb0UISoDFzIexiOeSVshj
         slZC6aArGyE5vxvEVE4tLmeezv2D4+4GXo6IbbnoXIuXaX3zlCXhb0Q0Lno5ziPcB1sq
         fN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=xPQJ5Y3KAvZd5TneaMLP9ybYNujHfhJF4JAr4gOb03g=;
        b=pY6Cwe58qRRyb5O9MoMlZkaidN0mqh0pfHGV0+JzP3KMHz2X77no0fySaaSnG5c6rl
         sxN62Ddrd4s3fkJOgCVOb3K67jjfHWyAJUpiQ4L8L3PDlOOYevwLMnFvqk03DSIm9Th2
         yA1hcHJPETxyb0iSpULwAEiHqsR8rlfjYrjDtlJsu1EsYEHYGCwxipFPDPqDGhZVD7Py
         suhwGfdPyYpvCkHpry6wL/V2BpMkHw00scXNUpuE2DrDbuVynReOKGaJJE/OqpqSzLN+
         RSzP6fwIvPXDAMAPdkpdPZBhYD1YZ6fFaD1aiIvgl2ceLelijME2OEq6JsDXNVvsIc1P
         m6OQ==
X-Gm-Message-State: AJcUuke/FdDJZdG3pE1Y8wje+23/ZWt6JFyrIjhYTiykf+0K7SVstYuo
        ICCNYE8VDI1vQWu6LzNWlGtBJfr1rO7wCen3eaP52enW
X-Google-Smtp-Source: ALg8bN597pZXb1ClNBICtmTdB6nzLR8foBdARoyiGSkSJ+eYo0gHJDRr0dGjsNDa4Eu2YdPtfLIKk33SITbynARjAuQ=
X-Received: by 2002:a0c:fc09:: with SMTP id z9mr52814471qvo.157.1546629033728;
 Fri, 04 Jan 2019 11:10:33 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 5 Jan 2019 05:10:22 +1000
Message-ID: <CAPM=9tzFx67xnMMYmrw1z1BTRmKsc+wjjXt_C+FuWNz4dMoV9A@mail.gmail.com>
Subject: [git pull] drm next fixes for rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Happy New Year, just decloaking from leave to get this stuff in before rc1.

Some stuff from the last week:
core:
two regression fixes for damage blob and atomic

i915 gvt:
Some missed GVT fixes from the original pull

amdgpu:
new PCI IDs
SR-IOV fixes
DC fixes
Vega20 fixes

Dave.

drm-next-2019-01-05:
drm i915 gvt, amdgpu, core fixes
The following changes since commit 221b35fedee1b38b9cee99320f0c60263d229e14=
:

  Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next (2018-12-18
14:24:52 +0100)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-01-05

for you to fetch changes up to 9ddf32a8df9e342371aaf9233d59739a356231e6:

  Merge tag 'drm-misc-next-fixes-2019-01-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2019-01-04
14:09:15 +1000)

----------------------------------------------------------------
drm i915 gvt, amdgpu, core fixes

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu/nbio6.1: add hw bug workaround for vega10/12
      drm/amdgpu/nbio7.4: add hw bug workaround for vega20
      drm/amdgpu: Add new VegaM pci id

Christian K=C3=B6nig (1):
      drm/amdgpu: fix NULL fence handling in amdgpu_cs_fence_to_handle_ioct=
l

Colin Ian King (2):
      drm/i915/gvt: fix spelling mistake "Interupts" -> "Interrupts"
      drm: fix null pointer dereference on null state pointer

Dale Zhao (1):
      drm/amd/display: Wait edp HPD to high in detect_sink

Dave Airlie (3):
      Merge tag 'drm-intel-next-fixes-2018-12-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm-next-4.21' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2019-01-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

David Francis (1):
      drm/amd/display: Warn instead of error on REG_WAIT timeout

Deepak Rawat (1):
      drm: Put damage blob when destroy plane state

Dmytro Laktyushkin (2):
      drm/amd/display: move AYCrCb8888 format to video section
      drm/amd/display: fix surface update sequence

Emily Deng (3):
      drm/amdgpu: access register without KIQ
      drm/amdgpu/psp_v3_1: Get psp fw version through reading register
      drm/amdgpu/psp: Correct and refine the vmr support. (v2)

Eric Yang (2):
      drm/amd/display: fix YCbCr420 blank color
      drm/amd/display: Don't skip link training for empty dongle

Evan Quan (7):
      drm/amdgpu: increase the MAX ring number
      drm/amdgpu: update the vm invalidation engine layout V2
      drm/amdgpu: use different irq ring ID for Vega20 page queues
      drm/amdgpu: enable Vega20 page queue support
      drm/amdgpu: correct the return value for error case
      drm/amd/powerplay: add Vega20 LCLK DPM level setting support
      drm/amdgpu: add Vega20 PSP ASD firmware loading

Felix Kuehling (1):
      drm/amdkfd: Fix handling of return code of dma_buf_get

Harry Wentland (1):
      drm/amd/display: Don't log error if we have no connectors

James Zhu (8):
      drm/amdgpu/vcn: Update vcn.cur_state during suspend
      drm/amdgpu/vcn:Always gate vcn block during hw finishing
      drm/amdgpu/vcn:Update ring point to JPEG before init JPEG wptr
      drm/amdgpu/vcn:Always check all vcn ring status during dpg mode stop
      drm/amdgpu/vcn:Scan enc/jpeg fences to init dpg pause new state
      drm/amdgpu/vcn:Remove bit 31 for scratch2 to indicate the WA is activ=
e
      drm/amdgpu:Improves robustness of SOC15_WAIT_ON_RREG
      drm/amdgpu/uvd:Change uvd ring name convention

Jani Nikula (1):
      Merge tag 'gvt-next-2018-12-07' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Jerry (Fangzhi) Zuo (1):
      drm/amd/display: Fix MST dp_blank REG_WAIT timeout

Leo Li (2):
      drm/amd/display: Add DCE_VERSION_12_1 enum for Vega 20
      drm/amd/display: Add functionality to get XGMI SS info

Michel D=C3=A4nzer (2):
      drm/amdgpu: WARN once if amdgpu_bo_unpin is called for an unpinned BO
      drm/ttm: Use drm_debug_printer for all ttm_bo_mem_space_debug output

Nicholas Kazlauskas (3):
      drm/amd/display: Skip fast cursor updates for fb changes
      drm/amd/display: Add below the range support for FreeSync
      drm/amd/display: Use div_u64 for flip timestamp ns to ms

Paul Hsieh (1):
      drm/amd/display: Add retry to read ddc_clock pin

Peng Hao (1):
      drm/i915/gvt: fix a typo: "registeration" -> "registration".

Roman Li (1):
      drm/amd/display: Raise dispclk value for Polaris

SivapiriyanKumarasamy (1):
      drm/amd/display: Fix bug with not updating VSP infoframe

Trigger Huang (1):
      drm/amdgpu: print process info when job timeout

Wenjing Liu (2):
      drm/amd/display: verify lane status before exiting verify link cap
      drm/amd/display: validate extended dongle caps

Xinyun Liu (1):
      drm/i915/gvt: fix typo in two MI cmd annotation

Xiong Zhang (1):
      drm/i915/gvt: Fix shadow ctx ppgtt destroy function

Yongqiang Sun (1):
      drm/amd/display: Optimize passive update planes.

Zhao Yan (1):
      drm/i915/gvt: update force-to-nonpriv register whitelist

wentalou (1):
      drm/amdgpu: kfd_pre_reset outside req_full_gpu cause sriov hang

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   8 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |  15 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  53 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h              |  10 +
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |   7 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   7 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  78 +++++--
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |   5 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   9 +-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |   9 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  33 ++-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  93 ++++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  15 ++
 .../amd/display/dc/bios/command_table_helper2.c    |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  48 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 246 +++++++++++------=
----
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c   |   7 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  11 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  15 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |   1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |   1 +
 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c     |   1 +
 .../drm/amd/display/include/bios_parser_types.h    |   1 +
 drivers/gpu/drm/amd/display/include/dal_types.h    |   1 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |  43 ++++
 drivers/gpu/drm/drm_atomic_state_helper.c          |   3 +
 drivers/gpu/drm/drm_damage_helper.c                |   3 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   6 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     |   2 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |   4 +
 drivers/gpu/drm/i915/gvt/handlers.c                |   1 +
 drivers/gpu/drm/i915/gvt/interrupt.c               |   2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |  33 +++
 drivers/gpu/drm/ttm/ttm_bo.c                       |  33 +--
 51 files changed, 630 insertions(+), 291 deletions(-)
