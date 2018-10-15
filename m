Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA19C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E7E2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6VUzNtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E7E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeJOWHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:07:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34637 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJOWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:07:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id o17-v6so21634910qtr.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQUeieoVYUdpM7wmp35b/yJ9IUUh6IXKFO6ygf0ulPw=;
        b=T6VUzNtBNsRSeQ3DnSGmSovu3M6VJ+udZTH5fcZBbQfTPUeumuv5ISea65YpNarRTf
         SPjtqPitkrBI4D/vPEvy4RrsgYaJp4MPrX7ziHUwmYlZhgDYpoi2XgX1V1d6ZLJIqMbe
         bFF+aIsI6Tfm39im1h+o+Sq30Hvc8tEKeRxfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQUeieoVYUdpM7wmp35b/yJ9IUUh6IXKFO6ygf0ulPw=;
        b=Rh+C6IliOPgj7nXrfaZ65YacfdMbvMIE/GNJUvwvaDbOwK8K3t6//FMqDZqPenF06t
         UI1+QCo0xYbsv6ZvyPRsYMkyvr2Zv4/Z/GbcGgUPZl6v3n+/pI2audRqmVIQrNJduJ6C
         EE//bLcjOADtwU/dIcDZ9yiyFH6oqAYEaFmkD8vVNblShZEOMsOok5ucfU/8I58vdhx5
         bPb8H34bl5uQrBflWME6SipMIfChfOh9U+pozdda3Zxp4bpNEi7reNuM0H2cuH9sqhYg
         a6UUZjjqPtjWX0jw42rua1DAKdCZtvB3iN+LmI12TtQ6XgRnmng9n1xK/o0auiCGHP0v
         pk1g==
X-Gm-Message-State: ABuFfoiF+lGgMidOl6BQ+/cQjwE3dFwvTfYeQ8pxk4wtBBt1LOiQ5Qh5
        O44CrcUb7nHHN+wWyqHkBZRgZCndPXtASoKQoMQcpXC1
X-Google-Smtp-Source: ACcGV61en+a+UngnA5nx2ZoDIiwfjsEXHp0yU4nFdRmQY1/rOCr52r/y7A8T3oI1BGYZsAlLkPycacaK2iGOnyFfUoU=
X-Received: by 2002:ac8:440d:: with SMTP id j13-v6mr15884734qtn.257.1539613295422;
 Mon, 15 Oct 2018 07:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181011204042.GA17125@embeddedor.com> <CACRpkdb9b6kxgj736OmLhBvzhR26DT+bE2Y=jGaMB3411oa3yw@mail.gmail.com>
 <3c7f85b1-b80d-a963-f599-587dd49d1f12@embeddedor.com>
In-Reply-To: <3c7f85b1-b80d-a963-f599-587dd49d1f12@embeddedor.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Oct 2018 16:21:23 +0200
Message-ID: <CACRpkdZKtK3xEyc3SG88_xp=fcotL5nC9rJoyB6FFK910Bo74Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rzn1: remove unnecessary unsigned integer comparison
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:28 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> On 10/12/18 11:17 AM, Linus Walleij wrote:
> > Sorry for top-posting, Geert is maintainer for this driver.
> >
>
> Oh okay.
>
> This is what I get when I run the get_maintainer scripts on the rzn1 driver:
>
> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback drivers/pinctrl/pinctrl-rzn1.c
> Linus Walleij <linus.walleij@linaro.org> (maintainer:PIN CONTROL SUBSYSTEM)
> linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)

Hm I bet it needs a MAINTAINERS update.
Geert can you assume maintainership?

Yours,
Linus Walleij
