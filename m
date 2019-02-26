Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BDFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6520217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NpNyNyfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfBZGLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:11:40 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55932 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfBZGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:11:39 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so2260406itf.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/FjzLVkfWc1Fpambna4iPYL8u1WjShUMfs1JzjB/L4=;
        b=NpNyNyfWgZBUJy9cgBSxcs/cSiKgU7JyLKClM/fo+yXZoxFP6Rdlr+pkSAOKeZ37PR
         EpqCQpPs560kd24GAMaxx9BMAaxCDswGJu1qFn8EeYah87dh0DoYY3ix64JyvQtmijiF
         9S6o6xPfFft9QN7rJoroLyM2j+8PDMsZjm79c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/FjzLVkfWc1Fpambna4iPYL8u1WjShUMfs1JzjB/L4=;
        b=hXQWbdOWJtFq4ZJ4Eh+z3lbjP1T5OlKXPGrdxdRwe+GVa4k6UU/KRYxOnvoGicvLMJ
         04/ffQeaSbpSAJg+NJVBFc0ji98owNTAoSQMvc0baERGlFb0z4Rpn2XqmyiAbJYyIpLz
         RjCDkoAIvNQXJupfVdgKHkG8H4yTu+nkU9D7hKcxCjfhso6Bm9uyJ/IglFonnpf+PyHr
         sSUJKOSXMDEixL4ISEewYKJYKN7Js39Xi1ZuMCB5duQMnvGNf8sk3A8Jk2zhY3LF6SP3
         WyUm9RiELqocGDPtWVfrReyKbrNOJ2fIH0kWIi8XEssIYeE/YgncktWz4eMP7g6T9zpp
         R/yQ==
X-Gm-Message-State: AHQUAubC6HW0LYskh5eP5uAdLtzezZAFOLr3lPk3nF7yRGNWkNxNxc2x
        qpAxI08+ufeARcXy9IGo37mnOi1kea+uZOIZEGz+LA==
X-Google-Smtp-Source: AHgI3IZgMtrSTKoRB4M+UCROfckcl5fwwa2duCJh7qRfl6zO/NUQGFMaqf4teYSgYBcZS1RidDk5IFw4l90YjK/RP9g=
X-Received: by 2002:a02:b5e4:: with SMTP id y33mr12427774jaj.85.1551161498760;
 Mon, 25 Feb 2019 22:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20190212115232.4532-1-jagan@amarulasolutions.com>
In-Reply-To: <20190212115232.4532-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 26 Feb 2019 11:41:27 +0530
Message-ID: <CAMty3ZCdYiWPstFh8JAwLSWwC6sE3Un+-QmKDaEWwmmWF5MQ4g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add vendor prefix for feiyang
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Feb 12, 2019 at 5:22 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Add vendor prefix for feiyang, known as
> Shenzhen Fly Young Technology Co.,LTD. a known producer for LCD modules.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Note: notation about using 'feiyang' is based on the datasheet
> http://files.pine64.org/doc/datasheet/pine64/FY07024DI26A30-D_feiyang_LCD_panel.pdf
>
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index a5ad57eaee20..f42e12eb9d64 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -140,6 +140,7 @@ fairphone   Fairphone B.V.
>  faraday        Faraday Technology Corporation
>  fastrax        Fastrax Oy
>  fcs    Fairchild Semiconductor
> +feiyang        Shenzhen Fly Young Technology Co.,LTD.
>  firefly        Firefly
>  focaltech      FocalTech Systems Co.,Ltd
>  friendlyarm    Guangzhou FriendlyARM Computer Tech Co., Ltd
> --
> 2.18.0.321.gffc6fa0e3
>

Any comments?
