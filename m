Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7A9C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A3727ED6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9Elhlmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A3727ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936313AbeF2MVY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:21:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37798 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755357AbeF2MVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:21:22 -0400
Received: by mail-it0-f66.google.com with SMTP id p17-v6so2581666itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIqrAKMT12WIpM+imnkxkjDhJJNXxMCT535TYywVHkE=;
        b=h9ElhlmoDN6eqcsKyx7l/APfahoQZ7rZDxjyC9wDAdd25hrl1riyLQnchK6eiVRYId
         XeOgHjMn3crbVE/r0uNmJzPDa9Mg0VCEM4vVEecMH+OU1KNbBms7K5DVzWnutag919Xo
         DtuinAYPti/zNOPvnmHksWfpvTU1k0FEls8TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIqrAKMT12WIpM+imnkxkjDhJJNXxMCT535TYywVHkE=;
        b=VfJLGRV9JnmipIAdZNEQgcIwGnYlscnlCgxsxx6Lh1sHjBTCa6nv+BhhvtmypVy9+B
         booNB+trN+luMHLjTAcOyR7oRmOW2YYojNAF61PJaxt2kC9yyRCBUEVisCtoA0uqFvRt
         MTLE4yuFGAEcIG8qaIzNFw9D3BJOsdOW65R+4zYUcVnsDzaHsOQGERsV7vYlPWBCGXMg
         CdUXp6qrQJXkyFFF+WxTnMOmX64clO5HYg0U6gB6zyHsWlnSF/G/PfI87AnahHXHGbqy
         RQEzxSWeSPwVf+FvA0Gmnw9xKz1BrpmAu9MR1PgHkrMH9n8XjOW4hzKMQOTe+mtwwpS8
         c9Rw==
X-Gm-Message-State: APt69E20uxvNBbQeVE+VV56X4WfxNCUjN/spUfXVzKVicTRSjPqeucWR
        TXrAAz1wPORmcKa7cHSjZWcmktOPDkeVXS5mhp9Nkg==
X-Google-Smtp-Source: AAOMgpeckTZwrfaqh6mayXwakB3tIdk3sK961Mopaa7Xu+wof1JmJxskbENfS8TOrEEVKtuCqnJqIZzzgGIuyQVB1/g=
X-Received: by 2002:a02:c006:: with SMTP id y6-v6mr12184770jai.87.1530274881386;
 Fri, 29 Jun 2018 05:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <098100772163e54fe5ca49576042edbfaf3807a5.1529639050.git.sean.wang@mediatek.com>
In-Reply-To: <098100772163e54fe5ca49576042edbfaf3807a5.1529639050.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:21:10 +0200
Message-ID: <CACRpkdYn3SJd=X1R-xLhJraqk6TWutmOVRZ2ROc8ih_fT_6MEw@mail.gmail.com>
Subject: Re: [PATCH 4/7] pinctrl: mt7622: stop using the deprecated pinctrl_add_gpio_range
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> If the pinctrl node has the gpio-ranges property, the range will be added
> by the gpio core and doesn't need to be added by the pinctrl driver.
>
> But for keeping backward compatibility, an explicit pinctrl_add_gpio_range
> is still needed to be called when there is a missing gpio-ranges in pinctrl
> node in old dts files.
>
> Cc: stable@vger.kernel.org
> Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
