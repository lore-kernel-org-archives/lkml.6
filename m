Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BCD68C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6855320020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7omco+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6855320020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935470AbeFMMQb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:16:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40928 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935273AbeFMMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:16:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so4940161wmc.5;
        Wed, 13 Jun 2018 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6cGf3uzrY0XFDG4MhLmH1ixeDh3doHOCLOTGKr2kjgQ=;
        b=g7omco+AFmdxdof9o00UPMj86O8erSNWyO4PNbcagS826HVe/GG0JuihBdVn6wxZbJ
         8A/g3OeRof/suaQP03MLCDMYV8hMuitUOrHZbNPQfO2PwB9l78kccWPF/Z3YEF0dFaGi
         NdH7aMrs5nUV8AuD23vmb0XqvTtk4d81bWX+sfIL8qbdb+rgpFUUv3N/xQqQQxIdv5Kj
         hTZwG5ahojNnpWCLSYuHhT1PjD/tiBSgWWfX0j950vjFUkF73md+LpFLL7R8QXQ/9mC7
         +DKCOVm21nUGxSCTcw9kfYZjNnCADdFX+bJUiPeOjPRpbQV0DDaCCa42k3LRzISRxCuM
         3l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6cGf3uzrY0XFDG4MhLmH1ixeDh3doHOCLOTGKr2kjgQ=;
        b=QL2ZN0JzePLLewWOg8oUsm9IsAWuPFidqwi4UUOCnneENkCrnp9hwrGfYY5a+jd7/M
         09JeWyUObf8okDgYqA515jnlumbksSAmN97M12+NKCvqnqH3sUjGqV+bZxZvlIz+K0fP
         QWPb93NuThxMbKmMok+ACdimvtJDAOwWlSy7+QO23HemKycEKgbGGpGtU7qBKwvo1S6D
         WSaAuP4rVqcBGv1H/8jq+3MLI4rAdSUxGVR5/hjCVcMYKyuMqdkiLJ/l7kR3xfF0Bzxv
         AhUMkS8BM9BbKWxhbR8HYlla/V6jYBfss7cGrs4ypeVQHJYU2SGNvqcWsZxIpOzYqsRY
         E/kQ==
X-Gm-Message-State: APt69E1AwsC4AI8fnYkLjOd/hUJ7UKxmcZZqcdViZP0juptyeXK8ExbY
        j0Ntoqh3QRs1Fa/uj1acZAqGmw==
X-Google-Smtp-Source: ADUXVKKXhinHnQy57tWO7dY/7ejFQhZazgxWT0k6GsgXbg5xQyu0qGmwV/xjXB+XFEUcOCCut3e/TA==
X-Received: by 2002:a1c:8941:: with SMTP id l62-v6mr3293024wmd.26.1528892188335;
        Wed, 13 Jun 2018 05:16:28 -0700 (PDT)
Received: from localhost (pD9E510DD.dip0.t-ipconnect.de. [217.229.16.221])
        by smtp.gmail.com with ESMTPSA id z83-v6sm3515235wmb.8.2018.06.13.05.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:16:27 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v4.18-rc1
Date:   Wed, 13 Jun 2018 14:16:26 +0200
Message-Id: <20180613121626.17188-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.18-rc1

for you to fetch changes up to 414c52b7899aa9097c2fa8444654a866e1df4a0c:

  pwm: stm32: Fix build warning with CONFIG_DMA_ENGINE disabled (2018-06-06 10:15:55 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.18-rc1

This contains a couple of fixes and cleanups for the Meson and ACPI/LPSS
drivers as well as capture support for STM32. Note that given the cross-
subsystem changes, the STM32 patches were merged through the MFD and PWM
trees, both sharing an immutable branch.

----------------------------------------------------------------
Arnd Bergmann (2):
      pwm: stm32: Enforce dependency on CONFIG_MFD_STM32_TIMERS
      pwm: stm32: Fix build warning with CONFIG_DMA_ENGINE disabled

Fabrice Gasnier (5):
      mfd: stm32-timers: Add support for DMAs
      pwm: stm32: Add capture support
      pwm: stm32: Improve capture by tuning counter prescaler
      pwm: stm32: Use input prescaler to improve period capture
      dt-bindings: mfd: stm32-timers: Add support for dmas

Hans de Goede (2):
      pwm: lpss: platform: Save/restore the ctrl register over a suspend/resume
      ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices

Martin Blumenstingl (1):
      pwm: meson: Fix allocation of PWM channel array

Thierry Reding (1):
      Merge tag 'ib-mfd-pwm-v4.18-1' of git://git.kernel.org/.../lee/mfd into for-next

Wolfram Sang (1):
      pwm: simplify getting .drvdata

 .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
 drivers/acpi/acpi_lpss.c                           |   2 +
 drivers/mfd/stm32-timers.c                         | 201 +++++++++++++++-
 drivers/pwm/Kconfig                                |   2 +-
 drivers/pwm/pwm-atmel-tcb.c                        |   6 +-
 drivers/pwm/pwm-lpss-platform.c                    |   5 +
 drivers/pwm/pwm-lpss.c                             |  30 +++
 drivers/pwm/pwm-lpss.h                             |   2 +
 drivers/pwm/pwm-meson.c                            |   4 +-
 drivers/pwm/pwm-rcar.c                             |   3 +-
 drivers/pwm/pwm-stm32.c                            | 255 +++++++++++++++++++++
 include/linux/mfd/stm32-timers.h                   |  58 +++++
 12 files changed, 577 insertions(+), 11 deletions(-)
