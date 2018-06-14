Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6FBA6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2522A208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbjZMxRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2522A208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754904AbeFNIbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:31:41 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35931 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754866AbeFNIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:31:36 -0400
Received: by mail-io0-f193.google.com with SMTP id k3-v6so6335016iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+YStBBN95UlUwr3EzcW5s+pzK7bzvJHPiNoWbUXyXHQ=;
        b=gbjZMxRZbP1vCMkcQHBhiVyDTl35iqwb45Xjogb4J4D5MzivuLQYrBVirpIrDhDc92
         edpHSGBUrLwg/WiUbrNS9dWxnw/M8ks7qr7VxUPD7vdFo9yGJPEz7QN7BDNuIbVBGLM7
         INBpNrIWiowja2mDI8PoEMcsBxMJLNkbehv64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+YStBBN95UlUwr3EzcW5s+pzK7bzvJHPiNoWbUXyXHQ=;
        b=t9La3EvhXf235ApVcw6ppgVbeBrUSSzO2IYoVENO2N02Ay/9DYUZycouTG0XWnChIM
         +wqYDFwhgGZIsV8BtnzCKv/RzTtBLaOx2mXY/FmVzM+wyA/tEMrt3zD7xdZo1+Y3IEmL
         CalW9Wy6YOMev4+ItjbeQXaKVOnBM2i5ud/VMKlYJhGUjS2s2TT1qqvV0xOhLGV7GwbO
         vtmsONAmwK8uggYSrWoOyBi7XpMV0VrxH2xM+5NEFnEBYlTLoR62b25ND+Ppr58oAjAW
         3Cg+Z0rm9DJU+UD8ueObViiQuXdfAQnAOfkzGLmUR/vAWp8VYJ/8OBNhdRfyVTKiJeAU
         uEJQ==
X-Gm-Message-State: APt69E2vR77FznsvcP3UnRLKGgUMQqvTn0FnjafTbKZwk5ICO/Zk6IAo
        E0x/zYILOqPRGrXgMOYz5p1vczm0RNwHMu2w3iQxdw==
X-Google-Smtp-Source: ADUXVKJG9HaYZkY5y72OST0l5e5KtmSINV4zhfV9QStRxne+uPGPfRSEdsbcDAyj7Ve3dfCRR3R9jX4xd6QVvAhaLqc=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr1425621ioz.304.1528965096319;
 Thu, 14 Jun 2018 01:31:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 01:31:35
 -0700 (PDT)
In-Reply-To: <20180606134338.4645-1-colin.king@canonical.com>
References: <20180606134338.4645-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 10:31:35 +0200
Message-ID: <CACRpkdZEawUiEU=qP+x7gTH5Sox9gH920ef7Cw-Y5-amxr9M2A@mail.gmail.com>
Subject: Re: [PATCH][next] pinctrl: pinctrl-single: add allocation failure
 checking of saved_vals
To:     Colin King <colin.king@canonical.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 3:43 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Currently saved_vals is being allocated and there is no check for
> failed allocation (which is more likely than normal when using
> GFP_ATOMIC).  Fix this by checking for a failed allocation and
> propagating this error return down the the caller chain.
>
> Detected by CoverityScan, CID#1469841 ("Dereference null return value")
>
> Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with Johan's and Tony's ACKs.

Yours,
Linus Walleij
