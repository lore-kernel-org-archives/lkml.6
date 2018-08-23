Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02150C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940A7208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9smjCF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940A7208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbeHWRBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:01:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36262 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeHWRBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:01:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id m27-v6so4668538wrf.3;
        Thu, 23 Aug 2018 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gLpKDEKW7vx2GEQc+W4lWlhd9BeZCdwR1Y5rTs3StPU=;
        b=E9smjCF2BvAHyLOELxVPwgs0GOwh1Olh0ET5V8c+JckYO77My6GlnTcp4LYhYfk9Xg
         5V9X5L+x6JId28BGcKp6WQkufiqdUe7FPld+Yh6Bymu28ruwhUR91JCDezXOPiY/AgAI
         hh5pV1V5HEb7QyMiQsiEsBUyGfhUwn7CanVvHYrs/8v8IJMfXOo8GzIQ6n0qD+ifw7Ze
         ybWMfBfjuxZX2B3aEKnss/HwWHRKIhobEPtCMD+Pf4fjjiIj0SH3Eqdo014SFoJ4LQBG
         0eIeeipmffYBBG/SoVJtWYGCtbLdnqpcDMbCvHDBoUX82IrYl6td/T12WN4aAaEUAHEH
         06kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gLpKDEKW7vx2GEQc+W4lWlhd9BeZCdwR1Y5rTs3StPU=;
        b=GylU5pgaLoj22emuIlUUPwPmF5/nHMJWVkhUnkkd98v4NMHmYGfbGPsDBZLZ/XLRCE
         tUElzr26o+QKMxxgZKAMmlatjb8gmlDaNl3NqaawywWzjiU1jXJGDAziRMgfZ+Mz3vc/
         V9ck7bAeYiaUrBNZyJQm968ZxxZobGZSasSHuN7i8WqYikknk9x182tE3w3X3l5eScau
         PykwTLMJksI7VEoSVF+U1pZD3viWmbDr3lt3zLeGBUPkj/14MK023I0aVd+V4cipttIi
         koHzZbXRi2GVMOJrJ+TyC43AkXF7ZVhO+CZtA3wOjEqthLQN4KA70HKDBE5ua2ulfH+i
         7M3A==
X-Gm-Message-State: APzg51CLwGk080zmMt8PJViV1ry9GO7ilTK87+eSfd4Pon88Bwd5zK3d
        IcDCs0EW+uQgFKiFy2WkioXjmFnZ
X-Google-Smtp-Source: ANB0Vdb/HDiXPUN2dwjolbjHsF68GkZWYwkJhmfqARTGxoNx4dfp/5T6bjvIyaTFl5u3UOzPlzw0jA==
X-Received: by 2002:adf:ea92:: with SMTP id s18-v6mr7013103wrm.284.1535031099212;
        Thu, 23 Aug 2018 06:31:39 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7979526wmd.22.2018.08.23.06.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 06:31:38 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v4.19-rc1
Date:   Thu, 23 Aug 2018 15:31:37 +0200
Message-Id: <20180823133137.32199-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.19-rc1

for you to fetch changes up to 8cdc43afbb2cb58692c49fab0b13e2d9439c0642:

  pwm: mediatek: Add MT7628 support (2018-08-20 11:36:07 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.19-rc1

This contains mostly minor bug fixes as well as some new chip support
for existing drivers.

----------------------------------------------------------------
David Rivshin (1):
      pwm: omap-dmtimer: Return -EPROBE_DEFER if no dmtimer platform data

Enric Balletbo i Serra (1):
      pwm: cros-ec: Switch to SPDX identifier

Fabio Estevam (2):
      pwm: imx: Switch to SPDX identifier
      pwm: mxs: Switch to SPDX identifier

Fabrice Gasnier (1):
      pwm: stm32-lp: Remove useless loop in stm32_pwm_lp_remove()

Jerome Brunet (1):
      pwm: meson: Fix mux clock names

John Crispin (2):
      dt-bindings: pwm: Add MT7628 information
      pwm: mediatek: Add MT7628 support

Thomas Hebb (1):
      pwm: berlin: Don't use broken prescaler values

Vignesh R (2):
      pwm: tiehrpwm: Don't use emulation mode bits to control PWM output
      pwm: tiehrpwm: Fix disabling of output of PWMs

Yoshihiro Shimoda (1):
      dt-bindings: pwm: rcar: Add bindings for R-Car E3 support

shenwei.wang@nxp.com (4):
      pwm: fsl-ftm: Added a dedicated IP interface clock
      pwm: fsl-ftm: Added the support of per-compatible data
      pwm: fsl-ftm: Enable support for the new SoC i.MX8QM
      dt-bindings: pwm: fsl-ftm: Add compatible string for i.MX8QM

 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        |  5 +-
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |  4 +-
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  1 +
 drivers/pwm/Kconfig                                |  2 +-
 drivers/pwm/pwm-berlin.c                           | 45 +++++++++--------
 drivers/pwm/pwm-cros-ec.c                          |  9 ++--
 drivers/pwm/pwm-fsl-ftm.c                          | 57 +++++++++++++++++++---
 drivers/pwm/pwm-imx.c                              |  5 +-
 drivers/pwm/pwm-mediatek.c                         | 19 +++++++-
 drivers/pwm/pwm-meson.c                            |  3 +-
 drivers/pwm/pwm-mxs.c                              |  8 +--
 drivers/pwm/pwm-omap-dmtimer.c                     |  5 +-
 drivers/pwm/pwm-stm32-lp.c                         |  4 +-
 drivers/pwm/pwm-tiehrpwm.c                         | 14 ++----
 14 files changed, 115 insertions(+), 66 deletions(-)
