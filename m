Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 13A8FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3F5208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbwUQ1XJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3F5208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754814AbeFNI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:29:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46854 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752882AbeFNI3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:29:11 -0400
Received: by mail-io0-f195.google.com with SMTP id d22-v6so6286283iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cX5hvQEFl75EGRnDmWxetM3r9T1D2CwJU9Hie/gwRkc=;
        b=hbwUQ1XJ6a3kZXLv3qDyZxjAhWPMDIaJncVKgiM4eZcA0ZACpIPBXuV1KndMGAlmjH
         ImlPCJQxWceI0MC7AW4onT1MpfYxUjxqa3pshRARzS+qMjFzGy9qLcqilkCVRH9ULSue
         59XSVOIPMbN1LOG2zvXzeRDXrYmqAt5V1rPLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cX5hvQEFl75EGRnDmWxetM3r9T1D2CwJU9Hie/gwRkc=;
        b=Uf6nCqcahgdRNl8ZBRjmpvsunKiveEuz5PvRm9bsCzt/BkDfdYRZnwZuz3I4qq8L6h
         zk+zEGfl0Y1nXC6apn99w1nwclDZBfiH/8Jtr196zkm0or6SR1u8ePU7mqCLGOp6fWih
         SV1Wlo0difsQIsrDwgJ0aik5rKZ1xPegKTAR/oN2BU+L6YWr1XrSGucNtEkAxxlyS559
         KESAb+HwVCSMVaJEzun3SqGY/pbEml+o7MlTKZmr4jgxQb/VPK70V8VYuGqACjV6yh8T
         MZ2GeO1nIxa31il6SI2TqhDhiV/PwvdXV/mc2At45OdKHWefzCuHl6gaHFs0+CjliK0p
         L2JQ==
X-Gm-Message-State: APt69E1IfOSpGZ3eyiFXNEG/fdVA/HorZlghPgIj9wlOxwJJ4WYT2KBG
        2Ec6Ch2b2+5zOM5YzF1L8grXTPty3a23QDE5XwbKkw==
X-Google-Smtp-Source: ADUXVKLr+MBXmZzHd/oR2ctwbOOaup2eLrCcLpJXoU1YAi4Jgm41veUpfZPkohj/3T4edovpWzXt/9N+dEbGBFqyXvo=
X-Received: by 2002:a6b:106:: with SMTP id 6-v6mr1418246iob.175.1528964950831;
 Thu, 14 Jun 2018 01:29:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 01:29:09
 -0700 (PDT)
In-Reply-To: <1528276734-1483-2-git-send-email-j-keerthy@ti.com>
References: <1528276734-1483-1-git-send-email-j-keerthy@ti.com> <1528276734-1483-2-git-send-email-j-keerthy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 10:29:09 +0200
Message-ID: <CACRpkdbFyZwG4S9t3ts3wmVWioadd7NjpdMUkq-wujH=g68zvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: davinci: Do not assume continuous IRQ numbering
To:     Keerthy <j-keerthy@ti.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 11:18 AM, Keerthy <j-keerthy@ti.com> wrote:

> Currently the driver assumes that the interrupts are continuous
> and does platform_get_irq only once and assumes the rest are continuous,
> instead call platform_get_irq for all the interrupts and store them
> in an array for later use.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Hm! Thierry has recently submitted patches to make it easier for chips with
banked IRQs to use the GPIOLIB_IRQCHIP.

Please look at the code in gpio/gpio-tegra186.c and see if you can use
his approach.

As you can see this chip is using gpiochip_irq_map/unmap in its
domain, and manipulates struct gpio_irq_chip directly.

I think the idea is to make it possible to use GPIOLIB_IRQCHIP
for banked IRQs but the infrastructure is not yet inside the gpiolib
so it is a bit taped on the side right now.

Yours,
Linus Walleij
