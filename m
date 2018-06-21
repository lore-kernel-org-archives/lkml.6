Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C93C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94CA20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uu/iGZK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94CA20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbeFUHhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:37:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33347 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbeFUHhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:37:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so2043764wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Djmr6P7/w02tjrGh56mJfhSLvLdCJdT0Xa6yTmN+g5M=;
        b=uu/iGZK0kvysdIhf4j8vxrrtF2h69qOg2e7QtSIuD4a2kP5ijW9bHn4P4LaD9jEXUE
         GQQ5/p5XQ+jVFzAmUfcZa5Q/yqxh/+oU6VKYeCpUAExPsrZMx0MQDy67vr73nOZsBUzh
         4bTgxwwW++7cjiUuxY8u7iEePZD+7gqo27YHsPONGXFtRpypfefbZQbdi681WO/bCBLI
         jb/D1aMMOsXspcsMNFHuq6ScsDORtZAfzBZI/zFR/V6qzy+Vk09uaZNHKoViRsM4wxnN
         mAGv7MO0oJVV7zEVVq6xIQbD3vWMBemwduirKg52a0jionlYSNHWW6moBDr5a/EutITb
         61xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Djmr6P7/w02tjrGh56mJfhSLvLdCJdT0Xa6yTmN+g5M=;
        b=fh2NIpXWqe+NLa0VHKlNGxdTO2b8u9gRe+fx7x6gItRLb2kYtxAC4wHODOtRJn2x/O
         +7fso7F8jzz0XyZFHZNT8/dkUmlRmwuGBrWZwsjx/+kwcCOfC1iSb+bMAWpgN8bObLRE
         g/gxlLEyay2LTTp40xAh2WmRT7z0q2ZE0gkowR2mYcImO8raRLObKkPcHBkDKciZn1WU
         eCMqnu9oSNXDlv19En9NCj6zk8fIY/Ysh6IHf0OY39li3ERO6dYcFad04c/X08yltVHl
         v0WgC/8W3THWH50Fcg6V4X1Ohl1GrfIm8HoRSh55NtD+0mEDZCU6Jx1AIXK4R1fd9gth
         OTkw==
X-Gm-Message-State: APt69E39X2O6CVZwAbf/FU+tlXypgdbtyPklMhmQG7RjEJAyGs3Khqoa
        MN9WoqJyF3y+RoFVaaWnrIUTGA==
X-Google-Smtp-Source: ADUXVKJlb++kgk3PoS3dbagrvIdQEr2saiwZ2gpEyX27T8mLV41fGAJ13xGo0wy/yELkG9Nj4DWNsg==
X-Received: by 2002:adf:ba8f:: with SMTP id p15-v6mr21866541wrg.139.1529566631093;
        Thu, 21 Jun 2018 00:37:11 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l7-v6sm767635wmh.1.2018.06.21.00.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 00:37:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v7 0/4] ARM: davinci: complete the conversion to using the reset framework
Date:   Thu, 21 Jun 2018 09:37:02 +0200
Message-Id: <20180621073706.22812-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

These are the remaining patches that still need to be merged in order
to complete the conversion of the davinci dsp driver to using the reset
framework.

They apply on top of v4.18-rc1 with David Lechner's remaining patches
merged.

v1 -> v2:
- fixed the device tree patches the descriptions of which were mixed up
- return -EPROBE_DEFER from davinci-rproc's probe() if we can't get the
  reset provider, since it's possible that the lookup table was not yet
  registered
- made the local variable naming consistent in the davinci-rproc driver
- fixed a typo in PATCH 5/8

v2 -> v3:
- modify PATCH 1/8: drop the provider argument from the function adding
  lookup entries and instead pass the provider name to the RESET_LOOKUP
  macro, return -EPROBE_DEFER if we locate a correct lookup entry but
  cannot get the corresponding reset controller
- modify the reset lookup entry in psc-da850
- don't manually return -EPROBE_DEFER from davinci-rproc, instead don't
  emit an error message if devm_reset_control_get_exclusive() returns
  this error code

v3 -> v4:
- make index the second parameter in RESET_LOOKUP() (right after the
  provider name)

v4 -> v5:
- fix a bug where the dsp_reset object correctly stored in drproc struct

v5 -> v6:
- rebased on top of v4.17-rc1 and retested
- dropped patches that were applied during 4.17 merge window
- added relevant review and ack tags

v6 -> v7:
- rebased on top of v4.18-rc1 and dropped patches that were applied for
  v4.17

Bartosz Golaszewski (4):
  remoteproc/davinci: use the reset framework
  clk: davinci: kill davinci_clk_reset_assert/deassert()
  ARM: davinci: dts: make psc0 a reset provider
  ARM: davinci: dts: add a reset control to the dsp node

 arch/arm/boot/dts/da850.dtsi               |  2 ++
 arch/arm/mach-davinci/include/mach/clock.h | 21 -------------
 drivers/clk/davinci/psc.c                  | 18 ------------
 drivers/remoteproc/da8xx_remoteproc.c      | 34 ++++++++++++++++++----
 4 files changed, 31 insertions(+), 44 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

-- 
2.17.1

