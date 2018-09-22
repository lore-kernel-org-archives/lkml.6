Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9906CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561E22150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561E22150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbeIVTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:48:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45736 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbeIVTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:48:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id p52-v6so12852945eda.12;
        Sat, 22 Sep 2018 06:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnKNBPkOmwn2+Nw8zSMgPknBNJi4vlhvIYz/bUWhg4U=;
        b=DnM9Yz6fFxhph/tXUjPrtOAUDmTzCCT0PGc0eLO1mQTjNo62SG0KGqEpoebn+45usP
         pb+ngsxNaBsJCrCpZExeQOEZjvszP34B/jtA6wmwxM/cJoo/EsCh/3R41cZ2DCyInf6J
         LvMC+7+OLirbagmcnONUbBduDFxczTRTjc/8p8lU25FeSEvJFz3c6Rvmkjr7qI06n4Li
         yl8qfNtgweXkMaoZ2QxgUcs5qSyHuETyFVD7uaajqwMU/p900PKqTFQE78R3MGMdfhg+
         atx8MNCMR4ZifePft52SnIp7vg0+Ndgzrc+RzaTlbctvwjWGQsdV7Eu0hCumyn3z2u5Z
         T0iw==
X-Gm-Message-State: APzg51BCTfuprrmFYMkXSqv08Ufp9yh9f+ZCvq2zyvqIugKjGfPrORmb
        Lf+Ay9Eyv8G2eRSc8L53RlhzwmApozk=
X-Google-Smtp-Source: ACcGV63AdYYDlFe1DaAzhE0NZgtZLyKZcnDwQF8RmKlYh7aZYl4YjalmZ+7+ZDZ67zWXfKJ4t/ZWqg==
X-Received: by 2002:aa7:c708:: with SMTP id i8-v6mr3981100edq.231.1537624510607;
        Sat, 22 Sep 2018 06:55:10 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id e30-v6sm3130038ede.91.2018.09.22.06.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 06:55:09 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id t15so7521528wrx.1;
        Sat, 22 Sep 2018 06:55:09 -0700 (PDT)
X-Received: by 2002:adf:8485:: with SMTP id 5-v6mr2079405wrg.34.1537624508741;
 Sat, 22 Sep 2018 06:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-15-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-15-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Sep 2018 21:54:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v679T6eqUcgRtR0Tw6Njq4GupCAmHhvq=K1EAGYkryWYyQ@mail.gmail.com>
Message-ID: <CAGb2v679T6eqUcgRtR0Tw6Njq4GupCAmHhvq=K1EAGYkryWYyQ@mail.gmail.com>
Subject: Re: [PATCH 14/27] drm/bridge/synopsys: dw-hdmi: Enable workaround for v2.12a
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> It turns out that even new DW HDMI controllers exhibits same mangenta

magenta?

Otherwise, FWIW,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> line issues as older versions.
>
> Enable workaround for v2.12a.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5971976284bf..df1c7a2d6961 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1664,6 +1664,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>         case 0x131a:
>         case 0x132a:
>         case 0x201a:
> +       case 0x212a:
>                 count = 1;
>                 break;
>         default:
> --
> 2.18.0
>
