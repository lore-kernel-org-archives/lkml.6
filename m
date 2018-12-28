Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68582C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE5320856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcSrwqY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbeL1QSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:18:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45571 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeL1QSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:18:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so19044085ljd.12;
        Fri, 28 Dec 2018 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+leDKkBVfjRpoUE44MkXKt8HF9pvwnytOv/e4MMaU8=;
        b=WcSrwqY64z5Sb6TFyFSlJCQlUBLnDE+X8oeeAfM4tmamS4Lh9uQe1jQoWlW7U7R1AK
         vgVcNUyDu4KZ6FkIXLCu7FmfNrRQMD3Zk2NyH/GQT7iDpjxZDGZ2Z2UOAY7fpwx/ka7V
         yaaXr3UsKTFnrUemBUuhHdsA8opySn/Lq7xmYgZJdqYi33I8U4Gp8+PjQJxGc1vToR8B
         /GosPsVzPOC6Sy3fFptbGyYFymAfg0dfMyNbfWZT1U8R4KXjhyik54V0lLX3wbdAQ9ih
         gmlVaKH2khrWFyQImyAc8BSUmiwTonbuAVHhvOE6T7EYK1kUDNami48K1i7KER2ZZHdL
         VoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+leDKkBVfjRpoUE44MkXKt8HF9pvwnytOv/e4MMaU8=;
        b=XX8mUR/2pASi3q3hsdojDjpF85mrMkwQbLUdfOu7d0OKwjo6mbtUJAlktEN0JKVDaL
         M5UmJ3x1lX9/uPiclu0YNcJrWcNd2XkEwHplVGtr0sV4Nv0gVl3fc4jX5S5nMJ72XMgq
         ZZOkxPuQxnci/JuqA0KE77efYOA601Ys7iRwJBkwUh5B7jETNP087RdxNh+nYK7ijuif
         YIg/fSu91aXLu7Tomtjao2tMjvS1mM9QEbXMyVOn4NHsqKfKf88+Pp5LVdAXbxoFfsfc
         HEOdVwojS6IUN6c1FgSV/i+3fSiAj3WWvlJThDiBfGnKq7gHdSGQuEPUjnDngeZO2bWM
         ARzg==
X-Gm-Message-State: AJcUukfDIOHqoyOyjFVR9MXN/o6YCnD2lpIDWCeI2mEPgkf7HUTF84R9
        7ijIClkUd7c+coG+1JAwIOw=
X-Google-Smtp-Source: ALg8bN7r4F+mBjki6kxhWO46pf+rJxzeohYOsNUr+Rcmz2Pga8Ms1bki4O3aO7GlE5ME1gPr2/XfXw==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr16099242ljh.63.1546013910132;
        Fri, 28 Dec 2018 08:18:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:18:29 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] ARM: dts: s5pv210: aries: Enable more drivers present on Samsung Aries based devices
Date:   Fri, 28 Dec 2018 17:18:13 +0100
Message-Id: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables more drivers for devices present on
 Samsung Aries based devices.

First patch switches fimd to correct variant, which wasn't
 present at moment of adding aries dts.

Next two patches removes hardcoded bootargs from dts files
 for galaxys and fascinate4g, because now we have working bootloader
 which can pass those values.

One of the patches also reserves memory for Samsung S5P MFC
 video codec, so it's possible to use it.

Last two patches adds and enables more drivers.

Jonathan Bakker (1):
  ARM: dts: s5pv210: aries: Support for more devices present on Aries

Paweł Chmiel (5):
  ARM: dts: s5pv210: Use correct fimd variant
  ARM: dts: s5pv210: galaxys: Remove hardcoded bootargs
  ARM: dts: s5pv210: fascinate4g: Remove hardcoded bootargs
  ARM: dts: s5pv210: aries: Add reserved memory for mfc
  ARM: defconfig: s5pv210: Enable more drivers present on Samsung Aries

 arch/arm/boot/dts/s5pv210-aries.dtsi      | 90 +++++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts |  7 --
 arch/arm/boot/dts/s5pv210-galaxys.dts     |  7 --
 arch/arm/boot/dts/s5pv210.dtsi            |  2 +-
 arch/arm/configs/s5pv210_defconfig        | 41 ++++++++---
 5 files changed, 121 insertions(+), 26 deletions(-)

-- 
2.17.1

