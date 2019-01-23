Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFFEC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A021C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="C72ZZDX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfAWOPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:15:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38163 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfAWOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so2632721wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfMiR+XMEe6du7+Dt7wulgcs5Y8OkUZiz4lCQp0Fk4s=;
        b=C72ZZDX/yumd3Db34fRNtFwhBZftusVs8T+Y7mvp3OfzwiWFOpIiwGXMilYb9yjGf1
         YkWDOehnXohdtH136gSpzm6g9znyB7Xo+NLGdhJJAlmlkkOzic2Z5QeUf5L7/VPhd7Xq
         XhUsEp3BAIZJK5UqT6zDizb5UqaMqGgZWDbeOxgV6umxwCn/XucyyU2q2T45LfRRAYNI
         f3Y08Uv8rV/4XIIY183Gs8IvVJlabziuaU6W+a1HERppKk5v802f411llPJIsObjv/IL
         Ud00+C55fsHsUphahX0+2Sia5YEfty5NjAvfyVa3c+3K/D8UuCIIMWMWibt10khDzp3V
         M9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfMiR+XMEe6du7+Dt7wulgcs5Y8OkUZiz4lCQp0Fk4s=;
        b=DLjOUEtd8wDPqSxXMfiDB5xmGYArSJncvdiwAfr+JyHwoIc72gfaAetlmFQWTUuqdb
         N1m+gZiwsbGrzKZpTKpzHBF5MeEx9Zed7Nk9yo90z6ns2J7GkjX4AP6RhDKaF/Z8Vk1I
         fzt3p+SfMJAULPmj3Ire5fg3cW5EZ98MmllJheV3RvuamMZyvuaI2vY9cMTTKNswRHGI
         dpefWN6I1UjHokRl/r2xCcGxjFd9hznvlTZZy5vbKH8reJWBhqdSnrP0epmEaBQoWPT4
         VEXtGhvf37s1tx4EuEiqjRodaHK70YreULewARDO0HdneE7AbJ9EZuUdVihq17zcX0Nc
         o/SQ==
X-Gm-Message-State: AJcUukev20PhQNSct4O1czrxq4OfhRI7pmpNji3y49w/Kp0VLWeWT+FT
        iHgRLtoqUnmIpc9Z5G1TN/vy7dXcx/w=
X-Google-Smtp-Source: ALg8bN6ltRiaepdcB5KDEyCLj6np9kTmOqKvdGZIzleIxhmOj3TR9TQw6l1VksUMTx8ZyxwgA6UmPw==
X-Received: by 2002:adf:891a:: with SMTP id s26mr2965007wrs.44.1548252945638;
        Wed, 23 Jan 2019 06:15:45 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm29072997wme.23.2019.01.23.06.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:15:44 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/9] gpio: mockup: improve the user-space testing interface
Date:   Wed, 23 Jan 2019 15:15:29 +0100
Message-Id: <20190123141538.29408-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series aims at reworking the gpio-mockup debugfs interface. The
reason for that is the fact that certain known problems with this
testing module exist and the user-space tests are broken anyway
after commit fa38869b0161 ("gpiolib: Don't support irq sharing
for userspace") which made it impossible for gpio-mockup to ignore
certain events (e.g. only receive notifications about rising edge
events).

The first three patches improve the interrupt simulator. The first one
makes the struct irq_chip part of the irq_sim structure so that we can
support multiple instances at once. The second delegates the irq number
mapping to the irq domain subsystem. The third patch provides a helper
that will allow users to check the current configuration of a dummy
interrupt and decide whether it should be fired depending on external
logic.

Next six patches improve the gpio-mockup module. Patches 4-5 have been
reviewed before but missed the last merge window. Patch 6 is there
because we're already breaking the debugfs interface anyway and it
removes a link that has no users. Patches 7-8 are minor tweaks.

Last patch introduces a rework of the debugfs interface. With this
change each mockup chip is represented by a directory named after the
chip's device name under <debugfs mount point>/gpio-mockup/. Each line
is represented by a file using the line's offset as the name under the
chip's directory. Reading from the line's file yields the current
*value*, writing to the line's file changes the current "pull". Default
pull for mockup lines is down. More info on that can be found in the
comment added by this change to the gpio-mockup code.

This is somewhat inspired by the idea of the gpio-simulator by
Uwe Kleine-König except that I strongly belive that when testing
certain user API code paths we should not be using the same paths for
verification. That's why there's a separate interface (debugfs) sharing
as little as possible with the character device that allows to check if
various operations (reading and setting values, events) work as
expected instead of two connected dummy chips sharing the same
interface.

If accepted this will of course require major modification of user-space
tests in libgpiod once upstream.

Bartosz Golaszewski (9):
  irq/irq_sim: don't share the irq_chip structure between simulators
  irq/irq_sim: use irq domain
  irq/irq_sim: provide irq_sim_get_type()
  gpio: mockup: add locking
  gpio: mockup: implement get_multiple()
  gpio: mockup: don't create the debugfs link named after the label
  gpio: mockup: change the type of 'offset' to unsigned int
  gpio: mockup: change the signature of unlocked get/set helpers
  gpio: mockup: rework debugfs interface

 drivers/gpio/gpio-mockup.c | 186 +++++++++++++++++++++++++++++++------
 include/linux/irq_sim.h    |  10 +-
 kernel/irq/irq_sim.c       | 127 ++++++++++++++++++-------
 3 files changed, 262 insertions(+), 61 deletions(-)

-- 
2.19.1

