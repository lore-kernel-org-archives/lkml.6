Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FFCC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B79620843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SECS7dEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B79620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJ1Vju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:39:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40155 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1Vju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:39:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so5393163wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI9NYKk9rl68vxziy4NzAMYLc4EmvVK+7lxE5tB43e4=;
        b=SECS7dEzzmF+awYfKj8XPiHpVOBNBVzJKS4QFWHVCrWwyaojnQTdGOG1NdNlIsLi2M
         1ch9Kh0OMfystAIE2vVWaj87eDSrjnzE/0PZcMqz60J7dC2HknOQIESFKJx469+huOma
         OBraJK81azAPPunuxlcMviXqVHJtQrmDeYyhrInQhHnmWAAb/IpsCY+3p2wIZyX4g/4P
         XZsVbFKiuh2Y5Dzped7riKE6EKdyOdke6CR3TUComP33bJnKtWd7mV6GJ3Wz2FHAGGab
         mCqw7A1+lnYUShMXtJ8IyWA0HFzewLxWWfaHZIKSO3CINyWjmAoDSPcP6i80/V+7GhLK
         yIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI9NYKk9rl68vxziy4NzAMYLc4EmvVK+7lxE5tB43e4=;
        b=euVYaMn5rXWX86O/2Bv42ziXPxCzFWvNQOIffG0tF24AuKaOqklqk3DLw7IqU0KM50
         +PS/c8RKFSgf+mpEBqeQBf1M1z6jV0FtAmhajJcO+F5RyHLsQFdvC8/8pw23HO+cf0x5
         le7R3e4Gq+o2bR0S9f/zYn+tF66KvhVHZwjrJwzS+KlIO1yYL7R1z6EGn/0RRnEOn36j
         0dQiddC1Kg7nCKEfS03c4UaaTHpJv9ERuSiCtgJUb4IsAWJRlTyaUvzbQRc3+VI2R0BB
         e1nrpVvCgr4Q/tCD7OsHNTaNR1ObvOHYWRG6bwH43CGs9XNi5BJ7C5acB28mpO4OgXqG
         6Y5Q==
X-Gm-Message-State: AGRZ1gJN7/QAubhOKXasvBGYjcGmo1LpfVI4XlZijK909UxGs4R9BBe1
        bqAtvWQiiq7Scdwbgk8e43g=
X-Google-Smtp-Source: AJdET5cwMQD01YlqUcvEw3ssztU/711DMtzQYCnbr18KKWy/EteNb/ccQztxuF27JjJ3W2Sw9qKusQ==
X-Received: by 2002:a1c:8015:: with SMTP id b21-v6mr3825443wmd.60.1540731314319;
        Sun, 28 Oct 2018 05:55:14 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7072200691979D1FB980407.dip0.t-ipconnect.de. [2003:dc:d707:2200:6919:79d1:fb98:407])
        by smtp.googlemail.com with ESMTPSA id u10-v6sm13759388wrt.59.2018.10.28.05.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 05:55:13 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] clocksource/meson6_timer: implement ARM delay timer
Date:   Sun, 28 Oct 2018 13:54:59 +0100
Message-Id: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to add support for the ARM TWD Timer and the ARM Global
Timer on Meson8, Meson8b and Meson8m2 (ARM Cortex-A5 and Cortex-A9 SoCs)
I did a review of the existing driver.
Unfortunately I found it hard to review because the pre-processor
#defines did not match the names from the public S805 datasheet. Thus
patch #1 adjusts these. No functional changes here, this is just
preparation work for patch #2.

Using the ARM Global Timer (drivers/clocksource/arm_global_timer.c)
would have given us a timer-based delay implementation (so udelay() and
friends would use the timer instead of using a loop-based delay
implementation). Unfortunately we can't use the ARM Global Timer yet
because it's input clock is derived from the CPU clock (which can change
once we enable CPU frequency scaling on these SoCs, for which I will be
sending patches in the near future).
Amlogic's 3.10 kernel uses Timer E as delay timer which (with the
current configuration) has a resolution of 1us. So patch #2 uses
register_current_timer_delay() to register Timer E as ARM delay timer
(which will be especially useful as we have to use udelay() when
changing the CPU clocks during DVFS).


Martin Blumenstingl (2):
  clocksource: meson6_timer: use register names from the datasheet
  clocksource: meson6_timer: implement ARM delay timer

 drivers/clocksource/meson6_timer.c | 130 ++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 41 deletions(-)

-- 
2.19.1

