Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22731C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3144222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391937AbfBNILZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:11:25 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43966 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBNILZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:11:25 -0500
Received: by mail-vs1-f65.google.com with SMTP id i15so505500vsd.10;
        Thu, 14 Feb 2019 00:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4a3D100K5NwmmTPJJ0s35hte8UB4taiTrnr7PheOHpw=;
        b=Tfr1b5Agkh3rGXa+k0Qpu8DPBrWzY0hQKQ1RvSoHbtN8KQVcn0XF9pGGjYbrYNMVZI
         jsT7apHwmQ9rzuWMeGjLzQuIWpxxmSTATz5kgYJ24qi4iIZhJt1R4wQsc8JkLv0Sa478
         3dR6nIyMhfbFqvnkQbbQYvUO8sUNde19eBpGAiYi8OCQqVhp3WBjycbdixWFzVGnuClZ
         QmaqTGon7/0xtBnOOQtrpsPljqx65Fjm5ju6q2Bzzm1mWxB85p2YLv1tCmi0qfrr6FML
         RL7vRD9uWjvzAdXmJAqc0gfsGuQCkDQlOXprG8HYLOstex8ZZ3etOV89GDrpWVr3guZG
         RL1Q==
X-Gm-Message-State: AHQUAua/itWYbL9ihpUniLYO8XVUSwmOzKGx8dYEaN38KroRr8QYt65n
        /WphStgKU3PEDshnZEOSQW/xmDsCazyzH4AsdBiiDYS2
X-Google-Smtp-Source: AHgI3IbxtQI24QYjPRnNrEhWZ+8rGpNy2/UZnWXN5HqiJOduvEND65+eZoiExYXcsXnh4oeImmJLyQnV8CZhtYrIpSc=
X-Received: by 2002:a67:541:: with SMTP id 62mr1260865vsf.11.1550131883912;
 Thu, 14 Feb 2019 00:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-8-hch@lst.de>
In-Reply-To: <20190213174005.28785-8-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Feb 2019 09:11:12 +0100
Message-ID: <CAMuHMdWDBaz1hLxmeGa7k3mzt-8GAoGVEQVSfeVX2CCpqrY-KA@mail.gmail.com>
Subject: Re: [PATCH 07/11] init: consolidate the GENERIC_CALIBRATE_DELAY symbol
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 3:25 AM Christoph Hellwig <hch@lst.de> wrote:
> Add one definition to init/Kconfig and let the architectures select it
> if supported.  The only complication is xtensa, where it is a user
> visible option - we introduce a xtensa-specific symbol instead to work
> around this.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       | 5 +----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
