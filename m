Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ED3C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7892600A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joBffrgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7892600A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966032AbeF0RSR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:18:17 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35027 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754757AbeF0RSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:18:15 -0400
Received: by mail-vk0-f68.google.com with SMTP id o202-v6so1639763vko.2;
        Wed, 27 Jun 2018 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d3Jk3QDw6KBOTy7oEddkwpKST1XA4/y9zsq6HZ2fZvc=;
        b=joBffrgY4JbR+NtDX8gUfxP7coQuduDojRx0bbgmrUbN9I78NhAajjkiWFkVmjHn+O
         BOirWDhwQm7ieldsgFFUE2tdmIZqQ88wPMxUEkbjxR67RE2o2rY7EijHYiBFzpdwOHNl
         NUopRsQiE4ElrkNfJakCo3Wt3hBHxC8ifysrW5fuI+iaOBM4Snb4avJzmIINGfFmlEK5
         RC2UxZerZw4z2NbS0QvBVh5ph8rEGnwnMjvj2DS4FoNQ/kJk+fQpH3i2XSAsm7dDWcbH
         Zppp7P4u/wOfnoRKK+76MCnoYCxHZNiMvQ2tI+gNcauJofDl2WtqvhvuUBM/wDZY8+Fm
         VzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d3Jk3QDw6KBOTy7oEddkwpKST1XA4/y9zsq6HZ2fZvc=;
        b=k0+Hvfm9OkWscD1q6XLGA44lzcG69QgfFJQ+uPNcn0ZErmykPEqaxrjOKL2Qp9QiZk
         1s3OsA3bsKoX6AKh8on/zj60sJH+I6APkUVwzvSCLH5ZqT2MO4XH4DhHrqoxso5JHHqh
         0GW3PL+JgUqdhmnY0WzS3G0ma7LbWmslQCeTb705f08mfumBJXKevzP/Ya/w6F14BpwI
         oJyX50sJ6eVxBc+Le1roRlvwgSavOTakc3DURtfZ5jWGBvpfYgfIAQXjYGXb0/XQr6ZL
         zmeJ9Iheq949Mop4/+bsr1jCUayAth+CRxyqkH+oXjhW70p1oL1JrXn/WMBjY0OUcEnD
         vdtA==
X-Gm-Message-State: APt69E3nr7c0XFbF0r3e1IM7oQjud3aFKmeVpME/1Mm6PVomjbelCEby
        MQBwhVa36wdHUdAB2YfbUHf9ivaHLfgQB7+2rM8=
X-Google-Smtp-Source: AAOMgpcv5t+tDmuUrYhEhNXfCIRlL+S0ZWPN8EA5DHU8I0gnapZQtcZHXkOWRRamrj8bjdf6CxpOOF6+WFvJetKS2vg=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr4178045vkf.26.1530119894204;
 Wed, 27 Jun 2018 10:18:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 10:18:13
 -0700 (PDT)
In-Reply-To: <20180627114904.10890-1-paul@crapouillou.net>
References: <20180627114904.10890-1-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 20:18:13 +0300
Message-ID: <CAHp75Vc3QTYKp6oS6kW6EezsBbiLf9E=NBErHMbpxRU9EXMxWg@mail.gmail.com>
Subject: Re: [PATCH 0/5] pinctrl_gpio_get_direction & ingenic fixes
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 2:48 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Hi Linus,
>
> Here's a set of (rather RFC) patches, to implement
> pinctrl_gpio_get_direction(). I did that, because my gpio-ingenic driver
> calls pinctrl_gpio_set_direction() within its gpio_chip's .set_direction
> callback, but there was no corresponding function to implement the
> .get_direction callback. If that's not the right way to do it, please
> advise.
>
> If not merging the whole series, patch [3/5] is a real fix that should
> go through.
>
> Note that it doesn't make checkpatch.pl happy, I wasn't sure whether I
> should try to comply to checkpatch.pl or match the coding style in the
> pinctrl subsystem, I chose the latter.

I dunno what Linus would going to say about this, but I would like to
see a schematics for this piece of IP.
Even if GPIO and pin muxing has only one set of buffers to indicate
input or output (same registers in use) it's a GPIO driver business to
get direction from GPIO part of IP.

Looking into the existing code I would rather say that
pinctrl-ingenic.c should incorporate gpio-ingenic.c as they are
(partially) sharing same registers.
To ->get_direction() implementation it's pretty straight forward, just
read necessary registers in the gpio-ingenic.c directly. No need to
have pin control or pin muxing to be involved.

-- 
With Best Regards,
Andy Shevchenko
