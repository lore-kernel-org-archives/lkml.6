Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A609C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD50B2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNJ9jpfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfBUMT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:19:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40098 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:19:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so31164630qta.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/2ZNi4+seoP8wcE7AZcv+b8GKE9EWvv7oGd8OropbY=;
        b=QNJ9jpfTMWq0Z+o8hYx5pydLXsVQX+x/b9KHpe9HHz7EMyr6n8X0vFpC0BoLGoxg7P
         DUNGRKjqtAR30JhJhIKA7WHZxyuLhmQmQKRp6Nb+uSxCt2KjVe26h98DbROld7N5RprS
         Aa2WY9jGDl3OqEuphtrK6/358mQrXFrxqYDz9yw+fvxIoAGDDLdEXpPq2hWtq1+nQjr4
         xDg/BchLaBHQoTFNKyZs/OJgnIYhOKyIt+hJIriuXu/iWHWo1gEuNi6YfMDoB1gwayZM
         ecxL3I+70VFRjPUX1VXs4iaI9fo//0v4Ze0kGf2WBL1kK2BSJJt3aO2DBjtW3Nb6xu2g
         68Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/2ZNi4+seoP8wcE7AZcv+b8GKE9EWvv7oGd8OropbY=;
        b=pbsibeNhF6ny5kfF25JylVuwzKsryqx1W1yF5axzk7RD0OQRTJrTDs+tztuNMTRcaT
         y4GafIxP9gTfQa65GqAJnY2D5emEXxLtzkDWKr0U9Hc7J6n42Zz5EYzKFcmKm6rDWSVR
         HBCz6YrmuunNDWtRIzOkaVI5vUWe7qB61ouRd/u/1upng3eSu3colA6u3qEXLubOHHln
         KBhBP+mLS6C1X85AUaqaWyUbIOdp8NdJIMoFeuk9iSAkcKk+fFBia27CdHgqlZM4RDLu
         CNn6bdsrI5jjo7ld122udE5eunq7VUqQSxp3wBw5Fb/hh8Jj+pYWd2GWrlv4Nqni/R4/
         nA9A==
X-Gm-Message-State: AHQUAublqGCeZqPbJLSS5CTVhtzGDzl++akGRY3VpYm6u7EgB0Crraob
        9VNZPm7SGaK6z1wm/5rqSojA9craQu/p58WoACwpxw==
X-Google-Smtp-Source: AHgI3IYb+Lim4ujwju32agFaluOMpK0kYIGpC5Ft4Pko6+uRB7FcgF/IuC+G8nWeWCfnE2koeKPLve8dK5CTP/VFVHs=
X-Received: by 2002:ac8:26a7:: with SMTP id 36mr32065386qto.234.1550751566925;
 Thu, 21 Feb 2019 04:19:26 -0800 (PST)
MIME-Version: 1.0
References: <70f5476004b2f4e4b444bf8425f21a3c993edf47.1550543288.git.baolin.wang@linaro.org>
 <d0f8377078efc1af13fa81c5d6837f3f26ddc1fb.1550543288.git.baolin.wang@linaro.org>
In-Reply-To: <d0f8377078efc1af13fa81c5d6837f3f26ddc1fb.1550543288.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Feb 2019 13:19:14 +0100
Message-ID: <CACRpkdbctA2T8iAXT30cAUr_RFntSSsd4ksH+_dDMd+w7ORZ3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: sprd: Change to use SoC compatible string
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

> Change to use SoC compatible string instead of wildcard string.
>
> The Spreadtrum SC9860 platform device trees and drivers' development
> are still in progress, and now we will always recompile and ship
> device trees at the same time as we will compile and ship the kernel,
> so we do not need care about the backwards compatibility.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v2:
>  - Add some comments to explain why we do not care backwards compatibility.

Patch applied.

Yours,
Linus Walleij
