Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1040FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B308E208B2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiDN33Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B308E208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeHHDJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:09:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36510 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeHHDJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:09:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so450270wro.3;
        Tue, 07 Aug 2018 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ipXFWiuQOKW9pNEhKfzCG/qF3S1F5xufVYdd/kZPvWg=;
        b=DiDN33Mk/9NVfYs7dWGVGqHoIjthCLdDbt4yxbakzjv0sJJkmG2Q9VOo/0QdOvC75+
         3+APS/G7/hdWdFnS0Wduf9QEa/ZcXro8bn9JOrx1sLb7g+JLbUKdcY7PO6GxtTH9ABDv
         3RPL07rI7nT4e33Z3yn0Esbwmus6Z1mJUXwWh4C1YsVQnk8G9ItRBTaqvTbOVUiht6Hc
         jVJqVL+cXoxghn9E5fUz1fUwgwP/zF/5/VHDE8R+Gvox45xzxs1doybNMOSWrV/jcc4N
         tNi2CLO0HHHlZvXxq9CNgHItfa/pMI1twbtONmSwJlC0mApuv8vZIO48+zdxRufUAvGU
         VGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ipXFWiuQOKW9pNEhKfzCG/qF3S1F5xufVYdd/kZPvWg=;
        b=RGb7t88FFewec4xuYAFIXodf7v0w8Wovqa81xogiD7wnnpcjnkLcOU1N2oKT3PBCjH
         yDbmhy+TzSN6RCs1lhnesfmlz9eH+9AW6pVUIgh+HFEHrWM+PnGTzZj0SIDEWTADAiDj
         t+mwX269E+x1OJRJH8r4zl3C6BW8xWnohJsByGGZryG4bzMOuygr9sG+vS3V8ILeQpoM
         amhpC7Qii9QiYAb83umsTflAiLpn3LA8TW14wT486ZFqHXtwTyM/D01zEGgYr83cj2kI
         ylUx7hvwNIR0j93tq6lTjxM7jvIFmfL5hawv9uuBAOnC6aFynaoq69dPWquEM18WM/XL
         DZJw==
X-Gm-Message-State: AOUpUlHmMzrpLlmy1lAwJqWeJ62U2OdhCjf2pXnnpYjBx62OG82uHAbl
        ErjyQitHB+ArxgLD3WB7Iu97ktLA1yk=
X-Google-Smtp-Source: AA+uWPwXVpCGdklxTlKCh3xOYWbYs/lizZ8a0XMozvWc7YDNz4aiJg7Sdp5UlwlJAV19NXSRKKAwzg==
X-Received: by 2002:adf:b583:: with SMTP id c3-v6mr415587wre.79.1533689534067;
        Tue, 07 Aug 2018 17:52:14 -0700 (PDT)
Received: from terrence.localdomain (cpc96818-rdng27-2-0-cust102.15-3.cable.virginm.net. [86.30.200.103])
        by smtp.gmail.com with ESMTPSA id u7-v6sm4074038wmd.46.2018.08.07.17.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 17:52:13 -0700 (PDT)
From:   Tom Todd <thomas.m.a.todd@gmail.com>
To:     rjw@jwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Todd <thomas.m.a.todd@gmail.com>
Subject: [PATCH] acpi: bus: Fixed a pointer coding style issue
Date:   Wed,  8 Aug 2018 01:52:02 +0100
Message-Id: <20180808005202.4011-1-thomas.m.a.todd@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>
---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62018eb..73e43d81ec63 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -962,7 +962,7 @@ static int acpi_device_probe(struct device *dev)
 	return 0;
 }
 
-static int acpi_device_remove(struct device * dev)
+static int acpi_device_remove(struct device *dev)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_driver *acpi_drv = acpi_dev->driver;
-- 
2.18.0

