Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3FAC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC5C21A52
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSw05l9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC5C21A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbeHGCoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:44:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33086 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbeHGCoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:44:02 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so13848888itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 17:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=N8+sNy05ycg9c2PeJx0NTstMC0emdQUf3EpwdrhV3Ig=;
        b=WSw05l9YX/qpNHUTUq9xzvjsjE9NOAggLGNfI2fY1opwUq56y+dSyi92wOh+7o201W
         UH41NnTyHqToR+Wpdpu5gE3Q/3qI9GN+irqtOsOoiiucJ65G8LJv6Yrja4quRSeqba/A
         LPV9QakQoB87tzIU9JMwYY2ITs5wYkkpxy8yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=N8+sNy05ycg9c2PeJx0NTstMC0emdQUf3EpwdrhV3Ig=;
        b=Wd1o0JWayt7Z10ec7dWFS9MHhm28PrEZGrvsUXTA+BKrWyREualPQTABvrv8HpKrjZ
         oNoMMdN0y9PoJI8XK4lPaTcCAhKhOwa0S0sMLDDqeO9wKSyUBcvjIwrEPWjMVAAD2Jp3
         bGzlY5na9LnzDB5s+LCyna+amqnF0h2sD4caEKPpObvDuUwx70KZB7/x4O9E+6Z0SsLg
         Q1mS/+WyINbzVF0O1Ag6oq4a0ZNJycEnAiJu726gMWJYIbQjrcjS/QX73NqVSr2R2nN+
         9kxhuaFz0ptimTJkqWknqlYY52yDzg3CpAyA25M0yLDSq5ecfBUbgs1ZKVVo08jfgPLx
         ONiQ==
X-Gm-Message-State: AOUpUlGEhRfX+1PBYSh1g4xiXlsCHB/Bh22WcM6AH9psAmX+2Szc4EH9
        Kco3UGpA/f4GGX/DPDeyJ7FeTwPTfpMcE0kvcolS6g==
X-Google-Smtp-Source: AA+uWPxPHhRqmNzVxZJ2o27eaLiRPu0SGLgaFT5ulJ6cAbsFWXvQUJF6B7SfZudf6xa1K5Nzhn4DFVp3WXQmN+mphxk=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr198172iti.135.1533601944365;
 Mon, 06 Aug 2018 17:32:24 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Aug 2018 02:32:11 +0200
Message-ID: <CACRpkdZrG-bVA5LC1FMbdzOTotU0BmZkkb7wZAesN+b7GHzv5A@mail.gmail.com>
Subject: [GIT PULL] GPIO fix for v4.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

a single ACPI GPIO thingie that is standing out.

Please pull it in! Description in the commit log.

Yours,
Linus Walleij

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.18-3

for you to fetch changes up to ca876c7483b697b498868b1f575997191b077885:

  gpiolib-acpi: make sure we trigger edge events at least once on boot
(2018-08-01 11:45:10 +0200)

----------------------------------------------------------------
GPIO fixes for v4.18:

This is a single fix affecting X86 ACPI, and as such pretty important.
It is going to stable as well and have all the high-notch x86 platform
developers agreeing on it.

----------------------------------------------------------------
Benjamin Tissoires (1):
      gpiolib-acpi: make sure we trigger edge events at least once on boot

 drivers/gpio/gpiolib-acpi.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)
