Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FE9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535D62080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6sCiHeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535D62080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeKQWfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 17:35:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44817 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeKQWfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 17:35:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so18266509lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 04:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwcZgS6Si8t6pVK8iLN8oUsF9P5jKc1FkAFCju2jRJg=;
        b=G6sCiHeWI0jperDcoeGMpNnvCQK5Vpj5BiA9QM+LbgCxL2NezLMkVWFMB/TDS5c6N5
         GwbtWfMBi+4g4p4F45l7HMmR1qz78QOQvzSZ6ujBb2pyXEl/F04j0OcLl/rVIwPGT7WJ
         vGiQN6Vgvjnjvjgtk8Nl/9fvMsSuCSto6u81c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwcZgS6Si8t6pVK8iLN8oUsF9P5jKc1FkAFCju2jRJg=;
        b=ZJ9vHGe0JnIf3ZCmom2rlpyozEYSaRAv6zQyTg50JHj1kKNHzQcy4wlPoiC1mjldAQ
         HVKjZXc9NNLQCyUhUbiFTsABA/B2wCaObdbZFI138cykzmoLgL6J4+eqz4p74MAYHfG2
         H6OAn5qQbYNyzYPU0fn8RC9XiAVV0vY8Hq14nbPb0aXkcJ8a2GQgbhUlGpGsfA9gkA+n
         jHADgCnRoCgBBE9cPrHNHkJNnfHsw4jgOSPasuZf6T15icSUo9pVanEQpzCX83EOvhlS
         fg3hYrelXC4UUfF7CbuBUWjlJSo4E4ScLfdAD8EpB0ZzbTVzfMVMFWb4g/bergh3SvaE
         zh5w==
X-Gm-Message-State: AGRZ1gKQbbIF3nhe+c34wwJnMYd/wR3ZnK9cus2ZeRPFXHuZJClDvkhw
        rwU0iF97DYcSwkRIG+WfSHE9TP8iOS+7ZVF2uwdYKQ==
X-Google-Smtp-Source: AJdET5e94Wk9IUd2910KPJLzpLY7dSkOCxyKCGQ5uvwsPy7gFtWfpNv/6IsK2oTR7Suiz1mhoiDxifocErDruYUWifU=
X-Received: by 2002:a19:5154:: with SMTP id f81mr7757418lfb.96.1542457115612;
 Sat, 17 Nov 2018 04:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20181111210047.30375-1-heiko@sntech.de>
In-Reply-To: <20181111210047.30375-1-heiko@sntech.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 17 Nov 2018 13:18:23 +0100
Message-ID: <CACRpkdbakPGfHap+WcuJ_TVn861zqQDxW-on4q9Wx+-QQb0ESw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: rockchip: allow specifying the regmap
 location for pin-routes
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>, heiko.stuebner@bq.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:01 PM Heiko Stuebner <heiko@sntech.de> wrote:

> From: Heiko Stuebner <heiko.stuebner@bq.com>
>
> Right now we expect the pin-rounting settings to be in the same area
> as the iomux setting itself. And while that seems to be true for all
> newer Rockchip socs, back in the wild west days of old this wasn't true.
>
> Nowadays pin settings in the GRF normally stay in the GRF and the same
> is true for pins configured from PMU registers. But old socs like the
> rk3188 really sprinkle pin settings somewhat randomly through both
> for its bank0.
>
> Therefore add the option to specify a location for the route setting,
> so that we can map older socs correctly. We'll keep "same" as the
> default, so that we only need to specify a location in the corner-cases
> described above.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

Patch applied with David's review tag.

Yours,
Linus Walleij
