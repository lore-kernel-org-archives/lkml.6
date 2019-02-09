Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC04FC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF5921841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YQ6fbz6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfBIASr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:18:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52572 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBIASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:18:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so6305720wml.2;
        Fri, 08 Feb 2019 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ICfnFTJe/2nIX0Z8exi3cYWN2wQuILJP40kTnZDRPg=;
        b=YQ6fbz6UmCgWZlz/acbE12gWpm0C+eTVO2ew5It1uMMjc47G26uHdX6Ye63Tzy2Mb+
         v92o5FPs24PxJGCd8oiPRSWxKU/6gD45XWby7fWbso9fxwZ07pgrh85QozPdfJvZPwkt
         MhxD/FTsJbzk+umGLh6o4w6yv9ZkRdTyWiUnwTy7XA2LfaI/fz1i85n8xMX2lh0a0/Y1
         dXQdjD4ne+M/TVdIE+U3cnV73U95bvf3Zuiid+MOpsuyYNTAeRh1txUZyD7xYN9HFWbj
         9TTdOu8f2lQkuRRxMJQBpr52LDqqUC5MHHtDCg4lVRzjlJuyd02LVUJGWd8Ke5bhsCaD
         jhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ICfnFTJe/2nIX0Z8exi3cYWN2wQuILJP40kTnZDRPg=;
        b=q+ln8sNzRq7k2zKDnvrZV342yN8G7AZd/8GXhcpPNHlUx/L4NM+iFbAgJDpqArwBpS
         TiCxPkKZP1+1Ui1EPw6TwJuMC+UzObj/9bA3vPcQ/QV1xekT+BQ3QvO5vcX3yxN9y5nl
         1i2Mz1ArIg/jCn4CI2zfLVK2JlnOwWSlgoPx+Pgb2YUNtwEOY8pphMwRDlFTtoYSovBY
         gnrszJMBXo159RYAy5KduGfbw6Ds8PHirSM07PaZ+lM6+NpiUfKTUVr6hYGCup7vkt+L
         xnf3Pko2pOAUhVzYt8CAJ2pEfwsBdgI4QiUnvVrXdHe7Yo/vEWoFuzDw4JIEyAYbqBw2
         7WKA==
X-Gm-Message-State: AHQUAuboqmzpcfe9D+409hXhQqeDiN9w+/zyvcaWtTIMdNVL/XRO0Oco
        VTD6dwmOq1DkStFDV+lnyak=
X-Google-Smtp-Source: AHgI3IatK0NG1EGRZHIs3Ufqr3RWvsxyL3YYHEO2826JH4xcGJLCuDzbwwBOlbnRMBcKKRkU1+ZG1Q==
X-Received: by 2002:a1c:a016:: with SMTP id j22mr827235wme.53.1549671524148;
        Fri, 08 Feb 2019 16:18:44 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD70B4600C545FEF64E1C6C81.dip0.t-ipconnect.de. [2003:dc:d70b:4600:c545:fef6:4e1c:6c81])
        by smtp.googlemail.com with ESMTPSA id b12sm2168162wmj.3.2019.02.08.16.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:18:43 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ben.dooks@codethink.co.uk, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v7 0/2] Amlogic Meson6/8/8b/8m2 SoC RTC driver
Date:   Sat,  9 Feb 2019 01:18:11 +0100
Message-Id: <20190209001813.6792-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the RTC on the 32-bit Amlogic Meson SoCs.

The series does not have any build dependencies, but does require
device-tree entries for the relevant boards.

The series is tested by myself on the Meson8b EC-100 board. Earlier
versions of this series were tested on an Odroid-C1 board with a
battery pack attached by Ben Dooks and Kevin Hilman.

I will send the DT changes in a second series so that they can be
merged once the dependencies have been satisfied.


Changes since v6 at [2]:
- added NVMEM_TYPE_BATTERY_BACKED (thanks to Alexandre Belloni for the
  hint)
- fixed dt-bindings description: #address-cells was duplicated but
  #size-cells was missing. While here also add these to the example.
  Spotted by Alexandre Belloni - thanks!

Changes since v5 at [1]:
- get rid of a dependency on the SZ_16 macro (fixes a kbuild test robot
  compile error)
- rebased on top of v5.0-rc1
- I kept the copyrights / author as in v4 because Ben didn't ask me to
  do it yet (please speak up if I should change it)

Changes since v4 at [0]:
- resurrected Ben's patches after 2 years: first I made it apply
  onto linux-next again
- I decided to update the author of the patch to my own name since I
  made a lot of changes compared to Ben's implementation (list of
  changes below, the diff-stat was: 223 insertions, 163 deletions)
- make the dt-bindings file name (rtc-meson.txt) match the driver name
- add a Meson8m2 compatible
- add the clocks and vdd-supply properties to the match the actual IP
  block implementation
- make the resets and interrupts properties mandatory to match the
  actual IP block implementation
- removed the status property from the dt-bindings example
- fix MODULE_LICENSE to match the actual license (GPL v2)
- switch to SPDX-License-Identifier
- sort the Kconfig option alphabetically
- use BIT() and GENMASK() macros consistenly
- replace #define RTC_REG(x) with actual #defines which match the names
  from the public S805 datasheet
- adjust existing #defines to align with the public S805 datasheet
- add support for the 4x32bit NVMEM (regmem) data
- implement regmap_bus to access the serial registers. this allows
  getting rid of the custom locking code and makes the NVMEM
  implementation much easier.
- use regmap also for accessing the peripheral registers to make the
  code shorter
- add support for the vdd-supply regulator
- switch from devm_rtc_device_register to devm_rtc_allocate_device and
  rtc_register_device
- set range_max to U32_MAX
- use rtc_time64_to_tm and rtc_tm_to_time64
- simplify timeout handling and use shorter timeouts (the driver from
  the 3.10 BSP kernel uses udelay resolution (100us after the reset, 5us
  for the "comm delay") as well as busy-looping from 0..40000 to wait
  for "s_ready"
- removed debug messages which are only printing register values (as
  these can now be seen in
  <debugfs>/regmap/c8100740.rtc-peripheral-registers/registers)


[0] https://www.spinics.net/lists/devicetree/msg135413.html
[1] https://patchwork.ozlabs.org/cover/1006597/
[2] https://patchwork.ozlabs.org/cover/1027951/


Martin Blumenstingl (2):
  dt-bindings: rtc: add device-tree bindings for the Amlogic Meson RTC
  rtc: support for the Amlogic Meson RTC

 .../devicetree/bindings/rtc/rtc-meson.txt     |  35 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-meson.c                       | 410 ++++++++++++++++++
 4 files changed, 457 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
 create mode 100644 drivers/rtc/rtc-meson.c

-- 
2.20.1

