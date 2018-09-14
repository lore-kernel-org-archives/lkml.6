Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C643C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8890220861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdvXrQPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8890220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeINHMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:12:33 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34911 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeINHMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:12:33 -0400
Received: by mail-qt0-f179.google.com with SMTP id j7-v6so7413783qtp.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 19:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=3pwsSPKMrZBOManHClzRzSXqbO6DYtTKX2ujv0eHHZo=;
        b=TdvXrQPvDIuo4uQKePKJJ2YGvqWnwZO6pvxWKanSjGd1IXdeNsbbKH5ME29d86RrJF
         YrB95nNX+4D37wroY4mN8cGmJzfqcZ8WYhUBUV768logwV4NOkLYKPgdrE+aQIA2Wazb
         ZCf3uouSmVUzkuqMhaN6zcqx1Q6R2KQ9ZuWI2V8iEil989RuR8QhB5dDL4TfCVzJU2qM
         Jl+EWExjTYe9z4Oabi0uVc6eSiA1wirYfjLsZbWvFjG70yCXWDHaLyKTw1++NwdwA+dp
         ZYrlfX5xLCcfESYIZbKY5ZSR+hIpOvD1+5SnoVI3nrU4UEQHlRs4Z3f8AT56yzDVtFHm
         vbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=3pwsSPKMrZBOManHClzRzSXqbO6DYtTKX2ujv0eHHZo=;
        b=GBSJ2gNrddkIJ5YshOhJ0YS6/pQdZrA9prA/6QMEyzBtAR1em2fWY/sGMvQur+iOih
         QUKJOiAi1YWCb38Krr7ikm9OntC3nCklks62eqfTzEdAeiAQ70N5UfFP3wpiDmtHYGa3
         iDoB0PVkrZfPb2574JHxcftKHGUEw7d7pCqUAAYWzQh70kGZOcefLQssYn7Iiz+XyIQT
         0NSq2HGQ7baAmzBJQpEYka+6k+D5LCVQmG21O/xSfx9/JAQNJ7tskWGBnzWeX4AjkP68
         ejYpLted0/iUm27OeY5rx71UQ+kN5Tb/VnkDTCslc+NGbczMXtoioJQRQhQ+19+Quq5h
         ZHnA==
X-Gm-Message-State: APzg51AXnVXchKK7pnZFe3Wdv3adywPuIXry26Zomn3gFuCSPHDuu9xL
        zH48+GuCio8sRHEGSTq4sbIsCqhLe72q1r83eJw=
X-Google-Smtp-Source: ANB0VdZ5x9hfIWfeERtzQk3Br7Mp40k9ElIsFGsiOG858ZCSnLiEpDsDO9zoO/PJfW7zMAA4hdajXThKJcr6VmgNJUU=
X-Received: by 2002:a0c:b88f:: with SMTP id y15-v6mr7303610qvf.203.1536890425915;
 Thu, 13 Sep 2018 19:00:25 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 14 Sep 2018 12:00:13 +1000
Message-ID: <CAPM=9tyHrA5a+gxtakZ+QFvUF0XB61_x_dD6fGprwojkFAA8AQ@mail.gmail.com>
Subject: [git pull] drm fixes for v4.19-rc4
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

This is the general drm fixes pull for rc4.

i915:
   Two GVT fixes (one for the mm reference issue you pointed out).
   Gen 2 video playback fix
   IPS timeout error suppression on Broadwell

amdgpu:
   Small memory leak, SR-IOV reset, locking and updated SDMA golden registe=
rs

nouveau:
   Remove some leftover debugging.

Thanks,
Dave.

drm-fixes-2018-09-14:
i915, amdgpu and a single nouveau cleanup
The following changes since commit 2887e5ce15ddaa2f9a19e66f7462bbf0fe6867e0=
:

  Merge branch 'linux-4.19' of git://github.com/skeggsb/linux into
drm-fixes (2018-09-11 16:54:46 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-09-14

for you to fetch changes up to 2b6318a09fd346edea42a60f8d0c07b2eea2d079:

  Merge branch 'linux-4.19' of git://github.com/skeggsb/linux into
drm-fixes (2018-09-14 09:38:42 +1000)

----------------------------------------------------------------
i915, amdgpu and a single nouveau cleanup

----------------------------------------------------------------
Ben Skeggs (1):
      drm/nouveau/devinit: fix warning when PMU/PRE_OS is missing

Chris Wilson (1):
      drm/i915/overlay: Allocate physical registers from stolen

Christian K=C3=B6nig (2):
      drm/amdgpu: fix amdgpu_mn_unlock() in the CS error path
      drm/amdgpu: fix error handling in amdgpu_cs_user_fence_chunk

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2018-09-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge branch 'linux-4.19' of git://github.com/skeggsb/linux into drm-=
fixes

Emily Deng (1):
      drm/amdgpu: move PSP init prior to IH in gpu reset

Imre Deak (1):
      drm/i915/bdw: Increase IPS disable timeout to 100ms

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2018-09-10' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Tao Zhou (1):
      drm/amdgpu: Fix SDMA hang in prt mode v2

Weinan Li (1):
      drm/i915/gvt: Fix the incorrect length of child_device_config issue

Zhenyu Wang (1):
      drm/i915/gvt: Fix life cycle reference on KVM mm

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  25 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   7 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |  10 +-
 drivers/gpu/drm/i915/gvt/opregion.c                |  20 +-
 drivers/gpu/drm/i915/intel_display.c               |   8 +-
 drivers/gpu/drm/i915/intel_overlay.c               | 228 +++++++----------=
----
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c    |  21 +-
 8 files changed, 131 insertions(+), 190 deletions(-)
