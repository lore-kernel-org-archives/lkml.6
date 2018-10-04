Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD76C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AA520684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4T0+vKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AA520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeJDLrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:47:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46856 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeJDLrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:47:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id q12-v6so4931177qkl.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 21:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KWan0y0P9Gqm7gNIL6jbTbcKFXt5g5uoZFZ1/xSM2m4=;
        b=e4T0+vKwas0w1WyF55bhhlz6oPD0hsWmxILSQg5v1mUDjbujYwr1ig/5mm24/HeIw8
         guTV0cjYv5PuihshQb/4Gn3Im32GQVNqHEZj58v3tZ9XnhZd4zAicMOGWZydN7u+eEFg
         IvugtFeoMrkWV2nQN1f9py7QDCMp8/wgH+BicWhma3v18/OWhW35+NEoOls/ntYS8osJ
         VzVdqn90CMfZGqVjWrgOzpdaHFze2F5Loy6kF4ms350SofSDe7EZusH6fWyCptj2cqmm
         DX+JwEsMDls1NTgQmmwJLzuYzCG3h/qpvlm5s0u/a24f6eoJitH6G2ec1ElICNVVhdOj
         etrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KWan0y0P9Gqm7gNIL6jbTbcKFXt5g5uoZFZ1/xSM2m4=;
        b=lJMdROju/6eSe3hDns5hKApFjw5vHt/ZWNXM1uKdTGNO4rJSLBKNA5JhGwUN7AFkl7
         LzonTZNnK23GGk1TYYvtjqkdcC5Kqs1TLpPBPl3Ccd3kfXyvhbi1qd9WysubuuuSWWwW
         BGT0r1cPZg7Q8B8qYGMCYn8mNl2JXcNATdGbWMOm2/skDIBT/t+Eb6VNcy4O8sCy6goZ
         jIMZKGWcc69jnHB0ZLj95JM5HCAJ3YATb3K99TRzLIZmtYAyED/RJ5HJCfa4TBus04oB
         bTQPF/D9DFr1bdtib0VF6yMxJfCgRQM9DfLUuyaSAjhGuxn0z+pxS7VER5jJLlXpyTrw
         +duA==
X-Gm-Message-State: ABuFfoiQdMyYj8bcwChw58ruPktN0HwkhVhngisHo3PCHuWKL9DzQY7R
        6MhKexR77Johnt41zkSH4N/pa2kE/UMv2xaLM8A=
X-Google-Smtp-Source: ACcGV61abR9jEXEWSuuVeIMbRhVDsrG+oGVnHgiTpV62X+I6iylBKU5aPeOPQIP+1zYA8jE6Lkt3THbtkUppMkTSCks=
X-Received: by 2002:a37:a215:: with SMTP id l21-v6mr3760004qke.101.1538628954384;
 Wed, 03 Oct 2018 21:55:54 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 4 Oct 2018 14:55:42 +1000
Message-ID: <CAPM=9txkgTxe=uAHSovtTk_wGTtLEOodkFFDm+DxOKb8_Z7_pw@mail.gmail.com>
Subject: [git pull] drm fixes for 4.19-rc7
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Nothing too much happening at this point,

3 i915 fixes:
compressed error handling zlib fix
compiler warning cleanup
and a minor code cleanup

2 tda9950:
Two fixes for the HDMI CEC

1 exynos:
A fix required for IOMMU interaction.

Thanks,
Dave.

drm-fixes-2018-10-04:
drm exynos, tda9950 and intel fixes
The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-10-04

for you to fetch changes up to d8938c981f58ee344687b7910a611ac345960045:

  Merge branch 'drm-tda9950-fixes' of
git://git.armlinux.org.uk/~rmk/linux-arm into drm-fixes (2018-10-04
10:32:14 +1000)

----------------------------------------------------------------
drm exynos, tda9950 and intel fixes

----------------------------------------------------------------
Anusha Srivatsa (1):
      drm/i915: Do not redefine the has_csr parameter.

Chris Wilson (2):
      drm/i915: Avoid compiler warning for maybe unused gu_misc_iir
      drm/i915: Handle incomplete Z_FINISH for compressed error states

Colin Ian King (1):
      drm/i2c: tda9950: fix timeout counter check

Dave Airlie (3):
      Merge tag 'exynos-drm-fixes-for-v4.19-rc7' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge tag 'drm-intel-fixes-2018-10-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-tda9950-fixes' of
git://git.armlinux.org.uk/~rmk/linux-arm into drm-fixes

Hans Verkuil (1):
      drm/i2c: tda9950: set MAX_RETRIES for errors only

Marek Szyprowski (1):
      drm/exynos: Use selected dma_dev default iommu domain instead of
a fake one

 drivers/gpu/drm/exynos/exynos_drm_iommu.h | 34 +++---------
 drivers/gpu/drm/i2c/tda9950.c             |  5 +-
 drivers/gpu/drm/i915/i915_gpu_error.c     | 88 ++++++++++++++++++++++---------
 drivers/gpu/drm/i915/i915_gpu_error.h     |  1 +
 drivers/gpu/drm/i915/i915_irq.c           | 33 +++++-------
 drivers/gpu/drm/i915/i915_pci.c           |  1 -
 6 files changed, 85 insertions(+), 77 deletions(-)
