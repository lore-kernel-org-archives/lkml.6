Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-155233-1525440471-2-13129037468209393954
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='pl',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525440470; b=lMRppCS6R2ZINaUgGURREO2jEpmSW9+5H/xq5ShLRfLQFPdDmE
    neOtlNykJM/qhviM4DTrJxgFSUH43fUKzxmo/UYooHnnuk+It1XFBqVzFjYF28Gd
    Xs9SrHxBghMpjrpB6ugR4pyRAz/IKwh2DNWOxnBJ1joy+TAD/zOhpV+Lnz8muWRx
    QRY0iNQ7svUG4RTpgZtplynq8HsIuE9wiLAPxdERr/TurdqBirv2ItAd3X+lakLV
    DJWI1+pZF0TA2IPuVSFAduOcSvgIWyQd4IEw8DRDlP0YOjatS9zAXwPdhtw7Leui
    oCFg3Zo481Amk00lRuNP0pgh8vKmPSc7Yx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525440470; bh=QZuNE1P6qCAkiJWzJb5u+5I3w0cbHj
    9zaL2MngbU5mU=; b=Kslu4sgD7S2HA9+eRZm4UtbgT5htFXvRl2NhAPsyNKaiFQ
    34OovrRnxEGZAk7obNl/u5zyfVvqbJg0wYDVRicy/UJqcuzfsXTit5DuI0b2d0Pm
    4ZHt0160qXiOW+LQunkAePxHwvNXX35qly2gA2CKeONLI+WAhujm6qVIZ0obQsyb
    mD+1GfH35D5xVMTySCdFMIZzay8sNiEcC4NjVLImZo89Wvcxdrpk34CRsxkvKlha
    O1x9HJB4YejkFXarv6rF1ZtO4fKYaYZ6Oj9e+wBmFYmthbZsJ9HAtCYB9LIk74Ah
    r40rsQUKd08UVnSm7+Ppy0GhCycIo9x1YgwThGUA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from bgdev.pl);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=bgdev-pl.20150623.gappssmtp.com
    header.i=@bgdev-pl.20150623.gappssmtp.com header.b=ffgkO7+5
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bgdev.pl;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-dkim-ssp=unknown (author policy from bgdev.pl);
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=j7MAJFzP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=bgdev.pl header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from bgdev.pl);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=bgdev-pl.20150623.gappssmtp.com
      header.i=@bgdev-pl.20150623.gappssmtp.com header.b=ffgkO7+5
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bgdev.pl;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-dkim-ssp=unknown (author policy from bgdev.pl);
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=j7MAJFzP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=bgdev.pl header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPmwdifdl4RUapD8SP8G3vBgYElMksD97cR6RB5Sk3ViDWW5JqKnlltd4dytQauP3cdw923Kfm3Q2YbwfgyOrDctZLW7Kts14ytImT42qEyi8z9X4FFr
    UBcuLg+Ef1uFL4+6dYP5wTzQtReutEkNZdmKWbnEhfHGwDnacTqNmQ2B+9moLeNlN0qEPZcin9Gw8RUKPhiwwg9c4Qr92u58vmtzlhN3xq5bNNfZu58tXhXZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=yg3DuJc_eakcdsX57IoA:9 a=x8gzFH9gYPwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEDN1q (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 09:27:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56022 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeEDN1o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 09:27:44 -0400
X-Google-Smtp-Source: AB8JxZopFnRiSkrN0Ll/Mg/QaDRrlQbbmiejPmqlF0cMYMQMfJ9ltyvMf3ziOOwmMW1CC+3e6lNHgw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 0/3] sh: make early_platform code SuperH-specific
Date: Fri,  4 May 2018 15:27:28 +0200
Message-Id: <20180504132731.14574-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I recently started a discussion about the need for a proper early device
probing mechanism[1]. One that would be based on real platform drivers
and support both platform data and device tree.

While we're far from reaching any consensus on the implementation, Arnd
suggested that I start off by moving the SuperH-specific early platform
drivers implementation to arch/sh[2].

This series is the first attempt at making way for a new, less hacky
implementation.

The first patch removes the last instance of a non-sh driver using the
early_platform API. It can be removed since ARM no longer probes early
drivers.

The second patch moves all the early_platform code to arch/sh.

The last patch prefixes all early_platform symbols with 'sh_'.

[1] https://lkml.org/lkml/2018/4/26/657
[2] https://lkml.org/lkml/2018/4/27/239

v1 -> v2:
- certain drivers are compiled for arm/mach-shmobile too - we need to
  add ifdefs for CONFIG_SUPERH around early_platform calls

v2 -> v3:
- added a stub for is_early_platform_device() which always returns false
  on non-SuperH architectures

Bartosz Golaszewski (3):
  clocksource: timer-ti-dm: remove the early platform driver
    registration
  platform: move the early platform device support to arch/sh
  sh: add the sh_ prefix to early platform symbols

 arch/sh/drivers/Makefile               |   2 +-
 arch/sh/drivers/platform_early.c       | 346 +++++++++++++++++++++++++
 arch/sh/include/asm/platform_early.h   |  61 +++++
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh3.c     |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   9 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   3 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |   3 +-
 arch/sh/kernel/setup.c                 |   3 +-
 arch/sh/kernel/time.c                  |   5 +-
 drivers/base/platform.c                | 288 --------------------
 drivers/clocksource/sh_cmt.c           |  13 +-
 drivers/clocksource/sh_mtu2.c          |  13 +-
 drivers/clocksource/sh_tmu.c           |  14 +-
 drivers/clocksource/timer-ti-dm.c      |   1 -
 drivers/tty/serial/sh-sci.c            |  11 +-
 include/linux/platform_device.h        |  64 +----
 41 files changed, 524 insertions(+), 388 deletions(-)
 create mode 100644 arch/sh/drivers/platform_early.c
 create mode 100644 arch/sh/include/asm/platform_early.h

-- 
2.17.0

