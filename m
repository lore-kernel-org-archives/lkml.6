Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46FF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fbb8MgFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfBLNQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:16:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37149 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfBLNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:16:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so2961306wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aLOnktZustE6y8JWolL2PvKBmiyCxQbH/eujNJyKiI=;
        b=fbb8MgFPmRhNYCSk3Xdv/4CSmFe6r/jv4EEQn6IVXZ9XmnOIgQ0JfaiIXFWUQHwrlJ
         xA+4xYRD+8JHR872TVlvLufU7rEmvHP40vY4jyYGgQMDgGdjXUkP5mqLGsGYGs7SDgY1
         t/eYpSzDf1HzBK51rqh9JtYMWmoQKnPSnaOCVFIayrcel0qk4xm5Sjb2n2KOxWDK4980
         5+S9DpiaZoCoXoQLkIG3DJ4op7MMcRgw+1uOOD7yXQ8uUTJVJfGN3Phx5MH2PvV/5N6K
         K6PZyD2p+h0nBAUtD7bGFf2VFd9659d5kdn0JEhEhXDpN4J5V3opGUiiL5+6s6xjfK3a
         XzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aLOnktZustE6y8JWolL2PvKBmiyCxQbH/eujNJyKiI=;
        b=MxcvVYfKEYkMqohgp6QqL4ea/P+CKfAHXGZeQMlw3uyQpo2KI0k8RomIhN/C9lZ+7Z
         CRv6mP3murYEn9Gy3aOcTRUh7dPZ0k2/XXHRxAh57+nEsw1RoZOsZ0PWWsPOuYkjrj5e
         6UEO8z3a0YqelmNuPFHG5z+6Y+uvyO9gWX1Otr2GZ/se/1pCWiY/po2ANU3WAYgl0KDK
         2Way4Qka528F2KH08J1TVyLwQVjIjUkWAQxdad5TFSs+3x5WAJ+qIMwnSIWg3hDhy+aT
         Euy9KHhe0zyKbcKhZEh4OMwXUhCULJbTXB1RBj1IksI5ULj+xXjuExlCA9BQB0+Daf7W
         94PQ==
X-Gm-Message-State: AHQUAuYcymjP457/ZmOFyyzrXOzz9WLBsbqUvNJC5AsEsZIAldvPacy2
        uDLeK0TjE6+zU+7t17rXYsXkyQ==
X-Google-Smtp-Source: AHgI3IajFI9DCk5zQKNDX/w4ps+WCCPCMcIHDv6pz5BeWrLUFFw5b63qXniVDecE+wWSrX51IuSpDQ==
X-Received: by 2002:a1c:a9d0:: with SMTP id s199mr2891755wme.142.1549977385240;
        Tue, 12 Feb 2019 05:16:25 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id p6sm5478517wre.63.2019.02.12.05.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:16:24 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/7] gpio: mockup: improve the user-space testing interface
Date:   Tue, 12 Feb 2019 14:15:53 +0100
Message-Id: <20190212131600.18960-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Marc,

this is a trimmed down version of the previous series. All irq_sim patches
from the previous implementation were dropped. The only change in irq_sim now
is addition of the irq_sim_get_type() helper. We store the irq type in the
irq_set_type() callback and allow users to retrieve it with the new function.

The entire logic handling the line state now lives directly in the only user
that needs it - the GPIO testing module. Since the GPIO user API only supports
edge interrupts, level types are not supported. This functionality is only
needed for user-space tests. The testing module tracks the line state and makes
sure to avoid impossible situations (like firing a rising edge interrupt if
the line is being driven low).

Other gpio-mockup patches are unchanged - the only change in patch 7 is the
line state tracking.

v1 -> v2:
- instead of providing the irq_sim_get_type() helper, move the irq type
  logic into the simulator and provide a helper that allows users to specify
  the type of the fired interrupt

v2 -> v3:
- switch back to having irq_sim_type() and put the line state logic into the
  GPIO testing module

Bartosz Golaszewski (7):
  irq/irq_sim: provide irq_sim_get_type()
  gpio: mockup: add locking
  gpio: mockup: implement get_multiple()
  gpio: mockup: don't create the debugfs link named after the label
  gpio: mockup: change the type of 'offset' to unsigned int
  gpio: mockup: change the signature of unlocked get/set helpers
  gpio: mockup: rework debugfs interface

 drivers/gpio/gpio-mockup.c | 188 +++++++++++++++++++++++++++++++------
 include/linux/irq_sim.h    |   2 +
 kernel/irq/irq_sim.c       |  23 +++++
 3 files changed, 186 insertions(+), 27 deletions(-)

-- 
2.20.1

