Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9520CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B952087A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B952087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbeKMUZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:25:42 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36717 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbeKMUZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:25:42 -0500
Received: by mail-vs1-f65.google.com with SMTP id v205so6939667vsc.3;
        Tue, 13 Nov 2018 02:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gm90P80lm21OUhAaOlYVYX7kEgQM5p6pBd5WinKUikI=;
        b=HV5Mof49bX46bUWp0bqnptZHdxMWiUxguA0n5n67XM04uzWvtNUP3+z3qvsVtV1V3L
         Are+fh5/yiFhinUI+Lgbz02Ob0CswdAxfvEsxmxGqxZub6J+TRvoUs2wycpMaSQNBIqW
         dsJrLLvmXGZ0jl4nyphWp9adsuYPM+kAQtY/syWPZ+WlaZJEFALZMqCvimTjUQmVzn+W
         qo2TA3bx4UOoOz48b9MY+GXnXavx46m1TF6TeVYpEIrn+Lon8g9lh3LDyy/2+LbvtaPA
         7MeE1F+l+/SarmEu4hhpitZwoCxoF7PufmoJqhPCB+wFv21ARMP4Yw4aaT+vHLUy0r+y
         sg+g==
X-Gm-Message-State: AGRZ1gILl5Pm7pSta36BxUwB4yp1QTtzD2UHQJk0ii1SGwGkR16ymeVi
        ftQtKUEV2/r5w2yX5hr6N5gx3RQeSy5LFb4oQqw=
X-Google-Smtp-Source: AJdET5dPcT/70u4ywgd6EoIJxNUx5Jcrv0xej0cBegdfRqrdMOlep552jLtr2i1IgDk415gbsCwvanpx3RfHhHKSy+E=
X-Received: by 2002:a67:c202:: with SMTP id i2mr1845743vsj.11.1542104893926;
 Tue, 13 Nov 2018 02:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20181113102228.820214-1-lkundrak@v3.sk> <20181113102228.820214-2-lkundrak@v3.sk>
In-Reply-To: <20181113102228.820214-2-lkundrak@v3.sk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Nov 2018 11:28:01 +0100
Message-ID: <CAMuHMdW6+LLM+Xf8cqgGcz5a3GZQDTba2bXS=qCC5eu2uwFEHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] spi: pxa2xx: dt-bindings: Add spi-slave property
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, quozl@laptop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:23 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> This is used to indicate that the chip attached to this controller is a SPI
> master.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
