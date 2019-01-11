Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE19C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0078E217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H05KZjJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfAKIW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:22:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45157 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730202AbfAKIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:22:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so6443761plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kDMiPaYUT4VgzHbYInug12qE4tWw9R1XGGt+UK6pUL4=;
        b=H05KZjJSqmLJFac445dWUNEVE7I8+s5Qy5qaceY970OkeYWp5VT6JpHAG8PUGw8W9b
         TDDMs7JI+12Q1KdvA9FD8C1J8LkBbwfOrgWQUvG3fB8Ty/HFrbsySBR90rKwZIt9PC62
         eor0wrC76+dowlSzi9SHZVL2Fe2o8hOhH15x36AbisIevsVKOmVAMJoUYUBotQEavWSg
         3pSTHha21F4qNdYWbtX8naaLtBRg7T2a3ewLr3qRxJQxxMagUqIVfQjoi9PiEe8RYvxW
         TR4tOGh0UBZqFq17ZNydzVwHYbiJhCUh1xnYa1Ki/TUB16fd72Fo5UrxwnjdioCxokbf
         75rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kDMiPaYUT4VgzHbYInug12qE4tWw9R1XGGt+UK6pUL4=;
        b=NAk2LW3mtvgXlTqIF5fobv6iEJ6f1PU4mn/6EBPdyCJioHjEh+EdhD60FkFqUw8ZKG
         TN/Wbqr07/ywMH31z8gN5GLigAGnFsfBYL0+PJuvjvWH3AVO+NbN64zdIclkmupv1+tp
         8IVexZ+Tv1IB9+oUR3P7nvs6lukY7nWAbtlKIcDb1RipzWztTQsXiAg0nuCuMOkB/LfY
         x4hhmARJv6OtdDzf2pJkQ/vcnHuXU0IR3UhUUcJ9BUU/qcKOZbFeCi6YJqNuoWzQFfwT
         yaMBrpUNZIP5xanQOJ/wU21spZsAaJzabI9UCZsinFIGfiwOz//aPlJxafdpp49gTQyG
         0Meg==
X-Gm-Message-State: AJcUukecZcNpD3jh33olGPPXOcgnrOKkWTbwSn5of8Ssyc5V6B9d6aLr
        7bDttCq87VQ3vlZOvrKg5g6i1A==
X-Google-Smtp-Source: ALg8bN4rf+UxOiY4kwmXaEWVQnTYrsvNpjguETEOBEyF28Uc4I8NoXay1kINgQQ8HI3xI0mdGTM0ow==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr12915069pls.124.1547194977943;
        Fri, 11 Jan 2019 00:22:57 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id t87sm248422324pfk.122.2019.01.11.00.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 00:22:57 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/2] PWM support for HiFive Unleashed
Date:   Fri, 11 Jan 2019 13:52:42 +0530
Message-Id: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

Yash Shah (2):
  pwm: sifive: Add DT documentation for SiFive PWM Controller
  pwm: sifive: Add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  37 ++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 246 +++++++++++++++++++++
 4 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

