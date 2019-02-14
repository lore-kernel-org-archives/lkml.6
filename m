Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61045222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+EJ83nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbfBNISl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:18:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39950 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfBNISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:18:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id t14so3873162lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYIInG/yQY9VXTcMQcsb+OjrEAY0b2XldRKqy7MikrY=;
        b=P+EJ83nvbFgbNAtT8fIb9K6BP4ypqTVDg5xyU0QuTgVx37dZZdOSzYF4pKiK8Dj/yz
         /IfeR89eUafg/U/1E2B09mvOBQ1paJh0LnSeZpHUIOtkiNp6SgFI8T//OvfLZg7DtZnE
         U6qHMJVpXVxsbHUgV1hOMhZSeL9Z1ynFFsS9mbBUXCEiiLfNjkeTHX7XcySWw0D+y+Uf
         yvWGr7F7VmKu7wDnweq9jpN2vzSCdgE726z5fKIDvV8wQwmITgwYKcBBav8lbn0UD5lP
         y5dqCygfNFhRU4z168YqmHTzgZXVZHJdq+W+LLpByG2nLAmuK/XJ/xiGF4IEAAeiPx+C
         w7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYIInG/yQY9VXTcMQcsb+OjrEAY0b2XldRKqy7MikrY=;
        b=TlMQT7ZERjQxsibP+gN10LmoBH66YmoCix0OXsrUVwGYtceiRkixsRLwIDIauAzEJD
         Eek+yA46RPvck3plpPebCnXN3TvsmiZtKa+etQMSEyYjZ+MvuYw1BzX9PtBm8FkOdZdG
         t+CP9SfvMFcehVWi5tulYwMO97Bb5nG/X4LjPKoRB5s0evw1GKiLm6fRKy7AGn1AbUIB
         TzC4V3GUGxwncojmaGs0d3VeZAmpKy0zP/FrQ2dUvNakmbGOebv1Yw6eFlRGfWdxkw93
         /ay/czB94lvq9MCYVc7dyAw6VPcJuPaNwyNRwXzagW08mm+4K5InbuVgRKYuSwqPvGD4
         rtww==
X-Gm-Message-State: AHQUAuYutGL9rBFrMHCljB/kWZIfnm7h4mMdCg5/efu5saJS5nJHJtAm
        ZdeRdz8Rzn+9Q9w75O7wZZlXfRMMXbtl7bLRkyNjnw==
X-Google-Smtp-Source: AHgI3Iahb8qHjs3k/rbjO+3KZnE3IEUgFhxV0ZOBXESlOPn3GNmmCTSXtbipoCT47W/DaolfayyN8/t6jpQn4bNt27k=
X-Received: by 2002:ac2:4219:: with SMTP id y25mr1474297lfh.130.1550132318807;
 Thu, 14 Feb 2019 00:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20190214013641.9740-1-masneyb@onstation.org> <20190214013641.9740-3-masneyb@onstation.org>
In-Reply-To: <20190214013641.9740-3-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Feb 2019 09:18:26 +0100
Message-ID: <CACRpkdYSMjyQ07TKaeoC1WbWk=6WomJOkd0Hm_8ho_yDqj6wQA@mail.gmail.com>
Subject: Re: [PATCH -next 3/3] qcom: ssbi-gpio: correct boundary conditions in pm8xxx_domain_translate
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 2:36 AM Brian Masney <masneyb@onstation.org> wrote:

> SSBI GPIOs are numbered 1..ngpio, so the boundary check in
> pm8xxx_domain_translate() is off by one. This patch corrects that check.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Originally found by Bjorn Andersson in spmi-gpio.
>
> Linus: For your ib-qcom-ssbi branch.

Thanks applied it there!

This small bug stuff is sorting itself out nicely :)
Less stuff to deal with in the -rc phase.

Yours,
Linus Walleij
