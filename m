Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEA320856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmvw2+Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEA320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeIBVxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 17:53:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34115 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeIBVxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 17:53:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so13631529ljk.1;
        Sun, 02 Sep 2018 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AQs9iA8kJ7oLjyevSTBzW3O1Et4jejjaNADnrlZa8RQ=;
        b=Nmvw2+Y+YorC0xoY6oqE21xKROEMIjHnjb7xwZ8Z0JiSXfWa5vloeLgsVJN1Uhhw6K
         sjBwpMZrypWtpBlA8lF3IrGyVsSCXV+/DqtvXLzS7wUBCtB5i5Dr8Et41LVioN+eF26Z
         qSuJLJ5Vh+kQOSGDaU6WYVsnu7/aaAAqpuuBaLoJjXjgRTGgG5J2NKugQ/aak4a3asmN
         HEQzsdCbtXD6QzhWpTnRIlKqgi2IaDirxliRTBxAZAvBjjAjPwcEaWEmBTKMEpAIgqu/
         KSwdZzxDXAq5qJgUD7a2ZI6uqX7lydNEPkm9kNc+MoHS4MEFhqUAPAxt3VjB5eyM9sg5
         4ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AQs9iA8kJ7oLjyevSTBzW3O1Et4jejjaNADnrlZa8RQ=;
        b=S8qrET/gV0ZpVaOOgP4Nwlfgr9FOy34Ir5JfVghGSdsgyQoXWheDPlL7duH8jGIAvX
         eE05NoKHKYVrURCPDXRxM84B6Rxg1eUo1dqK+qCMBKEA3e3XrgMm5ohz8Tbm68NtDCWG
         89WxRKRjBO06jwUtC1N58sbhHnaCn09E4uDIZ/K/7oQvPstn9H53FYYr+zuGdGvENQlR
         87HT9uozlMEQ3Bj/pr1VRY6dUQb1YTMDROSj/EJUUBbKNCzxbRdsWQadTZm0EuotT0n6
         dcz5d0KKY9zXuQLIqfMXOXzzgC9Jr1sUZQJ7Y+pfmngbUbQuFF8fdJWkHUsgghGTy03v
         y/CA==
X-Gm-Message-State: APzg51BaGrwRw8KxR34DKN2egJluJOR5hLg36eoLvk4AQZcKBCDZ8ntu
        XxGaJ5WYNlsDBiWOc8Zekpg=
X-Google-Smtp-Source: ANB0VdY5JD3c/p37vr9Wg+qI5LOKG50KblMHb98NGn6H/5eLazekx6eXoawDqWqW73fCCBiVXWI+XQ==
X-Received: by 2002:a2e:144c:: with SMTP id 12-v6mr16274267lju.122.1535909824310;
        Sun, 02 Sep 2018 10:37:04 -0700 (PDT)
Received: from localhost.localdomain (213-238-244-10.customers.ownit.se. [213.238.244.10])
        by smtp.gmail.com with ESMTPSA id y85-v6sm3097619lfi.46.2018.09.02.10.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 10:37:02 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] usb: chipidea: imx: make MODULE_LICENCE and SPDX-identifier match
Date:   Sun,  2 Sep 2018 19:36:50 +0200
Message-Id: <20180902173650.5514-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX-License-Identifier is set to GPL-2.0+, which correspond to
MODULE_LICENSE "GPL".

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
 drivers/usb/chipidea/usbmisc_imx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 19f5f5f2a48a..555d398fbfa7 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -492,7 +492,7 @@ static struct platform_driver ci_hdrc_imx_driver = {
 module_platform_driver(ci_hdrc_imx_driver);
 
 MODULE_ALIAS("platform:imx-usb");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("CI HDRC i.MX USB binding");
 MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
 MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 34ad5bf8acd8..d9cfa00b8a6c 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -633,6 +633,6 @@ static struct platform_driver usbmisc_imx_driver = {
 module_platform_driver(usbmisc_imx_driver);
 
 MODULE_ALIAS("platform:usbmisc-imx");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("driver for imx usb non-core registers");
 MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
-- 
2.18.0

