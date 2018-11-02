Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5850CC6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 05:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB592081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 05:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maBtCvvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB592081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeKBOig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 10:38:36 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:47053 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeKBOig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 10:38:36 -0400
Received: by mail-qk1-f171.google.com with SMTP id q1so1262936qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 22:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+mSchMSo1SOqxnfLbE8RnZ06mtWDxB07OWyoPcr1QXU=;
        b=maBtCvvDtTe4zfQl7Z46WfUXIjeDJT28UZKP9WFtO6QX4kMOaqjWgFqETwpqvCwfPa
         UBnWhBvPuFDl0y2W9seTrIfeZmXM4f4/PRMAE/3mCtxvjpBnBSyIUtaKvwMPl5gc396N
         MeDi7tpxabnZXnlBLj/EdLYIO3YkMK87mH24AbbVnQn4p5OZqQf7QV1eojqQDR2xPKHQ
         uH2ZkdIoMvheGaXFQMdZ7x9YK72hoCuEDcOxfldNfcxnAMInJmj/jqwqIV1ME7l1Gxda
         cNT9XXOTyON/DGHXiXWeacxjfAppptgbVtH4VwxSmxSib5RUlrZ6xWyHas2DoDn3OvsK
         Jquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+mSchMSo1SOqxnfLbE8RnZ06mtWDxB07OWyoPcr1QXU=;
        b=q+B1MWq53zgdiom/ZftyS3JYOyV79UPkdDGof8UuaAi1GlVqpBZca60unUvU/GJLhx
         FdNiU9oCasG/JkZ0OqnnxPoiFuXA+UMnFKgW1SzN0Laz0p92Hm6yJ7UoIkLMWIh0blY3
         QS2GnouVyqdCuxkQpJhfy08xmsc3d2Ph3RDMX+fLrBwNOMh52xtSJwK86g4QWK4yU/Jx
         deWrO9DWxzCfR/uLzgD7+qahxFK3OOPEMeMANqdQ3ADUzpXkjOQdmxhcXHo/rZSRu4Ib
         Q05MZTWxuHtRaEFQtWc4vi36ZyCE4jj1E8sV4zr/bYTelehkXZdQjeTl74fBxu+G+FK2
         cvfw==
X-Gm-Message-State: AGRZ1gJ8AxwITF8IjlZqc1MfAOLocXbIudoNVtZRNODAnoCSubBBcKPn
        y1EqQ9wbWDmvEyXSHP5lpAD+45WtNCH/BkhyXNM=
X-Google-Smtp-Source: AJdET5dev8uukQqihODJYXosh5XMGIT+rAJ7UpAlFBiCa6SXY58ZnK8HxmkyD5jx3DsxA3Q1jZVr0tWx5HQ8huL9lCI=
X-Received: by 2002:a0c:9359:: with SMTP id e25mr9571605qve.203.1541136760493;
 Thu, 01 Nov 2018 22:32:40 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 2 Nov 2018 15:32:28 +1000
Message-ID: <CAPM=9txf-NoKSEa+9-6-K-kSATevai54ma_tFepDpkQZCaUviA@mail.gmail.com>
Subject: [git pull] drm next fixes for 4.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Pretty much a normal fixes pull pre-rc1, mostly amdgpu fixes, one i915
link training regression fix, and a couple of minor panel/bridge fixes
and a panel quirk.

Thanks,
Dave.

drm-next-2018-11-02:
drm, i915, amdgpu, bridge + core quirk
The following changes since commit f2bfc71aee75feff33ca659322b72ffeed5a243d=
:

  Merge tag 'drm-intel-next-fixes-2018-10-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2018-10-19
14:28:11 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-11-02

for you to fetch changes up to f9885ef875e9160454392f85159163674159c51f:

  Merge tag 'drm-intel-next-fixes-2018-10-25' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2018-11-02
15:17:57 +1000)

----------------------------------------------------------------
drm, i915, amdgpu, bridge + core quirk

----------------------------------------------------------------
Andrey Grodzovsky (2):
      drm/amdgpu: Fix compute ring 1.0.0 failure after reset
      drm/amdgpu: Fix skipping hangged job reset during gpu recover.

Christian K=C3=B6nig (3):
      drm/amdgpu: fix amdgpu_vm_fini
      drm/amdgpu: fix VM leaf walking
      drm/amdgpu: revert "enable gfxoff in non-sriov and stutter mode
by default"

Dave Airlie (3):
      Merge tag 'drm-misc-next-fixes-2018-10-31' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-4.20' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2018-10-25' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

David Francis (2):
      powerplay: Respect units on max dcfclk watermark
      drm/amd/display: Disable 4k 60 HDMI on DCE11

Dhinakaran Pandiyan (2):
      drm/i915/dp: Fix link retraining comment in intel_dp_long_pulse()
      drm/i915/dp: Restrict link retrain workaround to external monitors

Douglas Anderson (6):
      dt-bindings: drm/panel: simple: Add no-hpd property
      drm/panel: simple: Support panels with HPD where HPD isn't connected
      drm/panel: simple: Add "no-hpd" delay for Innolux TV123WAM
      drm/bridge: ti-sn65dsi86: Remove the mystery delay
      dt-bindings: drm/panel: simple: Innolux TV123WAM is actually P120ZDG-=
BF1
      drm/panel: simple: Innolux TV123WAM is actually P120ZDG-BF1

Emily Deng (1):
      drm/amdgpu: Fix null pointer amdgpu_device_fw_loading

Evan Quan (8):
      drm/amd/powerplay: error out when force clock level under auto dpm mo=
de V2
      drm/amd/powerplay: drop highest UCLK setting after display
configuration change
      drm/amd/powerplay: bump the PPtable version supported
      drm/amd/powerplay: commit get_performance_level API as DAL needed
      drm/amd/powerplay: correct the clocks for DAL to be Khz unit
      drm/amd/powerplay: commonize the API for retrieving current clocks
      drm/amd/powerplay: revise Vega20 pptable version check
      drm/amd/powerplay: no MGPU fan boost enablement on DPM disabled

Guttula, Suresh (1):
      drm/amd/display: set backlight level limit to 1

Joseph Greathouse (1):
      drm/amd/pp: enable power limit increase in OD mode

Lee, Shawn C (1):
      drm/edid: Add 6 bpc quirk for BOE panel.

Lyude Paul (4):
      drm/atomic_helper: Disallow new modesets on unregistered connectors
      drm/atomic_helper: Allow DPMS On<->Off changes for unregistered conne=
ctors
      drm/atomic_helper: Stop modesets on unregistered connectors harder
      drm/nouveau: Fix nv50_mstc->best_encoder()

Rex Zhu (5):
      drm/amd/display: Fix Null point error if smu ip was disabled
      drm/amdgpu: Fix null point error
      drm/amd/pp: Fix pp_sclk/mclk_od not work on smu7
      drm/amd/pp: Fix pp_sclk/mclk_od not work on Vega10
      drm/amd/pp: Print warning if od_sclk/mclk out of range

Shirish S (1):
      drm/amdgpu: fix reporting of failed msg sent to SMU (v2)

 ...nnolux,tv123wam.txt =3D> innolux,p120zdg-bf1.txt} |  8 +-
 .../bindings/display/panel/simple-panel.txt        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  6 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  7 ++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 16 ++--
 .../drm/amd/display/dc/dce110/dce110_resource.c    |  2 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 33 ++++++---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 10 ++-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c   |  2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 43 ++++++++++-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |  8 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 85 ++++++++++++------=
----
 .../amd/powerplay/hwmgr/vega20_processpptables.c   | 56 +++++++-------
 .../gpu/drm/amd/powerplay/inc/smu11_driver_if.h    |  2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |  4 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              | 29 ++++----
 drivers/gpu/drm/drm_atomic_helper.c                | 21 +++++-
 drivers/gpu/drm/drm_connector.c                    | 11 +--
 drivers/gpu/drm/drm_edid.c                         |  3 +
 drivers/gpu/drm/i915/intel_dp.c                    | 20 ++---
 drivers/gpu/drm/i915/intel_dp_mst.c                |  8 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            | 14 +---
 drivers/gpu/drm/panel/panel-simple.c               | 29 +++++---
 include/drm/drm_connector.h                        | 71 +++++++++++++++++-
 32 files changed, 364 insertions(+), 175 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{innolux,tv123wam.t=
xt
=3D> innolux,p120zdg-bf1.txt} (70%)
