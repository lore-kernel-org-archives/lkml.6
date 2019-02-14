Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C52222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OTkGwA3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394843AbfBNNm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:42:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36757 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388598AbfBNNm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:42:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so6157709wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaqzOo5ekmO7O3nkT4wGLP0fRGWKJKkRH5O7bvxu5Ns=;
        b=OTkGwA3d3KJQf9Tnpmc3I2PgjO2qxsuwGdcvG5Hey09QX4DMBXPubcW/tm5qdJHTpv
         Gm0gRs4IzqI4YycfLVtID73DgKYAxIZyfy7SmX5A6yvcMvf2HsOYP52SvoG0mTxf+DOi
         QvWo4ECghfGp/6oHgP40rj7W2b4WhRm7+CKNf8Cb9lEs4mcHYha16ETMp0AW1hCNt5gw
         VSX0sVWBlK6i5f2k/KrfNBVAlb3Z0+H2Plu6SN051sQys6t43SRKllAmgnPG0WbtC62p
         cPEmKKSFVVi57x8CJlm34bdlF0SZeABI8/66H01+zEvsz0Na2gbKWdfbRkaCCre41BVs
         cZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaqzOo5ekmO7O3nkT4wGLP0fRGWKJKkRH5O7bvxu5Ns=;
        b=N3G3H3h8erhDONAVEpPYKWcrSv4+Wl1NCEqsnL6O4sUJQNyuVfWRf7neZFE+aKTSAw
         MmeX+Hh/lff+VXjoP39elsyxlDE9lGW89cKKB27aPv5k5HPVFwE5Jfj813wUYxfDh8Rc
         xr222Lq9Vvbfqr/ljsaqrG/e8FVhKDMgt9qf6FlOKGjp/HxuV0h3sqJViPpDP34Hhd+C
         8uCIOpacf95VxQvYtCw5j5zPR8b980SAq1D5NGDOWMvSGndu52DRre2uRffabQIoi7n6
         fqvsCWi1RmZLA24HZrT+P4KevZAFIyKlBv9hlQ6VnkmIO8Z1DYX+xGj+GpYhmN5UOLUc
         kkww==
X-Gm-Message-State: AHQUAuY0Pj/VAHD1pEOYjTYLNSbulTPUY/GpKVHjC3ZrSj52xaA8VYsl
        4/+SIPjCmL+RfGVKlE2PSceLNg==
X-Google-Smtp-Source: AHgI3IbwYZcXzRAn2sPkIxfitgsBOv60yNcXx6DoD1RhqxtnfphbHQ1lVTruZMhudz3sDKB2pcvK9w==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr2939052wmj.0.1550151775938;
        Thu, 14 Feb 2019 05:42:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 62sm4963460wra.46.2019.02.14.05.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 05:42:55 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/7] gpio: mockup: improve the user-space testing interface
Date:   Thu, 14 Feb 2019 14:42:25 +0100
Message-Id: <20190214134232.3821-1-brgl@bgdev.pl>
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

another try at the irq_sim stuff. This time I added a notifier chain to
irq_sim and made gpio-mockup register a notifier block. This way interested
users will get notified about a type config change.

v1 -> v2:
- instead of providing the irq_sim_get_type() helper, move the irq type
  logic into the simulator and provide a helper that allows users to specify
  the type of the fired interrupt

v2 -> v3:
- switch back to having irq_sim_type() and put the line state logic into the
  GPIO testing module

v3- > v4:
- drop irq_sim_get_type() and use a notifier chain instead so that any change
  in type configuration can be pushed out to interested users
- change the locking mechanism in gpio-mockup to a spinlock as we can't take
  a mutex when a hardirq-safe spinlock in irq_desc is being held when the
  irq_set_type() callback is called
- refuse to set any other type than falling or rising edge in irq_set_config

Bartosz Golaszewski (7):
  irq/irq_sim: add a notifier chain
  gpio: mockup: add locking
  gpio: mockup: implement get_multiple()
  gpio: mockup: don't create the debugfs link named after the label
  gpio: mockup: change the type of 'offset' to unsigned int
  gpio: mockup: change the signature of unlocked get/set helpers
  gpio: mockup: rework debugfs interface

 drivers/gpio/gpio-mockup.c | 215 ++++++++++++++++++++++++++++++++-----
 include/linux/irq_sim.h    |  22 +++-
 kernel/irq/irq_sim.c       |  40 +++++++
 3 files changed, 246 insertions(+), 31 deletions(-)

-- 
2.20.1

