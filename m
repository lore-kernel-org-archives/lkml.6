Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FDCC31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6433220880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUKKGJ9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfAUHRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:17:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45385 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfAUHRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:17:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so19671789ota.12;
        Sun, 20 Jan 2019 23:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pnx3Nxrg+oTItMgPKMvP1GMdGaCFOY9PulEkrbXfAs=;
        b=hUKKGJ9YAeXFUCPU8ff7HP9VcsGfbmxasPRsww3Z3VPWbFoVNvvDNps/OXWmPy4Nbp
         DBItLO0O4CeIDy1jwlMY6wxCYMvAHLgIpJrIveMVNR4orNpomEpTqh40aGoWAo1RcvZF
         4m0tIk9ZBRhRlizMmwD7rnrO48GPjp5FrKC6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pnx3Nxrg+oTItMgPKMvP1GMdGaCFOY9PulEkrbXfAs=;
        b=AE7nEm3m20uk0w/zi88IA3qvJLe8dNPL2lkLEhQxH9Ro3Um+fnf43UKgLacDaP96bS
         gkJOUzmVoIzPNIp/kDBYb+63DdvHOW2TNI5/7QHSFxfZ4BsG3Iqfq5ItEAQ023kbhlq9
         /OsuonWBeUyPYn3e0fJEtQNnRGYA15F7iKZ6JvfPU6HZAr1G2XxrAp+BOtRCv77mHjkg
         XAZ88mYxvYYH4oT9WRIat4nin5k2YaMX719ajILC/qyimmr0Z2RjdWdrc+39eycBfe10
         OIwkFbKjkiiU1pVGHg8VwLB4Fta4zj85E70zXyAOsObDZkcq5lPjNcD4EuMWBF7A0eIV
         iwTg==
X-Gm-Message-State: AJcUukdhpci0qzzkiiY62AW3oGYesN6F4/NVlFmhx4KeklyfR68eseLB
        Ac4HWte0GzzumSBTYFkRXoygmJ//WhiRMl4XiXH/fQ==
X-Google-Smtp-Source: ALg8bN4FmEhAeifQQzeKvFkSllUZosrWlkTj6jFjRavr8f5bLtJSgFzkgxbtsmTFY1se9+WPck7BOFntZgEw1g/3XgU=
X-Received: by 2002:a05:6830:20d6:: with SMTP id z22mr18885381otq.106.1548040973786;
 Sun, 20 Jan 2019 19:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20190110143917.9054-1-linus.walleij@linaro.org>
In-Reply-To: <20190110143917.9054-1-linus.walleij@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 21 Jan 2019 08:52:42 +0530
Message-ID: <CAOh2x=mEb8GOkveMrOe=sRt-6UJKjXsQQJAPOhGOLKz15WCMUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: config: Update SPEAr 3xx defconfig
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 8:09 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This config is updates to the latest structure of the
> Kconfig menus so we can apply DRM driver changes on top.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/configs/spear3xx_defconfig | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

I missed this email somehow :(

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
