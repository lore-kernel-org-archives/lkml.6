Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A73C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695EB223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mlg3NuBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695EB223EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeHJPrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:47:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35454 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeHJPrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:47:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so1900369wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=DmNuopTBWlRSbYnnF/g51P5+p+b3JWyaxeSCwWr4iC8=;
        b=mlg3NuBqI3kqfp3XR+K2c+4YLoew1/626NMC9yB7vQ5yICfd9xqQaDtis9aNIV+VDT
         AaMEnSoQHWnnQmqAyIJVXIbubk/kSmyt9RWI0tTG+/+9hVttQpS0jppwDoMJwA1BS7gB
         GNXcU+/LbbuzHaotUTC9oKh988ze6urcm1+wirzIms0E7qvZhXlvRr6gTObtY/ajHE2Z
         9CEXuVn9RJIuTzLWJ/UBvjoRMZqXTklJ05yy3SS+6qWw/TcO4sSa3Q596uDTL8kghZvp
         bgTp5TZKYSx1EFGSkx+1lOFCpC4Zm+dCRnY9JlNkfALp1zLQoR4y8xCy8LX9z1F8RI0O
         kq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DmNuopTBWlRSbYnnF/g51P5+p+b3JWyaxeSCwWr4iC8=;
        b=SzHNbOB6KtW17a1EhEpY+XkUSXkcUeh6PUhOS0IRG0Z2Fq+1uUWEjXGVfIZx1yiqZF
         07hlfki8B0P8b0Of6a6+IlH0K4BuxBiA3Qd2mLesi1fyfM1foCL2Cilr2eFCFqHVUNf7
         /j4U6MV2KsN1GDIkYVVHdGMj5+8lncds96iOlhYmE+NT9wfWE0+/i+bAVoqkm9R3GOEB
         Fg70E7D1l076hliVt/fgq9VMfHQiQV3FQjZ3G2s+1p4DiajjIPA8oFiNUZXyOfuu0FZB
         0BWwBFitYwG9XSeD9n9J8gbQuM4t1DPPfytreNfXeCieN3TBaSnImnTCx2q+5zfKXG2L
         r6kA==
X-Gm-Message-State: AOUpUlF+kviO8NBxVS+AbdWIQUl1hUCednlFvDNdIVUD1Mop11J3tobR
        an1WhAZOCLIq/sYxBhkaJ/NjXg==
X-Google-Smtp-Source: AA+uWPwUVMXA64JZ0IyxWoYaT9lC5UUw89zp8hzEyI5uvcD7aT9mOGLnw0H0yV4SCDB2/zu/rOxecw==
X-Received: by 2002:a1c:5f56:: with SMTP id t83-v6mr1606205wmb.27.1533907036696;
        Fri, 10 Aug 2018 06:17:16 -0700 (PDT)
Received: from radium.baylibre.local (AStLambert-681-1-8-155.w90-86.abo.wanadoo.fr. [90.86.13.155])
        by smtp.gmail.com with ESMTPSA id i205-v6sm2069523wmf.30.2018.08.10.06.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:17:15 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gpain@baylibre.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 0/3] power: supply: cros: add support for dedicated port and expose connected ports
Date:   Fri, 10 Aug 2018 15:13:46 +0200
Message-Id: <20180810131349.3883-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This patch series adds support for an optional dedicated port
to the ChromeOS power supply driver and adds a new property that expose
when a power supply is connected. The series was tested on ChromeOS "Fizz"
hardware.

This patch series depends on the following patch serie which adds
the ChromeOS power supply driver:
 * https://lkml.org/lkml/2018/5/2/585 [PATCH v4 0/3] mfd/power: cros_ec: add
   support for USBPD charger driver

The ChromeOS power supply driver also depends on the following patches to be
applied:
 * https://lkml.org/lkml/2018/4/23/602 ([PATCH v8 0/6] typec: tcpm: Add
   sink side support for PPS)
 * https://lkml.org/lkml/2018/4/18/229 ([RESEND PATCH v5 4/7] mfd:
   cros_ec_dev: Register cros-ec-rtc driver as a subdevice.)

Best Regards,
Fabien

V2:
  * Rebased to fixed apply issue with patch #2

Fabien Parent (3):
  mfd: cros: add charger port count command definition
  power: supply: cros: add support for dedicated port
  power: supply: cros: add property to detect connected ports

 drivers/power/supply/cros_usbpd-charger.c | 126 +++++++++++++++++++---
 include/linux/mfd/cros_ec_commands.h      |  10 ++
 2 files changed, 122 insertions(+), 14 deletions(-)

-- 
2.18.0

