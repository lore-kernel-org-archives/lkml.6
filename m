Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B7D06C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C96820864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C96820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755762AbeFOGJ3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:09:29 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34103 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755590AbeFOGJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:09:27 -0400
Received: by mail-vk0-f68.google.com with SMTP id q135-v6so5083642vkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 23:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rllti0XiTmnQxleIYjevmoXg8xbDDGuDB7X+CIEp0LI=;
        b=j5ikV8ahmMm/DKtfiYTpGtvnIL9obh4oMeTwKmIH5h+FIqkr4VgM7eAOqkKibbxnKS
         XwXdkWG8SCVp5JjdXp9ammsix3MFQm8KSxVdJoYG3bJ9/KQQ+R4NNJwDkhZsf7iUhfuJ
         jOB8qK6ygXkJQ/M+KO0VXHi2QUIe69VIRj+9nrWX1O0yBv9XxQ/QKIU/jyGZSITbzcKr
         unjo7J4r52vQ/touPLz1eydeFqpfCHjTKp2r8XPQy/8qA6P4SjP9F3svuW8Q6VTme4iQ
         kQmanRSXtTS597bhA8RED3VNdNI8QN6FHPta+zRClJ4rI0+wzAiJDq3z4Ab24HqUTpbH
         dRIg==
X-Gm-Message-State: APt69E2RpB3ivGFy1/lGBG+RHC1pXfwM+Fl0fZ1ez+zjM4IsttvtX9TT
        QPcXzeLIYFeqYCUj2xsU4hdo62UcWo53a3cu80w=
X-Google-Smtp-Source: ADUXVKKjoFIuRDSldqzKDDewDqIhe9JKPJU6szKj7bU/4zTFvpBX2vqxP/g9AKGzjTd1g9WzBBwsNqaQqk6i0XBC2Zw=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13-v6mr175971vks.106.1529042966786;
 Thu, 14 Jun 2018 23:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org> <1529016629-2948-2-git-send-email-daniel.diaz@linaro.org>
In-Reply-To: <1529016629-2948-2-git-send-email-daniel.diaz@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Jun 2018 08:09:14 +0200
Message-ID: <CAMuHMdXp-Sh6pUNsWHk9UaYLbb4uLoeFoSPrBXm-sYDS-ptHiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: multi_v7_defconfig: Enable KSM.
To:     daniel.diaz@linaro.org
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        anders.roxell@linaro.org, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Stefan Agner <stefan@agner.ch>,
        ext Tony Lindgren <tony@atomide.com>,
        Eric Anholt <eric@anholt.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        martin.blumenstingl@googlemail.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thanks for your patch!

On Fri, Jun 15, 2018 at 12:52 AM Daniel Díaz <daniel.diaz@linaro.org> wrote:
> As per the documentation, Kernel Samepage Merging (available
> since 2.6.32) is a memory-saving de-duplication feature,
> enabled by CONFIG_KSM=y and activated via sysfs. More
> information can be found here:
>   https://www.kernel.org/doc/Documentation/vm/ksm.txt
>
> When enabled in the kernel, the default is to not do anything
> at all, until it is activated at run-time with:
>   echo 1 > /sys/kernel/mm/ksm/run

So that's the "what" part.

Why is it good to have this in multi_v7_defconfig, which is meant to ease
(compile)testing for as many supported ARM v7 SoCs as possible?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
