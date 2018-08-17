Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8313E21479
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YboqQsIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8313E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeHQEK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:10:59 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36359 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeHQEK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:10:59 -0400
Received: by mail-qk0-f177.google.com with SMTP id 93-v6so3878021qks.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 18:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=A1CrGNIAZjnJGwqlu7qArSAHoMkhrLHTbiN+ig2lzK4=;
        b=YboqQsIu3h/mY5B+Y5xO1rHgO/aOuzEzfa0ZMVu1omisuvXmcZ+Q/tMXWmybmaPFbo
         z1cBUuE+zphwRwEOKZnhrR62saMhFPvAFNnTxPmi1xOLVuvifZSNSPQcO084KbGcTfXP
         Nv+hMqLKHQyjcx3Op5TFUaREztiz9ZA8Ju1L3mnK0PLDitGZVsDO8zv2KLkhmNUy+IUS
         hR6vopHFXThirP/TpAVuqcmPV4E1IU+xhRUsU1IplmNxp5pAmknvH0T+DCYa2h3a/4BQ
         1EIIucghjOvXGgtmseKEqcqUksTw0KixR4Zg+aHRJn7VvT8WCR9tV0Uxddwmwb5aTg+F
         iQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=A1CrGNIAZjnJGwqlu7qArSAHoMkhrLHTbiN+ig2lzK4=;
        b=Izu1EH+26dK2noTFvxQ67I2axmX7V3P6YmGFTgKaX9OoJJWmU3cVY3xBAsQ7fAlnxN
         gDT9jyCmjxrUmi8QYV8xz/gVWcNkf/f6QFKR9tiSYrmwSSjEWzeNwKtZnZUuOvlXpaGm
         z9t2tshPAPfrW+bw5C3LSz7NrYimL5bQ8/zKnSyHh/MLPY7Xow3/dGTWA4yXQtg3Ef+p
         eYfF3ICLRnNOUxVGx85Q5cBPkawQKeGTVgjeMFnXU5gVDoWwV70PpYyZrJJAdnA6ELsi
         104WhOKbv7MBox5Uq0RkVkpq6eQxO3dLKwdl0Qaz6RnpuCvyMj4olR8d72qDknwsCYu4
         nCFA==
X-Gm-Message-State: AOUpUlFuuqkurwb1dLUJ+uQiJV+k+W9joai/TQjgEDFp4+ZJ6N6yMIOO
        IWGCthnfok+W5liBkbWkPnT7j7CKoCbbFBWvGQPT+6yy
X-Google-Smtp-Source: AA+uWPzzCTMKkeBRQeAL6vZB05BxvnIZYx8WRrJ7bGvOAvv8PF0aTRgMZvz3xiWfqSNN80yCrf82rvhhQyw5J3WDHTE=
X-Received: by 2002:a37:a484:: with SMTP id n126-v6mr260497qke.56.1534468181768;
 Thu, 16 Aug 2018 18:09:41 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 17 Aug 2018 11:09:30 +1000
Message-ID: <CAPM=9tzM6rGXMts-Fv7CGtk14ig31BBcGgo20DrjMiW3kkDU0A@mail.gmail.com>
Subject: [git pull] drm msm support for adreno a6xx
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

This is the support for new Qualcomm Snapdragon SoCs with the A6xx
core. Userspace support is in mesa now.

I've edited the pull req down to only show the msm diffs vs the fixes pull
I sent earlier, but this branch contains all of that as well.

Thanks,
Dave.

drm-next-2018-08-17-1:
msm a6xx new hardware support
The following changes since commit 557ce95051c8eff67af48612ab350d8408aa0541=
:

  Merge branch 'drm-next-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2018-08-10
11:43:02 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-08-17-1

for you to fetch changes up to 3d63a3c14741ed015948943076f3c6a2f2cd7b27:

  Merge tag 'drm-msm-next-2018-08-10' of
git://people.freedesktop.org/~robclark/linux into drm-next (2018-08-17
10:46:51 +1000)

----------------------------------------------------------------
msm a6xx new hardware support

----------------------------------------------------------------
Colin Ian King (1):
      drm/msm: a6xx: fix spelling mistake: "initalization" -> "initializati=
on"

Dave Airlie (1):
      Merge tag 'drm-msm-next-2018-08-10' of
git://people.freedesktop.org/~robclark/linux into drm-next

Jordan Crouse (3):
      drm/msm: Add a helper function to parse clock names
      drm/msm/adreno: Load the firmware before bringing up the hardware
      drm/msm: Add A6XX device support

Rob Clark (1):
      drm/msm: update generated headers

 drivers/gpu/drm/msm/Makefile                   |    3 +
 drivers/gpu/drm/msm/adreno/a2xx.xml.h          |   57 ++--
 drivers/gpu/drm/msm/adreno/a3xx.xml.h          |   24 +-
 drivers/gpu/drm/msm/adreno/a4xx.xml.h          |  193 +++++++++++--
 drivers/gpu/drm/msm/adreno/a5xx.xml.h          |  483
++++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx.xml.h          | 4562
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c          | 1207
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h          |  162 +++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h      |  382 ++++++++++++++++++++=
+++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c          |  818
++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h          |   60 ++++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c          |  435
++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h          |  127 +++++++++
 drivers/gpu/drm/msm/adreno/adreno_common.xml.h |   38 ++-
 drivers/gpu/drm/msm/adreno/adreno_device.c     |   35 ++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c        |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h        |    5 +-
 drivers/gpu/drm/msm/adreno/adreno_pm4.xml.h    |  497
++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4.xml.h       |   26 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h       |   26 +-
 drivers/gpu/drm/msm/disp/mdp_common.xml.h      |   26 +-
 drivers/gpu/drm/msm/dsi/dsi.xml.h              |   13 +-
 drivers/gpu/drm/msm/dsi/mmss_cc.xml.h          |   26 +-
 drivers/gpu/drm/msm/dsi/sfpb.xml.h             |   26 +-
 drivers/gpu/drm/msm/edp/edp.xml.h              |   26 +-
 drivers/gpu/drm/msm/hdmi/hdmi.xml.h            |   26 +-
 drivers/gpu/drm/msm/hdmi/qfprom.xml.h          |   26 +-
 drivers/gpu/drm/msm/msm_drv.c                  |   57 ++++
 drivers/gpu/drm/msm/msm_drv.h                  |    4 +
 drivers/gpu/drm/msm/msm_gpu.c                  |   62 +---
 drivers/gpu/drm/msm/msm_gpu.h                  |    2 +-
 31 files changed, 9133 insertions(+), 303 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx.xml.h
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_gmu.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_gmu.h
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_gpu.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_gpu.h
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_hfi.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_hfi.h
