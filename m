Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842F4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3824E20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRwM2L9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3824E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbeGYWD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:03:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52813 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbeGYWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:03:26 -0400
Received: by mail-it0-f65.google.com with SMTP id p4-v6so10704973itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhagvDnGS+A/L8Ajan431u+vZptqzIAy0TUZk5e/SvI=;
        b=KRwM2L9FSzxDJhZN8UeYp/I17OpOiSmaaJfPQkr9OW1oDaFw+E6S9fjK1UTNxVnlbq
         AhvPmAQT6WstVOSOhUrW516zWhX1YUm7r5aIG1ejUXuB+Lf5f+YVub3CaB//fjn7FMRw
         hDzd/8aWR0qtDl0sULq20gm6fiTLc2XNZfoT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhagvDnGS+A/L8Ajan431u+vZptqzIAy0TUZk5e/SvI=;
        b=aRwEiB1rRknU+FokZmhg1IMZy4FqNvPNUSEqdOj2apq/U7GXo6fW+EcEkgGiTMm/Ew
         3XuWo+eMCThzAgn7bVxpJqhJv2ohFWR9Z+FmaqtDMFthTeqaCcDLhphAYOllcP1b3RsG
         kRwpkippz2sXHAJ3wOUmHCIRJ5HSiZ/VK9VG0Ut0eJ066x83m7lY9afH5yEL3WXCSfUA
         Y9YBGuzYA+dfkuHozWGF9Xk2FeJsnE2g8JbIh7amHp2qnxChn5GeEvm+gGW6IVp/73UZ
         g+yhQM4xaXGkDt+uKulneGXAL2GrLRVvBd+fX9kN0i9RUWW++sfg8bZNacQieaHMgl0t
         bwuw==
X-Gm-Message-State: AOUpUlG3meo9XeOA2iFVAolvO32cpCF146xq48rhloHvUn2Qdcj9nuBq
        tp/wh+AihW7kR0/+zT8jCR83BdSaNP5TStrGEVsVBMcy
X-Google-Smtp-Source: AAOMgpfSXuiFDpFK+hofHy5iUSJbKut6xpqNi6iH38YjIFJeZAnUEJpDHNNmlVZNSGOrVJO6L2uc2u0ERxmB0wBlpZQ=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr7811245iti.135.1532551801768;
 Wed, 25 Jul 2018 13:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180725161852.6963-1-krzk@kernel.org>
In-Reply-To: <20180725161852.6963-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Jul 2018 22:49:50 +0200
Message-ID: <CACRpkdaDsVdQDZzZBdAznE96WRovOGu9pTio7Ez=fA-T1hvQTA@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: Stuff for v4.19
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>, snawrocki@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 6:19 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-4.19
>
> for you to fetch changes up to b3793159249bb091efce4b1515ce18cdfc4c6e41:
>
>   dt-bindings: pinctrl: samsung: Add SPDX license identifier (2018-07-24 21:59:17 +0200)

Pulled to my devel branch for v4.19, thanks!

Yours,
Linus Walleij
