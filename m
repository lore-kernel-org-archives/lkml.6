Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A52ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA5A2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRHv8Lnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA5A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbeGQPmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:42:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35414 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbeGQPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:42:01 -0400
Received: by mail-it0-f66.google.com with SMTP id q20-v6so2380623ith.0;
        Tue, 17 Jul 2018 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E1XMdSYM49vbxZVEGoHGIfPrM8E0ywA3S2xqvFFx2cA=;
        b=pRHv8LnxJGm1/sYsyezDqOTmYWWYHLJEWmTfgAPEaMgbQFBvGmKYzO+2j7W9PVNtNz
         BIbGYjdws5x3y1ny2rUPHVGQrX2ThPRy/OAjYXn1Az7FR9fCx9j0c5HooPIwKxPljQHm
         E0gLzsm5UJGBGkcbI4KHp+VZkkMTvCYAZxMTvrs9MFBCGOEsJE9iVdx+mLOgTrddKe75
         ILN3oou/0ApoaY5YA53SQ3VOWfvqTLfFqmEvCyCNF1T/nwqbSmmCYGiOcH7b4TT77XNF
         Sc3bFYPXb2lt39Hl81lmBGyP8yDhRvfKVmHTPmvRFqfLdyj6sW/uqR//KEqKj7otKAma
         hZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E1XMdSYM49vbxZVEGoHGIfPrM8E0ywA3S2xqvFFx2cA=;
        b=bo36KjRAgnPab/Q4q2py7Gj/6X73EB+Oct8+NJq3O3kNOI8Wk5Q4Ywo4zpaimFdk/T
         VBI9M+7X/aj5TTrmZE4sXW7enshDzuPt0RrqYQagUjqfM4+gQyxZz5r8kpXqdKzq+Ogl
         66kJowDjJleQ03BoQEl8bpjtgfWEAzDQ+qORzUpdfWpXuzUWjL7TVa/4lQk5pcQ/N6ro
         u9wH2eIB+ZKbalpqbsefleoNH5kuxySPJ3gHKOaBev0j+ykkpbjClcnBf4zOtVN/trQx
         7pO2MzSiQPOAgGqXqCPwvWuqFT8t7AS4/HnICUUUXcI2iE1D0xv750eiwch+PZIJ5YWb
         6NNw==
X-Gm-Message-State: AOUpUlFXXw14wludRwwvXPHrxKYRZCXLPCPV9J9WwOJNYOzz/4rczLZ4
        /T0rOMahcEnej2LxS9KYcGBoJKyftnn9ij6kL8U=
X-Google-Smtp-Source: AAOMgpey/h+6b5GRu2G71oAr1cb0+bZpBIhzs2JMYXPMBWC1Qzt9LpUZftH4FaqxPHf2p3mklCmg8g989P8bxAo48No=
X-Received: by 2002:a24:4f57:: with SMTP id c84-v6mr1887786itb.94.1531840135986;
 Tue, 17 Jul 2018 08:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d00d:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 08:08:55
 -0700 (PDT)
In-Reply-To: <20180717040651.641-1-andrew.smirnov@gmail.com>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 17 Jul 2018 08:08:55 -0700
Message-ID: <CAFXsbZpdJvB3OtEnjjx5rNvgutmhFs=VK3uimRJnvQHLwzwYSw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 9:06 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Add support for Zodiac Inflight Innovations SSMB SPU3
> board (VF610-based).
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                |   3 +-
>  arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 343 ++++++++++++++++++++++
>  2 files changed, 345 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bea41b129493..e331b2c16539 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -570,7 +570,8 @@ dtb-$(CONFIG_SOC_VF610) += \
>         vf610m4-cosmic.dtb \
>         vf610-twr.dtb \
>         vf610-zii-dev-rev-b.dtb \
> -       vf610-zii-dev-rev-c.dtb
> +       vf610-zii-dev-rev-c.dtb \
> +       vf610-zii-ssmb-spu3.dtb


Tested-by: Chris Healy <cphealy@gmail.com>
