Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7C3C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805B12084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 14:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RVCm9poN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfASOoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 09:44:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33392 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbfASOoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 09:44:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so2977140wmh.0;
        Sat, 19 Jan 2019 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Ozus3BivcOK8itZMfeG08VWoPokGwR0TyZe9F4Jeso=;
        b=RVCm9poNqeGO0XaOQsekVrBPk0GVIVBV0TKKizJQX72qm+6J0y7SBg9KrIw5MUzqxm
         zqYYUMK2Phu+a/QMVXpbdxqmBvGqiaANPJrZj8VwY1oWzgtASWg5kQGBS7DhEOb2swgw
         MPiHenHOAc6Id3q6f1BI5mX4jmzu7t+L5E3Mu1mlMaPyFIMWUBn9MijC+Mpr7+aqszQ/
         WwhrkApj+NikrwEjIq1lM+ivieDTHBoCJ8A6b5ODiBRpCNip85HQ4ez017BbxvZ/E6Zr
         fXO1UKpqRT6BYK+FyOADn/iRCo5jUeV/FmR2Kq7tI2TB5YU4Z1FR88V/rhma444O2nW4
         z6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Ozus3BivcOK8itZMfeG08VWoPokGwR0TyZe9F4Jeso=;
        b=TEwNX+U9N9Lm17cVzfKDnN1ugwkBpOBuZXc3HbiNYRR1DNoyveQ3WG+ZA/Q207i/Vb
         3fwBNDFcWu8ycZsiYL/BCh38QbUt7XMFXbavLBRMzDCZBfPREQr37X+s0TfvH6cj9e8X
         M6uKHmzjaijX+ROtxDND6cnqRW9+tnTme0ow0Fr/LB1vA4QLf/K7fMkyI0mGjLsjdINP
         DQ2VgaSCV58F2JaHy+tkeupN56WB5X54wU/J2RtVoVjFo7WYshQltaWTP26t1MjytT5/
         Vl72TBQBdicx+bxoU2YsJDU0QG+FkrQTnAPPWuJ8jpPp9ANrAQtiQ0flc2ZZlsE9S51O
         bzRQ==
X-Gm-Message-State: AJcUuket5/++JSF65xJAhCZeH8+4JmjkGDTHR1oMx/V5opK2EeIWQG4U
        Ko1kAAGosFXeA9X8HLv89fY=
X-Google-Smtp-Source: ALg8bN4p4IfQL++SQBe0pA1973D4G5SDBovaqtlVTU4LWq5/7fgzfuGe6lVdeThrHVBMn1R00p6sPA==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr20259510wmg.48.1547909045808;
        Sat, 19 Jan 2019 06:44:05 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73A8100FDA9BD4E9DEACC2C.dip0.t-ipconnect.de. [2003:dc:d73a:8100:fda9:bd4e:9dea:cc2c])
        by smtp.googlemail.com with ESMTPSA id b7sm80452772wrs.47.2019.01.19.06.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 06:44:05 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ben.dooks@codethink.co.uk, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v6 0/2] Amlogic Meson6/8/8b/8m2 SoC RTC driver
Date:   Sat, 19 Jan 2019 15:43:30 +0100
Message-Id: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
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


Martin Blumenstingl (2):
  dt-bindings: rtc: add device-tree bindings for the Amlogic Meson RTC
  rtc: support for the Amlogic Meson RTC

 .../devicetree/bindings/rtc/rtc-meson.txt     |  32 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-meson.c                       | 409 ++++++++++++++++++
 4 files changed, 453 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
 create mode 100644 drivers/rtc/rtc-meson.c

-- 
2.20.1

