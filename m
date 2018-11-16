Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4617C2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZSSLfb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4617C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbeKPVBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:01:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41465 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKPVBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:01:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so10449813pgh.8;
        Fri, 16 Nov 2018 02:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SAndWDTI8NKHmuGGAoudOgM0fvBXdQrJSFHhCSQaTik=;
        b=nZSSLfb2MxSl6ADlFwVj5FlSCu4FjuJ+zPyDqOEx1iSmHPUG6SRxkWhvsh5Xbo07mw
         ADixAY33KFMxEfUazDG2qnjgah8fGogAGp5cIscimAZnf6Emnq5ygC+JcoAyEr8i8wJW
         cQ/9NVmd0u3kFJf9gv76RUJg1+XGWN+jz+5Gwot2/i9omHprlm3guK2FXLhURFE8oG2Q
         YcssRvyBJvNLt8hFwufV4Zxe0vPKJYCJ3ocS8ONJ8s4RXfrntIIiaf/TwqiJQ/6Mq+ta
         DsxoPk0l3W5Wg19Fqv88wgm7naHEZhUDFv0TAc0BW71cKkY5bMsVSoPM6gGa2wDIeogk
         Lt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SAndWDTI8NKHmuGGAoudOgM0fvBXdQrJSFHhCSQaTik=;
        b=f8yohBYHPD+C/iLuFBezX8ssgsLIyCIT7aUpbUi6MReI3anOcidO8s9CalYgBYIX/j
         HxnrvJk73TVjv8MNAzZIy3myY95jMHTqvjzYUNYMpBQgWMGJz6JrZdGRvlxe76SrdQXg
         cwaIOpaWmXk5CMp1v4XTGfwFwPpTVgSOD3mpU86neFwpW8+1JTHDFkDROQ9TLOJqLvus
         UON02B1ZLUnNoBIXVt0lUcvLIQYUvXNF4tkEBG3tY7b9nn+swnsE2ujVwzVTcuTPUcEy
         BzqM+j9HoYmSGXpYWWYTLrOQk/7cs/yTvJfCyr0afqMH0m8CkheytflEl+KY7Orpq5Z+
         HsxA==
X-Gm-Message-State: AGRZ1gIPjPuED8teH4f6ifjgoSJjSFki73RHuGCXQff9R8agDehXH/TK
        8kB5yTPN5GDNYV+PLdwScoY=
X-Google-Smtp-Source: AJdET5eYBZu2RJ0mZ0Wvx4u6WFSB0ovTZopCcjdP9PC6W8c1FR/QzPXqiFDmS+0BKqraD3FD9RpjwQ==
X-Received: by 2002:a62:b802:: with SMTP id p2-v6mr10428755pfe.1.1542365353672;
        Fri, 16 Nov 2018 02:49:13 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.99])
        by smtp.gmail.com with ESMTPSA id v84-v6sm40715931pfd.182.2018.11.16.02.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 02:49:13 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:19:10 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     linus.walleij@linaro.org
Cc:     jrdr.linux@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] drivers/gpio/gpio-grgpio.c: Remove duplicate header
Message-ID: <20181116104910.GA10265@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/gpio/driver.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpio/gpio-grgpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 60a1556c570a..45b8d6a02b87 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -30,7 +30,6 @@
 #include <linux/gpio/driver.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-- 
2.17.1

