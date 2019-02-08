Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E708AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64CF2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q21IJUmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfBHOix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:38:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42404 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBHOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:38:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so3165986lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1JV4UKGPid//QUWIswJKTDrZY8kaDLgj1mEClsy4p8=;
        b=q21IJUmWmMU/bc69iD13ApG8isLgVQvWTNe0o325QU5FKBdIVXu0Sjmc1NQ5iYxNFX
         uCrdmddKGdHtOPwMzJkeW9wpEV/HLQcycVSAfBBufzU+BHFrnfJHZnGe949clwlNtJBR
         0y8Q3ZZKnuqXIkKuPFQSBcVLnbuaZRCYRUoEA2d5GGqzsBIWu6/zNQKVIJXAgPc9UGdf
         kBxPZnizbxrCaIIF9U3sx8sHo41+PRncBk8BzqFC8WS7lbXd/xLlhRWGNmUr5TyxZFmF
         rqlV0xox0BRUB3WaiW30AqOGYyWYdha9H2x5i0Pz2NjYWRmzcIv2ekNDNgKHbe2Kunyd
         1Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1JV4UKGPid//QUWIswJKTDrZY8kaDLgj1mEClsy4p8=;
        b=uTlK3ms7qBAQEMVVTTblqYxCiU9GME4rGICHcj4mgZaitwdg886k8tndEZGDvUIqAo
         Hf4mvyEFU3iP2x/ZddllRwg5qgEtef1CbLFV4oZCF+pvIEPahzvaG9K9x4pxpv7/IWDL
         NW+q0JDqlkHEdnhjKdNI/v9PISJC74ZCu1dbFfb5b3fuJsHsFxU/q9i7lkqv2T5FWOKZ
         JMv4yyf+dItuXzhjRhwMYjjzSxkWvyUgIWNXHjF/nm07ODAi4DEhi2jH+Buj2Y8H7Fix
         4ChUoLSO8I3MO94cGYJMBZhlebvPR2L2dkQNaOZ9eQ+ir5tpeSHGH5ngcT6N0z8wLtWm
         9Gmg==
X-Gm-Message-State: AHQUAubkMkjiATNM0glyt5JpAVVWKPCz9/VOXs7isYg+uqrBMZQ9jxoI
        91cztIS84m+vP3ZxNUnRQ46kXnJBQwbnjgLIZGFWWg==
X-Google-Smtp-Source: AHgI3IbmU2DVVsqRSor+8xwjVZFQV0zJD7A3gaLJd96co/tYduJLXE2cmJYUuGNqBCZPD1fIGEw9gTzKWMmjnTjmfrI=
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr13903134ljb.153.1549636730629;
 Fri, 08 Feb 2019 06:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20190208123635.26755-1-masneyb@onstation.org>
In-Reply-To: <20190208123635.26755-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 15:38:38 +0100
Message-ID: <CACRpkdab=MFffe27qK5qFo1kAKcZOOeGDkEwwHa3HF+EEq0qeQ@mail.gmail.com>
Subject: Re: [PATCH -next] spmi: pmic-arb: revert "validate type when mapping IRQ"
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

I simply applied this patch to the pin control tree so we get it
in with the rest of the patches.

On Fri, Feb 8, 2019 at 1:36 PM Brian Masney <masneyb@onstation.org> wrote:

> Validation of the IRQ type was added to spmi pmic-arb, however spmi-mpp
> in device tree still uses IRQ_TYPE_NONE. This commit caused the
> spmi-mpp probe to fail since platform_irq_count() would return 0.
> Correct this by backing out the previous patch.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Fixes: 135ef21ab064 ("spmi: pmic-arb: validate type when mapping IRQ")
> ---
> Linus: I think that the better longer-term approach is to just embed the
> IRQ counts similar to what is now in spmi-gpio.

That is most certainly better.

> Since we are getting
> close to the end of the dev cycle, I think it is safer to just drop
> the old patch for the time being. I'll commit to doing that work for the
> next dev cycle, although I can send you that change this weekend if you
> prefer that we go that route instead.

It's fine like this.

> My ssbi-gpio series does not have this issue.

OK!

Yours,
Linus Walleij
