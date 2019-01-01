Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513392171F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CDxzRYci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfAATo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 14:44:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45519 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfAATo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 14:44:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so28711234wrr.12;
        Tue, 01 Jan 2019 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxBcdG/5USi5uOX1JOBscFWeU4VCyKnT01z3qsVhmyU=;
        b=CDxzRYcixveTYzrL15GGn2NTMljy1t3k5xe9/qKivkx6lk44Svs51tEPGOt5NM1kpG
         bpVsKxaVmuvzUQMZGctO/7dN51yRWTpEtQ1VZCRB0FSsUo75JwBvyQKnl5LHHfX6WVU1
         D7KjWxymjFniLF8ZUsSjzRoPQyS5CP8jV96auS25/frgnPblpvFzPQQ89m1e/klAougy
         1QQaQzRUWtXo3rAJUKmd3aF/QyMG9R/q1MqhUUFfCLfO7YsSDKbDyJbl+Finpe7fdK9g
         xJdmGFiy1dJi4C+AlE74LXn1XI2qsrymDCnJHoA9zSwBdPmtRpsrT6m/TW5lwkD8hSKx
         cyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxBcdG/5USi5uOX1JOBscFWeU4VCyKnT01z3qsVhmyU=;
        b=k9AQi+MIIPn7zFks9f2E7+uDsCJ8MQ4Dh5LT4beGDeJtgN3omPoYx9E2iEFZ0F2sXW
         B2F6pG4HXCdOQH6nlVKZRLFMSpqeCQTm4cm5M44f7eajicUDRzR6hPhb/IF3ZR0pFCe9
         xEGQHCHQWOqovs7pUQD4PuqnOzY6tzPilRX95L5PW8dZywiGiijdh6Hhzjr+mZ3rwS6k
         PgVUesSQU7c+lwrho7/HU5+BImrXMSmodAbQ+jYwoD/tW5mEfW/QG++uau7B6E616quu
         WyU6Q8RS6FAY/urI/PS+twSL63UwAapPkxxp4yMqCASgntd9hLSWQUR6KoG+RLy9DX8q
         yqSA==
X-Gm-Message-State: AJcUukdeRhszMODTwo+zAo9TZXx7vYcMoIxyku93rScaDYEW0Jx+NkAF
        2MIC3bt13Y8e/sRHEZBV830=
X-Google-Smtp-Source: ALg8bN64DDnzn5DH8rCQwHU58l1J01Pbr8s7gRhnO4bA4xq4Hs0XKrGiIV6JSxBZjVhet4pDMGBuuQ==
X-Received: by 2002:adf:c452:: with SMTP id a18mr37011121wrg.145.1546371867022;
        Tue, 01 Jan 2019 11:44:27 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD719940081266F57D36520DF.dip0.t-ipconnect.de. [2003:dc:d719:9400:8126:6f57:d365:20df])
        by smtp.googlemail.com with ESMTPSA id l8sm41505654wrr.60.2019.01.01.11.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 11:44:26 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     linux@roeck-us.net, bgolaszewski@baylibre.com,
        ulf.hansson@linaro.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] mmc: fix boards with CD GPIO and "cd-inverted"
Date:   Tue,  1 Jan 2019 20:44:13 +0100
Message-Id: <20190101194414.24766-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I explained in my original mail [0] I observed that some of my boards
were not detecting their SD card anymore:
- Meson8b Odroid-C1: the one one Kernel CI and another one on my desk
- Meson8b EC-100: on my desk
- Meson GXBB Odroid-C2: on Kernel CI

git bisect pointed to the following commit:
89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")

The one-line change from this series is supposed to fix this issue for
v4.21 (mainline git master).
As explained in the patch description the MMC core code which manages
the GPIO inversion can be cleaned up once no driver depends on it
anymore (it seems that only one driver is left, but I don't have
hardware for it so I can't test it). More details can also be found
in my discussion with Linus on this topic: [1]


[0] https://marc.info/?l=linux-gpio&m=154609359306731&w=3
[1] https://marc.info/?l=linux-mmc&m=154626524506451&w=3


Martin Blumenstingl (1):
  mmc: core: don't override the CD GPIO level when "cd-inverted" is set

 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.20.1

