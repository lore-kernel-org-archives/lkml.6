Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D39ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C036208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnzmqoch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C036208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeGNGQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37178 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeGNGQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id e9-v6so370545pgs.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TIEj4TMZZFkA2jJsLDMwFa007UJ1WVyLXsEGERF2z7E=;
        b=cnzmqoche/wZC+/i3FLeR8F5beC8FPai/41uJm7FRUS9QHeEMo0Y7BbU6CUVbHvO60
         6Djnv6ngy9u9J9cvu7W4FAwcyTck26MkfAqxOgQK/hMwZfqnxpYGhQiKOY+62asjs+3N
         C0mGbS7S5wvX1jyCWhqZTmZoqE1oiAi3GrxFuzSCQc/3MLmrbK2ih0RJ6ClgVSBKk3iD
         e9bXVJG650M8KoR1kqlnVvUCz6zFeLEWfF772sAI5uzGSo+D5m+p34JsW+nn4nFXlEd5
         92hD/pFgMOBrTHMyj7Jh25/Zs5wFGoCtwuu1p1LJ5C15jlnQdNFfvBYAFNNvuFMVtyng
         vXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TIEj4TMZZFkA2jJsLDMwFa007UJ1WVyLXsEGERF2z7E=;
        b=qd/u7YJ/D0n9EWbF2KRHWyq27uwJkmdkAHoY/jcOOmFyjXGhLH/N2cU76dlFdvSMNy
         DVHTTxc5N33Fwhqk1mcYKrmAkUPk6+vuV2rdKNT1JSJIK0NtyxO3U8ppGFQKcilAZndd
         llbidP3wR2poR4lB3WVYlOz0AKnBPWTxXiHgQnmjhi0ofW6FLz+NzzPFI445MmdPBPtl
         GdYFoFXcVZBnA7iLUGMOX4sGi6+DMOJ3leGLI2wm/5cttg1raJxscRKkwjgYA3/ZNqpi
         3I62lJA02wNDmS6ItlKQvrhz+Z/YV/PqADTgCi9ORvEx434AshiMLuNk2yHyWLMX9JGH
         NbIw==
X-Gm-Message-State: AOUpUlEYAOhBF0TJ3GDhYjfjLoUCX6wM5KPw+B+XiTE2Spq6dpv/EDDw
        MYQUyTKgv/CZrUaegDvVy9E=
X-Google-Smtp-Source: AAOMgpdHHUYISO6B6e0n6/Wc//4MSpnbno8vHrsiJSOwKxMk4dy1DbvnV8CnuxuGqdPMlG10vkEN9g==
X-Received: by 2002:a63:df04:: with SMTP id u4-v6mr8515200pgg.434.1531547925689;
        Fri, 13 Jul 2018 22:58:45 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:45 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Todd Poynor <toddpoynor@gmail.com>
Subject: [PATCH 01/18] staging: gasket: remove X86 Kconfig restriction
Date:   Fri, 13 Jul 2018 22:57:59 -0700
Message-Id: <20180714055816.223754-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The gasket and apex drivers are to be used on other architectures
besides X86.

Signed-off-by: Todd Poynor <toddpoynor@gmail.com>
---
 drivers/staging/gasket/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/Kconfig b/drivers/staging/gasket/Kconfig
index c836389c1402..ef40c4c75e0f 100644
--- a/drivers/staging/gasket/Kconfig
+++ b/drivers/staging/gasket/Kconfig
@@ -2,7 +2,7 @@ menu "Gasket devices"
 
 config STAGING_GASKET_FRAMEWORK
 	tristate "Gasket framework"
-	depends on PCI && X86_64
+	depends on PCI
 	help
 	  This framework supports Gasket-compatible devices, such as Apex.
 	  It is required for any of the following module(s).
-- 
2.18.0.203.gfac676dfb9-goog

