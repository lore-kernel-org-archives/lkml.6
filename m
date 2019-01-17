Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5310DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D48B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rfkmg9+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfAQKXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:23:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55613 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:23:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so434797wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKFGlyePrqXLCsc2FjkWti75c8kQk+cr+YrqmnNo64w=;
        b=rfkmg9+6zBqjgCNRsiGDNHDjIePdJgrZu2eFFmoURnX1zGrO4DVQrVmkrgB/AtBdZx
         u8z+WU2fdACnYyUQFkyfKrx96BFgRZb5P5HNJnj47LbVzEocZK/Duq7o5eTPNTbX9h5C
         c76vffJtC4d35LI0w4/93Qu8zG8EDE6ivUGYwEQulcfSNS6jpqqJ60eJUBI5IFOiQFbC
         AoB3mFYm1/Yvo1reit2jHsq+3ePUjMa5H3eQDojhoIKxQox1ryUwJ4LNC1mZTGM+Yq7a
         lfSFE5Svfe0SeBkGPEYKrsM0y9nwC5QYv1+7GmHBpoKy853TDbSjm1oFCOOyra4uhZ2v
         mi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKFGlyePrqXLCsc2FjkWti75c8kQk+cr+YrqmnNo64w=;
        b=dagyEIRBzeKcZcl0OumRzNdvcpByQsGrgDqDDFzLRK/1p9bZAsDhnL+dSvOV473iXz
         WDkTM0IRk97mz/jrtBIyaganfElkPpOAx3XWd0rNIYCSU2RtfMuNCupukLHxZILZvVqX
         /qYslpaUEBh1cjYCRC7dhFj7L4PO5IdbHgPUT63CsYK+5uoRk0JUQwqxppzTxUyoOjdN
         QC5b8/Q2384KKg0UbYqvWkhFI7W3sOPQYp6VJFc4qJQ772wfyqoZHsOxu+saQVDMZwoX
         TPC2YlB/m9XmketvxFEQeBXuX1wA4qvtJVzNvnP6YM5MV0TCkW+QsvVlT5kjphHqpGpI
         u3LQ==
X-Gm-Message-State: AJcUukdk9TUZAD+a+HNQg9N+p7deoge9umFc2GGBaWAMKRYgXoC0Vyzc
        JqmXbzraFMcsFgOsVLKqdOh1VQ==
X-Google-Smtp-Source: ALg8bN4I9wCh1M10jclA58pcFRDWiTD4vrOfQHJrFIfZZthLmhj4bhC4fl1X13mOxizqVok2G3F6Tg==
X-Received: by 2002:a1c:1688:: with SMTP id 130mr10675193wmw.86.1547720602762;
        Thu, 17 Jan 2019 02:23:22 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id u10sm66400530wrr.33.2019.01.17.02.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 02:23:22 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] pinctrl: meson: g12a fixes
Date:   Thu, 17 Jan 2019 11:23:12 +0100
Message-Id: <20190117102315.1833-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the initial pinctrl support added for th g12a SoC
family, which is mainly around the register regions claimed by the
driver.

Linus, would it possible for you to provide a tag with these changes to
Kevin ?

ATM, we can only use the devices for which the pinmux is already set by
the bootloader. Enabling the broken pinctrl driver could cause regressions
in kernelCI. Having a tag, would allow us to start using pinctrl on this
SoC in this cycle, w/o regression. It would be nice :)

Jerome

Jerome Brunet (2):
  dt-bindings: pinctrl: meson: update register descriptions
  pinctrl: meson: add optional region for drive strength

Xingyu Chen (1):
  pinctrl: meson: fix G12A ao pull registers base address

 .../bindings/pinctrl/meson,pinctrl.txt        | 10 ++++----
 drivers/pinctrl/meson/pinctrl-meson.c         | 24 ++++++++++++-------
 drivers/pinctrl/meson/pinctrl-meson.h         |  1 +
 3 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.20.1

