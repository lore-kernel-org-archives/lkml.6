Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0872D21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvOdh14t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbeLUPzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:55:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38450 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLUPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:55:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so5151179lja.5;
        Fri, 21 Dec 2018 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6GgTxgKujAL6bxZt3/XwrBWxuVSJAbJ+/4kL7P1mWVI=;
        b=KvOdh14tGYG18VCF3126oz0g6CWBwgX//7LyQwzLPOO7sxlF8bZtPv9CZtGXMiL2TW
         SCZ5f0trAXuyVbs9aPDg2x6zxdT05tT5BeDzkocMW4LOgYOcnsKuUzDwGRQ+QSrFp6Dj
         fecCO7CcmA8/7b+C/Tb8+1t/Th/YfaBCHJhVsXGN5okmbKUUzpBtnYb8LL20idBxoT9U
         fvsyoFTEEmy0IeGOwwfbn+fwQDvSyAAE3dbXIW/FOkB4JuIv5rZMXJ7pDTtigFvyeH0Y
         t4TcxOKwOJmlC7R3pwRq44NfvdAUivZmR7SD3AHRkjfb5ORv4kUuwOhKSoTkDDKsL90k
         nAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6GgTxgKujAL6bxZt3/XwrBWxuVSJAbJ+/4kL7P1mWVI=;
        b=K1g61Nz95FPakX6WdAUCLH8PnhGvliAzV/J24teT2fE6iS+GI+0c8AsCUC3KLZr59G
         fesZ4NzbJEgcCpH7ld5gCwsuDfakcIRbfL+yxOCgJKzYF8HVQjlnGexN7udWK+btUNnR
         70tPHNDgSQaYGj78181T5+A76SF3v+voLlIBKnEQ4jZl9Od4ozcUDM/x7+34M1/+mHZ+
         qpUUqlyx3Y127kpwTFM5NC4rxmTzH2ksigkiYJHAtGXbSo8DS5RtDuKsUVlgWxO9kkCw
         gqqYVNwkjEM00D/Gh5zJ98JRQMs92BYffMjId6Khi1nT6qlmdXpf/Y7bgrUjjxqdyzL0
         Ez9w==
X-Gm-Message-State: AA+aEWZEziQAgg+0K1rutJueFrkWdIrSYwIMC4FaeYcj6AAea+rytmHv
        v1yduilgFRtftnAdXT1p/gQ=
X-Google-Smtp-Source: AFSGD/VL8c/IpYbB+4qNXWlCl1jeVTCY/XGX2yTTPx8od8TNO62jBLBBtS8tw4NgBBvoa2rt1vEBRQ==
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr1895357ljb.11.1545407697451;
        Fri, 21 Dec 2018 07:54:57 -0800 (PST)
Received: from myhost.home (chs24.neoplus.adsl.tpnet.pl. [83.31.16.24])
        by smtp.gmail.com with ESMTPSA id r203sm757153lff.13.2018.12.21.07.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:54:56 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, krzk@kernel.org, robh@kernel.org,
        tiny.windzz@gmail.com
Subject: [GIT PULL] LED updates for 4.21-rc1
Date:   Fri, 21 Dec 2018 16:54:51 +0100
Message-Id: <20181221155451.7024-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull LED updates for 4.21-rc1.

There are several few-liners, where most of them are fixes
and improvments. One thing standing out is ground preparation
for inititializing trigger parameters via Device Tree.

We introduce LED_INIT_DEFAULT_TRIGGER flag for that purpose
and set it when default trigger is matched. It indicates
that trigger should parse DT properties to retrieve
the initialization data when set as default one.

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds-for-4.21-rc1

for you to fetch changes up to 8146aace60c7409cc60a1598bc9647a5bbb12eb4:

  led: triggers: Initialize LED_INIT_DEFAULT_TRIGGER if trigger is brought after class (2018-12-10 21:31:55 +0100)

Thanks,
Jacek Anaszewski

----------------------------------------------------------------
LEDs for 4.21-rc1
----------------------------------------------------------------
Jacek Anaszewski (2):
      led: triggers: Break the for loop after default trigger is found
      led: triggers: Add LED_INIT_DEFAULT_TRIGGER flag

Krzysztof Kozlowski (4):
      leds: gpio: Drop unneeded manual of_node assignment
      leds: pwm: Simplify with resource-managed devm_led_classdev_register()
      leds: pwm: Use OF variant of LED registering function
      led: triggers: Initialize LED_INIT_DEFAULT_TRIGGER if trigger is brought after class

Rob Herring (1):
      leds: 88pm860x: Use of_node_name_eq for node name comparisons

Yangtao Li (1):
      leds: powernv: add of_node_put()

 drivers/leds/led-triggers.c  |  9 +++++++--
 drivers/leds/leds-88pm860x.c |  2 +-
 drivers/leds/leds-gpio.c     |  1 -
 drivers/leds/leds-powernv.c  | 12 +++++++++---
 drivers/leds/leds-pwm.c      | 22 ++--------------------
 include/linux/leds.h         |  1 +
 6 files changed, 20 insertions(+), 27 deletions(-)
