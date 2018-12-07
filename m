Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9929C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FE8208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZFUJ9yjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FE8208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLGM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:27:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44142 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLGM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:27:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so2871797lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ev/LVS760cPukiSw1NVD/XABFylNoWP0fj64GTi62Sg=;
        b=ZFUJ9yjDkLHMpQZEe8csUZSyytFx6wVT6DacOwqoQbuHWKoYRx5GuwYjhmtIz6znz5
         JOXrh9hK6bhInckmCBf7ZK78cokGhfDCowL9T228HZc//HGe3zywU9z4/anS3ntjwbzH
         Uo6woQJU8hW7Hj+JYzOMPdphRbsUN3NYJfG7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ev/LVS760cPukiSw1NVD/XABFylNoWP0fj64GTi62Sg=;
        b=qT9ZheangiEZ/L/Uk0bKL5kZXAEE9RLHl/MubpVVEGGq+wA3Gz7tH9fnTo/WqU9P7n
         dDis3Dfh+64GjaTZiWUtROw+6CZW9N3ny6mEHdiupXYhvw0vYKfzUvpJX6FyD4d8INpl
         ouly2OUsoMiu5qTDKeMri5GVkM+dh4f5Mppe81Dk9fuJTYHLsbcreJdzY3aKSto++TKO
         ++0EiLeXX0f08D33Kh2CG8wtRCqwz8k/+x8bqReL4Y342fUNofNn7jmAiFaP+NqETPOJ
         DHVsBECxwO2OqOVOsQzuSjBMp2jP/2s1IoddSRDbAkdkaWb3BG7+Hvc16OBlEOqIXt8q
         LyMw==
X-Gm-Message-State: AA+aEWZogCexRDSJmi99kF6BlT+uLlTLYhabJu14PaLLttY0PlQ2T3B3
        itCeZ1D9IFcgr0H9pudSnfK3ZK1NWgBcQRWHpOWe8w==
X-Google-Smtp-Source: AFSGD/WzVwt33quCfPcM17C38/d+3TTZdR1YU9bd5ZSO9Svc7jPaNqxAF7F3um95uTb+mtMa1Xw9utl4vSxOkoBq/6o=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1295388lfb.96.1544185651436;
 Fri, 07 Dec 2018 04:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20181202021710.9307-1-tiny.windzz@gmail.com>
In-Reply-To: <20181202021710.9307-1-tiny.windzz@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 13:27:19 +0100
Message-ID: <CACRpkdahwmjED=BY715E+cpRhveqk32vCRpevyHF8SdcqC0kvg@mail.gmail.com>
Subject: Re: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
To:     tiny.windzz@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 3:17 AM Yangtao Li <tiny.windzz@gmail.com> wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
