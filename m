Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B43C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4923620834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K1tWG2B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4923620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbeLBWJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 17:09:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39226 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeLBWJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 17:09:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so1396061wmd.4;
        Sun, 02 Dec 2018 14:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVFm4iQFARb7LSpeEYqu6l+42fPoWzaNkx6zpzMl+0I=;
        b=K1tWG2B4/2q6qBnbeh5tSNzG+hXAYd+XsWRhHn/ZtANd09DBEFd1fEPsPGOCBt59eO
         toGQGVaeV6NgFtNOUhfL2kuWZIYTGyWB+wUxwPlaW5evhav1DKjDTuiP/Jc0Kmw4l5bq
         Pg/gcxGBLq9351OUvlVoE0p+qqeyo7IyLzzfrMfe2XoY2xbugDzoLn5b3mnkYwoZYX0T
         Maff9JbGsBxY4zqKAnaCpWMPKx2dYwKhcsLxU/yMaIbSywgQwonDg7nNNoQGPm4rbvGz
         L3gQaHkjP2vXJanla3dz9TlTQjiJFFUNDe7TAS4BPNXPDgUAYBczBSIIhiiagAWETuMN
         VGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVFm4iQFARb7LSpeEYqu6l+42fPoWzaNkx6zpzMl+0I=;
        b=J6wrWgh5YFars0AfhVRPfVVzEQCVfg9c+R5ZMwkhJvhGrDhwlXc8mJYSgpUbChg+lw
         eBnSAWfQ4prffHDymk/SgDvO8WmlHs8KxU1pQ0JqhQRDtopbP+WEgeP5WMo85HjS5w1u
         Wq4gZf0z9pO2HTbg+GptnilsH8x80yPMdH9gab+De1mbIkbnhhPXFZPU+d2B4Ia0X1SW
         rV84gXxXQWqgDMwAHHCATr3X0E3ZXc9bn0vJQEAhD4UGCYF/2jWOrt5OeYFFCNGfVbSC
         hHm0Dge6QeAmLOkWIEHLTHJa9NDDPlJ8KiWLwuDZ1PDZIbNcL6ProsplyH0ylf12Nl6K
         NTfQ==
X-Gm-Message-State: AA+aEWbWeC3s7jvpAxwpfIlR4D4hjivPkV1Vj4bpfWm3Fkxv0311ccob
        1pttMSdHadnre+IWT0Ui/xA=
X-Google-Smtp-Source: AFSGD/VFDdu+XpEtmybrNxO2yDzk+pu1fJsQJjF2YxYrJy4CXKcyNH399hdbb18P2N6ydbzJyg6Mjw==
X-Received: by 2002:a1c:cc3:: with SMTP id 186mr437276wmm.143.1543788536654;
        Sun, 02 Dec 2018 14:08:56 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
        by smtp.googlemail.com with ESMTPSA id m15sm8503351wrr.95.2018.12.02.14.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 14:08:56 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ben.dooks@codethink.co.uk, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v5 0/2] Amlogic Meson6/8/8b/8m2 SoC RTC driver
Date:   Sun,  2 Dec 2018 23:08:45 +0100
Message-Id: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
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
2.19.2

