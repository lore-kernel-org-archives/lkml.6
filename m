Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF863C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5A020870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuOK6LVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5A020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeLLIuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:50:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35037 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLIuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:50:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so12900898lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 00:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ezd9AdbM0cDcnlFSczPIL9Nsf/QbZtgN9hviCM+1Wo=;
        b=BuOK6LVZtAnYFxscbvh85Z1WDsUYlCHnsGvuq/g9wrzzV53saozwleFKo5Xlg/3BuV
         Qr5h3ktTnDaG0bj+3AooIuS2c9FnFxwvSfV1QrvskDnXQduNc+CZPCGgPjv4u3c612qB
         DWJxB5bZg6BYKGZmGL3y0QpRIIG/ZbDyyWiIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ezd9AdbM0cDcnlFSczPIL9Nsf/QbZtgN9hviCM+1Wo=;
        b=KUWjyVCjsMX66hnDVCzKci+vqjMrFEe3KbpodmxzJlv8Xk1Mzdu4qJR+2tHPticokW
         7E8vY0JH5iHij/21wzz4Tq9TNgj9FLmeix3I7XDMXlCQMFMA4xtdX7j3tkALpdU/JWZy
         p9t7OSLJGhD6TA76brqN7zHc93T8zvg/js6AWZWAu3SBNKbz7MU5PDe6feHx3lflO1XH
         Sv8GBZyp95qwtexMaLO1XkFFeK/2gRlcFfAuKz3GxwesNx+/+US0j03Jz7JiZem7LFR5
         +X9qpxR2vXOHc+kuOEQl+40nj8pAj6UzV6H68ZBprQxcPli8IHxo90H2FokLEQFQ6RnY
         L2Gg==
X-Gm-Message-State: AA+aEWYqCf35g4EamxiGiv4kuVEmbTnFmez/1A5bql2Z8+f/C2SBBVn4
        QQ1MArVdL8dv6taRJnVMRLAki8ofDtTgXsIKz3KlZg==
X-Google-Smtp-Source: AFSGD/UxZOszDS1BzgOQtbQwqeCt7pcYUeCbozWeSiMuZIEDgsJPZZKVRirERfCCOoIwPqPD6qvXnXhWY+Hq5FKOc3s=
X-Received: by 2002:a19:5154:: with SMTP id f81mr11888381lfb.96.1544604604903;
 Wed, 12 Dec 2018 00:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20181211212428.28327-1-linus.walleij@linaro.org>
 <20181211212428.28327-3-linus.walleij@linaro.org> <CAMuHMdWSTXsW8u9vwd8+G5Dy8fFNNiagHzWs4xyWO5TL9Y5Qxw@mail.gmail.com>
In-Reply-To: <CAMuHMdWSTXsW8u9vwd8+G5Dy8fFNNiagHzWs4xyWO5TL9Y5Qxw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Dec 2018 09:49:52 +0100
Message-ID: <CACRpkdas+Y3e7z_z49LBSL=gF7aRCYDP6TMaMetW-WqEcbqUXg@mail.gmail.com>
Subject: Re: [PATCH 2/5 v8] regulator: fixed/gpio: Pull inversion/OD into gpiolib
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        ext Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Paul Parsons <lost.distance@yahoo.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:12 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> CC Jacopo, who has an Ecovec24

Thanks Geert, Ecovec24 has the biggest boardfile (setup.c) of all the
Super-H boards, so I suppose it is simply the best supported board,
meaning if stuff works on Ecovec24 it is more likely to work with the
rest as well.

Yours,
Linus Walleij
