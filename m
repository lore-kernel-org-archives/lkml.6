Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-383575-1519312734-2-17569471647846527349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519312734; b=snEJlv70RRPGCQSiSkfY1M5fY52G8qeBLDXQF9XxdTaX/Nm
    0oNYXLk8FJ/rhgifrTh5WwO+z8p+rBaNCjQLEQNXdQxErfXzFAiaxOTkrNJ57RdZ
    JBdDtWxPKQ7djrn+oQQcqOATYiRAzcVUWd3dH/PslrGLfpM10/YKad/rXcxDjWqS
    /oNnO/JUQGe4qE1uBIEjd9F8YZfUv7WtmBqrjXmfcFUr2p6u86QEk9SyMUsDvPXQ
    j+BjuvM/jHhZVZi4p/LZJIurrNnMG5qnMTATMkgmdc+goGnD+UU6NSpOpFBoCixa
    eeYugyz2O9Ab1mmpKBW1RIWn2SKr2PTohyb3Epw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519312734; bh=Fc2txzdiRop19Mx72k48iHy6m6Y5nS2TRZYI3J
    4hXuM=; b=u7kTL5EbBBQs60OpUX52F/uQCaOa8o1jL26p8j3oEeabspqG5Ty+Xe
    JKElJlWoSCclkVB/d1uvkl/XAtdfKh1cokvV8H6hy265Ouym0r7x7YxFWw/R5Mx3
    37K1ETMjIlqnEF8Lk2xjq1FUXv7S3bOj8aVrQiVLqxRBWAYhvb/A8YXvHeO9gJB8
    2nwLNQjr8uHwfzDTk50GTx+3f3H9Q4QhKCxp/N7Dx1vDVZaeqNpA2V5nl92K79xN
    pMeZORGLL5rw6PIyoIfp+lYzR480B4PnWdHLhb7kuxOM3LrQG8R5qbl+L85yE/+e
    grWS5eQ2XwqPgml9bWNa4iRoRaDE06jA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QjL6KrFZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mEQzWI9X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QjL6KrFZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mEQzWI9X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeBVPST (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 10:18:19 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43559 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932828AbeBVPSR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 10:18:17 -0500
X-Google-Smtp-Source: AH8x226/r2GeMK/fZwoCCNqrNqXt9A2M1pmkqtEVx270FUtL4VGBl3SSxdzfqTadrjQCQ3hyjVZlIWf5Z9JAOL6hD04=
MIME-Version: 1.0
In-Reply-To: <20180220181751.20826-1-krzk@kernel.org>
References: <20180220181751.20826-1-krzk@kernel.org>
From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Fri, 23 Feb 2018 00:18:15 +0900
Message-ID: <CA+Ln22Hv=AawNquvGT=n4gxy7S=wOELPXX=c9NvzepmQjUVQqQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: Validate alias coming from DT
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS"
        <linux-samsung-soc@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-21 3:17 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> Driver uses alias from Device Tree as an index of pin controller data
> array.  In case of a wrong DTB or an out-of-tree DTB, the alias could be
> outside of this data array leading to out-of-bounds access.
>
> Depending on binary and memory layout, this could be handled properly
> (showing error like "samsung-pinctrl 3860000.pinctrl: driver data not
> available") or could lead to exceptions.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 30574f0db1b1 ("pinctrl: add samsung pinctrl and gpiolib driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Issue is present since first version of this driver so this should be
> backported as far as possible.
>
> Tested on Odroid HC1 (Exynos5422). Tests on S3C24xx, S3C64xx, Exynos
> ARM64 and any other chips are highly appreciated.
>
> Linus,
> I can take it through samsung/pinctrl tree and later send you again as
> pull request... or you can apply it directly as I do not have any other
> pinctrl patches queued so far.
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 56 +++++++++++++++++++----
>  drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 14 +++++-
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c      | 28 ++++++++++--
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c      |  7 ++-
>  drivers/pinctrl/samsung/pinctrl-samsung.c      | 61 ++++++++++++++++----------
>  drivers/pinctrl/samsung/pinctrl-samsung.h      | 40 ++++++++++-------
>  6 files changed, 154 insertions(+), 52 deletions(-)

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks Geert for the report and Krzysztof for the patch.

Best regards,
Tomasz
