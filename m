Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C14C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A5E2083C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFW929sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A5E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeHaCkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33579 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaCkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id m26-v6so8481692lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LkeLH5ys4Ym/Z4rYm7fEGLM3aBXNN1OdVpZ9tCI/YNw=;
        b=bFW929srddgkayxiNPmpKVwxQ3UQbXn6hTztET8zSE0Wh9fbI2dh+F6JhVqkNmZ2i8
         bYuw+refc+8Fv2/YwUl/uB5WQUfZrXcrxXggL7o8tU+hJU6mZBlNop7mdtayatFJWzK3
         i+vOLZByAig4DjnfRf0Y2A4AFQxM8RB4+uNsM+FAbBzPQOWlhkDmSb30Spgh6K6NBh0S
         5vAukvmtwypLixw52BpM3jKi+ZJ0lynb+M+UtNuVYKp+3HlONZaSm/zlaElGHck6JkK9
         e7PjvWaVpQq8D+fln8EKhx0WherkbALj31345b6W4onqsGilJ2uL/DqV/m8b3zJxZea7
         ov4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LkeLH5ys4Ym/Z4rYm7fEGLM3aBXNN1OdVpZ9tCI/YNw=;
        b=qf+3U58qAAfERtBYqcgLJEMIVVwPEHkkGMkRr2K4ejVmwtYanmNlLaNoftae/UYKgW
         PPNeJTmiztqwA+rgqjxaxGs1yzn8GtzCXmgbbjTs5fJdXAEy/XoZ3pgY8B8DP9nbUYz6
         rBtY0+Wv1/UuKxON2gvNBbCibEpEKGFd4zys+F6kqa1TYW6wNdS0kdSQJWtWSDVO4D1r
         zQj+NTuZlqZLV/r6Eg8MLUSYqogvmWtEgKZcqhgc3Aq+VPSpqBX3RdofwSw1jO1HYSao
         43wDR7iD3vXvHnV44+8sK1LlMwmZFtmmw0ftaL3DmvHb4wH6dOzHq6rcbejBtIqBbHY/
         QFFA==
X-Gm-Message-State: APzg51ANHG7dcs9cwa+pieaY29X5DVWPmNcpg6wm7uZQ+4qimf/AukBt
        F5vMCGJqOsbyYDVBZZw848+knmPrrnI=
X-Google-Smtp-Source: ANB0VdbrCIflsn54OQLuaU/YW0bcoyHX3BiKPpAMF0bErwyqdKQD5tCgChC+n5aHqjLDqP4cfGabug==
X-Received: by 2002:a19:4a09:: with SMTP id x9-v6mr8973403lfa.80.1535668550695;
        Thu, 30 Aug 2018 15:35:50 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:50 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 19/23] pinctrl: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:25 +0300
Message-Id: <20180830223429.30051-20-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index aefe3c33dffd..eb87ab774269 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -715,7 +715,7 @@ int aspeed_pin_config_set(struct pinctrl_dev *pctldev, unsigned int offset,
 
 		pmap = find_pinconf_map(param, MAP_TYPE_ARG, arg);
 
-		if (unlikely(WARN_ON(!pmap)))
+		if (WARN_ON(!pmap))
 			return -EINVAL;
 
 		val = pmap->val << pconf->bit;
-- 
2.17.1

