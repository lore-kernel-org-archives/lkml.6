Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4DAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C763520824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPX6WLY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C763520824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbeJ3E4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:56:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45571 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeJ3E4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:56:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so10057918wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mtor5hUQOZM2V9SZFC7nPGmJ2W1+7l80r8HlWEPyAt8=;
        b=aPX6WLY+DRXj1q4f1O4X1uBWaxNKxWDxCbBWbC98VfoAqLlb/hCTOPz3bhz21hy1Yh
         ghcpZWoFBjM9RVBZIKLNYm6aXsemZEunmBBNdGaOniU12ZNMqEBZFV6D4XSMMcxQ0oal
         /nUhZH58VefvPzBK4dlu7YRwY9t3XuplnHni0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mtor5hUQOZM2V9SZFC7nPGmJ2W1+7l80r8HlWEPyAt8=;
        b=Wr8Xs7F6R3kaBJr6KP9XohRL4tpqEd3tcfYD73D+ZURO/orF7R6OFKxaVLu3M99DVw
         vw+Ux5C7QnVW1wdRLz0M7w1rtqF0ZAEwYvL6C9TSmJVYD5SG8yCdBFdT/qRKGgOhAJdP
         LiV6RVE4/hL1m9Y17v5feu1+qRa3/HiOmFuWoWOqWPjNv/ERNUVLzmOU5OWbW3YK635Z
         LhRGkJJee5ztQ5aysuAMgwbHkzun/rT08LDeKC0dt44Lv/JvJSyAwJZ4m9BzPxfzA0Q2
         XyEBKdTX0Ls0kC6bu/NRGVBE4+Ieztf8SsMr6NIhs9V1b6KTaMUQrFLVvkUmzs2YlUn1
         HPhw==
X-Gm-Message-State: AGRZ1gIuWTnPMfgZRWr6jL6h6tUVFgYc2G/7W5G0IXxtKnmLSVNLdQbN
        7NTBLUL2Jxykm31/K9j35Rt5fG3RetakxOKCASiv4g==
X-Google-Smtp-Source: AJdET5eJSt9aS4vd5aaPfN+lqzie686AxHzP6WKEucHYM6mgTHINe+LmWTUEgLR/Ee78dhuK6aDMuev2qW0GO43KIXY=
X-Received: by 2002:adf:b245:: with SMTP id y5-v6mr15000255wra.90.1540843550027;
 Mon, 29 Oct 2018 13:05:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9f47:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 13:05:49
 -0700 (PDT)
In-Reply-To: <20181029200311.16947-1-semen.protsenko@linaro.org>
References: <20181029200311.16947-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 29 Oct 2018 22:05:49 +0200
Message-ID: <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Praneeth Bajjuri <praneeth@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 29, 2018 at 10:03 PM, Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> The kernel is self-contained project and can be built with bare-metal
> toolchain. But bare-metal toolchain doesn't define __linux__. Because of
> this u_quad_t type is not defined when using bare-metal toolchain and
> codafs build fails. This patch fixes it by defining u_quad_t type
> unconditionally.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Can you please pull this one, if this applicable? I sent it a while
ago, but I guess it got lost in mailing list. It might be also
applicable to stable branch (as it fixes allmodconfig build for ARM
with bare-metal toolchain).

Thanks!

>  include/linux/coda.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/coda.h b/include/linux/coda.h
> index d30209b9cef8..0ca0c83fdb1c 100644
> --- a/include/linux/coda.h
> +++ b/include/linux/coda.h
> @@ -58,8 +58,7 @@ Mellon the rights to redistribute these changes without encumbrance.
>  #ifndef _CODA_HEADER_
>  #define _CODA_HEADER_
>
> -#if defined(__linux__)
>  typedef unsigned long long u_quad_t;
> -#endif
> +
>  #include <uapi/linux/coda.h>
>  #endif
> --
> 2.19.1
>
