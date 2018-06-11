Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vpZrLztwHlvIdQAAmS7hNA
	; Mon, 11 Jun 2018 12:52:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4523B60792; Mon, 11 Jun 2018 12:52:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kY0giiDv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A036760351;
	Mon, 11 Jun 2018 12:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A036760351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbeFKMwf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:52:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36444 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbeFKMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:52:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id v131-v6so16300471wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=WkLUt17kbMxAtL9vSz5zdFpw4abDZHCx2cwOAjqwO5Q=;
        b=kY0giiDv6bOG2+/7TA4YmG9BfoL2Ja7mljH8zIgoC2T8oKaMHYrFrMLFatq1jLdzF7
         qWwCnx2n3tXX96TsX7das1lY7qp0ygU28wZziGmDElZqNLwGh+SRXmRYfWmbfbEB/kDd
         ZKZCfpkMcsMXltNP9gqv7nvvEDhPdov3H7m0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=WkLUt17kbMxAtL9vSz5zdFpw4abDZHCx2cwOAjqwO5Q=;
        b=nexcBUSr7b19MHLFWCkNIt8jJELj7F0H5fsMUY9oEyu3ZQpeRmLvkqi83UBT/cgUK/
         eycDtYJWdQ282oGoN+BdYcYdbAxPUwqLADLircyBKGRgTD0iMKPxKMuUr1j1MT5e+LZd
         JkAYxq/Usew+DEDXDVXEH8V6fBDZyQeexw0SwkD/TCWa7DxRcGTsTVXbHhSfAm2cv1DH
         a7F6x98PFZ6E/KReA1CbDiSjTjII6G0/Xqu2k0+6ICx1BRiD3uKy1NcWh8hPVriuYuFU
         M9vcXolNPwV+uVohruyjh2L8lk7gm8UIxBQhp86ZyhEi10E2J73uw9W835585g07df4P
         BaXw==
X-Gm-Message-State: APt69E33L8Z7vxjUKO3UXQ9039a2o5Yea8jSKLsKUane1y41ZAEUnywN
        C1KwmjRtbM4Jxyh5qjgjROdRjeVQIR0=
X-Google-Smtp-Source: ADUXVKIGH3msFBK/JpXeel7mL1b17aoZ7Fb9x6i64SGZfFHrbYP0zseSFW3USex12MtOWYg+VF/WBg==
X-Received: by 2002:a1c:f906:: with SMTP id x6-v6mr8226197wmh.63.1528721553358;
        Mon, 11 Jun 2018 05:52:33 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id c18-v6sm50839884wrq.17.2018.06.11.05.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 05:52:32 -0700 (PDT)
Date: Mon, 11 Jun 2018 13:52:31 +0100
From: Lee Jones <lee.jones@linaro.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v4.18
Message-ID: <20180611125231.GF5278@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

As promised.  Enjoy!

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-4.18

for you to fetch changes up to d5318d302e7cf6583ec85a2a8bfbb3a3910ae372:

  backlight: as3711_bl: Fix Device Tree node leaks (2018-06-11 13:40:45 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Provide helpers to enable/disable backlight
   - Provide standard and devres versions OF find helpers

 - New Drivers
   - Add support for the Zodiac Inflight Innovations RAVE Supervisory Processor

 - New Functionality
   - Allow pwm-on/pwm-off delay to be specified via DT

 - Bug Fixes
   - Fix ordering of the power {en,dis}able and PWM {en,dis}able signals
   - Fix Device Tree node look-up

----------------------------------------------------------------
Andrey Smirnov (2):
      backlight: Add RAVE SP backlight driver
      dt-bindings: backlight: Add binding for RAVE SP backlight driver

Daniel Vetter (6):
      backlight: Nuke unused backlight.props.state states
      backlight: generic-bl: Remove DRIVER1 state
      backlight: pandora: Stop using BL_CORE_DRIVER1
      staging: fbtft: Stop using BL_CORE_DRIVER1
      backlight: Nuke BL_CORE_DRIVER1
      MAINTAINERS: Add dri-devel for backlight subsystem patches

Enric Balletbo i Serra (3):
      pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.
      dt-bindings: pwm-backlight: Add PWM delay proprieties.
      pwm-backlight: Add support for PWM delays proprieties.

Felix Brack (1):
      backlight: otm3225a: Add support for ORISE OTM3225A LCD SoC

Johan Hovold (4):
      backlight: as3711_bl: Fix Device Tree node lookup
      backlight: max8925_bl: Fix Device Tree node lookup
      backlight: tps65217_bl: Fix Device Tree node lookup
      backlight: as3711_bl: Fix Device Tree node leaks

Wolfram Sang (1):
      backlight: pwm_bl: Don't use GPIOF_* with gpiod_get_direction

 .../bindings/leds/backlight/pwm-backlight.txt      |   6 +
 .../leds/backlight/zii,rave-sp-backlight.txt       |  23 ++
 MAINTAINERS                                        |   1 +
 drivers/staging/fbtft/fbtft-core.c                 |   4 +-
 drivers/staging/fbtft/fbtft.h                      |   1 +
 drivers/video/backlight/Kconfig                    |  13 ++
 drivers/video/backlight/Makefile                   |   2 +
 drivers/video/backlight/as3711_bl.c                |  45 ++--
 drivers/video/backlight/generic_bl.c               |   5 -
 drivers/video/backlight/max8925_bl.c               |   4 +-
 drivers/video/backlight/otm3225a.c                 | 252 +++++++++++++++++++++
 drivers/video/backlight/pandora_bl.c               |  25 +-
 drivers/video/backlight/pwm_bl.c                   |  34 ++-
 drivers/video/backlight/rave-sp-backlight.c        |  82 +++++++
 drivers/video/backlight/tps65217_bl.c              |   4 +-
 include/linux/backlight.h                          |   4 -
 include/linux/mfd/as3711.h                         |   4 +-
 include/linux/mfd/rave-sp.h                        |   1 +
 include/linux/pwm_backlight.h                      |   2 +
 19 files changed, 466 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
 create mode 100644 drivers/video/backlight/otm3225a.c
 create mode 100644 drivers/video/backlight/rave-sp-backlight.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
