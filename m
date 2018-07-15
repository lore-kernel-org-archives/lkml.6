Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2898ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0C320882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJH7rQsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0C320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeGOU7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:59:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39080 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbeGOU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:59:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so13699516wmb.4;
        Sun, 15 Jul 2018 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RL9nzhOLyDdXuPFCLZzvFhKZZgGr1SDBbDnvKwTVRvg=;
        b=DJH7rQspCQHW8HO59W1JaGdhzCNQwdpzU2iTZ38LOVKMTPVyOFBXb6daQB6J/5xxpV
         0dK0WfJCCGu6UIRw6bXyok0BSZyJkdKLEKbbvAaem1pV/hxaEunCM9FZoFbwjvGCoORR
         DxjuPr+hB4i+a+ax2xyjsXiRiaHRvGuyTXKARhCzOyGPzH8CHYjEgMC4EGcB0F/QgC6g
         EdTaHBbdfyzwOR3eLPO49kgGRw4F9B+IEBYbyRP1dHbyva9wIbn4RM1lZvfLUPWyFvsS
         YDA3EnB67weehROJ1lolYa5IAVS6eogqOfWI1lSM3fXQPD+iIPgTm7P2xSuNJKwSLMmf
         EctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RL9nzhOLyDdXuPFCLZzvFhKZZgGr1SDBbDnvKwTVRvg=;
        b=iYgjnIYHtpXSAsuzc40DTImUv2ZiCrNuvgGk1KTPVnhDadS8M9OhKWvFWAvTWmLbCh
         4yZq7/fcMeyLh8Ky94tA37S6T8gF6LdCp4jicwwGkVWk2SEMD2fV2XrTfIIkUjpgXLZd
         rk+Zh51uJ8F9VAzHFIX5BXe/raMTuNzmsTFTwiLKbVWVlIyRbK3UqDy/Pm3WfJg8cP5t
         8TKzBjKMPgI6ZXcusPlT5MTTmOFrZJYKXHRLQtj/TrXBW88MdP4uBjGNysGoTn+qdmqH
         rxVzcm5rdry5rvZ7ptxOL3MYW5t0sv+HviYoXVhv0fMXeN+X9CtR256umSzE8zqOwcFk
         869Q==
X-Gm-Message-State: AOUpUlG+iTIyx43Km8jLSBtERnaJ13tXZipeGtnDRQeGU0gq0CYF/gbV
        o38yyRiR2B3B6odh4frt/yw=
X-Google-Smtp-Source: AAOMgpfqLGCgkAaasGhkZpGLY4XXRkP83wGHbR1Kzt3NFKJy19wXcgZHs0uUfwYSeTpVQFTGAiovGw==
X-Received: by 2002:a1c:4405:: with SMTP id r5-v6mr7689270wma.4.1531686929374;
        Sun, 15 Jul 2018 13:35:29 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id u25-v6sm11768387wrd.61.2018.07.15.13.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:35:28 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v6 0/5] Add clock driver for Actions S700 SoC
Date:   Sun, 15 Jul 2018 22:35:19 +0200
Message-Id: <20180715203524.11948-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for Actions Semi Owl series S700 SoC
with relevant clock bindings and device tree info. 

Changed the UART clock using CMU instance and changes are tested in
cubieboard7

Changelog v6:
- Adding Fixes tag for adding REGMAP dependency addition

Changelog v5:
- Commit message corrections
- Removed MMC_OWL_CLK_NANDPLL option, as no active consumer
- Device tree clock label name correction

Changelog v4:
- dt-bindings use absolute numbering for clocks
- Patch re-oredering

Changelog v3:
- Splitted uart clock DTS changes into separate patch
- Splitted REGMAP Kconfig selection into separate patch
- General naming convention as "Actions Semi" in dt-binding documentation
- Patch re-oredering
- Cleanup and fixed review findings

Changelog v2:
Fixed 0 day compilation warning
Modified existing dts Actions S900 clock bindings common to Actions
Soc family

Thanks and regards,
Saravanan,
Parthiban

Saravanan Sekar (5):
  clk: actions: Add missing REGMAP_MMIO dependency
  dt-bindings: clock: Add S700 support for Actions Semi Soc's
  clk: actions: Add S700 SoC clock support
  arm64: dts: actions: Add Clock Management Unit for S700
  arm64: dts: actions: Set UART clock reference from CMU

 ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +-
 .../boot/dts/actions/s700-cubieboard7.dts     |   8 +-
 arch/arm64/boot/dts/actions/s700.dtsi         |  14 +
 drivers/clk/actions/Kconfig                   |   7 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-s700.c                | 606 ++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++
 7 files changed, 758 insertions(+), 16 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (68%)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.18.0

