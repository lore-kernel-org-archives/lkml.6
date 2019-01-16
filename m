Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F24C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E43F20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0k4wWIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbfAPIZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:25:43 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38113 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfAPIZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:25:42 -0500
Received: by mail-lj1-f176.google.com with SMTP id c19-v6so4690102lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 00:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqDkxs1cK0J5n5D/Lm38z/YsUnzmJKLTO8oYEyt0YFY=;
        b=E0k4wWIAep/DXJKTzNJe2uu0+PlNTmdCfA+ZT1TEBCgMxQ93DEonDclyY8AmAEpVD0
         6sKgyTWk1agI/ahwR0XIBI887BXCVe1GwLH0O4N51kibArK/lTT6COuc69HZDaxmcR90
         xq2Higmch3Byi1S9502zEf+mkCuC3iZ6tYOVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqDkxs1cK0J5n5D/Lm38z/YsUnzmJKLTO8oYEyt0YFY=;
        b=hgKNyX/9nBozbzC8L3qcdp2ZhtnOx6hL4lURR+3D+IBGGoXSJ/SehOnFsbhFY0eZgD
         kNWrFOIk9d1iv3Uiem9beF1h8Q2q4le3KSj6HLX9Lc4sDeknJ0hcyyTWz5tBy0FL3tSK
         MwMLKgeumnnkZwWZMeDJRyIfMQvPO+ktkd6o5i9mBtF0zEVwC8rGu0XfaXQvF8P0sM6P
         XTg+9PINEq1aFqWfCkZGQhLlO1dbvTvucxVdZDxHTQXcqEUMhv3t9kIhSSET861Kp74h
         C9j0s6+f7+ciQaMylF7Lw9Bpb3wJIsXGrlhFZ0YZoLBGVReTd6FamJuR75ZokCP/we1V
         /7uw==
X-Gm-Message-State: AJcUukfYps5i4MKHnMTbtMq1LobQSKFJ+bU7e+3wCThrO2yRAClqgjR2
        yOMnpLrTRBDL8o8LQEQTQtECssgX7tqaBwP5xynf1g==
X-Google-Smtp-Source: ALg8bN5CMH0G4Orjr+hQDw/NibT+B8cyrQspuWvGZdLnB/87caZDqVlgaEF7PhoOyJeYurxybwbOQJ1l9krilBOgXpk=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr5352172ljj.120.1547627140630;
 Wed, 16 Jan 2019 00:25:40 -0800 (PST)
MIME-Version: 1.0
References: <5c3cf3a4.1c69fb81.e81c0.fb80@mx.google.com> <20190114215926.GF11073@sirena.org.uk>
In-Reply-To: <20190114215926.GF11073@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Jan 2019 09:25:28 +0100
Message-ID: <CACRpkdZwuLwEfTd+PnjvCs_WrAQyEUzT+_ToUecHS3ufJhNkeQ@mail.gmail.com>
Subject: Re: broonie-regulator/for-next boot bisection: v5.0-rc2-20-g61b67608c6b9
 on meson8b-odroidc1
To:     Mark Brown <broonie@kernel.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        guillaume.tucker@collabora.com,
        Matt Hart <matthew.hart@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:59 PM Mark Brown <broonie@kernel.org> wrote:

> Linus, I'm going to revert this whole series - not sure what's gone
> wrong here but I guess we can test easily with kernelci which is good.

That's fine and I'm onto it, I am trying to create a mock system to test
the gpio-regulator so I have some confidence it's not breaking these
boards before submitting again.

Yours,
Linus Walleij
