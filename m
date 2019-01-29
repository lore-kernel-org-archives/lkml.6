Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F67C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50FD214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DAxMWgGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfA2IoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:44:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35156 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfA2IoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:44:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so21066760wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqGNmy9KB5gLgteplp8cLO+81L5bqfpDnlHvZNRtc6U=;
        b=DAxMWgGoqh7e4ZLwfMBAsM7bnjdW2ROqq9rOCDdlvxXUK9ohTypfFfYKtp8llxfi2u
         HjWg1wb57zn35jBjplwuX64Dl8MJ2UDoDwkdxcxvePQDq4ufFjwcPOqV7L+8bC+x3GIv
         8MjbpkdzT04E6uSlZdyXwm2LznPYlMKpcy2fAUA35fMKqoubIfisB392N5gMJL24vmlH
         opDm+a7UFTTokQ/0ZAbHygT/SoiAo+VKltpQ9konMI5CFX6v5lTeUiciKgHmS6qEUonV
         V6yAvQczW5FqgQp7mS+Z+XRamSH5uJAsj2/2R7iNBYJZ+eMiaXOTKimw2+zvQk7hTVMy
         +TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqGNmy9KB5gLgteplp8cLO+81L5bqfpDnlHvZNRtc6U=;
        b=kTAoXpFgduMy48naIyu8h6gK7aOJCTcsJ8SNgbxM13iQpJHGzHJLXcXBejxu6bdT46
         Y+/qMCgONRhUBZT6d4rMmYuAuL/Zlvf2FKH3llROT0OuXfI92IsGSDZgPauO6/2w/oqJ
         foO+664wmohGyGbhcyxg7est2Y+OWLuovKWVYoLjDn5E5uBGEh5MmJPxt6c8gVg3+0dj
         SBt7/oisHOe/GJjVnor3BH54rSZWms32uy6bPa/4aH3oNfWdaSnvXc8Fk2rw2Tc92qTC
         coLd0N2N8c2MEJvNlclz5OelxLXEiQSBwPVyYW2wAiLsJ/V8UNuBEKOLVIe5l4gXgqCv
         eTTA==
X-Gm-Message-State: AJcUukeiJ7u4rqKvAcppq7UfvpYoxeJoIujNeIwNUjIEGCwtoOHnRpf4
        41Bl7h5Y2/SKvzDjpCZt8LGZOA==
X-Google-Smtp-Source: ALg8bN67thkQRjU4HzkNuNdSD62G+cMFG4uuugP4SRVgOyMzynjwvW7hVFM24BloEs2gH9J9UKiIGg==
X-Received: by 2002:adf:f691:: with SMTP id v17mr24060162wrp.114.1548751458361;
        Tue, 29 Jan 2019 00:44:18 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c1sm3979319wmb.14.2019.01.29.00.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:44:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/9] gpio: mockup: improve the user-space testing interface
Date:   Tue, 29 Jan 2019 09:44:02 +0100
Message-Id: <20190129084411.30495-1-brgl@bgdev.pl>
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
that will allow users to specify the type of the fired interrupt so that
the configuration set by the set_type() callback can be taken into account.

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

v1 -> v2:
- instead of providing the irq_sim_get_type() helper, move the irq type
  logic into the simulator and provide a helper that allows users to specify
  the type of the fired interrupt

Bartosz Golaszewski (9):
  irq/irq_sim: don't share the irq_chip structure between simulators
  irq/irq_sim: use irq domain
  irq/irq_sim: provide irq_sim_fire_type()
  gpio: mockup: add locking
  gpio: mockup: implement get_multiple()
  gpio: mockup: don't create the debugfs link named after the label
  gpio: mockup: change the type of 'offset' to unsigned int
  gpio: mockup: change the signature of unlocked get/set helpers
  gpio: mockup: rework debugfs interface

 drivers/gpio/gpio-mockup.c | 185 +++++++++++++++++++++++++++++++------
 include/linux/irq_sim.h    |  17 +++-
 kernel/irq/irq_sim.c       | 126 ++++++++++++++++++-------
 3 files changed, 263 insertions(+), 65 deletions(-)

-- 
2.19.1

