Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA8CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34472089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cQEsRfA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfAHJPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:15:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44763 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHJPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:15:50 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so3433656edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAkuas4RshcTkIlVgGwGzsZuXoBBAfY4tFHpr5KQ4F8=;
        b=cQEsRfA0bicmbsvpJpqdYOE8XrOy462TTyLv2sEfLWkILgn0hTNKKxkGllB0Rk3drn
         pBmoOu9SS3up1n+abgWlQh81SsxxYuePzQN5rHxwmUERv0XPTfeXHqtbGhhu4NXeQz6m
         ms4GNp5RDHi5ljTR2sGJpLwp22UvafEDEWDVz86sR9SVx8kaG+s+zPaK03X4jmRUsFad
         SgzxNLRgwQEllNcFSW1UojZ8E6pdr78qe6EUShqGG3Xdqabc75AVnvGmW7zWK4l3mExo
         sTZUMaPB2G5xIY/EdTX/u4gxD7mWETkvtUAM6chCa0Mx19wVOhWB/GmvbDxjA4zKoOj1
         0Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAkuas4RshcTkIlVgGwGzsZuXoBBAfY4tFHpr5KQ4F8=;
        b=CWfQxINbYPzPmk1yp2sfkAEqmJBAI0ehFiS+OzKFNmrL7yN7FjH7SDKL0Ut09MB4/j
         oZhARZq+oio1JgPmXAWrvvlr7/TJeA3vJMi5IUD7nqwW9qs2JNvuTzG7JmYfXzamuI2I
         2ebQhvpXkBppgMlMWTCWRDPIvoxrsf1/qvjCPRgjBP66umbsLms+BogkmZCENcmD2UuD
         LVXp6kyxyZYnD3AwdLXc2EuJXQFOTcMMN6uY18YTBOlyx61jVRtRotq2dbA36juaExfX
         57U1ALJK8XrSjZwOSnhooHS9sGI9kfbKHBF7P6uXG+et4Ug7WCyczP+SUGahW9RhVcUV
         837Q==
X-Gm-Message-State: AJcUukdpXyhdhyjxIEVna1nN0HBDwe6wkD812fKyrFitBRLHu4LcgeZj
        l4oKEWYG5qEMGXMuI3ukzJrMVw==
X-Google-Smtp-Source: ALg8bN4hkgCTXy/KRez1N/oXJ9TRYJO/Cu3OVGIblbWkWnlwsmlkyGYFvVevjdlDsGdgqo9O+G5N0Q==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr1275696edr.203.1546938948404;
        Tue, 08 Jan 2019 01:15:48 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:15:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
Date:   Tue,  8 Jan 2019 10:15:27 +0100
Message-Id: <20190108091539.16674-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

now that all dependencies are in and v5.0-rc1 is tagged, please consider
picking up the second batch of davinci-specific changes into your tree.
Once that's done, please provide me with an immutable branch for me to
apply the last patch to my at24 tree.

This is the second part of the effort to modernize the at24 driver and
remove the legacy platform data structure in favor of device properties.
It required getting rid of the at24 setup callback in favor of nvmem
lookups.

Re-tested with da850-evm and dm365-evm.

Bartosz Golaszewski (12):
  ARM: davinci: da850-evm: remove dead MTD code
  ARM: davinci: mityomapl138: don't read the MAC address from machine
    code
  ARM: davinci: dm365-evm: use device properties for at24 eeprom
  ARM: davinci: da830-evm: use device properties for at24 eeprom
  ARM: davinci: dm644x-evm: use device properties for at24 eeprom
  ARM: davinci: dm646x-evm: use device properties for at24 eeprom
  ARM: davinci: sffsdr: fix the at24 eeprom device name
  ARM: davinci: sffsdr: use device properties for at24 eeprom
  ARM: davinci: remove dead code related to MAC address reading
  ARM: davinci: mityomapl138: use nvmem notifiers
  ARM: davinci: mityomapl138: use device properties for at24 eeprom
  eeprom: at24: remove at24_platform_data

 MAINTAINERS                                |   1 -
 arch/arm/mach-davinci/board-da830-evm.c    |  13 +-
 arch/arm/mach-davinci/board-da850-evm.c    |  28 ----
 arch/arm/mach-davinci/board-dm365-evm.c    |  13 +-
 arch/arm/mach-davinci/board-dm644x-evm.c   |  13 +-
 arch/arm/mach-davinci/board-dm646x-evm.c   |  13 +-
 arch/arm/mach-davinci/board-mityomapl138.c |  38 ++---
 arch/arm/mach-davinci/board-sffsdr.c       |  13 +-
 arch/arm/mach-davinci/common.c             |  15 --
 drivers/misc/eeprom/at24.c                 | 162 ++++++++++-----------
 include/linux/davinci_emac.h               |   1 -
 include/linux/platform_data/at24.h         |  60 --------
 12 files changed, 122 insertions(+), 248 deletions(-)
 delete mode 100644 include/linux/platform_data/at24.h

-- 
2.19.1

