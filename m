Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54437C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3E220877
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWGTVMyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3E220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbeISBKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:10:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45747 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbeISBKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:10:35 -0400
Received: by mail-io1-f68.google.com with SMTP id e12-v6so2533408iok.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HaziqBy+V5QAZXa4Q7VGsDF3kW7/En5g9KsvupesJY=;
        b=jWGTVMyUHtBGifUGbaBtQ6fxfngOpNDBku9aD2LSLsvC+z2fCujXoVsuTMakyBmMss
         vRgpdsO2jN3YuqTiOZZ2wCTbehKGe7EKEO7l2hAzYgSWj4b/REm7Nt8M9QSYs7MeKtdv
         G3+boB+D3WcCTRISBlKUAqHSXo89Y2Fmagffs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HaziqBy+V5QAZXa4Q7VGsDF3kW7/En5g9KsvupesJY=;
        b=Gc1M2QItubWQmgcubcx1QBHy1nK9nFDd24+9EQhOyD8oA1DyWzMb2DBXwvBYz5Uxpl
         v8J06J2FGCFV2qBGjrnAlwcZMnOJBpjX0cuELl0gaILXsGsYkYZemNMDX2mMCjzYX0nD
         EzKsi1zKwm0T7fHx9Rf8c/qpl0fp5NqbjplqfmyTzQohs3nlL+ywf/IekYlpmzTbNGQw
         oNYYB5odg4+XhV/YyT3EOU+tWIC1sFEXg0UYMfKIFMYeHcL9rFmoHIJbvSupxcYaVD6Q
         6+OWcUcUnKjjqbAfJDkJqvvvC7dRpaK8d+Y8aUGTQbHhFB2GHu2OqCihrjQezgTjqMpJ
         6sWg==
X-Gm-Message-State: APzg51AfxIwboqk6SKpRI8cAu1rQc84IY3QBGLshwPKfLXvhJ5jvRFnn
        q8HLHVQeUNPVSlKF4ATx8zEcZg1LSZ6QPiWQb7fPzg==
X-Google-Smtp-Source: ANB0VdZzt9LRMvJbjFSirKTr54diA9EZk/pyQVexkhnKLL3IEgyL3QfRmU8eXiXqfir+0FCUwFLpm/8dCiQ7N1rRHR8=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr14464585ioa.277.1537299391905;
 Tue, 18 Sep 2018 12:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <75d8f8c745d60b49ee1ec60de7f776ef51f97f79.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <75d8f8c745d60b49ee1ec60de7f776ef51f97f79.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:36:18 -0700
Message-ID: <CACRpkdaLc8i0QtpqsBJVLmcRewahRWKqkr5vys8_w0Ld0gEc7w@mail.gmail.com>
Subject: Re: [PATCH v2 01/22] pinctrl: mediatek: add pinctrl-mtk-common-v2 for
 all MediaTek pinctrls
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Irregular register arrangement and distinct logic access from various
> MediaTek SoCs would cause pinctrl-mtk-common to bloat and really hard to
> maintain in the future so that the patch creates pinctrl-mtk-common-v2
> based on the core of mt7622-pinctrl.
>
> The goals pinctrl-mtk-common-v2 want to achieve are to hopefully support
> all of MediaTek SoCs, and two kinds of dt-bindings being supported,
> Linux generic pinctrl dt-binding mt7622 supports and MediaTek per-pin
> dt-binding the other SoCs support the MT8183 and MT6765 incline to make
> use of.
>
> The patch starts to refactor MT7622 pinctrl driver first with splitting
> out these portable ways from there such as table-based register operation
> and drive strength control that is common in both kinds of driver.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied, had to use some fuzzing and removed a <linux/gpio.h>
include that was not used.

Yours,
Linus Walleij
