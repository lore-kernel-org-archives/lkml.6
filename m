Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C8C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A021720850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTwhcUaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A021720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeLFO7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:59:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45974 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbeLFOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so589127ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 06:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6numlv32oFc61TvwBF/tFURTaowj7NWGsOUf6c2rp/o=;
        b=BTwhcUaIbnbSUdg6lMSvacD1LegaR64dNfl621JVVF/4DabiXGT5dem2gQRyZd/MvF
         ToWAkrR/z9r9qlW7dDHWNREjxM0I35TY1g4pj+ZpgQFTvByiQusgRwlJWiIiL5xWN7B8
         MbS/B+anwYRh9Na9hwRYFQqzF7B57ZNIYje1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6numlv32oFc61TvwBF/tFURTaowj7NWGsOUf6c2rp/o=;
        b=RjBxFqCokAeHYVXdijl+4KailtETxERG3zwy8EmA2M/AGUxDW+3vyRo7cASjn9pBux
         Z2KC2/dpYFY5hhDFUEpZyK0ZY4b3OVHvMWpS2QS9rDUrJFoaul8fFt8aC7MieaApmdkm
         2BVpYV3nI/sKwEYkQE1kRQAtTlM04YZVsKI+CrsiaK5/URjwBjs+duu+mIPeoPuzpovY
         DMWIpCo6+ndF90kdNvAtyCstN8kMY5YTyqxkqCAdk3dfmE7SivxOPGoQVqZw/bRF+uHH
         4emLW5mB/keTSSp+fF7lpXq2WdE60vXvXQmuLXXtl72joc+R3ZNQZCLgcF4B+3Oo+7w7
         A58w==
X-Gm-Message-State: AA+aEWZlPhWHYkVdFNBJBIStHtI2NNYYlaOtJXxj0MDGs1q4+vxViMc6
        B0wUbd9DyBbSwFjzS5Az/ETM6Crv+H24uS6DCcKqZA==
X-Google-Smtp-Source: AFSGD/XkJ6SL631ACTymVrU7Nnpyi3+u1Wxf1IF0P/NiWChRypDt0ETuHe+lVk+X3GXzOWk6GkLMTFPLYVPeWMcKu6s=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr18395459ljp.12.1544107292663;
 Thu, 06 Dec 2018 06:41:32 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181206124518epcas4p2fd2837b5bc5e0c806e93ce752599e264@epcas4p2.samsung.com>
 <20181206124351.10155-1-linus.walleij@linaro.org> <b2dd4b32-9929-19b1-c849-63d8c793c187@samsung.com>
 <20181206134901.GJ16508@imbe.wolfsonmicro.main>
In-Reply-To: <20181206134901.GJ16508@imbe.wolfsonmicro.main>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Dec 2018 15:41:20 +0100
Message-ID: <CACRpkdZV5NHEh1FdrUCDozXFdNcM=FQQnvnLJAUtwV3qD3FEZg@mail.gmail.com>
Subject: Re: [PATCH 00/15 v4] Regulator ena_gpiod fixups
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 2:49 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Dec 06, 2018 at 02:27:03PM +0100, Marek Szyprowski wrote:
> > On 2018-12-06 13:43, Linus Walleij wrote:
> > One more thing - if I got everything right, gpiod_put() in
> > *regulator_register() error path has to be removed also in
> > wm8994-regulator.c and arizona-ldo1.c.
>
> Indeed yes, good spot.
>
> But apart from those additional two patches, series
> also looks good to me:
>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks a lot, I hope Mark can merge this for starters and then I can go in
and fix the two outliers separately.

Yours,
Linus Walleij
