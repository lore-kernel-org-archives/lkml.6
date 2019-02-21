Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEB3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D5120880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBJHIFhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBUMSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:18:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33641 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfBUMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:18:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so31240297qtz.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFw2flC4VtWGsXIcAYWNPt3SI6bIFUGFsW1L2eun4Ys=;
        b=NBJHIFhNvz5g53eqf+QxZmq9Y9j35kbISnVMOkBh6TGXlpFnikbw/45NuksCs9h2BF
         WjJP3Jl3V91RjgF3gU21gdWornzWVolx85mC1JXCuLKNnTU9m/O2FfD2fNCMehiwMtCC
         v8jEEcXJ3XjPzAB2XC67z30HtZhvAYOwsbT8eVsvPZyaSzHyJGj6TQB2APG3AAf1Dphx
         qire8zLpV8W9ptCHHF7XNrExW//PSUSpz41NEERTaTgFHD0vuLKsunrSqVMql9XQVBoh
         woc/8nNT1BoVCf0w1P19fcXj/mOnPknGBu/CdsHHGoeKs57T/RaTXVyczaFqDD6QEoF5
         Ku/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFw2flC4VtWGsXIcAYWNPt3SI6bIFUGFsW1L2eun4Ys=;
        b=oMEVpVFnWRVetGLCBUZJ8j5soQSNgswyNZbzzcrBPQGSRxvVPrq3pLuEsL5BfHv81y
         soFKY6bgAinJ1T4DV8JCBCjsJt/8+4yBn/15itvDhDzzVpNtlpTjoRHiMycpnJvVHc2j
         cq21lFBnClXae3ubauQBxvdeI+7x7M81jO8h2hePCHeWseVEzNVpHcF6ghjh9HeZBkBl
         ogtvTcEpI/ZWYLnihKx+PZR9dosWTSRm+O/nqMy3RvSjZXRyAgBEegv/wEngI45emj/l
         sr0W5vyTqz021R/DP1bDxTpDfVC1l9xeAe+JDbrux/fGNpUpA0n6w2OMwBLjBYYYVn9P
         6VWQ==
X-Gm-Message-State: AHQUAubLecj72e0tlY1JmQ7TGPj/aOyWLdnZmmdd0pYGMY795NaegCtM
        c6hPNzTsnhPIMRadu0YbTiK1ZS8Hmi/RxmiCAWxkpw==
X-Google-Smtp-Source: AHgI3IYhSaiOCNupyi6U4JsVlX5fL+K/TKUxF7WBVg0ICMcMAz9dBUUpf1cUfs8dlMoiIwU6PY44oPAH3ZzCjdUofMw=
X-Received: by 2002:a0c:b60d:: with SMTP id f13mr5805505qve.209.1550751509922;
 Thu, 21 Feb 2019 04:18:29 -0800 (PST)
MIME-Version: 1.0
References: <70f5476004b2f4e4b444bf8425f21a3c993edf47.1550543288.git.baolin.wang@linaro.org>
In-Reply-To: <70f5476004b2f4e4b444bf8425f21a3c993edf47.1550543288.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Feb 2019 13:18:16 +0100
Message-ID: <CACRpkdYBrxiPcAS3ML9G3u41-8utgWqG+BHpAcJ-BdQRLCUtOA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: sprd: Use SoC compatible string
 instead of wildcard string
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 3:30 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Use SoC compatible string instead of wildcard string.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Patch applied.

Yours,
Linus Walleij
