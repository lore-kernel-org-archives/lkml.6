Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A1C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D91920672
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZSkKzqC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D91920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeKUAJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:09:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51797 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKUAJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:09:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id w7-v6so2174300wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yx1WFBCVhmRGMcW/zuuIYQ5+sU7fBDj29lf17Ej0/WI=;
        b=ZSkKzqC1shRByu5rrH0UQQCOT1+PGccf/YJiz7jKg7dunQK/fFPQeO4eZ1oEl/Uj8X
         nZreYF4wZZ0Xe01otKV8Ad0qQS8EYcBiHjJq1+1lMeaZLtEtq35Tdv9bjrXATP/K0oWT
         hkNQAkqnVJnR74PQkF6nItOwhrxitpRDfs2ZlATov0/ApHGEiefX3ncooagrZssL0Tlw
         eCZMkzY0n/tR9sg7z1MXFMWgpiau7wnx5D6VxCfYB57icZ1lgTyvdtCAis1wS5aGTNDa
         ixpUC6iv7SGDevDF+zr40S7U+wGBUZ941pQR9xzEnKvvr1pNUn2MBYc/z9nk9rH2F0OR
         wqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yx1WFBCVhmRGMcW/zuuIYQ5+sU7fBDj29lf17Ej0/WI=;
        b=immzPQCDy3kzxfmW4RgTukudNw83hOI8cPqLMpZtukocNB6Ys2itGKGIBRge1BTmdw
         jDs6ywceFzVCrOFdyKl8oIWTVJbvd/8SSB92e4Lc0inNmoo8pU1jDVNfPginh2MAw3ab
         LdY9J6+DUV7sX0wNx/JJ4ZXfh0GAb1PzJSY/SLeOxk/UOfog8PmRMlC0zsNj5ofbvDBT
         6ZrLwnW+FlFIyTbwEGMhKxUQ/MQHe4n5z71j+UmaS92b7hlSaCdikz1Ax7iB1i3/wx/t
         iIzMMoAyYfnobW8jp3Ai8ZsN2PQjR9MqM2NHM/gR+D2jXaj6O3TPTbu+SOOGxjPVzTV6
         5/Lg==
X-Gm-Message-State: AGRZ1gJKBeGMScqlfm5vj7h07ssjzvFTBPX8pZj8yT/E7MNQHy6F9bEm
        fUDf4hUjUEl8Y0yCJFONkhGNQw==
X-Google-Smtp-Source: AFSGD/X7fiBUgdx/vb7teiV8yJqEq53I0CE9Uc1Feh/gnIeVhsGp6ejTva1qwLmhWPImMUc8G44etQ==
X-Received: by 2002:a1c:ccf:: with SMTP id 198-v6mr2377110wmm.6.1542721239813;
        Tue, 20 Nov 2018 05:40:39 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id j129-v6sm36962901wmb.47.2018.11.20.05.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:40:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] irq/irq_sim: provide a specialized variant of irq_sim_fire()
Date:   Tue, 20 Nov 2018 14:40:30 +0100
Message-Id: <20181120134032.31645-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupts simulator has a limitation in that a call to irq_sim_fire()
always fires the dummy interrupt - irrespective of the flags passed to the
irq request function.

This series addresses a problem with certain libgpiod tests failing when
using gpio-mockup with simulated interrupts since commit fa38869b0161
("gpiolib: Don't support irq sharing for userspace"). The tests are
failing because irq_sim fires interrupts for falling edge events even if
gpiolib requests a threaded irq triggered by rising edge only (and vice
versa).

We're introducing a new function: irq_sim_fire_edge() which takes
another argument allowing to specify the trigger type for the dummy
interrupt. We then use it in gpio-mockup.

Patch 1 applies on top of my previous irq_sim changeset[1]. Patch 2
applies on top of the recent changes to gpio-mockup[2].

Since test breakage in user-space after 4.20-rc1 can be considered
a regression, it would be great if this could go into 4.20.

[1] https://lkml.org/lkml/2018/11/9/1418
[2] https://lkml.org/lkml/2018/11/8/1012

Bartosz Golaszewski (2):
  irq/irq_sim: provide irq_sim_fire_edge()
  gpio: mockup: use irq_sim_fire_edge()

 drivers/gpio/gpio-mockup.c |  5 +++--
 include/linux/irq_sim.h    |  2 ++
 kernel/irq/irq_sim.c       | 30 ++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.19.1

