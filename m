Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDC6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6FF22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6FF22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbeKMU1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:27:07 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33821 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbeKMU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:27:06 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so6960633vsi.1;
        Tue, 13 Nov 2018 02:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CquzHrxqU1PmcSG+K5U+nSegT+7crl7xbuOzYfsLOEY=;
        b=K8xHEk/5gRxGUiVELkkqVaMzJZjEwmfAx1X3FBNN2yLxZymdzcE5F/zAOdbSWn7Djz
         eRutPAVGTpzBxevj2lmfdmOHtarFWHrTKm4KxkE9oae4/EP208nam86TGGEghRsiriwt
         t/8GO+ezDNRQ2D9FG72RKly40Kad+FLdOJOd0hAt1re1FrCQ2QTutfR7V6g6OA/lTXfc
         QxPovy6JgI2L17pPhve1iU5lz7y9/yX+SX8Px7Pwx0Hsz+lXlfnBiRP7jyOrk+PXjHFX
         jgb67hntLJWjnl9UHRPn0YAbttjiNx+8KR+6DtGnsKl2AeCUUFTUos2OxIDVRlKzS361
         O2bQ==
X-Gm-Message-State: AGRZ1gLwbv7TSRgXUW8f1rBl/FXHHrAXXNDzcHj2Kl6iDdWotx5qIVHI
        YMSgsgeutYn5vrQUfHpVacJZvu4JK4MQY5ZqPQc=
X-Google-Smtp-Source: AJdET5cvep1TbzMZ/xinMPJ2WQ9GWB7OwnxC4FrX3axKPV3tusxrzxppjyF2FAPW2+2gGMfXWzxNiqpPOWPDT2hATWk=
X-Received: by 2002:a67:d119:: with SMTP id u25mr1911376vsi.63.1542104977758;
 Tue, 13 Nov 2018 02:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20181113102228.820214-1-lkundrak@v3.sk> <20181113102228.820214-5-lkundrak@v3.sk>
In-Reply-To: <20181113102228.820214-5-lkundrak@v3.sk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Nov 2018 11:29:25 +0100
Message-ID: <CAMuHMdU2hJ_htC19jpno_khGombxn-KK+kdQjVMOuJrZWVXV5A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] spi: pxa2xx: dt-bindings: Add ready GPIO signal
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
> This this is used to let the SPI master know that our FIFO is filled and
> we're ready to service a transfer. Only useful in slave mode.
>
> A signal like this is used by an embedded controller on a OLPC XO 1.75
> machine, that happens to be a SPI master.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
