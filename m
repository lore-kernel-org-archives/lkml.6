Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E6CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E44A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K/l/QbIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E44A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967116AbeFSREG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:04:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33638 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966695AbeFSREC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:04:02 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so175825pfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=AgMpSZNQFROjN7nLuFbFWsI7QnfBHozTZoIIdjqW78Y=;
        b=K/l/QbIPax4SQnwOpSU93mivcacPSnicyoHUdlv5LHFz7/f6qX6u+rGJwppUYkvEwk
         WGuls7JNLSQwgPHuvlXFlJ3X26cAq0M98lgUw0O47L/S3SDrLESJWVf8ec7oHZ2II7Jn
         ieRGjLcag80nJhDW+PvWYbqEmQq8bsjNVZnv2a6YQ+iqtRiFEnqpGKUpc2RH5BKdi83p
         gXIA7HbmuyMEaRq5LkbPVzW4hLNqMaOiBR6/jSxvl5KHo8/bJO4jLZRkSGUAqT7mj4NX
         6qQND+NcJuJkxck8E5Xor96hWBcTXOQIGir3q6ISdLW7e6hYxcJwLP+maPH7k2JViAE9
         QwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=AgMpSZNQFROjN7nLuFbFWsI7QnfBHozTZoIIdjqW78Y=;
        b=YTbj+QQDK2GfwIRx+lTMbVGS7qZ6k5wkXwd1ZBuH/U73fJfgFH+QA5PgW3DLq3rZib
         znV3oYGx2F5+h5zxDzuUduVRQDSgvFLco+Ils6rS/16e113fpmjKI08a4Sm5eVosK8ZV
         eDW0npy/d4o6XHguf1t3sJ0fZuqTsKkc5IxcecCAil3CXYJxdnhCyGMIWbxN7WPauTlz
         TYBtjK0tx2akCSA2BOE7r4gx1Ph3Yyba81x3Kv2wiki9Jawa/EZiz1dmIf3+Rw6aSVat
         FaEUY2nkThakqrc1sMebWoAFaQvhLubZV6itXaBiu9BnjCHM78k8lSA2PnCX4Z6Lbdwd
         em/g==
X-Gm-Message-State: APt69E2bRt5y2+rwxdZ0TqCaLWU/ycV95+aKQsHWrsyQdFFD9TaFSCXx
        89axpQJgXB97LOwI3eA7NlMo/g==
X-Google-Smtp-Source: ADUXVKK946HjrpkL3ZwUHVxWZr+oF7MB2K8UbPi5sv86Ks7Yd6WGpcQuxLDZkeUuQboNP/sOIp3Txw==
X-Received: by 2002:a62:d345:: with SMTP id q66-v6mr18945239pfg.158.1529427841736;
        Tue, 19 Jun 2018 10:04:01 -0700 (PDT)
Received: from localhost ([2605:e000:151d:96f:170:3319:9294:4203])
        by smtp.gmail.com with ESMTPSA id r3-v6sm240992pfl.162.2018.06.19.10.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:04:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20180619134051.16726-3-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
References: <20180619134051.16726-1-jbrunet@baylibre.com>
 <20180619134051.16726-3-jbrunet@baylibre.com>
Message-ID: <20180619170358.33232.26576@harbor.lan>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: fix CLK_SET_RATE_GATE with clock rate protection
Date:   Tue, 19 Jun 2018 10:03:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-06-19 06:40:51)
> CLK_SET_RATE_GATE should prevent any operation which may result in a rate
> change or glitch while the clock is prepared/enabled.
> =

> IOW, the following sequence is not allowed anymore with CLK_SET_RATE_GATE:
> * clk_get()
> * clk_prepare_enable()
> * clk_get_rate()
> * clk_set_rate()
> =

> At the moment this is enforced on the leaf clock of the operation, not
> along the tree. This problematic because, if a PLL has the CLK_RATE_GATE,
> it won't be enforced if the clk_set_rate() is called on its child clocks.
> =

> Using clock rate protection, we can now enforce CLK_SET_RATE_GATE along t=
he
> clock tree
> =

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to clk-core-set-rate-gate.

Thanks,
Mike

> ---
>  drivers/clk/clk.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9760b526ca31..97c09243fb21 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -691,6 +691,9 @@ static void clk_core_unprepare(struct clk_core *core)
>             "Unpreparing critical %s\n", core->name))
>                 return;
>  =

> +       if (core->flags & CLK_SET_RATE_GATE)
> +               clk_core_rate_unprotect(core);
> +
>         if (--core->prepare_count > 0)
>                 return;
>  =

> @@ -765,6 +768,16 @@ static int clk_core_prepare(struct clk_core *core)
>  =

>         core->prepare_count++;
>  =

> +       /*
> +        * CLK_SET_RATE_GATE is a special case of clock protection
> +        * Instead of a consumer claiming exclusive rate control, it is
> +        * actually the provider which prevents any consumer from making =
any
> +        * operation which could result in a rate change or rate glitch w=
hile
> +        * the clock is prepared.
> +        */
> +       if (core->flags & CLK_SET_RATE_GATE)
> +               clk_core_rate_protect(core);
> +
>         return 0;
>  unprepare:
>         clk_core_unprepare(core->parent);
> @@ -1888,9 +1901,6 @@ static int clk_core_set_rate_nolock(struct clk_core=
 *core,
>         if (clk_core_rate_is_protected(core))
>                 return -EBUSY;
>  =

> -       if ((core->flags & CLK_SET_RATE_GATE) && core->prepare_count)
> -               return -EBUSY;
> -
>         /* calculate new rates and get the topmost changed clock */
>         top =3D clk_calc_new_rates(core, req_rate);
>         if (!top)
> -- =

> 2.14.3
>=20
