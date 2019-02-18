Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C97C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42972217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNmLNLgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfBRTMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41453 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfBRTMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id y5so3610430plk.8;
        Mon, 18 Feb 2019 11:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6Nzx1UBHbUz3hyzl5qrUbTEPXuO+FY0q06jvpcgndA=;
        b=UNmLNLgtSp5b9Sl12DMhlj+eN4/iQVFaEJp0K555aL7xdfI2VHi15ibQBlF4nkyV/q
         4nxy+TPLZJWuhRjFVuOADgIslzdS/F3aE/wsWMMRkHEDhekWGn5sZx4q7N0eGE+myCnW
         LUyTWht45PZYmu9jEX8LQyIj4jciZQfqHD0TgHuO1ivEjVYVmvFqy4AmhdmaJV0wG4cT
         e0pOvNhNTXgXvzBriGRHJ6b6fNfKit1v81ppZ9oRbg27JGXbVhVte6FUXiN1rnsSvcNA
         abnWshAOe5Ge/3DJKp0/Xz6DSJ5IKbcgChvLiDpHscfbcFSc0sZYIJRjZ5BRSYGFmyCs
         FY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6Nzx1UBHbUz3hyzl5qrUbTEPXuO+FY0q06jvpcgndA=;
        b=Bx6/IlVBFcsc+zvATqxbcI3x2ud9S/PkBFbYy60xA3teoqhv170qZ8dTOmge4JUmm0
         0vuyNuS2lVEUY5j0CiqaLDRyiGACtgWFkqckvjJ6CjJm4xtNZx9W+UQNk9SF/ftT+9Ia
         yRxT7NRqA0K4CYfH6NipByGV0g8WW6tRSI32VPqDYZuAhz7fglzrXEHMiXdpXPt7ZFV6
         gC8f/15iTw/cfWBHBLxf1A/3m6nrCoEUgWBHxuuitM9EKmGU1doiVATGT4lxRNWOxNHp
         GkLN/gwEpUO+crVUw4Hx/A8qGiZaQDak7R5iM6IGrfLLbvpQyMuKQ6uXFzRaQ87CwnqI
         defg==
X-Gm-Message-State: AHQUAuZNjXZUIfiI2Ll4v0WFQkmbaURZzI6yyyYppsvxarLtd9dS/CcV
        WukEgVqouX4MJrkc9pkAqrajYAfn
X-Google-Smtp-Source: AHgI3IZJU6pNjf0ooQXeDMruY/fSPVXJNgsPbIiW8z2ziyPzKC3pN3ngAeGpBufWuxs1mgCcP3vn/w==
X-Received: by 2002:a17:902:9b96:: with SMTP id y22mr27344771plp.179.1550517120410;
        Mon, 18 Feb 2019 11:12:00 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:11:59 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] QorIQ TMU multi-sensor and HWMON support
Date:   Mon, 18 Feb 2019 11:11:29 -0800
Message-Id: <20190218191141.3729-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains patches adding support for HWMON integration,
multi-sensor support as well as a small fix and general improvements
(hopefully) for TMU driver I made while working on it on i.MX8MQ.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (12):
  thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
  thermal: qoriq: Remove unnecessary DT node is NULL check
  thermal: qoriq: Add local struct device pointer in qoriq_tmu_probe()
  thermal: qoriq: Don't pass platform_device to qoriq_tmu_calibration()
  thermal: qoriq: Convert driver to use devm_ioremap()
  thermal: qoriq: Add hwmon support
  thermal: qoriq: Convert driver to use regmap API
  thermal: qoriq: Enable monitoring before querying temperature
  thermal: qoriq: Do not report invalid temperature reading
  thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()
  thermal: qoriq: Be more strict when parsing "thermal-sensors"
  thermal: qoriq: Add support for multiple thremal sites

 drivers/thermal/qoriq_thermal.c | 326 ++++++++++++++++++--------------
 drivers/thermal/thermal_hwmon.c |  28 +++
 drivers/thermal/thermal_hwmon.h |   7 +
 3 files changed, 214 insertions(+), 147 deletions(-)

-- 
2.20.1

