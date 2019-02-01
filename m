Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA0E2184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlP20WR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfBAITn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:19:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36264 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfBAITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:19:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so5196488wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 00:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=71MVWMA/8wD5zBXTn3iZ6b/RFSdxv3ty7sHGBPSBKB4=;
        b=DlP20WR180NJOVcE2oZ2W7xK7XXUumR5ygfrOIMzXyPaTuafNquAXiAHbvO6tzMJTE
         C/2GhgDrN9NU0gvl0D9JxgnLxJb8edaiI6mYlGQlhVWPEh/QIlucA69c8n2ZuzHs15tZ
         ztClHqOhnyKgxQyaOnOP9ORZWJ3slxdBx3c+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=71MVWMA/8wD5zBXTn3iZ6b/RFSdxv3ty7sHGBPSBKB4=;
        b=t1vMsDo/4q6aWOyYvfIPHfDrdE9M+zbZP4boU1P39oqp0v6UBBY50Ye+cEubJGSRYF
         1fCUaquQQ9zvvhk8j6Cp70rlwoBT4zb5tfxB1sXDt+D8OVhKAbHSE78off6Ge2hWJogm
         RC8V+yw2S/eIspN4Kh7ZZc/b2j4xtniaany8rRJZDUvJXgZs/k0Dk29R7WmPoBHD7jZN
         YFtTYV25i2GhkLerupYuyHpLopGMIv5pW5Qt8XO4M9RhefmjXTW0/fYs0hkJDxQNfK2j
         gFS5h6682gKYDv2VA7YXLNqDccuO7qoRJnBohq3CgzSMHSVLLnM0G7qx1znJj29sGxmR
         qoWw==
X-Gm-Message-State: AHQUAubpLeVA4dozMB50y4GMHuBvH/gDFddND3cXIW8xA7dW0B2b+gXu
        IALX+DnNDO5YibTUdl1nZBkEsg==
X-Google-Smtp-Source: AHgI3Ia/j86Mps5Ex2HBh4ee9ilRcrc8yGNuamLhrxniCsMxDEOGeV602kQsGIlVF81JfsZqIq77PQ==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr1308647wmi.144.1549009180331;
        Fri, 01 Feb 2019 00:19:40 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id k135sm2458922wmd.42.2019.02.01.00.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 00:19:39 -0800 (PST)
Date:   Fri, 1 Feb 2019 08:19:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org
Subject: [GIT PULL] Immutable branch between MFD and Platform due for the
 v5.1 merge window
Message-ID: <20190201081938.GC783@dell>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212173402.27086-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-platform-v5.1

for you to fetch changes up to fd68bd0f5d4c2090c95f84e27b05d0836bcd6c0c:

  platform/chrome: cros_ec_lightbar: Instantiate only if the EC has a lightbar (2019-02-01 08:09:27 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Platform due for the v5.1 merge window

----------------------------------------------------------------
Enric Balletbo i Serra (7):
      mfd / platform: cros_ec: Use devm_mfd_add_devices
      mfd / platform: cros_ec: Move lightbar attributes to its own driver
      mfd / platform: cros_ec: Move vbc attributes to its own driver
      mfd / platform: cros_ec: Move debugfs attributes to its own driver
      mfd / platform: cros_ec: Move device sysfs attributes to its own driver
      mfd / platform: cros_ec_vbc: Instantiate only if the EC has a VBC NVRAM
      platform/chrome: cros_ec_lightbar: Instantiate only if the EC has a lightbar

 Documentation/ABI/testing/sysfs-class-chromeos     |  32 ++++++
 .../sysfs-class-chromeos-driver-cros-ec-lightbar   |  74 ++++++++++++
 .../sysfs-class-chromeos-driver-cros-ec-vbc        |   6 +
 drivers/mfd/Kconfig                                |   1 -
 drivers/mfd/cros_ec.c                              |  14 +--
 drivers/mfd/cros_ec_dev.c                          |  89 ++++++---------
 drivers/mfd/cros_ec_dev.h                          |   6 -
 drivers/platform/chrome/Kconfig                    |  47 +++++++-
 drivers/platform/chrome/Makefile                   |   7 +-
 drivers/platform/chrome/cros_ec_debugfs.c          |  62 ++++++----
 drivers/platform/chrome/cros_ec_i2c.c              |  10 --
 drivers/platform/chrome/cros_ec_lightbar.c         | 126 +++++++++++++--------
 drivers/platform/chrome/cros_ec_lpc.c              |   4 -
 drivers/platform/chrome/cros_ec_spi.c              |  11 --
 drivers/platform/chrome/cros_ec_sysfs.c            |  36 +++++-
 drivers/platform/chrome/cros_ec_vbc.c              |  59 +++++++---
 include/linux/mfd/cros_ec.h                        |  21 ----
 17 files changed, 394 insertions(+), 211 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
