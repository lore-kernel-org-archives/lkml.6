Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301D3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA0C20672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDWS1Utf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA0C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeLLQfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:35:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44941 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeLLQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:35:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so8829184pls.11;
        Wed, 12 Dec 2018 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=92Bb501r+++YwJ9OpG4I87NXN2iJc7TJbeMDIsThrgU=;
        b=eDWS1UtfTfNrZhjRsiqkX5xlxnj+rZfEoff+YYb77dMonDq8mqJOKWzMq5lExzSYTp
         VH+xLLiL+oeJmmtgWegFfF36TpLlHLdOBD2vgk9/QyfZh5Ao+AgnYSFmr46SdynFySje
         DBM8Ftu1yaV6DgNWOxLYOTWaGRsjqLJSGOssBKvfVo4Ql0ybasPRfXAoB/sEe5mAAC8p
         po7Etd+K0zQfFFCevfLSJbTodderks4c/oU2YTpMxefk2bP7gXvvS7WIyi8FhrtK/eom
         ZDPuMvLbxrL6vjaXv+pkmbPuhdDv1l1Xo7Q6ts4uInrI2vEJaU8BoiNSJJGOqv41nfdt
         f9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=92Bb501r+++YwJ9OpG4I87NXN2iJc7TJbeMDIsThrgU=;
        b=kk7OWzKLBFpf7+ajHXbRmfjT7KNpsTMFABnmpbdvv5bTSfTnsVNoXELZPUZ9qy6ED1
         yEl0FhCbap82zZeJR7XrdAZKu2Zku26P8E8hTsdOZZSUH9YiEWXb4Dz3VyxMxyZFOIqy
         VFtAtkd3K36hg69lF3w2NWUq6V28lLFGUPagJYKeGFT8o0erqdWqGU4H32KPOlCVhCxu
         E7vQ1ogxdrf41OfJ0EoFTrprL0vov9v4s0cYM/pxg5m+xLnOXXA6YTRBe+hYc+Rwfr/s
         F3KNtTLk5DQHPkgge06RgQmX1hCZihh84xGf8wpsb89dHmQpAzZ8FqXjCosHoB8MDkWZ
         Fp8w==
X-Gm-Message-State: AA+aEWYU3Z6TMXQkKJhMJZEJqV2CYTonahnVgjTHOaDYXHl1WdMhK8xt
        by4dCjggkV8384c1RiULf9YnMi0fhGc=
X-Google-Smtp-Source: AFSGD/UWaVce9ih12stI+4ct5+omo2bZUDSoztvQ3dZaHUVTx9eR0aZQeteqCogogyMvIrEil9oYuA==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr20849404plt.106.1544632552122;
        Wed, 12 Dec 2018 08:35:52 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d25sm28156119pfe.40.2018.12.12.08.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 08:35:51 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4] Input: i8042 add i8042_is_mr_coffee() helper to avoid refconut leak
Date:   Wed, 12 Dec 2018 11:35:48 -0500
Message-Id: <20181212163548.23723-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node returned by
it and that reference needs to be dropped by its caller. Add
i8042_is_mr_coffee() helper to avoid refconut leak.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
changes in v4:
-fix typo

changes in v3:
-add i8042_is_mr_coffee
---
 drivers/input/serio/i8042-sparcio.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 796289846204..28aa154d9c81 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -106,11 +106,23 @@ static struct platform_driver sparc_i8042_driver = {
 	.remove		= sparc_i8042_remove,
 };
 
+static inline bool i8042_is_mr_coffee(void)
+{
+	struct device_node *root;
+	bool is_mr_coffee;
+
+	root = of_find_node_by_path("/");
+	is_mr_coffree = !strcmp(root->name, "SUNW,JavaStation-1");
+	of_node_put(root);
+
+	return is_mr_coffee;
+}
+
 static int __init i8042_platform_init(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	bool match = i8042_is_mr_coffee();
 
-	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
+	if (match) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
@@ -138,9 +150,9 @@ static int __init i8042_platform_init(void)
 
 static inline void i8042_platform_exit(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	bool match = i8042_is_mr_coffee();
 
-	if (strcmp(root->name, "SUNW,JavaStation-1"))
+	if (!match)
 		platform_driver_unregister(&sparc_i8042_driver);
 }
 
-- 
2.17.0

