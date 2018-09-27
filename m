Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E38C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A37215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr2YCYKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A37215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeI1GUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:20:16 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:35341 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeI1GUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:20:16 -0400
Received: by mail-qt1-f169.google.com with SMTP id z14-v6so4842866qtn.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EcL0OghxW5S7n8wDwCbX2qCtf4Iy3gx6NWPAb3RbRx0=;
        b=lr2YCYKukrvVw7fNh8C7GogMChZ5U3ffNSabTVInPo5ionSh48W5xI55HGFg8FQTjV
         6fB9Ve+DMfQDJ9qL81cuFT26xG9/naHCt425un/R0ipu2nQ7POUv7tvimpXOHj2i3nm5
         6fDdGV57HoJmi59JAhiHk9OlVNrj+xFH18uj2zzliQnhqkNQzW0lTu9cc/o4S3+XMeLb
         PXr7O/vmJrpPp/cnobjbHnRDTnn7doclB32ABwXanUFlvocQI40r58QZeRRxIbCLtDLh
         ksFnPW6Bvi8RUx1EAwB4Ok3gzJujjul3DVDmxGV3ck49A5o75tU6dnU4+kfHdzi6E5cM
         puTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EcL0OghxW5S7n8wDwCbX2qCtf4Iy3gx6NWPAb3RbRx0=;
        b=UmFct1soGVzUknlp4IrvFX0cOCb27ZU6KZuOpxUkSg9Yojy9jlzWPWL3vr9S+cPh+O
         tns+dvEBR3G+bKmaERLnHVTpLB5sX4kG161dDHphRaFb6SfbrW/dSJShmVw/04gEADBN
         B4/MSRsyafFpiERudNW/yRGyX2Fyo1gBhtvC7qfwNernH3iqb6kqkL5dSNQVDjYNATKY
         PaKj2JJr2gF8OgsgZBJSdFWqeLHdV1uewp23qDxBQ8PDlas1HyCb400ITKVoa7lAa1mB
         Zzhisd1wUqOsDJnCYndoqRI7IEh0EfjN0RAH78eq/N+jDlDpCgOm1/JF1qSA0ixwC6/j
         XyYA==
X-Gm-Message-State: ABuFfoio2Rf6sDAWK5dakcMCnO/Iv7BvxQlgtA1mVv6o9QiWMrEda7Hl
        oxVpFjSI34MoF558q+hK0F2taLWDbRJ5YCGy9rMgQ49t
X-Google-Smtp-Source: ACcGV62zjATXAllGjhIpYrT/7mxb2bC3TXphi7coujS+m3m+pfBhGj9E2nnKmIEjmrVFYIOYTQbL6Jq2soU+Z7ex/HM=
X-Received: by 2002:aed:2050:: with SMTP id 74-v6mr10392795qta.166.1538092763406;
 Thu, 27 Sep 2018 16:59:23 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 28 Sep 2018 09:59:11 +1000
Message-ID: <CAPM=9tzPZcrUoxq==jObY6tGOgsPP9kbAqcmOoUkts-EjHb5Ww@mail.gmail.com>
Subject: [git pull[ drm fixes for 4.19-rc6
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Looks like a pretty normal week for graphics,

core: syncobj fix, panel link regression revert
amd: suspend/resume fixes, EDID emulation fix
mali-dp: NV12 writeback and vblank reset fixes
etnaviv: DMA setup fix

Regards,
Dave.

drm-fixes-2018-09-28:
amd, etnaviv, mali_dp, syncobj and panel fixes
The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-09-28

for you to fetch changes up to fcb1349a2af5a3c4a1d789bb5d1a9b3e582652a3:

  Merge branch 'drm-fixes-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2018-09-28
09:30:22 +1000)

----------------------------------------------------------------
amd, etnaviv, mali_dp, syncobj and panel fixes

----------------------------------------------------------------
Alexandru Gheorghe (2):
      drm: mali-dp: Call drm_crtc_vblank_reset on device init
      drm/malidp: Fix writeback in NV12

Bhawanpreet Lakha (1):
      drm/amd/display: Fix Edid emulation for linux

Dave Airlie (4):
      Merge branch 'etnaviv/fixes' of
https://git.pengutronix.de/git/lst/linux into drm-fixes
      Merge branch 'for-upstream/malidp-fixes' of
git://linux-arm.org/linux-ld into drm-fixes
      Merge tag 'drm-misc-fixes-2018-09-27-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Jason Ekstrand (1):
      drm/syncobj: Don't leak fences when WAIT_FOR_SUBMIT is set

Linus Walleij (1):
      Revert "drm/panel: Add device_link from panel device to DRM device"

Lucas Stach (1):
      drm/etnaviv: add DMA configuration for etnaviv platform device

Rex Zhu (1):
      drm/amdgpu: Fix vce work queue was not cancelled when suspend

Roman Li (1):
      drm/amd/display: Fix Vega10 lightup on S3 resume

 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 139 ++++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |   1 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   2 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.h    |   5 -
 .../amd/display/dc/dce120/dce120_hw_sequencer.c    |  12 --
 drivers/gpu/drm/arm/malidp_drv.c                   |   1 +
 drivers/gpu/drm/arm/malidp_hw.c                    |  25 +++-
 drivers/gpu/drm/arm/malidp_hw.h                    |   3 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |  25 +++-
 drivers/gpu/drm/arm/malidp_regs.h                  |   2 +
 drivers/gpu/drm/drm_panel.c                        |  10 --
 drivers/gpu/drm/drm_syncobj.c                      |   5 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  27 +++-
 include/drm/drm_panel.h                            |   1 -
 17 files changed, 217 insertions(+), 52 deletions(-)
