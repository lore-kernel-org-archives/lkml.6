Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25686C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB21D20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NGEniBJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB21D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLHRNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:13:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43420 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeLHRNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:13:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so6555771wrs.10;
        Sat, 08 Dec 2018 09:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PXdW4UBpQPSOC7lPcUMX6pSS8TgUTrjYuc4GLT/lzQ=;
        b=NGEniBJ0JYstL6hTiODRxWJLzTOGQWgeJkhhOBS+Q3uv/oibqKRcvE8eHpA7jqz9FL
         rTol4mzf7PfkiOaCB7MTgAgnDrwMpuxznJF+EmtviYKU2vDQrBnJpDo4DjsLVDbLIGxy
         9kr1bAeJSL23fvgeW9LMx9vxYmFQlVWlJAV9HOQJCXg3hToPA9HuIwjq/lEr803nTvAY
         KlFXWO9tD5thZ4VP4qOkM0ZWr4JCbsivJXP3PXuL3QQh69L+JM6JTSSRYPxvqaCAJbbi
         TQFgdugXd40xcQ5/+9NDW3aAc8BWqYEyxIN2kArlFEjBpKIFFa58CjCQmaVsfU3yRIKo
         SvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PXdW4UBpQPSOC7lPcUMX6pSS8TgUTrjYuc4GLT/lzQ=;
        b=B4N26xoZlaOBmwE+BqBeBB4bFqcmlsfnatvCB1e12ki70mlKAaL0wqkGY8Mn6laNMV
         wWfVXc2Qeb1LzsQw24H9o16KPWRzygasDfr0hjSABWPzxNLLXxCukqhc+IbC/jBnCXhb
         iNtiIKf5ugLnNKa0xvIV5gFB2xPRSPJTi1jyiSHybvWQb0GbN9U+do2G6okwbWZ17fku
         uvJnhrInVKGcctRoaMhv2bg2mDtGXHAj8XKLJjwAyj4N6jJwkhB3Xj7Eit+/7btumE6t
         nGTlGEaNi2Y1j4NQ6TXJna6iw9DNo+iK2vJhqRQ4rvhBUNk7fEdoMSNnVlAzLWtg5ViW
         +lVw==
X-Gm-Message-State: AA+aEWYyiWxODZP5PbGCNgE8KeLFSs6R5aRBsQWMfpJhuQOLyVn6Uvy4
        h4AoEBM+5MOJiU67zYtutbs=
X-Google-Smtp-Source: AFSGD/W0zwq0Qh1rO4lqFd/9JHkO8YGJaRm6Jm77JFfPyNgSv4afSqre0vlg4UaQvTC7XqoVAy7YJg==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr5411511wrq.182.1544289188552;
        Sat, 08 Dec 2018 09:13:08 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r12sm4995851wrq.3.2018.12.08.09.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 09:13:07 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/5] Meson (32-bit): add support for the Mali GPU
Date:   Sat,  8 Dec 2018 18:12:42 +0100
Message-Id: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Mali-450 GPU on Meson8 and Meson8b.
Meson6 uses a Mali-400 GPU but since we don't have a clock driver (and
I don't have a device for testing) Meson6 is left out in this series.

Meson8 uses a Mali-450 MP6 with six pixel processors. Meson8b (as
cost-reduced SoC) uses a Mali-450 MP2 with two pixel processors.
I tested both using the open source lima driver and a patched mesa
from the lima project as well. Since we don't have display support
on the 32-bit SoCs I used off-screen rendering as described in [0].
The result is (for example): [1]

The bootloader (at least on my boards) leaves the Mali clock disabled
by default. The board crashes when trying to access the Mali registers
with the "core" clock disabled.
Thus this series also implements the required clock driver changes. The
Mali clock tree on Meson8b and Meson8m2 is almost identical to the one
on GXBB (see the description of patch #3 for more details). Only Meson8
is slightly different as it doesn't have a glitch-free mux. Patch #2
prepares the meson8b clock driver so we can have different clocks per
SoC.

Dependencies:
- the .dts changes depend on my other series "ARM: dts: meson: add the
  APB/APB2 busses" from [2]
- the .dts changes from this series have no compile-time dependency on
  the clock driver changes because CLKID_MALI was defined in the
  dt-bindings since the first version of the clock driver (but it was
  not used until now).
- the .dts changes from this series have a runtime dependency on the
  clock driver changes (also from this series) if you have a kernel
  patched with the lima driver (without the lima driver there's no
  runtime dependency)

Other notes:
By default the GPU runs off the XTAL clock (24MHz). The lima driver
currently does not update the GPU clock rate. Different frequencies
have to be requested by adding the following properties to the Mali
GPU node (to run it at 510MHz for example):
  assigned-clocks = <&clkc CLKID_MALI>;
  assigned-clock-rates = <510000000>;


[0] https://gitlab.freedesktop.org/lima/web/wikis/home
[1] https://abload.de/img/dump0myic0.png
[2] https://patchwork.kernel.org/cover/10719445/


Martin Blumenstingl (5):
  dt-bindings: gpu: mali-utgard: add Amlogic Meson8 and Meson8b
    compatible
  clk: meson: meson8b: use a separate clock table for Meson8
  clk: meson: meson8b: add the GPU clock tree
  ARM: dts: meson8: add the Mali-450 MP6 GPU
  ARM: dts: meson8b: add the Mali-450 MP2 GPU

 .../bindings/gpu/arm,mali-utgard.txt          |   6 +
 arch/arm/boot/dts/meson8.dtsi                 |  58 +++
 arch/arm/boot/dts/meson8b.dtsi                |  46 +++
 drivers/clk/meson/meson8b.c                   | 349 +++++++++++++++++-
 drivers/clk/meson/meson8b.h                   |   9 +-
 5 files changed, 461 insertions(+), 7 deletions(-)

-- 
2.19.2

