Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9B6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3903D219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9W+FFIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3903D219E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeHFLWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:22:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45611 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeHFLWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:22:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id w16-v6so9971378ljh.12;
        Mon, 06 Aug 2018 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=saMR/6gfdyKAMhicqzFP5W6VqmJ4SzH5aSP/KO4QbS0=;
        b=A9W+FFINZe8EIECKihoMR0ihwug/TXQQvLn7pbKeMvGD+Bzny5iYQCQnjywWPYzpl/
         Cdl2azFDXKmRubaPK5rUR6B1n4FLlxFl0odT8YjL34Oabut4FSZVIP5uFQFzFQj3URmp
         iATNF3LlZ6pJMolN/pZrAwAEfD2NHRtdU5XkJtZq2oeYgbdclpIv5QF/y6dt1M9zFnZ9
         G/j6m++y6wOqJxtLhvdKI1883OGGzG6Y8YYXm/VkcWiLm6VI5Y7o7gFx1vQMCpVs/lRt
         3J5SqEe+4M3GoBrXJFtBQnvwoIRBOvevWesavbKenVNSAf2a/fNgAt5HhR2I3q2hvqGF
         y/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=saMR/6gfdyKAMhicqzFP5W6VqmJ4SzH5aSP/KO4QbS0=;
        b=YlfzM/6lD1etXB4dLHEe1uLLKb5X6Xb7EMueGBAcYLBjBtbnRXbkOqbMZEutJnl1/n
         mbIjbg35WEJuLQlCjuvHXzRw3koCBcnaRNmiwFsxZBEsbQ/SxWysYU9u15mUjun8EDnJ
         c8lVVEafMAkmNEMh7Etg/Q26xd9xreM5trzwnJiBsLgKYnxwwTMln7L/xiRHlpiipe+L
         MqmgCN4kEiE7aCfhKUmrPfDjvGornCAbkXmF5qaGogYafn/nC5fARrXd7qwGrd57x1U+
         IELNNVJ00eyWkPz6BxCJQ6f93r5b9ZkB3q9i9afaa80FquY2E90j3ws/866DyDaomzTt
         EQ+g==
X-Gm-Message-State: AOUpUlHfu6WVKxJJzor9XKpd4oPd+wsVpxYoHevfgh07djD9XTd2BFxk
        C313YnhcQabcvk09RqbFAf8=
X-Google-Smtp-Source: AAOMgpfPDq+mBVE0aPO9KhZKL2sZqb/GLVjlfv9LCFaiW7Jcpeb0nZtuE2dFRGJFDV0zQxgthbkxKA==
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr12785509ljh.18.1533546845419;
        Mon, 06 Aug 2018 02:14:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q16-v6sm2175912ljj.68.2018.08.06.02.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 02:14:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] pinctrl: tegra: Move drivers registration to arch_init level
Date:   Mon,  6 Aug 2018 12:12:06 +0300
Message-Id: <20180806091207.12586-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in regards to deferred probing within the drivers core
that causes GPIO-driver to suspend before its users. The bug appears if
GPIO-driver probe is getting deferred, which happens after introducing
dependency on PINCTRL-driver for the GPIO-driver by defining "gpio-ranges"
property in device-tree. The bug in the drivers core is old (more than 4
years now) and is well known, unfortunately there is no easy fix for it.
The good news is that we can workaround the deferred probe issue by
changing GPIO / PINCTRL drivers registration order and hence by moving
PINCTRL driver registration to the arch_init level and GPIO to the
subsys_init.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Stefan Agner <stefan@agner.ch>
---

Changelog:

v2: Corrected commit message with s/to suspend after/to suspend before/.



 drivers/pinctrl/tegra/pinctrl-tegra114.c | 7 ++++++-
 drivers/pinctrl/tegra/pinctrl-tegra124.c | 7 ++++++-
 drivers/pinctrl/tegra/pinctrl-tegra20.c  | 7 ++++++-
 drivers/pinctrl/tegra/pinctrl-tegra210.c | 7 ++++++-
 drivers/pinctrl/tegra/pinctrl-tegra30.c  | 7 ++++++-
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra114.c b/drivers/pinctrl/tegra/pinctrl-tegra114.c
index 511a8774fd8d..d43c209e9c30 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra114.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra114.c
@@ -1868,4 +1868,9 @@ static struct platform_driver tegra114_pinctrl_driver = {
 	},
 	.probe = tegra114_pinctrl_probe,
 };
-builtin_platform_driver(tegra114_pinctrl_driver);
+
+static int __init tegra114_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra114_pinctrl_driver);
+}
+arch_initcall(tegra114_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra124.c b/drivers/pinctrl/tegra/pinctrl-tegra124.c
index 57e3cdcf4503..5b07a5834d15 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra124.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra124.c
@@ -2080,4 +2080,9 @@ static struct platform_driver tegra124_pinctrl_driver = {
 	},
 	.probe = tegra124_pinctrl_probe,
 };
-builtin_platform_driver(tegra124_pinctrl_driver);
+
+static int __init tegra124_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra124_pinctrl_driver);
+}
+arch_initcall(tegra124_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index 624889ed3a9d..1fc82a9576e0 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -2277,4 +2277,9 @@ static struct platform_driver tegra20_pinctrl_driver = {
 	},
 	.probe = tegra20_pinctrl_probe,
 };
-builtin_platform_driver(tegra20_pinctrl_driver);
+
+static int __init tegra20_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra20_pinctrl_driver);
+}
+arch_initcall(tegra20_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra210.c b/drivers/pinctrl/tegra/pinctrl-tegra210.c
index 0956a1c73391..3e77f5474dd8 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra210.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra210.c
@@ -1582,4 +1582,9 @@ static struct platform_driver tegra210_pinctrl_driver = {
 	},
 	.probe = tegra210_pinctrl_probe,
 };
-builtin_platform_driver(tegra210_pinctrl_driver);
+
+static int __init tegra210_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra210_pinctrl_driver);
+}
+arch_initcall(tegra210_pinctrl_init);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra30.c b/drivers/pinctrl/tegra/pinctrl-tegra30.c
index c923ad58af84..10e617003e9c 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra30.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra30.c
@@ -2503,4 +2503,9 @@ static struct platform_driver tegra30_pinctrl_driver = {
 	},
 	.probe = tegra30_pinctrl_probe,
 };
-builtin_platform_driver(tegra30_pinctrl_driver);
+
+static int __init tegra30_pinctrl_init(void)
+{
+	return platform_driver_register(&tegra30_pinctrl_driver);
+}
+arch_initcall(tegra30_pinctrl_init);
-- 
2.18.0

