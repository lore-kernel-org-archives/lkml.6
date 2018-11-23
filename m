Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9B7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4E920672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4E920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394663AbeKWWuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:50:15 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33462 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388295AbeKWWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:50:15 -0500
Received: by mail-ua1-f65.google.com with SMTP id t8so4036701uap.0;
        Fri, 23 Nov 2018 04:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtjuxidprlDLVOls/eZ8OMHERPfgrBk7C0ZztidCI9E=;
        b=U5iC95OaL/G8KpmPpAHVJZlMGfkLIsSe/4ebE5c4qI0lchhkAyDG6Z3PL8UzckNcX0
         kD6b2asqzINb1p0PrkMsWyvU5OaTXSIBfxMtl6pu7aKE/6asY+nPgaQBFb++Xiqbb/lc
         AdYa1Dt7K1BeOeILk/2Hmvhmi6Qtni284JS+x66q6XSg9oRtVVgn0P/24dxvRUBghAN1
         UVsshA+hbQB12pg/3IyuWYBDR+i51Lj61+ZvpTXz46X7tyyrITryH23LokSzACdtiVb2
         cITmQzAhiKfgdzegxe1tKijWiFRCbtxCZrgmTTaVLApLvbmMNmm4wnbwUPjsBj/XyEHn
         p2cw==
X-Gm-Message-State: AA+aEWYslEDsioSoyrNlgNljyIW1fjhxdDtaRtYW1pZV3nRY8B9i6WBp
        RJjdTKkseP4sKGHQQsDhh4pPUgyXlhCvyYEpK5c=
X-Google-Smtp-Source: AFSGD/VL6Wmx8pY8XWcHu8lRHF2OcpNrZtRgInh8jkkoBty28dK9+IO7uituDFNQL6Mg5rzOTUFqz44mK1E6EczMEEQ=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr6634282uap.0.1542974776542;
 Fri, 23 Nov 2018 04:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20181123105428.13457-1-phil.edworthy@renesas.com> <20181123105428.13457-2-phil.edworthy@renesas.com>
In-Reply-To: <20181123105428.13457-2-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Nov 2018 13:06:02 +0100
Message-ID: <CAMuHMdW8_1cuLNyUFVVfdydbRmiqY6F+-Qfj9XEX3enz4-z00A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rzn1: Fix of_get_child_count() error check
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:54 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> If we assign the result of of_get_child_count() to an unsigned int,
> the code will not detect any errors. Therefore assign it to an int
> instead.

Note that currently of_get_child_count() never returns a negative
error code. But it does return int, not unsigned int.

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in sh-pfc-for-v4.21.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
