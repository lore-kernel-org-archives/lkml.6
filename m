Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ACEC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA295223F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKIlYLmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA295223F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeHJMzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:55:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36767 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeHJMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:55:14 -0400
Received: by mail-it0-f68.google.com with SMTP id p81-v6so1994005itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qiie/80O+NQyatAAf/UTsMok73ZfNfGd8hIkUp1nGs8=;
        b=eKIlYLmPcT98fHUVszGxFYWD8jeldXNS5c1XsgJmEi5XDQ1c14dVzVQuK3rEoDRZ7X
         NykONpmns1VnEsysBccW2m+YJwNRVKScxEA6Lv5acLVdJ6ffTuPKK5OfumNuNErnpaiH
         CJChSRbaU58yh6y1tGcYxcp8IgGAYLAvnFIvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qiie/80O+NQyatAAf/UTsMok73ZfNfGd8hIkUp1nGs8=;
        b=J1kelVqo92mZr3Lg14a3ooIvXIDgSMhpPMdZgHYkYgI6UkdMC+4eEbCUxZgNZlPPVa
         zwyfxIcH2SDEp9DpWV0kmk2ODgpEIrCwBr68sykYXyPbSQhL2i/UxbdRmrQd1gGBc4+Z
         UPdiAHIRdYJVw8un/8wU/5av7KB/gUmfqNh8JC1TRDZEyJe7debRa9u69a7EXIXKHQmO
         p2x/16L5LrblxNxTwqiqXxQAJZhox+VIoTREkmInFkj5VmhR7kNpxq+/gfticV8qRuSX
         Fd9LUfUgN/wqZHolRH+FhbXi6fddxBZ/Ztr/Lt9znbb8fGyXVisbCZhu4sf1TIK8ysI9
         TXkA==
X-Gm-Message-State: AOUpUlFRYNbmIH0MEaKkOnfk3DA0VttF2R5O1Lzhm342+J2tHYi4S/xG
        pzfvxqhqi1IAbAp4t4nOxuTb9MAMliGLtzRpLI/qhg==
X-Google-Smtp-Source: AA+uWPxsahDXEw0KDI5CtoBliDTabP/Ul4TC0EomVFLdXuheFw5pvx/9Mfl0+phiblaJLshKLvIxunJpX8DA2y5bbFA=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr1612529iti.135.1533896758189;
 Fri, 10 Aug 2018 03:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-6-jmkrzyszt@gmail.com>
In-Reply-To: <20180806222918.12644-6-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 12:25:45 +0200
Message-ID: <CACRpkdagqyuhxtv43UezqcKZvvUbOrHB3Cz9oaHT5X+64WaZQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for
 data read/write
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Don't readw()/writew() data directly from/to GPIO port which is under
> control of gpio-omap driver, use GPIO API instead.
>
> Degrade of performance on Amstrad Delta is completely not acceptable.
>
> The driver should work with any 8+-bit bidirectional GPIO port, not
> only OMAP.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
