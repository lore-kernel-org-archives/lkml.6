Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F1CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F30520857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9yia882"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfBHNek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:34:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38715 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfBHNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:34:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id j15so2545634lfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVpF5CM4kmNqgD308Zd6OdbapiCMvc6nkYIh9QkfA1s=;
        b=D9yia882uReR1uWCds/eKVRffZcoVsnKUe8GFGv2OzDHs/BOzfBM+r/tfAJzXf1FN1
         97JBsaEa0RukmUx88UoHh9/awRA58L8slnXn83cRAaINkG/M6W2aMDeXVqBUSZRsFFtR
         +awEG3ilmGdjKl4UqTyAGVTQzs+/0z7rl2OVlev9AjjPWzWAUc3E98wPlDqTsz4vZ37h
         XCtjP3TPbtJd5XZnvpKJnXYyU+j2Lgmp4nY95EnZY8AZN210MBRd9rEIuPHaRq2KACCp
         1z3dpsXgmX4vBLcfrKvlGSdioduePRFg2F/Yh0e+bvOnwIAcWSOb78yVRgjxT2FDtGAq
         OiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVpF5CM4kmNqgD308Zd6OdbapiCMvc6nkYIh9QkfA1s=;
        b=RUjWaXRLBv1ZYRsTDndnerZQNYn/TQ2nVEgWqaGcf9tgemkZYB/bjxJeK3iHSkzGoK
         B46ReI3KCTgVwK6QmcH1Jl6utAd6sRdnuBEJn+Pkj4JxS9x5w2EdxIcL3S3uPbVYeGkf
         cAZ87t/X+HZjQWhzaBbaT/QbFEIaiSqO09W/k8z8UY0drg7IaqlFz7CDWj3hC6GUId9l
         5rVx30Lcv7r4VFL/CJSMMQPbETDl9YvyjWEbWlDLiAC82xopfXtCZo4ey0xkngf6ed/r
         WuS0NkbHu9eBzMlsAGLuEAy4r8vdlkWTUdAaJZgl5ep2sDNpLZi8RwtidCmbwQrghZMU
         EE7Q==
X-Gm-Message-State: AHQUAuZqj20uGTk39fu1RstP4NXCLqN+dtRbf7U4fLUWAy0VbkaLJj8g
        1OGMEBq97es/NtTeOW2+pg24kDYJc/vcHxZTv8O3CfZd
X-Google-Smtp-Source: AHgI3IZ99r3YTVCn5AyIyH5vFejioN4md+OJ7ebUTpZ8i/e5O9XdbeRnYkYn8YKjHtXkHi0C2wW0lJm1I3oyLgvv1Ls=
X-Received: by 2002:a19:c502:: with SMTP id w2mr13206138lfe.168.1549632878369;
 Fri, 08 Feb 2019 05:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20190205102546.29457-1-brgl@bgdev.pl> <20190205102546.29457-5-brgl@bgdev.pl>
In-Reply-To: <20190205102546.29457-5-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 14:34:27 +0100
Message-ID: <CACRpkda9M+MWxQnfkSbAXxdXjR0Ko41+rh+GbmNzJJTLn8Ptaw@mail.gmail.com>
Subject: Re: [PATCH 4/8] ARM: davinci: da830-evm: use gpio lookup entries for
 usb gpios
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 11:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add lookup entries for vbus and overcurrent gpios for da830-evm.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
