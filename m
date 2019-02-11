Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC85C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32E02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Sufvb4eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfBKKhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:37:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38524 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfBKKhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:37:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id v26so16308000wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lp1z88rmSvOgpHJjKgNZ/hWDt9IGj1pIXD05fNWwKy8=;
        b=Sufvb4egsQ51rirVphDLxi9YG0kRqBsdDsj4Xa5r1xMgynbkKEnv3/RwUr6Tl5lwJi
         VPO0szmPHap3TVe5iNXXwocVml2yBvtoPYhHxlNR1keVFD8eXvKKoZuYsF8KOQZZX8s6
         27AxLaF92J3Okhx1Wqs5nKs/2NgmqpdONsgTxarYyj7fNESL/h55iG+yDsjKn9TenNEk
         U5kFti2fGgffjnQPuGFG0ZkNoEe2yr+vNWl/4rr6ahKoQe+JCoeb+1G05qstAvS1HJCo
         5CP9ygbRa+K6EbTVQ209WEmnVOT+kZihhcJszN3kXZVBRP0Qr6vILVpf1WWBCGoeCP03
         +9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lp1z88rmSvOgpHJjKgNZ/hWDt9IGj1pIXD05fNWwKy8=;
        b=OiHSgMETutnVS1l2g7p1AutxOnUUth1U+pXDTsb5QFr0532dM8HYgO4QMEae3uI9Sp
         FL2BUvn7XEDse34Bc3G55LneK1HX814GN7yASDZ/acXmxApyoYAXpFC8EQa1ZIzCz/G5
         hSlwtYfIAb3qaau2hRLU1MtV8RpBawNnyiLm05WwxDLzpzL8qhw4wUmbgqAPlO/jZCHU
         2CJkpp2olabVKs1CyoLflzrdTdCAU/B9diuIxvEEf+vpkS+x3lgyRxb0KDT89cl9XahK
         OXG5VY0V3lGd6Wug9wKOAYnBh/Bdathvu31VxC6ldoszGw1ERpf/0Tf482U0e7+CZLvN
         sMDQ==
X-Gm-Message-State: AHQUAuaNrGSm2CSvxOABQtt/AmLv+5kSnwnrO5CxLuRGOsfVqPxijiF9
        ji1iRNL97wKmgqELgz8OIGzIGw==
X-Google-Smtp-Source: AHgI3IYo5IcQW4kWbVn+7JxJfi7KrWkt9X31jdXtUzSKteRW1gb7ZzGR5lRcQWfbO0GA9UnxpZfVcA==
X-Received: by 2002:adf:e647:: with SMTP id b7mr1739112wrn.260.1549881426304;
        Mon, 11 Feb 2019 02:37:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:37:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/8] ARM: davinci: move the da8xx-ohci GPIO logic into the driver
Date:   Mon, 11 Feb 2019 11:36:54 +0100
Message-Id: <20190211103702.4277-1-brgl@bgdev.pl>
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

v1 -> v2:
- use the non-sleeping version of gpiod_ functions in the irq handler
- improve commit messages (make them readable without the subject line)
- collect Acked-by and Reviewed-by tags
- rebase on top of v5.0-rc6

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

