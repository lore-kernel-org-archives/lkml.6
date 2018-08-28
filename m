Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8E4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A42D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A42D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeH1Fq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:46:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46612 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeH1FoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:08 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so1684140oie.13;
        Mon, 27 Aug 2018 18:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xICQgXXNh+bEKVkznGau3uNnEHJJPk53QNNxMeb1nrE=;
        b=OjLaZ7aRcqr9zhF3p6ftwE3+ZMHiUGJ4DXOeWhqrm79rdAVoKi/UvWamGYtqNHUAHO
         G8gQrO1JBtnqoTcQ8CDCYw0mO5/bNS6/t+7mo1wt8yimRaoQ6ElwNBJ7jYiidReHT388
         aosHUA5KrsToHdrY5N2Kqvkm0lut/hnAfNeh0RNuABu3jzHcgVVc8lmAcr23uNYS2M4z
         uB1fhPhxEuNyxR2PrirckFC+9azNQaDtJQX0XY4BTI30jhLXA0wJMZYZ42ZwlQ+8FgKR
         1/ZhBVINCLTeQWNLbYj/UqVjENHeX7hzHNdyDb1HNQ0tgK4tKuLwez7G6LZkNy76D2tU
         xxSA==
X-Gm-Message-State: APzg51BO9C/RbQlq+5mDJxrNCDDukpqQQGUnXXv5oaHfL6O8PHAE+Ybz
        gnwwDuK/Ksc7jdh7XY54prueCqk=
X-Google-Smtp-Source: ANB0VdYFFjc4k7jH8D/1Fxk16z3qWPuleCEErB57yC16piQpwLTQzVXzEvv1vVHDQPicQgwyCC+1fA==
X-Received: by 2002:aca:e350:: with SMTP id a77-v6mr1132597oih.250.1535421291711;
        Mon, 27 Aug 2018 18:54:51 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:51 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: [PATCH] leds: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:26 -0500
Message-Id: <20180828015252.28511-25-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/leds/leds-as3645a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-as3645a.c b/drivers/leds/leds-as3645a.c
index f883616d9e60..98a69b1a43f9 100644
--- a/drivers/leds/leds-as3645a.c
+++ b/drivers/leds/leds-as3645a.c
@@ -529,7 +529,7 @@ static int as3645a_parse_node(struct as3645a *flash,
 		strlcpy(names->flash, name, sizeof(names->flash));
 	else
 		snprintf(names->flash, sizeof(names->flash),
-			 "%s:flash", node->name);
+			 "%pOFn:flash", node);
 
 	rval = of_property_read_u32(flash->flash_node, "flash-timeout-us",
 				    &cfg->flash_timeout_us);
@@ -573,7 +573,7 @@ static int as3645a_parse_node(struct as3645a *flash,
 		strlcpy(names->indicator, name, sizeof(names->indicator));
 	else
 		snprintf(names->indicator, sizeof(names->indicator),
-			 "%s:indicator", node->name);
+			 "%pOFn:indicator", node);
 
 	rval = of_property_read_u32(flash->indicator_node, "led-max-microamp",
 				    &cfg->indicator_max_ua);
-- 
2.17.1

