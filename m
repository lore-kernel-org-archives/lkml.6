Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A83AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE572083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bpcuFGma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfBEKZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:25:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbfBEKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:25:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id a16so3024641wrv.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsNW22ssNcRzeaLbI3kaHnMCg+AMjSvUm5/De6rVJv0=;
        b=bpcuFGma4ARp+rS3F1Y6V4YUidcHMBR5+qlz7Kp8QZJQIJB6LAnK6mtZWs6glMlX6h
         IF9N2vdbUKgh9CkWOI7eFXROxa2V0v8FbbWDy75SMS5JnymJbcATlH2E5Uhv6T35WofX
         l7s6JMnkipTc0TwBjvsPs7Vub0rK6RXf3ijQqBg3I+tELDTpjgP/ZLMReQMhSj1k7RaD
         IGxQUcaJCDIdpTpx+2zmag4HZrxM3gsQgUyj/t62BRXGh9+0uf7JGfMuErGhcoDwUPl0
         p6kyMZm6AZng2bf2TDdhd4lZdH9WqbfG5m+GLTo7xtDLiaVpOkvctD90nJuC1H0y0Yyg
         GLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsNW22ssNcRzeaLbI3kaHnMCg+AMjSvUm5/De6rVJv0=;
        b=JZgLzmSFGf2kVzyxmtGo/xKD3sZTP8NsAqDU5nGUl4YauL7gxhOUhizvlV74QN5P8q
         H18aikAt37eF5Q1fhPAeoBScDCbVypwfXtD37KsJnVJ0cM0WxsE7cjEqbB1O01z9F9Eq
         XRPPHL06PvuaM7KOl0VJI66GVs62LCYbfNpRET6aIFVCojVT4k92MQFZqebgL7yA75pc
         S5/EhWi3PkMpikt0Nr0touPvcrV07d8ZZhjBJWPYReWUPPCwuEqrXR7zPxBw3N8E1d0F
         0CDLwd4ueeymo/RlFDfjbVsaihImE20ey00NxqL+oN0wUm45yOlPE5o02UBfgb9OYWnI
         5WLQ==
X-Gm-Message-State: AHQUAua+xgJQ62DFz8S9K9c5dL/r4DmJntV9Wg9gujR3pw/cuhlvNfx/
        /Z5v3gFkfXGC36b/qA7o+MEezA==
X-Google-Smtp-Source: AHgI3IYtZh9j91EE8qCq+sT6sMUlF8AIU8mOHOTsUv757AKgBdtKOyzNSYAfc+NbMCTx7Ocgay6M6A==
X-Received: by 2002:adf:f903:: with SMTP id b3mr3193749wrr.82.1549362350470;
        Tue, 05 Feb 2019 02:25:50 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:25:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/8] ARM: davinci: move the da8xx-ohci GPIO logic into the driver
Date:   Tue,  5 Feb 2019 11:25:38 +0100
Message-Id: <20190205102546.29457-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In order to drop the hard-coded GPIO base values from the davinci GPIO
driver's platform data, we first need to get rid of all calls to the
legacy GPIO functions.

This series moves the GPIO logic related to da8xx-ohci out of the board
files and into the driver code.

First two patches are just coding style tweaks. Next two add the GPIO
lookup entries to the board files. Patch 5 add the vbus and overcurrent
GPIO logic to the davinci USB host driver. Last three remove code that's
no longer used.

Bartosz Golaszewski (8):
  usb: ohci-da8xx: add a new line after local variables
  usb: ohci-da8xx: add a helper pointer to &pdev->dev
  ARM: davinci: omapl138-hawk: use gpio lookup entries for usb gpios
  ARM: davinci: da830-evm: use gpio lookup entries for usb gpios
  usb: ohci-da8xx: add vbus and overcurrent gpios
  ARM: davinci: omapl138-hawk: remove legacy usb helpers
  ARM: davinci: da830-evm: remove legacy usb helpers
  usb: ohci-da8xx: remove unused callbacks from platform data

 arch/arm/mach-davinci/board-da830-evm.c     |  73 ++----------
 arch/arm/mach-davinci/board-omapl138-hawk.c |  81 ++------------
 drivers/usb/host/ohci-da8xx.c               | 118 ++++++++++----------
 include/linux/platform_data/usb-davinci.h   |  14 ---
 4 files changed, 77 insertions(+), 209 deletions(-)

-- 
2.20.1

