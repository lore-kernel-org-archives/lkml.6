Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC81C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BFB20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgQqJZUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BFB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbeG2WTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:19:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37952 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeG2WTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:19:17 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so14151128itb.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0XJ73p9AmUDRyXmYJx3AeBjw7ZR9thb6t1BaxJMTuk=;
        b=LgQqJZUyfrbEBNqHxZ+3lHZghxGt3udppcrisXTyq8kNa1BQJjpYzVExnYtFW3eKXr
         wFqRjBLXkr0P1b+KgVP3RIoiI15IxWBFIoukGAA4NbZ54XwiUThMRF0fxGGm4DHuziIr
         PFP/kSJsCLK74L09ki8js4pYk3O0eYGWGHt9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0XJ73p9AmUDRyXmYJx3AeBjw7ZR9thb6t1BaxJMTuk=;
        b=RgVaWEwDYH30X1KBeBj/OgKRvecsCtKUOW9bqN875SEnu39EG17uJx7loT+ETMrGUh
         OO+VElSSvYxYCSJXqTjG4jQ5hPpa+fgYjyGozLGHfakLhj+VcvfY/1GjSw5+VsYNZ7O/
         ycsz+0nVXbZjx/WyDekFLxNdiRO8/Nswvqz8BV5fACHv/4j4p5pSePlJIhI3TiPFDI3V
         KhKrySu/f6K6jvnA+VdvZb38rx92OqxJPqunz18WNUaIZr4FBgh8RllSoN9oWnnuSwlv
         EmtPhTNBCE+Cjzk1XQzGWvkyAC9r6+B78/Kd/RpRoX231xntsh/J4X4Ai/8UrOZSNPlk
         dXQg==
X-Gm-Message-State: AOUpUlHP5m37OD7SirlkGDbiX2k3HXZaxjAxjO5tf9Py2jVrGZMyKsbq
        FSDbagoX2LP6vRKL3TpBc+8u5c88zQcCROtOybbW9Bvc
X-Google-Smtp-Source: AAOMgpd+djduGFIK/1pnRjbG/c62ZF0XJ76EK9vLUZsNj6aZ/ncaV1z1lupV1Npxf48iSsDq5b+3SnvAZj9xDc035ZI=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr14202057jab.87.1532897251306;
 Sun, 29 Jul 2018 13:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <1531981249-26329-1-git-send-email-hayashibara.keiji@socionext.com>
In-Reply-To: <1531981249-26329-1-git-send-email-hayashibara.keiji@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:47:19 +0200
Message-ID: <CACRpkdYD6FT9k50kc4kSx_nzv91wTeBYgJ1jHVrbFDY-XMaB9w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: add spi pin-mux settings
To:     hayashibara.keiji@socionext.com
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 8:21 AM Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:

> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>
> Add pin-mux settings for spi controller.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>

There is some problem with the test robot, can you comment/followup?

Yours,
Linus Walleij
