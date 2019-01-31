Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A88C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4520F20869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QVxvtZ1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbfAaPUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:20:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43394 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfAaPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:20:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so1599150pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITDyul5zig3PGH8GrA3owY3o+NpX5a3M/wI7nP9lJaE=;
        b=QVxvtZ1eQRMWkF//cZXkKT3CkkRMhs13BoaWYdzLjO/yb/hiH2lEoDWlUJLni4THo4
         iPtg+oXRUKFN1/D5U5/WvHY2odUdap4mwl6Ne+TstB3AUf9MEviOs3grqTnJH85+xLcr
         rrrhuT9eoypbODOv5aHazROL5jrEypcdl+A0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITDyul5zig3PGH8GrA3owY3o+NpX5a3M/wI7nP9lJaE=;
        b=cRhynfAqkxqbyS5oilkc3m4kRrk22pch24ik8C7+g7wfpDGZDRP3yYYloTAONNnMKI
         6MKQoR28eiZyDNBEhyaGaqiFo0DiOVVEmSOTRKyCy/ooypm6Ku+0DW/i7lXGRqYpNwR6
         JyMUfAXC97BiMspI2SS1uuEclqu9+SO+v6NrimwqrkZq8iK5a/DgNbhb38hd0+Im7I53
         ZJS9nnjN9yvNa3PY/n+TQeHpzLkhqm6I+k7tOT4ah/dqjAAK1MJVPsHRqRmFWGZ/d4hV
         E+eRA8UZCl1VJliKKdwx3KyAtjHizNwg63YOtHmBeNiAPHfDwE9KvZVa95BGK4g7h/hh
         cEAQ==
X-Gm-Message-State: AJcUukeX1CPWhi+JQ8E2fhPD/wLH5GUopqL1GIHW0PgxjxO51cN/Wb4q
        5Oif0QYKdgGAPeEs4rXxsIq3kw==
X-Google-Smtp-Source: ALg8bN7dVdxsD3j5WxY8KwQm4KtRPlX5fGZOb+YR6ofE8siYCCvcMtQM0NAzJ8c730McTKp33ELbFg==
X-Received: by 2002:a63:d450:: with SMTP id i16mr31369473pgj.246.1548948048231;
        Thu, 31 Jan 2019 07:20:48 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id u186sm6633664pfu.51.2019.01.31.07.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:20:47 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/2] arm64: defconfig: Enable I2C_GPIO
Date:   Thu, 31 Jan 2019 20:50:34 +0530
Message-Id: <20190131152035.7138-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO-based bitbanging I2C driver is required to configure
CSI data, clock pins on CSI block in Allwinner A64 SoC.

Let build it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- rebase on master

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6e5af2563ef5..8f36b1e8017a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -347,6 +347,7 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_BCM2835=m
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_GPIO=m
 CONFIG_I2C_IMX=y
 CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
-- 
2.18.0.321.gffc6fa0e3

