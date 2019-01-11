Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA2AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A40920872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOz11hKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfAKCL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:11:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42034 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfAKCLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:11:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so16569090qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fLgbI/MPiI3uJDog97+QnDPfdxG0PCIKP5L0lKGeUak=;
        b=dOz11hKLd7RCsWaoRE1E+HKztCAB8ZUxND9ZiofJ5u+01wy2xUOQrjG/tB6zMPKyfM
         hPugrrRPxb+J8/0Gf6D+S7Hji4p3dPUZuOwjwIbp7t8EqfxYJQ951mkqbPZFjHaUDM6+
         dWLytS6Hhk/Y7Cr6ZZY9nxjHBCX7GT1/Uw+lTpz842JNyVFoeQEkLV1TgqtjP/RQcHqj
         mdyTbWSyXaPtUlAyG+GQAJsA8SBsVnAhUHllwcT6QS/rNlWM8wlItNKMTt+dtFBi2KZF
         3c64xRquvCHN2HqSG82TK+45aX4G5AQ0TiZ2amvEpDP+cjxBErgErTPr96rXBdLIfxo3
         I8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fLgbI/MPiI3uJDog97+QnDPfdxG0PCIKP5L0lKGeUak=;
        b=HWmDZvT6p47QXvh8oD0EAvOPGcHCEQa/EIgONvKieJg1ok0Hv8MI8i9n5NhU7snNlP
         Tl9z6u4yBKDjFLid4cRX1euQ+lg3UTsFg+P7C/q1NpjLrEIJb4t5L2wq0kqte8+M/Zz+
         4nG8KlDtMrpzv4Rzq4Tvy6zIbLDrErK5DG+Bluh8c01aOoHLHqurJwOKUjNGbixv7NKV
         cp6NZ/ns4NchUx1S4mJxBJ3VjAIY/6ZQUfMVf+gjyZj9knxwz9qq8mUX/AIKcdz1X1vA
         PmqEFWh3M8jjlEQL35CFRoSDMcoyi8Ag5UF0t+EU3EW9rxUOCq2g9RciNldpneXsFEV8
         LF/w==
X-Gm-Message-State: AJcUukdPeU6VTK2i9tYNI4UaI6UGd0yxBSXOD22us31ERoEuIvoOB1Gr
        nNjuBwj4nj4B8Tp9WafO/i/3o/TwZv6Z8WDCXYLIhSbL
X-Google-Smtp-Source: ALg8bN4Y3RYEdTooZkRghywCG3kLECLtFjHZPmQsRAxyh2XxidI9pIKT6JWOzdPAJ7E8kPAG9knGflAxyLTC5Q8yeqI=
X-Received: by 2002:a37:9f92:: with SMTP id i140mr11293695qke.131.1547172714104;
 Thu, 10 Jan 2019 18:11:54 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 11 Jan 2019 12:11:42 +1000
Message-ID: <CAPM=9tzYotNYEw4n+-+FDNchOMwJSqTz7Per=dwhghewSuJTRA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.0-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Not a huge amount for rc2, assume the usual quiet period, and rc3 will
be most of it.

amdgpu:
- Powerplay fixes
- Virtual display pinning fixes
- Golden register updates for Vega
- Pitch and gem size validation fixes
- SR-IOV init error fix
- Pagetables in system RAM disable for some Raven system
- DP-MST resume fixes

tc358767 bridge:
- fix to work with displayport connector.

Dave.

drm-fixes-2019-01-11:
drm: amdgpu + tc358767 bridge + amd mst s/r fix
The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c=
:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-11

for you to fetch changes up to f34c48e06ddcc197f2cf7cbc006ceb74e28e1ccf:

  Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-01-11
07:38:56 +1000)

----------------------------------------------------------------
drm: amdgpu + tc358767 bridge + amd mst s/r fix

----------------------------------------------------------------
Christian K=C3=B6nig (1):
      drm/amdgpu: disable system memory page tables for now

Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2019-01-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Emily Deng (3):
      drm/amdgpu/virtual_dce: No need to pin the fb's bo
      drm/amdgpu/virtual_dce: No need to pin the cursor bo
      drm/amdgpu/sriov:Correct pfvf exchange logic

Evan Quan (5):
      drm/amd/powerplay: support BOOTUP_DEFAULT power profile mode
      drm/amd/powerplay: update OD support flag for SKU with no OD capabili=
ties
      drm/amd/powerplay: create pp_od_clk_voltage device file under OD supp=
ort
      drm/amd/powerplay: avoid possible buffer overflow
      drm/amd/powerplay: drop the unnecessary uclk hard min setting

Jim Qu (1):
      drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang

Kent Russell (1):
      drm/amdgpu: Cleanup 2 compiler warnings

Likun Gao (1):
      drm/amdgpu: make gfx9 enter into rlc safe mode when set MGCG

Lyude Paul (3):
      drm/amdgpu: Don't ignore rc from drm_dp_mst_topology_mgr_resume()
      drm/amdgpu: Don't fail resume process if resuming atomic state fails
      drm/dp_mst: Add __must_check to drm_dp_mst_topology_mgr_resume()

Tao Zhou (1):
      drm/amdgpu: fix CPDMA hang in PRT mode for VEGA20

Tiecheng Zhou (1):
      drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings test sequence

Tomi Valkeinen (7):
      drm/bridge: tc358767: add bus flags
      drm/bridge: tc358767: add defines for DP1_SRCCTRL & PHY_2LANE
      drm/bridge: tc358767: fix single lane configuration
      drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value
      drm/bridge: tc358767: reject modes which require too much BW
      drm/bridge: tc358767: fix output H/V syncs
      drm/bridge: tc358767: use DP connector if no panel set

Yu Zhao (2):
      drm/amdgpu: validate user pitch alignment
      drm/amdgpu: validate user GEM object size

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 12 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        | 38 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 22 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  3 --
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           | 17 ++------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 48 +++++++++++++++---=
----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 14 ++++---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 37 +++++++++++------
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     | 13 +++---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        | 24 ++++++-----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  8 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 12 +++---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 34 ++++++++++-----
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  2 +-
 drivers/gpu/drm/bridge/tc358767.c                  | 48 +++++++++++++++++-=
----
 include/drm/drm_dp_mst_helper.h                    |  3 +-
 18 files changed, 221 insertions(+), 119 deletions(-)
