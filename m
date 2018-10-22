Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3758CC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2A720663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh819slT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2A720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeJWDs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:48:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39651 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbeJWDs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:48:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id p11-v6so4907021lfc.6;
        Mon, 22 Oct 2018 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JBET6pl2NSjEv9XWSceFW17H5LNwySQtpBw1KV+FM/o=;
        b=eh819slT+yVCyMXalFCE+2Yp0O9szJuWKrvYMurOPohZlbf+uCw57Y0Ib+//IS64Nt
         G5IlpHlUdhEdg+63JX6l8boTvm6ZWbgkBR3tc4QJCknRs1CSagVY1eOD4iiYDcjozGOx
         gdlGo7gxwXHwjlmlVyox7CzSHHL7b5mZ8ht3v7+va28gBMEerCfzjw50pO8GkKlGyq+x
         cWqmfJSoaAJXwO8Eayji2z6E7dMM2wIkvx1jrm7s7SjZSnnUhHikVOh4TDTEXneLQmN+
         G9FekoobTZVRTf8R+UiXcE0MXFt3/Dtn87NFjCTFz2R/fSJI93iu/mqpkFWTUahB5o84
         70rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JBET6pl2NSjEv9XWSceFW17H5LNwySQtpBw1KV+FM/o=;
        b=g9B/iMYb1kDjMUWDamERTCSyavDhin3xwbk3Y29eHW+qxomJ0YASDoy0b4u1KRWWPu
         Tdoot35DoJFvhqv7xGf+n54R0mOQXvFmVh6UOLYzm8FvVm91BrBtVXXI0bnx1edTj6oD
         gylk4FsG1vzmGCAV+H2je836sv41mg/wRoWIBKUc1/yV9i1tEalHHuo74Ull9Jc391b6
         xOS8u+XVmPzF66Av1bJs/VEYH9BQbwVOCBnyv/SLMGxnhHlU949nkehth/UFTUw88ASM
         5lNMFpBBSqDgKVAErkaNbZfQb306Z0sXblgYgPF4UqlO5N+++hz1znly4FzHONnjqsec
         QMjQ==
X-Gm-Message-State: ABuFfojYHCJc07hI8EIe+IzAqfa0ta2YDBaGVLzzVNQfIHmHLUQ+l+kd
        V7Z+hKIRgWnllCBrOCSfJgY=
X-Google-Smtp-Source: ACcGV61NL7W90SojStu3QQp1p/K1AEk2qbJlmld9cavDHdmREByk8g/bqTZy+rDpvZa/t/udlr16lA==
X-Received: by 2002:a19:24c6:: with SMTP id k189mr10542231lfk.77.1540236516832;
        Mon, 22 Oct 2018 12:28:36 -0700 (PDT)
Received: from i4790k.home (dnt127.neoplus.adsl.tpnet.pl. [83.24.101.127])
        by smtp.gmail.com with ESMTPSA id u20-v6sm5944lfk.55.2018.10.22.12.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 12:28:36 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, baolin.wang@linaro.org,
        jbrunet@baylibre.com, linus.walleij@linaro.org, robh@kernel.org,
        simon@lineageos.org
Subject: [GIT PULL] LED updates for 4.20-rc1
Date:   Mon, 22 Oct 2018 21:28:29 +0200
Message-Id: <1540236509-5341-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull LED updates for 4.20-rc1.

We introduce LED pattern trigger - the idea that was proposed three years
ago now received enough attention and determination to drive it to the
successful end.

There is also one new LED class driver and couple of improvements
to the existing ones.


New LED class driver
	- add support for Panasonic AN30259A with related DT bindings

New LED trigger
	- introduce LED pattern trigger

leds-sc27xx-bltc
	- implement pattern_set/clear ops to enable support for
	  pattern trigger's hw_pattern sysfs file

Improvements to existing LED class drivers:
	- leds-pwm: don't print error message on -EPROBE_DEFER
	- leds-gpio: try to lookup gpiod from device
	- leds-as3645a: convert to using %pOFn instead of device_node.name


Thanks,
Jacek Anaszewski

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds-for-4.20-rc1

for you to fetch changes up to 8dbac65f5c181e4723586ab738b703bb23bc3f2a:

  leds: sc27xx: Add pattern_set/clear interfaces for LED controller (2018-10-11 21:59:11 +0200)

----------------------------------------------------------------
LED updates for 4.20-rc1.
----------------------------------------------------------------
Baolin Wang (2):
      leds: core: Introduce LED pattern trigger
      leds: sc27xx: Add pattern_set/clear interfaces for LED controller

Jerome Brunet (1):
      leds: pwm: silently error out on EPROBE_DEFER

Linus Walleij (1):
      leds: gpio: Try to lookup gpiod from device

Rob Herring (1):
      leds: Convert to using %pOFn instead of device_node.name

Simon Shields (2):
      dt-bindings: leds: document Panasonic AN30259A bindings
      leds: add Panasonic AN30259A support

 .../ABI/testing/sysfs-class-led-driver-sc27xx      |  22 ++
 .../ABI/testing/sysfs-class-led-trigger-pattern    |  82 ++++
 .../devicetree/bindings/leds/leds-an30259a.txt     |  43 +++
 drivers/leds/Kconfig                               |  10 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-an30259a.c                       | 368 ++++++++++++++++++
 drivers/leds/leds-as3645a.c                        |   4 +-
 drivers/leds/leds-gpio.c                           |  92 +++--
 drivers/leds/leds-pwm.c                            |   5 +-
 drivers/leds/leds-sc27xx-bltc.c                    | 121 ++++++
 drivers/leds/trigger/Kconfig                       |   7 +
 drivers/leds/trigger/Makefile                      |   1 +
 drivers/leds/trigger/ledtrig-pattern.c             | 411 +++++++++++++++++++++
 include/linux/leds.h                               |  15 +
 14 files changed, 1148 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
 create mode 100644 Documentation/devicetree/bindings/leds/leds-an30259a.txt
 create mode 100644 drivers/leds/leds-an30259a.c
 create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
