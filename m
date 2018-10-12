Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC018C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71FB2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nndl/WVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71FB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeJLQG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:06:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51076 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbeJLQG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:06:27 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so11505984ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JTMJ0vEG5WDoVKecOSaNNeBKlZdU16j5j6PCb/UEo+c=;
        b=Nndl/WVhUZ7JDEwYazRx73OBfJV9ubzpl+8wRYnt4ed6WW8T4PSnDGAKgdn3CLtHkh
         9uZCsr66VNr1CzZr7n8zBaUtoChvaq6jp6iUOXzeMrN5aoi6Ie3jEa39gXZHnv8xwChi
         ycvX/IAHbuKdhyNvC6FXwU+MMyw9C6rStSTRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JTMJ0vEG5WDoVKecOSaNNeBKlZdU16j5j6PCb/UEo+c=;
        b=W9y3Mv4wG62D1/x0kyWU/oVH/iP/zOR4yjUadkBX55rC028dLM2Hgulw7HEmAn6pzw
         q2GXswvjkj20mOmvm6LdW1CQVN9SYm30v6walEijI5xnEyUckUT+YO2nV+35fXb1IQ5W
         lm+6QrYDKqhTW+v8AV1q3pQhRrDP8JDtDIw5muS7ago7hxGbehC6CtaRcUmYNe/zbDlO
         1d/5TazUfrw8Ad+n4nBXTclTF5VYCEDhmsH642k9tcvSx9sFTGx9qVAmsbjFfSghp+zf
         nst95GO1K7MpfvQ2IUevJeVE7xcik0fh0qdFpFdi8VWqAn+tAhBnU4x0dmjtzKOR5gGu
         cj3Q==
X-Gm-Message-State: ABuFfoj6EEuy6YORgHQA21TugPBxORd49gfHKFY3sNnNYzeBRPsOnv6J
        ymbKR+MwcExERy8H6yjHfROivSTrBU77U+bltDeWMg==
X-Google-Smtp-Source: ACcGV61EqGYkBWaDW5CKD0O2bXTONMiGqfivQJsUeLSaxw/pzBqUa9pCflADK35gcHVB2JRc6HTj7vPxWD3bBAvDm8Q=
X-Received: by 2002:a02:7789:: with SMTP id g131-v6mr4032545jac.66.1539333307241;
 Fri, 12 Oct 2018 01:35:07 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Oct 2018 10:34:55 +0200
Message-ID: <CACRpkdb-KP_m6+2oB9r-WbR9K3juC+EMjgktv7v-PS_OACie=w@mail.gmail.com>
Subject: [GIT PULL] GPIO fix for v4.19
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

here is a last minute GPIO fix for the v4.19 series.

This fixes GPIO IRQchip parent assignment on a lot
of GPIO drivers.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.19-4

for you to fetch changes up to 3e779a2e7f909015f21428b66834127496110b6d:

  gpio: Assign gpio_irq_chip::parents to non-stack pointer (2018-10-10
14:03:27 +0200)

----------------------------------------------------------------
GPIO fix for the v4.19 series:
- Fix up the interrupt parent for the irqdomains.

----------------------------------------------------------------
Stephen Boyd (1):
      gpio: Assign gpio_irq_chip::parents to non-stack pointer

 drivers/gpio/gpiolib.c      | 3 ++-
 include/linux/gpio/driver.h | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)
