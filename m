Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D2DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF31208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="em7GBryb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF31208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeGPJBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:01:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54897 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeGPJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:01:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so3939522wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vjZNvz3xtHFkb8CwzN3Geicikme0JpKGQRcHKtjh3eE=;
        b=em7GBrybQCPxRXv5ZepM9y6vcOpJEq8yUBWjHkdvyUK50bT8Vz96i9O7s7+8EuJsBi
         JSgc8WVVBTc4al/DGl086nDpsoSa6HlS0j4qc9kE7DDWebsyBrbmaoJJZaGxvQpSiDOh
         aNG8poAWaMxq9gwx6fbV5Q1AfE762+nUDLmNCHOV+i+8dcF8Dhpi8gJvwUBp4W9RK7vM
         veGOKcqBx7cnb5Fm41VdVPLEjkBXjio2iddMqvvR7Z18lT23HKeZgliqKs+4LnueY1Rk
         O2Gd34RxEUbiZVFvNTpX0aGOPik/jU/ZvcE18fQJM0VfyqYVC/TqIMjW7A9dkZY/akAo
         t1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vjZNvz3xtHFkb8CwzN3Geicikme0JpKGQRcHKtjh3eE=;
        b=Ro7ggsXsOSGceuLKjE9X75sC+4kViewWtnSWRynqfP2S7ndwf4OLUcnTqpjYO4JYqA
         CcL0mfD8doMlTIrOE8V7GBsgMUKoPol4d0pxD97RYMJMwnRbk4yBiGONIhWz+wK6IWTN
         8v3vaQss+DoU7m0xT6Cgq1dO5ANH9LvzhaFQ+XZAavfxO/YQWd9Lc0VyVbKOgiAwfV5b
         3AJF3YNux8gKLineBq9AfXUgLzS8mL8tauuEfpYBxaGa7+Z2VynwHn0Ir9Cv+c96Gkh2
         eZHhTB4IkbxF1+EXmX/4D/+k5W5Nld0K+uU0q5bV1de2D8uJgOxZ9zyfH2udHPf9sFg/
         ewaw==
X-Gm-Message-State: AOUpUlG8hSEHF3OcXpJAemmeH54ddyN9mtEe5N7KYIWNSHYw930Z+/tw
        aTkdhS97RfeqwPymzTDaF/lQkIVGitE=
X-Google-Smtp-Source: AAOMgpeTsmIk1Pj+Ch6Lhys2Ey0Nr0/4u/LxvIfYSlAl5QDqyB1DBu0g8EQJugy564ZhOtXWVqM7fA==
X-Received: by 2002:a1c:dcf:: with SMTP id 198-v6mr9367267wmn.131.1531730083114;
        Mon, 16 Jul 2018 01:34:43 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id z3-v6sm29483104wru.27.2018.07.16.01.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 01:34:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] gpiolib: linehandle_ioctl() tweaks
Date:   Mon, 16 Jul 2018 10:34:22 +0200
Message-Id: <20180716083424.11157-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that - unlike sysfs - it's possible to set values of input
lines from user space using the character device. There's actually
even a TODO in the linehandle_ioctl() code.

This is not correct so the first patches fixes that and the second
removes a TODO that's not really needed.

Bartosz Golaszewski (2):
  gpiolib: don't allow userspace to set values of input lines
  gpiolib: remove an unneccessary TODO

 drivers/gpio/gpiolib.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.17.1

