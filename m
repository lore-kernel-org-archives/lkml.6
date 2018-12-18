Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B165218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzIJ9lSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeLRUzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:55:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37457 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRUzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:55:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so4195323wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 12:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOi0WSQxEvc0Rs6AL8W3qRpEySU4z9T/xkS/tyIoq4E=;
        b=dzIJ9lSQKAzcFaRuPKc/KxO1XskoBFjWSsdmf6udXt8vC6qBzXVQvMi7mYYFOa/6WA
         1YYoHO9bQcHtUCDOG7+BgtM5mZG0K9G9DjhTWtZcMye3R5TANT9Yo/7SdLTj0c/KeQvp
         mFfDoi+mL8q7DZMtR0jnkN8pceftYqro1pUKOjCEgswX88SPbwwsqZAX6vy95nC/Ag16
         at/NWkueCUI8nEjJYXIIlKK+0udVYB9PgNooNta43/AOBHTX0iDqxY67R3cg9oMCY/rZ
         WysCWeqq+gkRMyXXuCwz+GTiZyTXhplKUDncKtOVN2/0O+O8D+Ol8px+PRFPbbuODh8F
         Hspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=tOi0WSQxEvc0Rs6AL8W3qRpEySU4z9T/xkS/tyIoq4E=;
        b=otP6gEgdKyk5ClJH6YoYkPh+UVrrnLwOGZgniy467xe16VcGudfZCtTFd2gvhN6NKk
         PdLx/stJfMttTtvUjvU6SmO/WVpt/0n4xvDwqCfbj4OOrshJsGOa2Bjrm87iIDZ+FA2A
         Lqu3BJ7o6+tqlgCAT9ZI2eUDfUHM/6xUhSERyf/SbNAa/0wqPrxt7Axh/ZrwBMvUL8dz
         ZY9nUHPqMylwdr3d69TCU1SefqviZmGuGxioXLXAtUlWWd/TI6WR26+QfO1A510/Of1B
         kMwdaFsRoNuwI+cy9E4q7D54TH8mGEeWNqz0xWsSyWiYZme8TZ9y4iGh7kHkz8OT8o6r
         st4g==
X-Gm-Message-State: AA+aEWbw4ZpTZCtZ1fIfXfo4IygvITHS8kq6cTFMcsUw/GZh/tEfZr8h
        PWgzWZzH6ebsQd7RB7M7xU28ZzUU
X-Google-Smtp-Source: AFSGD/XsEYvnEZVRcYrcw2ooP69qvHF9+UsQHUmhr8GHTf8HOvjUL68D/8/C48BC3Fxx0I++wcXA2Q==
X-Received: by 2002:a1c:709:: with SMTP id 9mr4593373wmh.39.1545166545485;
        Tue, 18 Dec 2018 12:55:45 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id h13sm5572416wrp.61.2018.12.18.12.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 12:55:44 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 2CE59114106E; Tue, 18 Dec 2018 21:55:43 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: Use __printf markup to silence compiler
Date:   Tue, 18 Dec 2018 21:55:41 +0100
Message-Id: <20181218205541.26783-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence warnings (triggered at W=1) by adding relevant __printf attributes.

  drivers/clk/clkdev.c:267:3: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  drivers/clk/clkdev.c:280:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  drivers/clk/clkdev.c:398:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/clk/clkdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..2fb03595dc26 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -247,7 +247,7 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
-static struct clk_lookup * __ref
+__printf(3, 0) static struct clk_lookup * __ref
 vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
 {
@@ -271,7 +271,7 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	return &cla->cl;
 }
 
-static struct clk_lookup *
+__printf(3, 0) static struct clk_lookup *
 vclkdev_create(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
 {
@@ -387,6 +387,7 @@ void clkdev_drop(struct clk_lookup *cl)
 }
 EXPORT_SYMBOL(clkdev_drop);
 
+__printf(3, 4)
 static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
 						const char *con_id,
 						const char *dev_id, ...)
-- 
2.19.2

