Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19328C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50E22086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5RSl8bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfANI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:27:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34148 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfANI1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:27:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id u89-v6so18222689lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NzA7/J4xxPn4u4wIvrXOpJ7H3TlxZsszDjWpbsKesww=;
        b=G5RSl8bCDFhNbIYksGGYurGSR0NY6xfbxCCHZEEsPrdNTCZt1ZnvXQ9yUULeB9V6us
         dEOoDaPqjIOuR3AToXZq+iIGMhhtgmnSOAUq0D/10rW9o615S9eel1cYqYGjYOXb/G1i
         oaQcSWCELqx+rS/ZhvKp3baofE/tTPQCTPUN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NzA7/J4xxPn4u4wIvrXOpJ7H3TlxZsszDjWpbsKesww=;
        b=HOQoAInvgzXMqwtklla2G6/nq7KTeQFyivSCoqGg5M2E5PIxraDDDNsEFkZ5DCJ8di
         3HFi6C7aqcZWxwWuteseAtwXcMcPlhd6hfpPL7HTByCqz9lBQuoKLrjvqokHaWkFQTrn
         rVDs7OGedM+aqg2hS7ivWOPk+QIy4Q6Jv8IvJJZ8ZMdQ8bivjY/ph0QuenckIEW2ztdx
         Lq/Eg7Ap4B6IBoDEwRAtTq7dBcHhTFQbOrUKaHK6uDbb1Js3WeFFYF85lKz2u3Jt39NR
         89HgmzYm3oyk1svF4KFZMva7sJixcQVowm/gaoGR2mKDuLIWX/iZz0F+FRbCirG1Peqt
         hRAw==
X-Gm-Message-State: AJcUukfxXxMVLhGR51xiMYaMe0ZYaODKHqlRWU1tdU3h6FJm4y1JYt3n
        SmUofqO0+C0jxsMVsEnuPmwObgIsAMpupztRcI1MOg==
X-Google-Smtp-Source: ALg8bN4CjMyE4FhgpjTJDqQTJOai7BoXzHvMURZGKGXnkwlE+4I+RjB0KwPjbp+WmUFPkX4Dj5SmHQ3QZN9Q4XrUJkc=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr12027497ljj.120.1547454436025;
 Mon, 14 Jan 2019 00:27:16 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Jan 2019 09:27:04 +0100
Message-ID: <CACRpkdbP+kAp6px=QOZ6SDMLKVEYsjEA=CoR7D4whv0c4+motw@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v5.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some GPIO fixes for the v5.0 series.

The patch hitting the MMC/SD subsystem is fixing up my own
mess when moving semantics from MMC/SD over to gpiolib.
Ulf is on vacation but I managed to reach him on chat and
obtain his ACK.

The other two are early-rc fixes that are not super serious
but pretty annoying so I'd like to get rid of them.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.0-2

for you to fetch changes up to e3e4767bd550b3f19278e42bcce143e0d2316ba2:

  mmc: core: don't override the CD GPIO level when "cd-inverted" is
set (2019-01-11 15:27:35 +0100)

----------------------------------------------------------------
GPIO fixes for the v5.0 series:
- Get rid of some WARN_ON() from the ACPI code
- Staticize a symbol
- Fix MMC polarity detection

----------------------------------------------------------------
Hans de Goede (1):
      gpiolib-acpi: Remove unnecessary WARN_ON from
acpi_gpiochip_free_interrupts

Martin Blumenstingl (1):
      mmc: core: don't override the CD GPIO level when "cd-inverted" is set

Wei Yongjun (1):
      gpio: pca953x: Make symbol 'pca953x_i2c_regmap' static

 drivers/gpio/gpio-pca953x.c | 2 +-
 drivers/gpio/gpiolib-acpi.c | 7 +------
 drivers/mmc/core/host.c     | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)
