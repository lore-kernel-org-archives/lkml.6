Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7250C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D18214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Mvv7Gztu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389836AbfBRQlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:41:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53729 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733253AbfBRQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:41:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so18089350wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67spD6XAyVso08RyDm9g/Aby9TDa5GOGUS0SopZDEuY=;
        b=Mvv7GztuSOZBiaR/Btm6mFtsfJ7G5KE5SooL+0wCDsxc9FiqaedNEFPASyiNe07f5q
         qREtMOPSasAhBp9nC2yjfAO85WJU8WOJQ2EICBJO8HV1npBXvrv9fk4aUdVxJfcJbDz+
         5ImKHJBnufSNpvS6OUYiR8amIJhIHknSfdyLc9Elz+Z8Uuew5DKfNytRLF0XlPbAroBw
         WC9cp3BunSGYGpYwj51KAhrW6f93P6LmS5HGQz2dsfmhgn/i5LaCUtO/4ou5fPAZgaaJ
         5AJmSCJEtwIymNX3tRp6GCDnM5NmsDv4ymYPkp2wWTM5faqXUwZzxCb9wrYsE86j52cv
         g0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67spD6XAyVso08RyDm9g/Aby9TDa5GOGUS0SopZDEuY=;
        b=OnUPduipUEKDjYX4QsfDk86k8ASYESVWIZAyTinmyYH9Qrwsvg0tpOg2CWxxqZ/vi8
         VEGGPq7by6s1+VajT05BH/QBitB6LDUjww/QnuFFfUn+ahpL3OvC+TNtsUd1urKEOiYU
         5K4kH9PdEhH2prNahnpug2hTbsV+5MDDoGUx4GTOT91BQA/RLM7sZ6FUnE8bVsPyh5/Y
         GeGNSCH48Zzq0HGtX/kHLYWZy4wBmngiwiFYY/P67wol0Q/k9i8uoIu0yMLe3z8WxQCL
         /loVnA6TUNFLn5S+FRfUgIzkAQjfeTfcrj33Z9RC8VMUddapimevCMBhIvRUeveHDnDk
         2r4g==
X-Gm-Message-State: AHQUAuacffKWSaFd710YU/ufwGIhEM7snhPKksnKpeGEg7NwQZ8qorXT
        xWRmvpcqDc5eYXRUh34/wtu6dQ==
X-Google-Smtp-Source: AHgI3IbGiKOESnNG/kV/lmkE3lebyMkbiAGasEekXJbeCSu5cqjC0ytyEUViRx3VjeYjvS77IsjsIA==
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr16458016wme.16.1550508102373;
        Mon, 18 Feb 2019 08:41:42 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id w10sm6325442wru.5.2019.02.18.08.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:41:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 0/7] gpio: mockup: improve the user-space testing interface
Date:   Mon, 18 Feb 2019 17:41:31 +0100
Message-Id: <20190218164138.24921-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Marc,

please take a look at another, much simpler approach. The only change
in irq_sim is calling the irqd_set_trigger_type() in irq_set_type(). We
don't care about the actual type - we simply store it and any interested
user (for example gpio-mockup in this series) can retrieve it using
irq_get_trigger_type() and interpret it on its own.

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

Bartosz Golaszewski (7):
  irq/irq_sim: add irq_set_type() callback
  gpio: mockup: add locking
  gpio: mockup: implement get_multiple()
  gpio: mockup: don't create the debugfs link named after the label
  gpio: mockup: change the type of 'offset' to unsigned int
  gpio: mockup: change the signature of unlocked get/set helpers
  gpio: mockup: rework debugfs interface

 drivers/gpio/gpio-mockup.c | 189 +++++++++++++++++++++++++++++++------
 kernel/irq/irq_sim.c       |   8 ++
 2 files changed, 170 insertions(+), 27 deletions(-)

-- 
2.20.1

