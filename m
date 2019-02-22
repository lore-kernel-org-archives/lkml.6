Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE761C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866A8206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMpQzVk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfBVUFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39802 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBVUFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so1560405pld.6;
        Fri, 22 Feb 2019 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLgXukEyyHDJIUjgU13jznDjfk8zvTixS2St7n0l+Gw=;
        b=YMpQzVk+FqUOU7GQtIzYwQL5f/cYJh5g6WPEV/9wV/hnrlhAXxxKWqTvOJrlgy8LvS
         VuEJMhA6M/3OSMfihfPOEMNDw2sFqa5PD7gsYtRom+nBCqzZ4EA9poVCBQfBDbuS3Ido
         o20eGFnx4lMu2C0CpFWeH/5PPlm79VsexVOec/wXketbTSZmCY8JQSVoOp/BQpBaZ5iA
         /YOkmY3Ot+e8UlI00Q0owdf1j4CjIyhDslDHvUR7b/BgQ0Yde8GoxZHLao8J7Ae0kLUh
         jivW3cBUT1gMan+85kRhIJaJvxxzjmA1y7tDPx1luDvOlfl1Pa15PIPZGmtMQCydrvdx
         3DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLgXukEyyHDJIUjgU13jznDjfk8zvTixS2St7n0l+Gw=;
        b=sSVcKdWSaDvXuwyooLKpCrdXMTqQi7by6qKaRVCSsH6JPds9nnkTck3sIHCjEH3SsT
         0PURUmA8J+FB3BUBCe46ALkvu2QLhwkIUOo/wqUo9aTr0tZtU+HgHL15LM/FeZwdRwbB
         qfXB4y0V5TFlVRE03rsFdaJBZcr0HInYf+VSu2d+0qV0gYBkRihPyUV3E/HejoP6gg1G
         EK+ur2tnKIRcppZJZIkLhZweDX1+Qmp0jtBgKYea8dKW1hN00h0OvBTPOmpPGA1vBLpj
         piE1QOQJR/vMsPbYMllP4+SBmH4wdQ5vTxOPktvOiHzo8ASvdYqqsgp+PAfkQSzdHvJF
         NGWg==
X-Gm-Message-State: AHQUAuaRPOZ0w5tXJeWIjkiHDr/2BzU6oHyB2ynGKnxa0T6U+bU3s1q6
        03Szhu1fHATYvLfloc8Krj/g72Wi
X-Google-Smtp-Source: AHgI3IaLQ/ADB4bUrWYFTzEK248uHnt+jiZW9+eQnK6wIKnj88A+pssdxNDN4mDO4zPbtKt7OBT8Uw==
X-Received: by 2002:a17:902:9a43:: with SMTP id x3mr5811851plv.173.1550865920745;
        Fri, 22 Feb 2019 12:05:20 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:19 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13] QorIQ TMU multi-sensor and HWMON support
Date:   Fri, 22 Feb 2019 12:04:55 -0800
Message-Id: <20190222200508.26325-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains patches adding support for HWMON integration, bug
fixes and general improvements (hopefully) for TMU driver I made while
working on it on i.MX8MQ.

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v1]

    - Rebased on "linus" branch of
      git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
      that included latest chagnes adding multi-sensors support

    - Dropped

	thermal: qoriq: Add support for multiple thremal sites
	thermal: qoriq: Be more strict when parsing
	thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()

      since they are no longer relevant

    - Added

	thermal: qoriq: Don't store struct thermal_zone_device reference
	thermal: qoriq: Add local struct qoriq_sensor pointer
	thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
	thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly

      to simplify latest codebase

    - Changed "thermal: qoriq: Do not report invalid temperature
      reading" to use regmap_read_poll_timeout() to make sure that
      tmu_get_temp() waits for fist sample to be ready before
      reporting it. This case is triggered on my setup if
      qoriq_thermal is compiled as a module

[v1] lore.kernel.org/lkml/20190218191141.3729-1-andrew.smirnov@gmail.com


Andrey Smirnov (13):
  thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
  thermal: qoriq: Remove unnecessary DT node is NULL check
  thermal: qoriq: Add local struct device pointer
  thermal: qoriq: Don't store struct thermal_zone_device reference
  thermal: qoriq: Add local struct qoriq_sensor pointer
  thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
  thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
  thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
  thermal: qoriq: Convert driver to use devm_ioremap()
  thermal: qoriq: Convert driver to use regmap API
  thermal: qoriq: Enable all sensors before registering them
  thermal: qoriq: Do not report invalid temperature reading
  thermal: qoriq: Add hwmon support

 drivers/thermal/qoriq_thermal.c | 274 ++++++++++++++++----------------
 drivers/thermal/thermal_hwmon.c |  28 ++++
 drivers/thermal/thermal_hwmon.h |   7 +
 3 files changed, 169 insertions(+), 140 deletions(-)

-- 
2.20.1

