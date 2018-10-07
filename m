Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF659C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511112087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ipl+pgvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511112087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeJGTgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 15:36:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40147 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeJGTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 15:36:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so13415593wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UNqqNDjRPsEcGeJzOf229HEvgkunue35VWMse+IIzYQ=;
        b=Ipl+pgvlvqjyBUHQSA3vfXbU8j/8a9A3SMsAkd/N6fAVzgHqsHPFA5Htd3pbFsXf5V
         k1EtgjxNeBRRD7bKCnYmeaZRa8BLEbD+HuAdy2xD9XkHzwmUBVqXpTFt2TrUoEK7X9KF
         OOLkJu8nHgejyo6ODNY0arioen8jDZKvY6E9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UNqqNDjRPsEcGeJzOf229HEvgkunue35VWMse+IIzYQ=;
        b=MP7goF2YjJnkdyFGx9bCShcGybh9o39nOkGwL9GZmqP54nkuecZI88ab92t+Qj6CCs
         8lZc+5YT/z5La1baDHqnF9a9G8NY9UY0DhRPVtWoxCFZDreOe+tVoiU9Nm83b3LS2pFv
         QgIJrb5iSxxZb0tTalGLSSbV0m1KXTmZJXglIHzn5wENEP+4AwSDXskDIRYMfOkurM6w
         JG5LZZZftqJP+qi6lxluw033EiUOCiayIXdOH2c1OOxNbXCl3jSIaBvKl80McxXZwmDJ
         KVU60M+vtNhtzaRCoTU9x9lgTbMxbkAkPSKGDr+EeeUEIN4rQzSVnhr5pjZavLOFmzWD
         H59A==
X-Gm-Message-State: ABuFfojZOyFU7ky+JFzrnIzfMAIJolfvOaIgnNg0CRiNyk/7SN3gxufn
        ORdyB7rsglXWzKJEXF68ayT2TA7SS6c=
X-Google-Smtp-Source: ACcGV62BjJ1EAZB6v2S0SO79bE6xJTHV7Td9ZgdeOW/w2EJplb4ziuRnnupWUpVigRRVzJZd2yxO2g==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5-v6mr13330819wrw.288.1538915344305;
        Sun, 07 Oct 2018 05:29:04 -0700 (PDT)
Received: from [192.168.0.40] (79.11.130.77.rev.sfr.net. [77.130.11.79])
        by smtp.googlemail.com with ESMTPSA id a5-v6sm6620491wmh.8.2018.10.07.05.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 05:29:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer changes for 4.20 #2 (SOB fixed)
To:     tglx@linutronix.de
Cc:     dinguyen@kernel.org, kuninori.morimoto.gx@renesas.com,
        robh@kernel.org, sergei.shtylyov@cogentembedded.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <4ea1aeac-369d-df55-62a0-ef840b3d845e@linaro.org>
Date:   Sun, 7 Oct 2018 14:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

these are the changes for v4.20, it contains:

 - Prefix file names with timer-* (Daniel Lezcano)

 - Remove old CLOCKSOURCE_OF_DECLARE which was replaced by
TIMER_OF_DECLARE (Daniel Lezcano)

 - Add reset control for dw_apb (Dinh Nguyen)

 - Add the SPDX identifiers for the renesas and sh timers (Kuninori
Morimoto)

 - Use %pOFn instead of device_node.name (Rob Herring)

 - Fixup 64bits and clocksource width to 32b for sh_cmt (Sergei Shtylyov)

 - Add the R-Car gen3 support (Sergei Shtylyov)

Thanks!

  -- Daniel

The following changes since commit dc6253108f0fbff4a634055d5b8a91958ec2af81:

  tick/broadcast: Remove redundant check (2018-09-28 22:29:35 +0200)

are available in the git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.20

for you to fetch changes up to 1f174a1a2cdebc65138e6ed1448b842e73200bb5:

  clocksource/drivers/dw_apb: Add reset control (2018-10-07 14:16:35 +0200)

----------------------------------------------------------------
Daniel Lezcano (2):
      clocksource/drivers: Unify the names to timer-* format
      clocksource: Remove obsolete CLOCKSOURCE_OF_DECLARE

Dinh Nguyen (1):
      clocksource/drivers/dw_apb: Add reset control

Kuninori Morimoto (4):
      clocksource/drivers/renesas-ostm: Convert to SPDX identifiers
      clocksource/drivers/sh_cmt: Convert to SPDX identifiers
      clocksource/drivers/sh_mtu2: Convert to SPDX identifiers
      clocksource/drivers/sh_tmu: Convert to SPDX identifiers

Rob Herring (1):
      clocksource: Convert to using %pOFn instead of device_node.name

Sergei Shtylyov (5):
      clocksource/drivers/sh_cmt: Fixup for 64-bit machines
      clocksource/drivers/sh_cmt: Fix clocksource width for 32-bit machines
      clocksource/drivers/sh_cmt: Properly line-wrap sh_cmt_of_table[]
initializer
      dt-bindings: timer: renesas: cmt: document R-Car gen3 support
      clocksource/drivers/sh_cmt: Add R-Car gen3 support

 .../devicetree/bindings/timer/renesas,cmt.txt      |   7 ++
 MAINTAINERS                                        |  10 +-
 drivers/clocksource/Makefile                       |  26 ++---
 drivers/clocksource/asm9260_timer.c                |   2 +-
 drivers/clocksource/dw_apb_timer_of.c              |  20 +++-
 drivers/clocksource/pxa_timer.c                    |   6 +-
 drivers/clocksource/renesas-ostm.c                 |  11 +--
 drivers/clocksource/sh_cmt.c                       | 106
++++++++++-----------
 drivers/clocksource/sh_mtu2.c                      |  10 +-
 drivers/clocksource/sh_tmu.c                       |  10 +-
 ...{time-armada-370-xp.c => timer-armada-370-xp.c} |   0
 .../{cadence_ttc_timer.c => timer-cadence-ttc.c}   |   2 +-
 .../clocksource/{time-efm32.c => timer-efm32.c}    |   0
 .../{fsl_ftm_timer.c => timer-fsl-ftm.c}           |   0
 drivers/clocksource/timer-integrator-ap.c          |   2 +-
 .../{time-lpc32xx.c => timer-lpc32xx.c}            |   0
 .../clocksource/{time-orion.c => timer-orion.c}    |   8 +-
 drivers/clocksource/{owl-timer.c => timer-owl.c}   |   0
 .../{time-pistachio.c => timer-pistachio.c}        |   0
 drivers/clocksource/{qcom-timer.c => timer-qcom.c} |   0
 drivers/clocksource/timer-sp804.c                  |   2 +-
 .../clocksource/{versatile.c => timer-versatile.c} |   0
 .../clocksource/{vf_pit_timer.c => timer-vf-pit.c} |   0
 .../clocksource/{vt8500_timer.c => timer-vt8500.c} |   0
 .../clocksource/{zevio-timer.c => timer-zevio.c}   |   8 +-
 include/linux/clocksource.h                        |   3 -
 26 files changed, 112 insertions(+), 121 deletions(-)
 rename drivers/clocksource/{time-armada-370-xp.c =>
timer-armada-370-xp.c} (100%)
 rename drivers/clocksource/{cadence_ttc_timer.c => timer-cadence-ttc.c}
(99%)
 rename drivers/clocksource/{time-efm32.c => timer-efm32.c} (100%)
 rename drivers/clocksource/{fsl_ftm_timer.c => timer-fsl-ftm.c} (100%)
 rename drivers/clocksource/{time-lpc32xx.c => timer-lpc32xx.c} (100%)
 rename drivers/clocksource/{time-orion.c => timer-orion.c} (95%)
 rename drivers/clocksource/{owl-timer.c => timer-owl.c} (100%)
 rename drivers/clocksource/{time-pistachio.c => timer-pistachio.c} (100%)
 rename drivers/clocksource/{qcom-timer.c => timer-qcom.c} (100%)
 rename drivers/clocksource/{versatile.c => timer-versatile.c} (100%)
 rename drivers/clocksource/{vf_pit_timer.c => timer-vf-pit.c} (100%)
 rename drivers/clocksource/{vt8500_timer.c => timer-vt8500.c} (100%)
 rename drivers/clocksource/{zevio-timer.c => timer-zevio.c} (97%)
-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
