Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FB8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B10208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7GzfF/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B10208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeGPQQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:16:10 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44957 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeGPQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:16:10 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so15431786pls.11;
        Mon, 16 Jul 2018 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fP7rOYuQG4G8KhED01V0G5aV8vBJY/MpeTNEFJSl/Pk=;
        b=B7GzfF/2D1bHlg2deGkTAuOYVD7Pb3ywSmxxgG+/1m5AJP6AFQ1K1gaXM5/gnMHT7f
         LuJjFD3oYNlTZy1z+sR4rJlWfXfAWHqjpAp7I5gx1J4kKMFlKedQDYxvdTg+JEytVvSU
         J/MqGI+piEraGNzZx8tcl/MarodJaXovC4n9og25nxcWJ7EqH8EWK2neJGXXaqS/zKNN
         d0gPOXk2Hm3HdEOHSM6k7/FcLonZoMxEEpRXWs3M2rIPbxYCoUXi6/g7SUQ2L7AnRT9q
         pwq7TjEnAmKEW+CRq3Le3LZYlGNqrP3rpeSEbOPJWZuiz6wElqct6Mi0TaFhkU66ieIg
         6XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fP7rOYuQG4G8KhED01V0G5aV8vBJY/MpeTNEFJSl/Pk=;
        b=eqo0LTa248KtmOPhNlcMJFwhuuiSCxEnJaKdmo5updQmMZxoidPYRelGDB13h124cJ
         jfhu0y1NcdnlHwOeHXqc3IIxV0PCXcg83WBOx5B9OU5ObZfPy14I6PHeDzG3jT2DzO6p
         2zr+G340nEL26XNkTpOoSh7nrZ8nP9RMS64cqOqrLs9WjPSBmShf46IcQUTnsQpnc5Uy
         wRQ96sYVv+RT4aCefwFL3l0KgSqpPyysDAMkh/ZOQ9tomEeLNYN+CbpTwRW1ly0zQHUc
         sn8Ss1FU0COUWz/pztFKRxy17ezqkeyBzsacvBwUTR32zv2AOMZOCHIeqRoIKt2YPJis
         aXLA==
X-Gm-Message-State: AOUpUlFVkjEICwd8rqFe+w57qfFoIx4u/aurcHYx07XEvuE3zwyRgjCG
        /3Aro/fCPQW1UnDyFKW5mMa2WQ==
X-Google-Smtp-Source: AAOMgpd78iC+HZIRypJkio1Wdd2JtPoywnJkQ42QrdBPpzv//P9nDjoPM0qWWAFXHnblB13kmytdVA==
X-Received: by 2002:a17:902:2983:: with SMTP id h3-v6mr17337636plb.232.1531756089383;
        Mon, 16 Jul 2018 08:48:09 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:91ac:ef2:819b:3d04])
        by smtp.gmail.com with ESMTPSA id r64-v6sm6195001pfk.157.2018.07.16.08.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 08:48:08 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH -next v4 0/3] introduce SCCB regmap
Date:   Tue, 17 Jul 2018 00:47:47 +0900
Message-Id: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces Serial Camera Control Bus (SCCB) support for
regmap API and convert ov772x and ov9650 drivers to use it.

This patchset was previously submitted as "introduce SCCB helpers"
that provides three functions (sccb_is_available, sccb_read_byte, and
sccb_write_byte).  This time, the helpers are replaced by regmap API,
but internal code is not much changed from the previous version.

* v4
- Introduce SCCB regmap instead of helper functions,
  suggested by Sebastian Reichel
- Change ov772x driver to use regmap instead of helper functions
- Add register access conversion for ov9650 driver

* v3
- Rewrite the helpers based on the code provided by Wolfram
- Convert ov772x driver to use SCCB helpers

 v2
- Convert all helpers into static inline functions, and remove C source
  and Kconfig option.
- Acquire i2c adapter lock while issuing two requests for sccb_read_byte

Akinobu Mita (3):
  regmap: add SCCB support
  media: ov772x: use SCCB regmap
  media: ov9650: use SCCB regmap

 drivers/base/regmap/Kconfig       |   4 +
 drivers/base/regmap/Makefile      |   1 +
 drivers/base/regmap/regmap-sccb.c | 128 +++++++++++++++++++++++++
 drivers/media/i2c/Kconfig         |   2 +
 drivers/media/i2c/ov772x.c        | 192 ++++++++++++++++----------------------
 drivers/media/i2c/ov9650.c        | 157 +++++++++++++++----------------
 include/linux/regmap.h            |  35 +++++++
 7 files changed, 326 insertions(+), 193 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-sccb.c

Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
-- 
2.7.4

