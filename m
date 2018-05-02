Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525295134-2-5565595920666752690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295134; b=b2GgttkaKYbY2rWS+a8QE5OiVRYMkC5JzZeFKyiL8FqYEoDNiF
    cupcaMPxV4qdXHFi7djTAu9uIhcbSvpgnyeMJ3aBOQDQP1KRjFIPp9qSBepDuDgM
    kfJ7/T7TXZ80r4ytHg9P6Rs4eU7CGD2pUdQnL9cXa2/RCKnnIoufMm3c0zBcnxC7
    AjXbdgkkBcxt3sg8VWjxmuzeHNeN7BvpfQsIO3c5v9TosUNJl2qPBR361lfh9TkT
    3GrmO+rzHUzHOHS4aEH7FTmph4FIokrhDGxPRIBt20ZkOcw6jGviGGK/DDsLUYFu
    BtVdqt3onmXgtm73mWYdNM93q+GGqi9fsVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525295134; bh=gZaNnRDBNN0YIVthQBS0LYer9/zliElVNCafo0kGU1
    o=; b=PWMw19he3QX7Y5pUo2P4Kt6AMxO1dBKt1ZcfejaBREFbPA/zvpvUHvS2/D
    vhrqp9lI4eUU1wWHIQIazyA5v/DHaTbvEVVn4Zo02FiqqrP21SKUgl3RFdwBK6jd
    DVAja7IHPCmrR5ROK/mhlVD9HMR/X9nziz3fRh0O37XEOgj6OgnMWejknkB1c9fP
    lwrOW22cmffzE2p2SgyYRHjefmymYZRRHaYm5+Y4kDEWlLP1dSygDfya7jiSsd++
    fJ5ne4oW375M50QXi9ONpY9rK+BUXStiyEN0vIC/B1T9vwqFuM+oUsFI5MynzGZN
    c14H5KYHJP1RsImqFYnCFc//Esqw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=knCZ1IpI x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=aUt76qpi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=knCZ1IpI x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=aUt76qpi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC7MFWZ94NWlyZD8k6op+gL0qjxMZjQM4CfBaSP33nSiCdDYVDP8zXeFCQeXe7Dl2auNRsoSr36mhhFnmA2OhZxv0B33Q1DhRmqrJ5dKEx2m/8LLwyC4
    8aHhYbdoFJtecoz8wuE+GRjmJMoRYLPrS9b74m+YIoNNsjqSLPwDnu2y0zmQ5fWBRFIlGkiqccleyBgElcuM4LEJR8h1Q3zcz/6zkWfh3eDb2pH+Aik0JxEd
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=SSMdg3Pr_zl7aIGtyLoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbeEBVFb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:05:31 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35170 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeEBVF3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 May 2018 17:05:29 -0400
X-Google-Smtp-Source: AB8JxZqDDWHBhu97hiya5uaBsaYxWKkkKNhOR2Hxvb6dFI1t/5we5TaJAgee17oauU53lH6JkE8jaHpmXwH31QB8jUg=
MIME-Version: 1.0
In-Reply-To: <20180502094821.2907-1-brgl@bgdev.pl>
References: <20180502094821.2907-1-brgl@bgdev.pl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 23:05:28 +0200
X-Google-Sender-Auth: 2GxwOld4klT9adGwwslfIwKCEa0
Message-ID: <CAMuHMdVCrtLm7-sfbhG+o5Wvymgeu8cREtbesuuqFN0U1pc06g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] sh: make early_platform code SuperH-specific
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CC Magnus

On Wed, May 2, 2018 at 11:48 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> I recently started a discussion about the need for a proper early device
> probing mechanism[1]. One that would be based on real platform drivers
> and support both platform data and device tree.
>
> While we're far from reaching any consensus on the implementation, Arnd
> suggested that I start off by moving the SuperH-specific early platform
> drivers implementation to arch/sh[2].
>
> This series is the first attempt at making way for a new, less hacky
> implementation.
>
> The first patch removes the last instance of a non-sh driver using the
> early_platform API. It can be removed since ARM no longer probes early
> drivers.
>
> The second patch moves all the early_platform code to arch/sh.
>
> The last patch prefixes all early_platform symbols with 'sh_'.
>
> [1] https://lkml.org/lkml/2018/4/26/657
> [2] https://lkml.org/lkml/2018/4/27/239
>
> v1 -> v2:
> - certain drivers are compiled for arm/mach-shmobile too - we need to
>   add ifdefs for CONFIG_SUPERH around early_platform calls
>
> Bartosz Golaszewski (3):
>   clocksource: timer-ti-dm: remove the early platform driver
>     registration
>   platform: move the early platform device support to arch/sh
>   sh: add the sh_ prefix to early platform symbols
>
>  arch/sh/drivers/Makefile               |   2 +-
>  arch/sh/drivers/platform_early.c       | 346 +++++++++++++++++++++++++
>  arch/sh/include/asm/platform_early.h   |  61 +++++
>  arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   4 +-
>  arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7201.c |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7264.c |   3 +-
>  arch/sh/kernel/cpu/sh2a/setup-sh7269.c |   3 +-
>  arch/sh/kernel/cpu/sh3/setup-sh3.c     |   1 +
>  arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   3 +-
>  arch/sh/kernel/cpu/sh3/setup-sh770x.c  |   3 +-
>  arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   3 +-
>  arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   3 +-
>  arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   3 +-
>  arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   9 +-
>  arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7770.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   4 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   3 +-
>  arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   3 +-
>  arch/sh/kernel/cpu/sh5/setup-sh5.c     |   3 +-
>  arch/sh/kernel/setup.c                 |   3 +-
>  arch/sh/kernel/time.c                  |   5 +-
>  drivers/base/platform.c                | 288 --------------------
>  drivers/clocksource/sh_cmt.c           |  17 +-
>  drivers/clocksource/sh_mtu2.c          |  17 +-
>  drivers/clocksource/sh_tmu.c           |  18 +-
>  drivers/clocksource/timer-ti-dm.c      |   1 -
>  drivers/tty/serial/sh-sci.c            |  11 +-
>  include/linux/platform_device.h        |  52 ----
>  41 files changed, 526 insertions(+), 388 deletions(-)
>  create mode 100644 arch/sh/drivers/platform_early.c
>  create mode 100644 arch/sh/include/asm/platform_early.h
>
