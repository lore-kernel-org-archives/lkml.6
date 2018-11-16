Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B658C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DFE2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWwU1tgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DFE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeKQIF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:05:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45283 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKQIF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:05:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so21561997ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eebk3k+Ee2DLZhAqOBb58hXbNryPIbM2sxDCyBLxJN8=;
        b=AWwU1tgCl0neZigxAR3YW9DGiMcyoZfHX3toH/PI9mU9jpSONfofmZt06EjlI5fBb/
         Gv8q/iO4ewomeZ4saynqtHy2FGeRdkPLQoZaKiWbBTHxm0XSSEenuuWuEOh5YUgSpWMR
         UdYHMt8wxn6wdw0HHhx8ondiNW0brZWVRknNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eebk3k+Ee2DLZhAqOBb58hXbNryPIbM2sxDCyBLxJN8=;
        b=fyh/skM5x/i42FLbvousAmcxdmvu5f97fvZ2zUfpQT2W07WTlCZ2JzO0WfyNFjiDGI
         PO22U3BzHnP7/BP10w9lWz59sig+ydbGZ6hni8/pmNBsgKJT4koSU5PVzc1jus0Tnu8t
         Vna93Na0frb8yjZGdBx7jQKDuR1oNo8WVR5JTlTGBMDDLYSxFouM2LYCg9LXIiYAdA/T
         wmyf2JRAvsqJw05s61yKCVzW6mp4jWTYaB14KdTeIXHjItCxJgYrkHzX944fnJEfIvnq
         tz0NNZgSPJoKi0MkX4ajjM34EjnXUoCOQhuumxT7KdY5bGpOrcIMb3tG/ICpaSr0G4CO
         oCSA==
X-Gm-Message-State: AA+aEWbPbLzTT59HSAe4fh8hM+1twhQEaQiwMf/JhRpAGAoYxvgztiHu
        GoazXhWnVLuLRZkkA64uYfsBKPf2gc1W6hfXhsFSjg==
X-Google-Smtp-Source: AFSGD/VFKpSM358Tty/jBpcwUuLnYhNBpbqVAmTZTTQkOSycdlmW39iwqkAhPEzNyl8xzsA+0rtyMmaGU5Mv6Ecn0AM=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr2485062ljk.4.1542405080792;
 Fri, 16 Nov 2018 13:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20181113135051.15308-1-brgl@bgdev.pl>
In-Reply-To: <20181113135051.15308-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Nov 2018 22:51:08 +0100
Message-ID: <CACRpkda4aarCn=PHPSWfMgtOZhcGA2ifcA7_ujYgmj+do2+N+Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: davinci: fix ethernet support on da850-evm
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 2:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Ethernet doesn't work on da850-evm in legacy boot mode since v4.19. This
> series addresses two problems I've found. I guess with this kind of
> intrusive changes in the GPIO driver, other boards may be broken at the
> moment too.
>
> Bartosz Golaszewski (3):
>   ARM: davinci: define gpio interrupts as separate resources
>   gpio: davinci: restore a way to manually specify the GPIO base
>   ARM: davinci: fix da850-evm boot in legacy mode

I have some patches starting to move DaVinci over to using only
descriptor tables, but that's not somthing we can pull off overnight
so I guess we have to go for this solution.

Can we have ACKs from the DaVinci maintainers so I can merge
all three patches through the GPIO tree fixes? Else I'm fine
with merging through ARM SoC.

Yours,
Linus Walleij
