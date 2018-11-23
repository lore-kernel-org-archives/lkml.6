Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C604C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02B8206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIp06AE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02B8206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408357AbeKWS4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:56:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35907 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390293AbeKWS4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:56:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so9942072ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 00:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6QQ5eiXvfq10kYfUEC3g1FBwuRlBaRNfIcAqrwWpjMY=;
        b=JIp06AE1Nh8cTWQSsNSwNawAl4xyegk0wTHPlhsC4tUn811OVnON6J3ynHkSEcUBJb
         wPq2s3Ot6Wsu5twPGYmuiTQa4IYBbA34zsgg0DWDT2a4bvUzSKlWVQs4JDNqa1BvqEkJ
         uH0xc9Da6qEakWQQ9jjKkuXg9iXKDUMmWi9eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6QQ5eiXvfq10kYfUEC3g1FBwuRlBaRNfIcAqrwWpjMY=;
        b=fT4LSA+6AGTdCywNPqiic+3Wm9tPEAMfu4ZoYWLl0/+acUOkrsFXPNG+Q597R3osgr
         PQa9nC8wSfAyERl6UCGRLrOF7TLPxofzncSX/SySF/iBdGzm6N+XbWpzoD5/FodTXmPA
         4QzezPWT8vdfnTFO0ORl8TST9E+xWEfouDPsY4PgGChtq63kJxUV4YdC63551Xwk/rDC
         Cm5+hY2QtH0DP/5ol2MKB34s0SR1qYybu31Mxa3PsknDXF5X7sH/qy6Bu9zB3/piRdtz
         2D8c6dXhGiHPx6vtWHVcfBeHb0UMdi51byWKQeG21N4vlC3P5Aqp0lEbFiUTHq2YAS7D
         hl8w==
X-Gm-Message-State: AA+aEWbxeX6nqAm60P1trOkzCsj089epvBrpRMeZWvdWPgwPUz3oPB5x
        iUj+EgSM5MqaK9iBPLhhbG+hn+7Z0VFJhxvaNegG4A==
X-Google-Smtp-Source: AFSGD/UVZtU7uSVpJdH9M5SmqRboTdVIRf1/dIFnr3bhHIhUXIp0FcHTNQhKGrhJK4+ekQXq1TyNQn6Wte4i7KFN8rI=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr9135727ljk.4.1542960770688;
 Fri, 23 Nov 2018 00:12:50 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Nov 2018 09:12:38 +0100
Message-ID: <CACRpkdYEtBRi7qcLtL602qE3fe6+eaYAH_Nw+25NsaL0EebOiQ@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for the v4.20 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are a few collected GPIO fixes for the v4.20 series.
Minor stuff except the IDA leak which was kind of important
to fix. Also new maintainers, yay.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.20-2

for you to fetch changes up to 10547d956d590fbb846a7bd053a1dfc30e8f9a68:

  MAINTAINERS: Do maintain Intel GPIO drivers via separate tree
(2018-11-16 23:06:51 +0100)

----------------------------------------------------------------
GPIO fixes for the v4.20 series:

- Do not lose an IDA on the gpiochip register errorpath.

- Fix the PXA non-pincontrol GPIO-using platforms.

- Fix the direction on the mockup GPIO driver.

- Add some MAINTAINERS stuff: Bartosz stepped up as GPIO
  co-maintainer, and Andy established an Intel git tree.

----------------------------------------------------------------
Andy Shevchenko (1):
      MAINTAINERS: Do maintain Intel GPIO drivers via separate tree

Bartosz Golaszewski (2):
      MAINTAINERS: add myself as co-maintainer of gpiolib
      gpio: mockup: fix indicated direction

Robert Jarzmik (1):
      gpio: pxa: fix legacy non pinctrl aware builds again

Vladimir Zapolskiy (1):
      gpio: don't free unallocated ida on gpiochip_add_data_with_key()
error path

 MAINTAINERS                | 34 ++++++++++++++++++++++------------
 drivers/gpio/gpio-mockup.c |  6 +++---
 drivers/gpio/gpio-pxa.c    |  4 ++--
 drivers/gpio/gpiolib.c     |  5 +++--
 4 files changed, 30 insertions(+), 19 deletions(-)
