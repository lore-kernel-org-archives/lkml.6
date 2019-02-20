Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685A0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C3D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vFtxneft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfBTLMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:12:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44188 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfBTLMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:12:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so10877686wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q4wAmubw+71ow/UhLi8/rFgd6cQ65r5DJHbcxmmblg=;
        b=vFtxneft+rbf7b5Ztv0rIbTpneDSzkka68pjs5ZOKvkKuXbtqEjBEpV/Bg7TI/Y9u+
         JHbBCJVgQZzBmLLcawTyFMJjrtYSgebnXPn8N4vy9h0SKASe9+b3zAS/NHCnmrIn6u54
         vq+WrYkeO5CweERdnDGkh0JHTFOcFTwNpUjob200IpQWmY1SeJvRd0Zcdpc9+ImJ1FJT
         KbTv/sHIhxXNQ9mJHlZaxFdbH5EFff3yO1Y7cqIHyPdoD7if2DgS1hXo3m4BIOEKJseC
         fZ+PIxyrOckXjktW4LrGtRwW4wrw1ZO+91pWxNO45YAZxiD2w6bzxZoMfiRIy8SgakE0
         JyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q4wAmubw+71ow/UhLi8/rFgd6cQ65r5DJHbcxmmblg=;
        b=k4cl35kNOKvqocHQvtsfAWf9QJNRD4urd2sx3CDY+5gz+sKNgkDApHNbIvBJWBBYT7
         LwoXjcNrF7ZyOkkFqDrcqc61b2mWUvCI9DZiRAtVA0M8xTbdSmaSTSasMAuHI1758ZBZ
         BmDoOl/AuEbgSUthBOz8CnBkibfwdq6t+tCEgKjVizusvgf2F6cyZzt0gZh+L+kuqlwd
         0zfLYu6Ve7l1EYF7xP5SvLFaR2MNLDJndD9LSmq3fma5V3iF8cK8iZbeZXUkaUSg6FNb
         xG7xhLv4xoXOTmiKWS99xBongmz0LfbME0W+Xi/HChTA+SSVDrDEyiEoq2NkO6mTccPK
         vhGw==
X-Gm-Message-State: AHQUAuYHqG2weXt7HgI+khBgbgHrhr+inThLkltwI5xbk1x8YkmiRmnw
        QLPnNpjcVjbcF1tbkx1sELxtvA==
X-Google-Smtp-Source: AHgI3IbCZ4y1QXWNqO7p6u9/DluycvSU+f+qt5VuzAJDL5TF4kjk9/laSnPNEXFj14cgRieh+dLKFQ==
X-Received: by 2002:adf:e706:: with SMTP id c6mr24486829wrm.278.1550661167235;
        Wed, 20 Feb 2019 03:12:47 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c18sm22969770wre.32.2019.02.20.03.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:12:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/2] drivers: new helper for ioremapping memory resources
Date:   Wed, 20 Feb 2019 12:12:38 +0100
Message-Id: <20190220111240.10041-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are currently 1200+ instances of using platform_get_resource()
and devm_ioremap_resource() together in the kernel tree. It's a minor
redundancy, but consolidation is always good.

The first patch in this series adds a wrapper for these two calls and
the second uses it in a driver I could test.

If accepted I'll prepare a coccinelle script that'll make it easier
to convert all users.

v1 -> v2:
- EXPORT_SYMBOL() -> EXPORT_SYMBOL_GPL()

Bartosz Golaszewski (2):
  drivers: provide devm_platform_ioremap_resource()
  gpio: davinci: use devm_platform_ioremap_resource()

 drivers/base/platform.c         | 18 ++++++++++++++++++
 drivers/gpio/gpio-davinci.c     |  4 +---
 include/linux/platform_device.h |  3 +++
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.20.1

