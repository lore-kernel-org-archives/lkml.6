Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9E8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD413208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX/AsCTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD413208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeGPBGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:06:05 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34541 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeGPBGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:06:04 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so31616343qth.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 17:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=IPjY7InebTg6JvJBqWpvICjhFmFedMQuoO7nSAvP3Us=;
        b=pX/AsCTYK4YVSjV7NVOvvtD0PH47t67xLXhr/BH6awmmiXNjf5Qvc76dRpmLHYBpVk
         GwjUo6FS/1Q0taYMygGvJ9VGOj+KX6KS16f3kV0EmAKEn6hU4FPPwWK0lqrJNI+Gg37B
         RNrcAVAWSSkIUJuRwhy2xZClaoGbb+/nsWPpFaFtrJgG3StWdJzVky0lz223Zo/Yha4l
         w5ooYCDX/k07FeFfJBZOMOnnsQOCQd1DOEMWfNRE14tZAeQFiKtznau/idxtaxKzdl1m
         4mYIRCZyA4cC2rhOP2IVEManMgNELTPt0VBoiS00t2teK1usrujjgh90JFxTWBcU2VWl
         jzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=IPjY7InebTg6JvJBqWpvICjhFmFedMQuoO7nSAvP3Us=;
        b=AnkvjUtsZsI4JKWeq8A7KV7Wx/kO9ImabcTks3KHjKvxW5pSQ8B1xSa3EWMk9vkcTs
         aeCqe49eKOrNGfpXHcQwHpzjFZX/97MrRlb2NhRHZym+EHIvWRDy+8BnupQiSM69jIJR
         ub9YDOJB1d6PXz++YFF/AAVDNAEDzciHEHGCseSWY1G0jtNlVNXl91RsY3axEiv++ljU
         KP/Y09Y3jSuDklYi54N4j5OGBbs5EtBz7Gjx+K4gLFTzlTD62VL6IDPurULpQtGLlOW3
         NWOLFc3Pu3Sm8iLcxX1ip0X23tZdS2CDMAfEAoJF1qLqgKRlZveA+J1AbM7EzYGcQBqL
         FiHQ==
X-Gm-Message-State: AOUpUlGkJagWBaODom1UAkN7cbcTJ/D/lwiWQc+Bju/LebTLRf+AcSRj
        Gx6nS09W2tUR3C5d8sMAW3iBY9/vhbLWrcjCQAMHmw==
X-Google-Smtp-Source: AAOMgpfiaR5Y+y9PQ+2Qe4KA2osBKxM2BQTTi1Oi8UZoyXVLm94et1Vc52NzwEm6025E179eV5f+GxfW3A/B6hk9wEk=
X-Received: by 2002:ac8:38ac:: with SMTP id f41-v6mr13291581qtc.190.1531701675659;
 Sun, 15 Jul 2018 17:41:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3666:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 17:41:15
 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 16 Jul 2018 10:41:15 +1000
Message-ID: <CAPM=9tzwffMdqNuqeMTosei7TZZiC=QCpawQC+-8_WWqZnN=QA@mail.gmail.com>
Subject: [git pull] drm-fixes for 4.18-rc6 (well it was for -rc5)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Not actually back online fully, but I've managed to find a few minutes
to pull in all the fixes that were meant for rc5 but have leaked over.

There are two AGP fixes in here, as well as a bunch of mostly amdgpu
fixes, along with a sun4i build fix, two armada fixes and some tegra
fixes, one i915 core and one i915 gvt fix.

Hopefully be back on schedule for rc6.

Thanks,
Dave.

drm-fixes-2018-07-16-1:
i915, amdgpu, armada, sun4i and tegra fixes
The following changes since commit dc81aab1be9fac2e11f31fe7538a50705eba08cf=
:

  MAINTAINERS: update drm tree (2018-07-10 10:59:58 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-07-16-1

for you to fetch changes up to bf642e3a1996f1ed8f083c5ecd4b51270a9e11bc:

  Merge tag 'drm-intel-fixes-2018-07-12' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2018-07-16
10:32:28 +1000)

----------------------------------------------------------------
i915, amdgpu, armada, sun4i and tegra fixes

----------------------------------------------------------------
Alex Deucher (2):
      Revert "drm/amd/display: Don't return ddc result and read_bytes
in same return value"
      drm/amdgpu/pp/smu7: use a local variable for toc indexing

Andrey Grodzovsky (1):
      drm/amdgpu: Verify root PD is mapped into kernel address space (v4)

Arnd Bergmann (1):
      drm/sun4i: link in front-end code if needed

Christian K=C3=B6nig (1):
      drm/amd/display: fix invalid function table override

Dave Airlie (6):
      Merge tag 'drm-intel-fixes-2018-07-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm/tegra/for-4.18-rc5' of
git://anongit.freedesktop.org/tegra/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2018-07-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-armada-fixes' of
git://git.armlinux.org.uk/~rmk/linux-arm into drm-fixes
      Merge tag 'drm-intel-fixes-2018-07-12' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

David Francis (1):
      amd/dc/dce100: On dce100, set clocks to 0 on suspend

Dmitry Osipenko (2):
      gpu: host1x: Skip IOMMU initialization if firewall is enabled
      gpu: host1x: Check whether size of unpin isn't 0

Gustavo A. R. Silva (1):
      char: amd64-agp: Use 64-bit arithmetic instead of 32-bit

Hang Yuan (1):
      drm/i915/gvt: update vreg on inhibit context lri command

Harry Wentland (1):
      drm/amd/display: Convert 10kHz clks from PPLib into kHz for Vega

Michel D=C3=A4nzer (1):
      drm/amdgpu: Reserve VM root shared fence slot for command submission =
(v3)

Mikko Perttunen (1):
      drm/tegra: Fix comparison operator for buffer size

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2018-07-11' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Russell King (2):
      drm/armada: fix colorkey mode property
      drm/armada: fix irq handling

Souptick Joarder (1):
      char: agp: Change return type to vm_fault_t

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix hotplug irq ack on i965/g4x

 drivers/char/agp/alpha-agp.c                       |  2 +-
 drivers/char/agp/amd64-agp.c                       |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  4 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 20 ++++++--------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  5 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  | 10 ++-----
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 27 ++++++++++++++++--
 .../drm/amd/display/dc/dce100/dce100_resource.c    | 19 +++++++++++--
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |  5 ++--
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 23 ++++++++--------
 drivers/gpu/drm/armada/armada_crtc.c               | 12 ++++++--
 drivers/gpu/drm/armada/armada_hw.h                 |  1 +
 drivers/gpu/drm/armada/armada_overlay.c            | 30 ++++++++++++++----=
--
 drivers/gpu/drm/i915/gvt/cmd_parser.c              | 23 ++++++++++++++++
 drivers/gpu/drm/i915/gvt/gvt.h                     | 29 ++++++++++++++++++=
++
 drivers/gpu/drm/i915/gvt/handlers.c                | 24 ++++++++++++++++
 drivers/gpu/drm/i915/gvt/mmio.h                    |  2 ++
 drivers/gpu/drm/i915/gvt/mmio_context.c            |  4 ++-
 drivers/gpu/drm/i915/i915_irq.c                    | 32 ++++++++++++++++++=
++--
 drivers/gpu/drm/sun4i/Makefile                     |  5 +++-
 drivers/gpu/drm/tegra/drm.c                        |  2 +-
 drivers/gpu/host1x/dev.c                           |  3 ++
 drivers/gpu/host1x/job.c                           |  3 +-
 24 files changed, 233 insertions(+), 60 deletions(-)
