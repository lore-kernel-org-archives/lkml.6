Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40661C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074002075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVJ6aCI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074002075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeJWThA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:37:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52842 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:37:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so1347595wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=1HyQ2bbt9cszvfk9MAVeEWT6agyVikeeJCuUYA9t1mo=;
        b=hVJ6aCI4cDA8F0NBkHN1lGHYIePWfMnqM6mW2c6sY+ZXlpRaITick0bdKzf48cGMLn
         tnhYzKnOnCXKqHvZvLKz+6VxT36nBZ9NjYm0Vf45oO5InmwEYiBBs3pqp3XCaZc8ee6p
         uPT7REPf18SEfEhsFK+4jKsaNZd0j8SDO7dHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=1HyQ2bbt9cszvfk9MAVeEWT6agyVikeeJCuUYA9t1mo=;
        b=KyzWlEp1nXDZqn1vn2XvF/Bjtff7XiwKoG7CEFxlrqstbJ3DqBpc1F78XcRJIDHRvw
         PNUUHOLXNu9NQYkkb6t/NGAeBb46weAsS7heJ8IO0lp7n14ymZCgm6HzH1Tmu7cgfINZ
         SeaVT6RC0MQZBBaDTBticR3vBbd5adRTDTOuTq3TednMG5baLrj9kXaS3QM5xsVzbeZ/
         gS50WE0Vmsw29IllxzdpF25LiyEOHqRSlNYgveNZtTrLU1I/G/wpQn/ilClDJOSESrYC
         +4a/plxStczjeO8Cgrg8U7BIhQHlpVnUxEYM0fmktthFitytasRlmP19vr0fGobgEJPq
         /5qw==
X-Gm-Message-State: ABuFfog/H39EVSkGzARqK8DNRsUZNIaaWV4WULYSJ/kFMYpzSRpCNX8t
        Rvbn+tn2JkXl9TDC9Qq4NgUNKZ7Z++U=
X-Google-Smtp-Source: AJdET5evRaifu8hy6gjcEvN4NeABnJg5oWbiNrisFvndciugRgWIyGnYt2gdrmLj12rBpPB47K+SYg==
X-Received: by 2002:a1c:204:: with SMTP id 4-v6mr20682155wmc.138.1540293238229;
        Tue, 23 Oct 2018 04:13:58 -0700 (PDT)
Received: from dell ([2.27.167.33])
        by smtp.gmail.com with ESMTPSA id q1-v6sm568445wru.23.2018.10.23.04.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:13:57 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:13:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v4.20
Message-ID: <20181023111355.GY4939@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Welcome back.

Enjoy!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-4.20

for you to fetch changes up to e1c9f2eaa0fbfda0ca0d958e98fe0c458ecfa96d:

  backlight: Remove ld9040 driver (2018-10-09 02:59:20 -0700)

----------------------------------------------------------------
 - Old Drivers
   - Remove driver for S6E63M0
   - Remove driver for LD9040

 - Fix-ups
   - Trivial (email address update); adp*_bl
   - Use 'atomic' PWM API; pwm_bl

 - Bug Fixes
   - Remove pointless boolen '&ptr' check; lm3639_bl

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      backlight: pwm_bl: Switch to using "atomic" PWM API

Krzysztof Kozlowski (2):
      backlight: Remove s6e63m0 driver
      backlight: Remove ld9040 driver

Michael Hennerich (1):
      backlight: Update MODULE AUTHOR email address

Nathan Chancellor (1):
      backlight: lm3639: Unconditionally call led_classdev_unregister

 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0 |  27 --
 drivers/video/backlight/Kconfig                   |  16 -
 drivers/video/backlight/Makefile                  |   2 -
 drivers/video/backlight/adp5520_bl.c              |   2 +-
 drivers/video/backlight/adp8860_bl.c              |   2 +-
 drivers/video/backlight/adp8870_bl.c              |   2 +-
 drivers/video/backlight/ld9040.c                  | 811 -------------------------------------------
 drivers/video/backlight/ld9040_gamma.h            | 202 -----------
 drivers/video/backlight/lm3639_bl.c               |   6 +-
 drivers/video/backlight/pwm_bl.c                  |  81 ++---
 drivers/video/backlight/s6e63m0.c                 | 857 ----------------------------------------------
 drivers/video/backlight/s6e63m0_gamma.h           | 266 --------------
 12 files changed, 47 insertions(+), 2227 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0
 delete mode 100644 drivers/video/backlight/ld9040.c
 delete mode 100644 drivers/video/backlight/ld9040_gamma.h
 delete mode 100644 drivers/video/backlight/s6e63m0.c
 delete mode 100644 drivers/video/backlight/s6e63m0_gamma.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
