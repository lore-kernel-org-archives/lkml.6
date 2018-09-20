Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6BD2150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhy6MNRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6BD2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeIUCbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:31:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36425 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:31:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id v17-v6so5695336lfe.3;
        Thu, 20 Sep 2018 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d3SsFeK73BDBaVaH0gbzC0wuehUzjUhBg5plqI7ONe0=;
        b=Jhy6MNREd0B2FfU8q2jRLiVWWEL400/s5E6htFqTPXys4GdzlDNcA6DQ9BXB6Xr05N
         ALosh9hOO7rbL6ORvV7x5qT+HK2Ypn+/ZZjWpy28mZaOMsn4fiVtiSFL0BLeuFu+XExD
         qbDFI5nyjV5MgAuuWS9CQs5GCDO96OyeipKr3C9aHqa3xRs51/BSVplOg1YM+x03cPiC
         dP8sXOYe8gkbu85/K3Jf3UWBi11Gkox8yFchmUU+tpjb+4NB2iPFj1V8r3gXXiy3wgFR
         OJ0hIIp2KeWOmi6oqg9RjUvjoygSZEa7cs51Kazqf6SXx8BzjuZTZWOLu4ZwwIhd9rZu
         lM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d3SsFeK73BDBaVaH0gbzC0wuehUzjUhBg5plqI7ONe0=;
        b=MWfeeb6k30I5udOj3UCaFoGkmJYkcFRazsRL2A0lhgQly4stVTGyl5/ikEGgP/CeHv
         M+hOiTehe06Fe1tKiDu6lmuVqa796WN0MOzBqdJEg39yg1Dy9dDdDJ+dAWnfg8hyeXjD
         EYQoJS9UFUJm4zMB/B3HoHFMuumMB7O+PCbvfwvTUtjpq5ZrfO+MbgHLMtZUCto5uld0
         Dgqe7XM/DjZDZ0AC2nOGDNZSgBnHY4G3fz8nOzakM78QpfSq/tRMCCIpeh0+6DwFVinW
         hpNnsQsjLLtoq8GsGkBM8XwJqaXTKlXU4SDhLg726ZcEg/G6eKJc4NA5f0sDcUZG4pwg
         Zbpw==
X-Gm-Message-State: APzg51CldqF5DbtgCeWSSNA9C+bZZWfOxZn2Dt1F+lLK5ZLMHkrGeJqA
        plPqqJn9IlPWV6t8AyOHLGc=
X-Google-Smtp-Source: ANB0VdaNaJYo5qF28iNo/ATHp3e9Ftu+x/uIGCCkXiOx2LPCBilO9VoRGbIeCzdp9U6EDorhoNR6iw==
X-Received: by 2002:a19:6f0a:: with SMTP id k10-v6mr13969438lfc.143.1537476357072;
        Thu, 20 Sep 2018 13:45:57 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r23-v6sm4470355ljc.15.2018.09.20.13.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:45:56 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [[PATCH v3] 4/6] [media] ad5820: Add support for acpi autoload
Date:   Thu, 20 Sep 2018 22:45:38 +0200
Message-Id: <20180920204540.28832-4-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920204540.28832-1-ricardo.ribalda@gmail.com>
References: <20180920204540.28832-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow module autoloading of ad5820 ACPI devices.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/ad5820.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index e461d36201a4..5d1185e7f78d 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -22,6 +22,7 @@
  * General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
@@ -380,6 +381,15 @@ static const struct of_device_id ad5820_of_table[] = {
 MODULE_DEVICE_TABLE(of, ad5820_of_table);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id ad5820_acpi_ids[] = {
+	{ "AD5820" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, ad5820_acpi_ids);
+#endif
+
 static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
@@ -387,6 +397,7 @@ static struct i2c_driver ad5820_i2c_driver = {
 		.name	= AD5820_NAME,
 		.pm	= &ad5820_pm,
 		.of_match_table = of_match_ptr(ad5820_of_table),
+		.acpi_match_table = ACPI_PTR(ad5820_acpi_ids),
 	},
 	.probe		= ad5820_probe,
 	.remove		= ad5820_remove,
-- 
2.18.0

