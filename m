Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4D2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF28C218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5I2IPL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbeLUKPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:15:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37508 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731021AbeLUKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:15:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so4231864ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGstlgzAhYekvSI+PJ9By92VAGAoLLwYkDeZkhyu6X0=;
        b=c5I2IPL2v2/au8jFT5du0k+RJP1kCtptQ6y4dH+1/Bit8xmzEJc4/12YMmnPUnpUh2
         ojVRNIlnxl/nKp7jqAplsaizrmh3z38cOghW302OAWFagOg4SG8pZ9J5t5RpWCJlYRsc
         8wDphWPt32yfcmnPlelX7NX9Mw+fGekaPCElM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGstlgzAhYekvSI+PJ9By92VAGAoLLwYkDeZkhyu6X0=;
        b=ejl3W4cKYXRi71vJvuCpArWPxdwkSLVt4LLO962tVg8Nz67rNuGF1s2DmfjrHw+0zb
         +EZP+QOiKFkwnTH+XZkfWBu1Q7IgXsiPkM+CFQOCvCFgs9EfYc8aSec2FbHutV9qR6X5
         pPPc/3Xo6M8/UN2+BgYaokfKyztGxF1HHJt2dLYUQbBx4Tp8X6bGIdU9CCApZSjAC7yF
         VzKNYHbLMttRM9QESLvT8ciFaoQh2AbJ2M+5IBKIwDuF348QJ7l/gRJ9Sh61VKhUUmfu
         I4ERDbKUKVGQJnklfnurLlMGTBiYYuCqyIrlctHlm2Y1BZ/JPC/rI8GZS31jpQ28S0ql
         XAnQ==
X-Gm-Message-State: AJcUukd/SoC5rXe16t9D4j5+fNgYFZeRst2YJKsDWN8rP/h4XO2UC3UT
        UVISCwfTiSPjVghaW+IPE/QvQ5GetHFBd6uBReKGxA==
X-Google-Smtp-Source: ALg8bN7AopW4FfqmbqbcDvGxfNYRDMgbPHW18qr/+SeYk+5GjNXRgJbQgLxxSX/kfbkrDMjq5hpbL14VpZIRL4d2eK8=
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr1190314ljk.4.1545387301141;
 Fri, 21 Dec 2018 02:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20181212215305.3852170-1-taoren@fb.com>
In-Reply-To: <20181212215305.3852170-1-taoren@fb.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:14:48 +0100
Message-ID: <CACRpkdZr7zX2cvk-T93Ahj3Q2cE7-ey+T4Kr0n_==jae3KGr0Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: remove duplicated statement
To:     Tao Ren <taoren@fb.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:53 PM Tao Ren <taoren@fb.com> wrote:

> Remove duplicated assignment statement from aspeed_gpio_probe() function.
>
> Signed-off-by: Tao Ren <taoren@fb.com>

Patch applied with Joel's ACK.

Yours,
Linus Walleij
