Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65946217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="s7D0nn2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfBRJsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:48:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43001 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfBRJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:48:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so4198120wrg.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 01:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGqYI1tFUvXzb6Qt6BCRzM/Y80lHTx6YZMCEPujBRZw=;
        b=s7D0nn2TPxnA7MuvAo84ZoeykWgf+hGbtKqtXYdQowdMf4K/X4yrbUk6Pm92tlKVxb
         FvQ4uPpKTOe+yDSL8uecpzCe4BlQ1wHrhqETfEK3MYqzLGHRo9/+7eXCKvda6ozDprtQ
         QT5g8Y103CVA3UYhKdqPsU8o25djxrY8DMaeyUSwOdH+e6wF2OQn2XVDCCbU9mw6IlDO
         k2iwuGAgFmk7vY6n1FaWs2ER8wneJb5kt9lK+ol1DuPKrNyAdVHGamnhWCgDNpwiNDc2
         hfimsovDBJm0GgtzcuWqBQvMmsEJ1AaokcT+9T6c365UNgy/yht2yw6bcr39cZ5JPk/1
         ydVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGqYI1tFUvXzb6Qt6BCRzM/Y80lHTx6YZMCEPujBRZw=;
        b=XC//D5chFSoNDYdqW6ffABDtS9R0uH0XC/gdDFGj0f40ESZHhDjhhNwcNsM323iXms
         ozlxYhq9tiv1Cg3PB97rFL4nroKPfDH/ZhRejQwOyCs4SHwrSDFI6hmLReaGMFZFYgeu
         5eIwQ+ESJxY9sTLykhTPrNcaAMpS2xVwoJflDsRCbT0IJ/ebKir9RvdUJWkd0/TSFYll
         GYuPrPZiVWDUc7UQ7U0Kx3wBPoS25ZCcSJBWu1huDhUpe1YWXQASbRlJT3pO3YTqqYxr
         FDn/VHiVWZpsLy1wdxFWjSLqMAM/rtZaaQYPwLTUwzkd5NfQxi3Kw1IjhsrNVNjUBTsQ
         rRMw==
X-Gm-Message-State: AHQUAuaYIgq8AaSuUJkpbcl+mG06VE55XA7/tsLGXv72HDpjjViY2LQL
        AEaueGRqFv0YgZ29Q3HhxydoWw==
X-Google-Smtp-Source: AHgI3IYlU3MR0x1gOughxtZRKN92dZRiuEeVNvD7bwrjLqwFubavwpJW031aJiYw4Pu3AZ4zjXLRXw==
X-Received: by 2002:a5d:6810:: with SMTP id w16mr15936783wru.62.1550483287735;
        Mon, 18 Feb 2019 01:48:07 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id u15sm17582974wmu.17.2019.02.18.01.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 01:48:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/6] gpio: mockup: rework the testing driver - alternative version
Date:   Mon, 18 Feb 2019 10:47:53 +0100
Message-Id: <20190218094759.14545-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's very late in the release cycle and we cannot seem to get the irq
subsystem maintainers' ack on the proposed change in the interrupt
simulator. This series contains only the gpio-mockup patches from the
previous submission in order to at least partially track the line's
state and add a way to verify the results of uAPI calls. The interrupts
are fired regardless of their type configuration. This will be fixed
once irq_sim supports it.

Bartosz Golaszewski (6):
  gpio: mockup: add locking
  gpio: mockup: implement get_multiple()
  gpio: mockup: don't create the debugfs link named after the label
  gpio: mockup: change the type of 'offset' to unsigned int
  gpio: mockup: change the signature of unlocked get/set helpers
  gpio: mockup: rework debugfs interface

 drivers/gpio/gpio-mockup.c | 188 +++++++++++++++++++++++++++++++------
 1 file changed, 161 insertions(+), 27 deletions(-)

-- 
2.20.1

