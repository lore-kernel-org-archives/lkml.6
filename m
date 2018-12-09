Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB77CC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7242320837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3isnTBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7242320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLINyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 08:54:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35742 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeLINyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 08:54:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so8622387wmh.0;
        Sun, 09 Dec 2018 05:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TcU5f/V8rP5wLgNb/i4F20N0yPSWixrtOv2pV4ZERPY=;
        b=g3isnTBVbC5cQrkjJmAgpM3v3+xeGsi/GysE0ep94hyITJsRBlSeH4tJ7l0MT1oAtm
         uYbZrLK9+40nrz+0KAiuP2cLCKkUJb3RUuWpYoifP9/bFdxLXFJf0goqGcAJ1d/02pLD
         hmoFb9zzCmTio1WN6AA5LdU/xKjpYEFXlRvdJcoZhKUpVBR6VU+c7hVZFhYv1lGhyZMu
         BDIABackbmqKWDGX1dynm4NtZeJ6KfTploLPrA6dSrco57U7AVDDsFinQdbv3e/a0R/c
         Jk2MaXR0mLFTAtePJOJP9aTbfh3NUEzh9UlEgRabjsKdzqHvPQ/NNg9tGplX7oYj0Sys
         h44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TcU5f/V8rP5wLgNb/i4F20N0yPSWixrtOv2pV4ZERPY=;
        b=nOnkON8mTpi5qBOjW0hMJWGXd78w4iQFEY5/N3zLRnmq04pTLL9YJMODRS/z0drYFv
         vxvf8wMiSKEjhOQ8H4NXsw9/JnbNQpdj8dXEzcY/iuO+oPd2coaxlYT+sOuNRtRgVjhk
         hLVcHzexpAT1PrWLzZndV80DjZrRehOAgkFY18Ko4TSQzHQIX9Wc7jFQ0Aw2MG68PZSI
         6gLbW6x+ZxaHnsQRXFWmgJ3AMwtQ/P3mk8/0viyKO5p/DBmfh2zQzwzzutpfhsBzo4Od
         GxFyfOigblKomMXYDyK6NWwyz5bRszpP/BH2PXHrHcgG2Rs9rjbFhNkj8fCNvSxRK/iz
         d58Q==
X-Gm-Message-State: AA+aEWZwwqz5QZUw5Mf5gMl58+6QkSo2UD+JhJSHqvXfEphqKazq59Mi
        dLKs3EAUO+ckKloN1YO7aR0=
X-Google-Smtp-Source: AFSGD/Wv1WuyM2jT4/F1O59lS0S2uqsdPSc3qb/9Ix75YU8vkrJE7pnb4Gygvpc3WupmmeSBg2ShLA==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr7677752wmi.10.1544363661170;
        Sun, 09 Dec 2018 05:54:21 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (dgv239.neoplus.adsl.tpnet.pl. [83.23.177.239])
        by smtp.gmail.com with ESMTPSA id k128sm12271795wmd.37.2018.12.09.05.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 05:54:20 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH 0/5] Add support for STM32F4 SPI
Date:   Sun,  9 Dec 2018 14:53:51 +0100
Message-Id: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This series of patches adds support for first generation of SPI interface
for STM32F4 family.

This version of driver is mostly different to STM32H7 one. Based on linux
kernel I2C drivers for STM32 where drivers were splited into STM32F4 and
STM32F7 family the same approach seems to be sufficient for SPI STM32
drivers. Therefore STM32H7 driver was moved to spi-stm32h7.c file and
register and functions were renamed to be more specific to STM32H7.

For current version master mode with full-duplex and 8/16 bit data frame
format are supported. There is no TX and RX FIFOs like in STM32H7.
DMA capabilility is supported for messages longer than arbitrary number
of bytes (that is set already to 16 bytes) when TX and RX channels are
set at the same time.

Cezary Gapinski (5):
  spi: stm32: rename STM32 SPI registers and functions to STM32H7
  spi: stm32: rename spi-stm32 to spi-stm32h7
  spi: stm32: add driver for STM32F4 controller
  ARM: dts: stm32: add SPI support on STM32F429 SoC
  spi: stm32: add description about STM32F4 bindings

 .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   60 +
 drivers/spi/Kconfig                                |   18 +-
 drivers/spi/Makefile                               |    3 +-
 drivers/spi/spi-stm32.c                            | 1322 -------------------
 drivers/spi/spi-stm32f4.c                          | 1002 +++++++++++++++
 drivers/spi/spi-stm32h7.c                          | 1340 ++++++++++++++++++++
 7 files changed, 2424 insertions(+), 1330 deletions(-)
 delete mode 100644 drivers/spi/spi-stm32.c
 create mode 100644 drivers/spi/spi-stm32f4.c
 create mode 100644 drivers/spi/spi-stm32h7.c

-- 
2.7.4

