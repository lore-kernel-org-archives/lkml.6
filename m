Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5FBC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 21:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D120219F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 21:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTLcVlib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D120219F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeHMAGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 20:06:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40157 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeHMAGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 20:06:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so6624530pgp.7;
        Sun, 12 Aug 2018 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bs4aGuGZSuJzFeRrcQVtL+CckuEXq9pPwSNF2i3oAc=;
        b=MTLcVlib1AfgX/GYZiOY8qIC866FLSJfKgPz9w8Mf4RyS7giRxzq07PoCvTMIUsI25
         NquQ9QULjn5VBivEX9UqNwrSE8KGOIfRIoSmXNwVpsz6APIIL4rFOpsHnRjaSqB++jNn
         WagdU9go3YhtF8cBp5FbkvOIHUZbClHW/xOLN24WibDe7s5yBZP/SOP15im8ZAGtZ1LY
         oWZqB0U8UQSQwO5XjH6R6hDHQ1fTWAXu0yG9PZGIrLKOz6IynIS42mou7bEUuG31Apik
         Eh9YZr7UNj1WkCvW27qqEkOSLrq2yjQhAiB39Fh9t/jJsq5p15mkZ5o42jwYHLtzllz8
         NbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7bs4aGuGZSuJzFeRrcQVtL+CckuEXq9pPwSNF2i3oAc=;
        b=Mwv/s01ZsER8Ro8ODFlKRkpPHOMFKdwZW9TqxzQVtQd8WWonNOvudux+2PWq7MrGCx
         CPA77vK1C+0zRoS92q3XN/lptW9fLNEW4twfhsc5eyEjijIqIoFlwjAGomgtI6YFY3+O
         3LscUNn8j/kIeUUxOGVDdUXlE6p1SSAyO7kWOUHWqfZj0fJdu2/tYGCeq3SV3VrD7Ye8
         OB2Bh5n0n0MHEKHEr4HauS5tg/zbhNgZvWf/cC7UqTdW7miJXVelGhLwkU/N7SLYM3G7
         TZJqMOaCFeCmBN1N2joFkHb/6aOdmdOZ1i+twucd6xrPYUN3fx/r+qXvvyGDRhB2zCA3
         embw==
X-Gm-Message-State: AOUpUlFdk0pZFgutLEdCer6NX1wLOjng6/G8Zu5Gpap5X7CsOOrzh955
        +/iI7zDDvF0SBHt33Trup80=
X-Google-Smtp-Source: AA+uWPzkV5JyINgY9e0/1xYafpxEWfJAP47NzaFENsGkYPUkCakE5YGlWQs80LP3NBA8AywTG+nb0g==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr16428572pfj.74.1534109255750;
        Sun, 12 Aug 2018 14:27:35 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y69-v6sm39656930pfd.36.2018.08.12.14.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 14:27:34 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v4.19-rc1
Date:   Sun, 12 Aug 2018 14:27:33 -0700
Message-Id: <1534109253-19294-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v4.19-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.19-rc1

Thanks,
Guenter
------

The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:

  Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.19-rc1

for you to fetch changes up to 4afec79f652b11189c07ce49498c4477adda887c:

  hwmon: (adt7475) Change show functions to return error data correctly (2018-08-10 09:13:01 -0700)

----------------------------------------------------------------
hwmon updates for v4.19-rc1

New driver for NPCM7xx PWM and Fan controller
New driver for Mellanox FAN controller
Add support for MAX34451 to max34440 driver
Add support for new Threadripper variants to k10temp driver
Add error handling to adt7475 driver
Cleanup nct6775 and nct7904 drivers
Document sensor enable ABI attributes

----------------------------------------------------------------
Guenter Roeck (2):
      hwmon: (nct6775) Fix comment in the description of pwm_mode
      hwmon: k10temp: Support Threadripper 2920X, 2970WX; simplify offset table

Gustavo A. R. Silva (1):
      hwmon: Mark expected switch fall-throughs

Jakob Albert (3):
      hwmon: (nct7904) Fix SPACING errors
      hwmon: (nct7904) Fix CODE_INDENT error
      hwmon: (nct7904) Fix UNSPECIFIED_INT warning

Kun Yi (1):
      hwmon: (pmbus/max34440) Add support for MAX34451.

Maxime Roussin-Bélanger (1):
      hwmon: (iio_hwmon) Use devm functions

Michael Larabel (1):
      hwmon: (k10temp) 27C Offset needed for Threadripper2

Shilpasri G Bhat (1):
      hwmon: Document the sensor enable attribute

Tokunori Ikegami (4):
      hwmon: (adt7475) Split device update function to measure and limits
      hwmon: (adt7475) Change valid parameter to bool type
      hwmon: (adt7475) Change update functions to add error handling
      hwmon: (adt7475) Change show functions to return error data correctly

Tomer Maimon (2):
      dt-binding: hwmon: Add NPCM7xx PWM and Fan controller documentation
      hwmon: Add NPCM7xx PWM and Fan driver

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Add support for Mellanox FAN driver

 .../devicetree/bindings/hwmon/npcm750-pwm-fan.txt  |   84 ++
 Documentation/hwmon/max34440                       |   16 +-
 Documentation/hwmon/mlxreg-fan                     |   60 ++
 Documentation/hwmon/npcm750-pwm-fan                |   22 +
 Documentation/hwmon/sysfs-interface                |   48 +
 drivers/hwmon/Kconfig                              |   22 +
 drivers/hwmon/Makefile                             |    2 +
 drivers/hwmon/adt7475.c                            |  340 +++++--
 drivers/hwmon/emc1403.c                            |    2 +
 drivers/hwmon/iio_hwmon.c                          |   67 +-
 drivers/hwmon/k10temp.c                            |    8 +-
 drivers/hwmon/mlxreg-fan.c                         |  489 +++++++++
 drivers/hwmon/nct6775.c                            |    6 +-
 drivers/hwmon/nct7904.c                            |   68 +-
 drivers/hwmon/npcm750-pwm-fan.c                    | 1057 ++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig                        |    2 +-
 drivers/hwmon/pmbus/max34440.c                     |   93 +-
 17 files changed, 2190 insertions(+), 196 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
 create mode 100644 Documentation/hwmon/mlxreg-fan
 create mode 100644 Documentation/hwmon/npcm750-pwm-fan
 create mode 100644 drivers/hwmon/mlxreg-fan.c
 create mode 100644 drivers/hwmon/npcm750-pwm-fan.c
