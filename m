Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A48C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11EE2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YurVLAZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeLPAYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 19:24:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42169 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeLPAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 19:24:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so6902390lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 16:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/wXWijC5sXloSVHQvvLkkFGdyUckN6W9iO16EUSGP8=;
        b=YurVLAZ3QPt+RUAeLQqynWN2d22ySzTvG8Wa8q83VWnhASro/75edN0T2Nub4iecEl
         NWH5cywjkuc2Tkq8PcEnDN4hd7jClYJiqjX3a33jYwqj/mei/IlEy8KysTv3sXgZHIGC
         kCOuSwFk7h9Ox7BVD3IyN4vDQ/Gax6xKbm3Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/wXWijC5sXloSVHQvvLkkFGdyUckN6W9iO16EUSGP8=;
        b=mge/3IeQPkCreis/h6tVrH32Gm3mPvr1Hze7QvYrYFXijZFjZ+29VfkN8BOBEPE5jS
         +g99fyj638SvQPeJ9G+1u9cG3m5IlsUn5Z+szObrJN1jhlcaZR9y2QkZRZSBK21ektuY
         Odz7+T4N1r+StQbOeGpJ8+yxe2nxpcYw/NswwPCazDlTJIIL1AC8XjiGUx6NTNwPJxp0
         2QMgBMwvRz+GdnwY4C4UJv68V5hwpsmb6E6IoalZZnEtNiqGd5jy5u//2hGxzUGpddUn
         Z0M4riRwmxieXvJXBDx6PDAoSSVuEUZrb+/VXz36dFsi/VvTfaelhZLM0y46FPdFuT3X
         0I/Q==
X-Gm-Message-State: AA+aEWbfHMaDI43GnDtkNh3fMlXVG3OXHp5exy5SdNnQRXRntwb9Gfoc
        Z/uNvKIUqGkzAvG1C1DCYEY2rSpLAhxWsWNCCcrRew==
X-Google-Smtp-Source: AFSGD/XT4DcCs4J5DYsLcJjspPIaeJRfDEOYdNVXff6Xs0Xkm2SzbCfjKkdTKC2cGUDjaLbFS9sgO6EXHFgb5DQl3+M=
X-Received: by 2002:a19:4849:: with SMTP id v70mr4377570lfa.62.1544919838333;
 Sat, 15 Dec 2018 16:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20181211000506.7559-1-natechancellor@gmail.com>
In-Reply-To: <20181211000506.7559-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Dec 2018 01:23:46 +0100
Message-ID: <CACRpkdYH9VDjzpH90X=gTKAnw1guGG3uUjDmUXcSkBxg=6LgyA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:05 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang does not support this option:
>
> warning: unknown warning option '-Woverride-init'; did you mean
> '-Woverride-module'? [-Wunknown-warning-option]
> 1 warning generated.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Patch applied with the ACKs!

Yours,
Linus Walleij
