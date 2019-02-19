Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19048C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1162147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sBwQjTHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfBSQG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:06:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46729 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfBSQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:06:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so14356141wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7s4eDmqcVrJit+LRNz/3DTAZJVvDNlWByMSZ7/sgKQ0=;
        b=sBwQjTHTUad96tqXQ19VixTG8equAaSgvO9R99ygJbZT+h74UDZ5wjzsQURo3tJ+qM
         2LFUexxGD3rjFyS6fbtpmtTsWPAm09UcFHsUnAPHqsDwKMkPcQL7ppNdt3S/NQtxX7BE
         ZRYtmBVYUe9lQ6ppBtkwUAEgFnNyq/pxYNpjVR9oyctuOHjNHbFmXezjqnHp4WYr68pY
         p8+KRjd6+mEcxHn5w7aCKxVqs+PCsvyHZFRz2i3kluGDgN7T1X4O0ep8tbfiNyW1874q
         aDr4mS9d5oT7vcvHOk9RrUQnDdGZ/9zL0lMSvFTuW2hTUtT451NUlaBSsv86Trcmd1ss
         f3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7s4eDmqcVrJit+LRNz/3DTAZJVvDNlWByMSZ7/sgKQ0=;
        b=g/INbCV+kDTnwdwFYOCR0kbLjD8opCR+Ig0RCvSNPxn25rMHSIQhXfUpKKX/Fie9s+
         2MAuXE+pzqqscwEpjgA5tXbgZF4zOWX2fqjEVmw4StvSc+k6xnjcV1pa6S0ck3ckJ5+F
         OHb3x5lENcB8WSAXLROsyZJjcf3cv90j5PoqrJLF+hhR5qSFcWKvMXqH3quYmKCzWvCo
         HbRB8sSmptJ5lEv5MUZm/R+ODglNm60pKqYky9PTxVFIQAv2R4h5a/vqYB4rfEgcGQ4L
         HVK8PgerX1y1zQfIEcdbfzkGrzfhTzaGQA6SHVjiN96A8mrqqz4A8o4DnzBGygQsD8jn
         YLiQ==
X-Gm-Message-State: AHQUAua+Lyje0gDggqzsXgtWp8Qh3T/pJimXOlKY8ng8EAabIvR4osBt
        48Vmrp9w37TyoxvMKGPxw+prZg==
X-Google-Smtp-Source: AHgI3Ibu006gCFFU8Jrjp0vF5YcczrijRkjyZex9+wQbWHRu8l3vLw6K1KLC7tDkSI9Yak26bslVyw==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr21210682wrp.180.1550592415724;
        Tue, 19 Feb 2019 08:06:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h17sm12161381wrq.17.2019.02.19.08.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:06:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 0/7] gpio: mockup: improve the user-space testing interface
Date:   Tue, 19 Feb 2019 17:06:43 +0100
Message-Id: <20190219160650.9614-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Marc,

as discussed. This is hopefully the last version. The irq_set_type()
callback now only accepts edge triggers.

v1 -> v2:
- instead of providing the irq_sim_get_type() helper, move the irq type
  logic into the simulator and provide a helper that allows users to specify
  the type of the fired interrupt

v2 -> v3:
- switch back to having irq_sim_type() and put the line state logic into the
  GPIO testing module

v3 -> v4:
- drop irq_sim_get_type() and use a notifier chain instead so that any change
  in type configuration can be pushed out to interested users
- change the locking mechanism in gpio-mockup to a spinlock as we can't take
  a mutex when a hardirq-safe spinlock in irq_desc is being held when the
  irq_set_type() callback is called
- refuse to set any other type than falling or rising edge in irq_set_config

v4 -> v5:
- drop the notifier, use irqd_set_trigger_type() instead

v5 -> v6:
- same as v5, but we're now validating the trigger type and only allow
  edge triggers

Bartosz Golaszewski (7):
  irq/irq_sim: add irq_set_type() callback
  gpio: mockup: add locking
  gpio: mockup: implement get_multiple()
  gpio: mockup: don't create the debugfs link named after the label
  gpio: mockup: change the type of 'offset' to unsigned int
  gpio: mockup: change the signature of unlocked get/set helpers
  gpio: mockup: rework debugfs interface

 drivers/gpio/gpio-mockup.c | 189 +++++++++++++++++++++++++++++++------
 kernel/irq/irq_sim.c       |  12 +++
 2 files changed, 174 insertions(+), 27 deletions(-)

-- 
2.20.1

