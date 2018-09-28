Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2771CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA0D2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNVx8NBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA0D2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeI2EUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbeI2EUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:20:35 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00DA20836;
        Fri, 28 Sep 2018 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538171692;
        bh=wO/7NnPHt29CtHkNpoflZzOeviI6n11wsKWSgUyBE1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TNVx8NBFFNO1IpwBDdnfHqaiLReVAnWqDi3KjTwKyCQ2nyAWdGjnYTth3Yakgso5z
         CaGzlARE8lnHLUBiAKTyYv7hpeLOis9BkKR7+F9S6pP3nfWPKqHOUqDoav55IUbjO+
         ejOgaNv6OaCHakSa3auHPqUO/RMmQL/xzDdp0a2k=
Received: by mail-qk1-f177.google.com with SMTP id a85-v6so4820793qkg.3;
        Fri, 28 Sep 2018 14:54:52 -0700 (PDT)
X-Gm-Message-State: ABuFfohc3v10YsQH5pxPZY9ojkV9uR+WfKvQuwOftMRnbQi4Pooa1FMW
        LccAk/PqGZe5VMd+QpfWrTiCauLEQhPwR1qz2A==
X-Google-Smtp-Source: ACcGV611aTjDKXfr7rdyMO7+dcCJ7qzLQSHmw3FOQIL5RNjBJjeqgsk8VZZGXW05lZiHFOmG4peRNRdCHdF6wZMafSc=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr402401qkb.326.1538171691945;
 Fri, 28 Sep 2018 14:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-23-robh@kernel.org>
In-Reply-To: <20180828015252.28511-23-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 16:54:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLTYvz2nW5uX8dt5OAYagpBqFe_yHDFchxxSuMyYe2+yA@mail.gmail.com>
Message-ID: <CAL_JsqLTYvz2nW5uX8dt5OAYagpBqFe_yHDFchxxSuMyYe2+yA@mail.gmail.com>
Subject: Re: [PATCH] input: sun4i-lradc: Convert to using %pOFn instead of device_node.name
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:54 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/input/keyboard/sun4i-lradc-keys.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Ping.

>
> diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
> index a37c172452e6..57272df34cd5 100644
> --- a/drivers/input/keyboard/sun4i-lradc-keys.c
> +++ b/drivers/input/keyboard/sun4i-lradc-keys.c
> @@ -185,19 +185,19 @@ static int sun4i_lradc_load_dt_keymap(struct device *dev,
>
>                 error = of_property_read_u32(pp, "channel", &channel);
>                 if (error || channel != 0) {
> -                       dev_err(dev, "%s: Inval channel prop\n", pp->name);
> +                       dev_err(dev, "%pOFn: Inval channel prop\n", pp);
>                         return -EINVAL;
>                 }
>
>                 error = of_property_read_u32(pp, "voltage", &map->voltage);
>                 if (error) {
> -                       dev_err(dev, "%s: Inval voltage prop\n", pp->name);
> +                       dev_err(dev, "%pOFn: Inval voltage prop\n", pp);
>                         return -EINVAL;
>                 }
>
>                 error = of_property_read_u32(pp, "linux,code", &map->keycode);
>                 if (error) {
> -                       dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
> +                       dev_err(dev, "%pOFn: Inval linux,code prop\n", pp);
>                         return -EINVAL;
>                 }
>
> --
> 2.17.1
>
