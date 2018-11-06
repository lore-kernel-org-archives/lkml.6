Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB062C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663492086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJK0L5ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663492086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbeKGHfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35038 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeKGHfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so12958016ljb.2;
        Tue, 06 Nov 2018 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cagExdpJG/a9sbtG/vQh5lz8UCDFiBZI3hHAzeqd2J8=;
        b=MJK0L5ci0J3jrdAtSL+Qa7Ew5TbSsaO8oCgRYmqz94XNFCtBtGgOBXa8bxM+0NMQLp
         ffL+ViHR5x2o7lvGcV+zXbe4sc1lvj5L2JH7ARPI9/zo0/MfBWp7OatIYnuc3WA2qYvl
         4HtmUWJ8WTkv9epWVVKDS0gLv6qpSQkq3BfK0jdtyNX4dntD0lnpyASDgmqz5M1CH+Y6
         ar/sCsOpDEqSjLcrOYnjJ5o5KMAqaDgpwIIuNIMCtZYUNU8UlXVLnSXyKoDcBgNLon7+
         gftsGOxgsCnE0f0wZ48234Bfm0TJ3rsyb+skA5IZvj+oPhwPaNcNawB4daU2KuN7Nfpp
         F57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cagExdpJG/a9sbtG/vQh5lz8UCDFiBZI3hHAzeqd2J8=;
        b=TqX4Jx3B7xrYz+HoMAZVUIsVdwuDGEs9aBzsXfHvxjkqTk3BbsWGS04jCKsRRiuPCb
         w3UtQuI/iAOhCO4lz/VqWOoRIumHARIW+scTDVZxS8O0HYxKlDdXI3Tvop30OncKUGLu
         F9rmhuDj68dIS8MfoPkrrpv1bHR+6B9sajlMYxRnBj+R4F2gSCTxNQinsyLrUWaB204U
         Tme0R2OCsSJNeppKc8fNkKaqoUSvGmr0E9Yk1An9jNh7qdFm8AwCml5i3WDk7Pb5gjF3
         Dv7fEuazIoPbGStL8uvzXd+Ab7hX4hMuK9W8lLZ30FLuV6KdkqBLnTqwsQY2HlAbxigE
         Y1aQ==
X-Gm-Message-State: AGRZ1gJdlaoadY3E6hlvuYTUWTXITblYghH/2T7mGWnOqXD6tZIHRCVH
        Ac93APMl2ysP4c/BnwYhyELdzAZm
X-Google-Smtp-Source: AJdET5f2txo2HCF+d+tKFmw04MPBgNvNJt8fx/RRZakoxxQIZu1A5MH/IA8nZwp5/GRmqkiN009rqw==
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr20140693lje.78.1541542062319;
        Tue, 06 Nov 2018 14:07:42 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:07:41 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH 00/24] Add generic support for composing LED class device name
Date:   Tue,  6 Nov 2018 23:07:08 +0100
Message-Id: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LED class device naming pattern included devicename section, which had
unpleasant effect of varying userspace interface dependent on underlaying
hardware. Moreover, this information was redundant in the LED name, since
the LED controller name could have been obtained from sysfs device group

This patch set introduces a led_compose_name() function in the LED core,
which unifies and simplifies LED class device name composition. This
change is accompanied by the improvements in the common LED DT bindings
where two new properties are introduced: "function" and "color" . The two
deprecate the old "label" property which was leaving too much room for
interpretation, leading to inconsistent LED naming.

There are also changes in LED DT node naming, which are in line with
DT maintainer's request from [0].

Since some DT LED naming unification, related to not including devicename
section in "label" DT property, is being requested during reviews of new
LED class drivers for almost a year now, then those drivers are the first
candidates for optimalization and the first users of the new
led_compose_name() API. The modifications were tested with Qemu,
by stubbing the driver internals where hardware interaction was needed
for proper probing.

Thanks,
Jacek Anaszewski

[0] https://lore.kernel.org/patchwork/patch/858993/

Jacek Anaszewski (24):
  leds: class: Improve LED and LED flash class registration API
  leds: core: Add support for composing LED class device names
  leds: dt-bindings: Add LED_FUNCTION definitions
  dt-bindings: leds: Add function and color properties
  dt-bindings: sc27xx-blt: Add function and color properties
  leds: sc27xx-blt: Use led_compose_name()
  dt-bindings: lt3593: Add function and color properties
  leds: lt3593: Use led_compose_name()
  dt-bindings: lp8860: Add function and color properties
  leds: lp8860: Use led_compose_name()
  dt-bindings: lm3692x: Add function and color properties
  leds: lm3692x: Use led_compose_name()
  dt-bindings: lm36010: Add function and color properties
  leds: lm3601x: Use led_compose_name()
  dt-bindings: cr0014114: Add function and color properties
  leds: cr0014114: Use led_compose_name()
  dt-bindings: aat1290: Add function and color properties
  leds: aat1290: Use led_compose_name()
  dt-bindings: as3645a: Add function and color properties
  leds: as3645a: Use led_compose_name()
  dt-bindings: leds-gpio: Add function and color properties
  leds: gpio: Use led_compose_name()
  dt-bindings: an30259a: Add function and color properties
  leds: an30259a: Use led_compose_name()

 .../devicetree/bindings/leds/ams,as3645a.txt       |  22 +++--
 Documentation/devicetree/bindings/leds/common.txt  |  52 +++++++++--
 .../devicetree/bindings/leds/leds-aat1290.txt      |  12 ++-
 .../devicetree/bindings/leds/leds-an30259a.txt     |  22 ++++-
 .../devicetree/bindings/leds/leds-cr0014114.txt    |  26 ++++--
 .../devicetree/bindings/leds/leds-gpio.txt         |  22 +++--
 .../devicetree/bindings/leds/leds-lm3601x.txt      |  10 +-
 .../devicetree/bindings/leds/leds-lm3692x.txt      |   9 +-
 .../devicetree/bindings/leds/leds-lp8860.txt       |   9 +-
 .../devicetree/bindings/leds/leds-lt3593.txt       |  11 ++-
 .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |  10 +-
 Documentation/leds/leds-class.txt                  |   2 +-
 drivers/leds/led-class-flash.c                     |   9 +-
 drivers/leds/led-class.c                           |  34 ++++---
 drivers/leds/led-core.c                            |  71 +++++++++++++++
 drivers/leds/leds-aat1290.c                        |  17 ++--
 drivers/leds/leds-an30259a.c                       |  26 +++---
 drivers/leds/leds-as3645a.c                        |  65 ++++++-------
 drivers/leds/leds-cr0014114.c                      |  30 ++----
 drivers/leds/leds-gpio.c                           |  27 +++---
 drivers/leds/leds-lm3601x.c                        |  45 ++++-----
 drivers/leds/leds-lm3692x.c                        |  39 ++++----
 drivers/leds/leds-lp8860.c                         |  38 ++++----
 drivers/leds/leds-lt3593.c                         |  19 ++--
 drivers/leds/leds-sc27xx-bltc.c                    |  23 ++---
 include/dt-bindings/leds/functions.h               | 101 +++++++++++++++++++++
 include/linux/led-class-flash.h                    |  13 ++-
 include/linux/leds.h                               |  61 +++++++++++--
 28 files changed, 571 insertions(+), 254 deletions(-)
 create mode 100644 include/dt-bindings/leds/functions.h

-- 
2.1.4

