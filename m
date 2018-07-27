Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12F5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DB720857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9wWbcoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DB720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbeG0FeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:34:24 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:39130 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeG0FeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:34:24 -0400
Received: by mail-qk0-f176.google.com with SMTP id b5-v6so2492933qkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 21:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iPPvON/yiUjlXeLLOE5U9jXUIJ2mM32QkMDQVuBkbf4=;
        b=B9wWbcoYMgynGHokG4VzIcjpzO0+7zvQ4QFEsEMdvnLVGPLOecv1EWdjP92KVD83q4
         O13qqTvETeWLF3u8oOmp6HYgsso+Xv+IQSgREtOPINHQbmwqzsW0Vm/UbGbKHhrQdQLm
         ap9FIrQLO5FEOA9YE0i81LK8Rl7nfEmHVNmS5x530XivrxkQ0RLgixXiDAzlDo68OaB7
         CDXxjoGkvCL+SNiWX9anW4o4gHrs3qjdSn/F5l5T2o+ZRUL65S57r2HRW6nz7aiDrpCA
         o9i8o9skaf1mVEMdKmk8klozUNXQ5K+vv7393r6Zb+D6jweUfxx6QpyN68UwDtwwh7d/
         ukEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iPPvON/yiUjlXeLLOE5U9jXUIJ2mM32QkMDQVuBkbf4=;
        b=l7UdbPt8e7g1HpREDLEoHvUUgQ5ZNEKJLKA1xokLOa74ilLLgP5X9c/rm48nF1/4QH
         0dSftwyrp9qcjIEVTlX/dSaRidfU4qz8ggCieT1QUJyfilhn70ccT7DWpUke1hT68bms
         n0NTrLWToxwzjKwKueVBjVFO9XtoNEF8BaFWvGLGxeNL4jzqX3JEpih/qXonVpS6ms0y
         swb1vRJviNvysgzaOd1AKviPxYQ6Cd9v5yku74Qa1vnHI2OC5lM7B9bG1HCB9hfgb9ep
         UzkQGcXCy5oHoTyB3mOmQo+8Iqk0MDqUaZkqZx9i2HNZuG8RkTH32suLRvtQ5+3ekA9x
         smcw==
X-Gm-Message-State: AOUpUlHsTU4+zvHBQdTVyA24PNp26ik3he7Ce5lX7eytPkWPNIS7Mqfo
        Nj7PHr5YLDqsqs0abE7mx7MYvxYj3W9xkcbfpb18mKzm
X-Google-Smtp-Source: AAOMgpfSWEZj8jc1YzGWzGpj1/Jf8pBvtWUBTIAcGS2QTVmu6rw7Dk4IDekO5p0+HQDI1142y+IcfDgJOAHPtUyxHvM=
X-Received: by 2002:a37:5b47:: with SMTP id p68-v6mr4293921qkb.202.1532664868173;
 Thu, 26 Jul 2018 21:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3666:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 21:14:27
 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 27 Jul 2018 14:14:27 +1000
Message-ID: <CAPM=9tySPSST_j3KPqPUFvfAbrA63+6zS_QsFZEiuBVja=yRDA@mail.gmail.com>
Subject: [git pull] drm fixes for 4.18-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Not much happening this week which is good, two imx display fixes and
one i915 quirk addition.

Dave.

drm-fixes-2018-07-27:
two imx fixes and one i915 fix.
The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-07-27

for you to fetch changes up to 050d2a5533af362932553cb47fd5db9a3476074e:

  Merge tag 'imx-drm-fixes-2018-07-20' of
git://git.pengutronix.de/git/pza/linux into drm-fixes (2018-07-27
12:17:31 +1000)

----------------------------------------------------------------
two imx fixes and one i915 fix.

----------------------------------------------------------------
Clint Taylor (1):
      drm/i915/glk: Add Quirk for GLK NUC HDMI port issues.

Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2018-07-26' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'imx-drm-fixes-2018-07-20' of
git://git.pengutronix.de/git/pza/linux into drm-fixes

Lucas Stach (2):
      drm/imx: imx-ldb: disable LDB on driver bind
      drm/imx: imx-ldb: check if channel is enabled before printing warning

Steve Longerbeam (1):
      gpu: ipu-csi: Check for field type alternate

 drivers/gpu/drm/i915/i915_drv.h      |  1 +
 drivers/gpu/drm/i915/intel_ddi.c     | 13 +++++++++++--
 drivers/gpu/drm/i915/intel_display.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/i915/intel_drv.h     |  3 +--
 drivers/gpu/drm/imx/imx-ldb.c        |  9 ++++++---
 drivers/gpu/ipu-v3/ipu-csi.c         |  3 ++-
 6 files changed, 41 insertions(+), 9 deletions(-)
