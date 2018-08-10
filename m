Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9FEC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0A5223FA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKCLkJEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0A5223FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeHJMko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:40:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36068 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeHJMko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:40:44 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so1950776itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6M0dCfaQXx9iYWMNcClBpv33wj3darPut/Qo5lma94=;
        b=fKCLkJEUmp62n+YLnuySzKOEWwogRuCECbZgnOrmrUlSzD1pK51p37H3Ypta15rWrz
         90VDDbt74U3A+TQEFNiMZNddn7CNqIwXDrcg1+lQrFSM4LH5SdT3V3I0I1kP79G07V7r
         80ZE/KvieoG9MOd/8A8vcEkRyhe6U5xaHhreA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6M0dCfaQXx9iYWMNcClBpv33wj3darPut/Qo5lma94=;
        b=FuHmuJZVf6GMFqIs08GaLxZ9rxXz9KhRk/tk6sU8RRQmLQYHtTOgqaUImYneRIxdao
         ImV3b+PoYcleVuyfYtPXoCWttoy2naZjWj/4z5wtqRl9iWQTODFmRE0MQZksLjGohw1l
         yejbm2PAHYtoznczuBLqAHgne0xoX9izNVbl8eDcOyg6pvcSe7fQK54x8qfh30ErY0l7
         5YqcYfrdKu8S6Hpuw9DPxaKOj49OQW3pdRa8q9k880M08P/0fjdW1M/sxGicxG3JI64b
         y7IWIV50QJSk3et+hIEAVqZC7pEnJxoUNhJlcERKLwKmFBTeh1zkqOSyE1rsWjnzTd8l
         eDtQ==
X-Gm-Message-State: AOUpUlFcvJqOjIeM8wYVHCPlqX9Jk3JjynVUr0njlrT70HS7LFX7oLWf
        gzJkX2lfsFHpkiu84G40Y/LWHPatbeU4l/e4V/tMrg==
X-Google-Smtp-Source: AA+uWPzMml66Mmlx1kdHa4dMZgsndA6pcwFvBgRkN+rUJcek94uyXKK9vUtymzpHP4crlY2sqLgYf7DU0UJvgnT17ZM=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr5148979jab.87.1533895891792;
 Fri, 10 Aug 2018 03:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-5-jmkrzyszt@gmail.com>
In-Reply-To: <20180806222918.12644-5-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 12:11:19 +0200
Message-ID: <CACRpkdZFq3AfH6ehCzMYqwptyfpdd3NLurx3kgj==DmKRASuiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/12] mtd: rawnand: ams-delta: request data port
 GPIO resource
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

> Data port used by the driver is actually an OMAP MPUIO device, already
> under control of gpio-omap driver.  For that reason we used to not
> request the memory region of the port as that would fail because the
> region is already busy.  Despite that, we are still accessing the port
> by just ioremapping it and performing read/write operations.  Moreover,
> we are doing that without any proteciton from other users legally
> manipulating the port pins over GPIO API.
>
> The plan is to convert the driver to access the port over functions
> exposed by the gpio-omap driver.  Before that happens, already prevent
> from other users accessing the port pins by requesting an array of its
> GPIO descriptors.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
