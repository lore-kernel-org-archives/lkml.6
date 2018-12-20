Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8840C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA235218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aP2kn+lA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbeLTSOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:14:41 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41868 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732563AbeLTSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:14:41 -0500
Received: by mail-vs1-f68.google.com with SMTP id t17so1656198vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVQRcZQN96bCOPNHdgG5tEwa97yOWB8bDA315UyQrug=;
        b=aP2kn+lAjRpUVG5gzgCbbEO0jZBi9+9jJXQDYyb0SAXARQ4UEKiYDbZoENsYE7eKe+
         u87TYyQUGlHc4ETiT7z0CFikwbblhLM7+RJPzimlmRUAoF4askL3QdGCUict+KAXTxrV
         njNmmKpYV+zgITPCz/psgy1k6sviquDu7fiMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVQRcZQN96bCOPNHdgG5tEwa97yOWB8bDA315UyQrug=;
        b=B8NxILm+wPGq9Sja/EeK5TeBej4V01IL6dD0ddY7T5tWhxpRhHdtwAqAHqpNo9bPgp
         9KkIgAe5lAo2dPtQlmEHEuIYSRWOoIQ+Kq9NlcqEw+jVZ5h/71EzDto/+m0lXAQkdDcC
         vlj8+Bp85RSqAPkAyvstU4zsTyWM+qgCN/cEmmeajlGQFoggOZXnFHUiYv+q5+3ChG/V
         B9VqT2du9c9w/+1WrapHv6Lnc1z2xv+jpCllh9MmQUylK0aQAs/M6xXFwclmzZ4fjbSO
         bk2N7TAiOlemeJVKXKN33DwX9N88mkGWca3bHgl6lgVGGY0jcS71PC6j95YpjmCw/HQp
         PNyA==
X-Gm-Message-State: AA+aEWZpaEIt/wEOK7VOrBWW3w25YmwYiVu/GyisnBQ8C3fu29x3iIlv
        Fznv+YdWzbZMGqsWd4qekTcX4bVRC/Q=
X-Google-Smtp-Source: AFSGD/VH1pNvATjOJ9/mQCKp/ahPzc2OhCaW8ZyTM3iysVls9uHZqfC12AqbU3j/mmL8BlKix3f7aw==
X-Received: by 2002:a67:6204:: with SMTP id w4mr12856001vsb.68.1545329679474;
        Thu, 20 Dec 2018 10:14:39 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id c11sm8575390vsd.9.2018.12.20.10.14.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:14:38 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id 197so593347vkf.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:14:38 -0800 (PST)
X-Received: by 2002:a1f:e807:: with SMTP id f7mr11710641vkh.16.1545329677754;
 Thu, 20 Dec 2018 10:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-7-ilina@codeaurora.org>
In-Reply-To: <20181219221105.3004-7-ilina@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Dec 2018 10:14:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V_+wbOhiVNHYAiZ0zD8tC6vCbZpWAZOhOESSnH12Dqig@mail.gmail.com>
Message-ID: <CAD=FV=V_+wbOhiVNHYAiZ0zD8tC6vCbZpWAZOhOESSnH12Dqig@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: msm: add PDC device bindings for sdm845
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raju P L S S S N <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 19, 2018 at 2:11 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> Add PDC interrupt controller device bindings for SDM845.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v3:
>         - Fix PDC map, use GIC SPI port number for hwirq
> Changes in v2:
>         - Order by address
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

nit: ${SUBJECT} makes it sounds like you're adding something into the
"Documentation/devicetree/bindings" folder, but you're not.  Also you
probably want the prefix "qcom", not "msm" since it ends up in the
"qcom" dir.  Also, subject should say that this is the interrupt
controller.  How about:

arm64: dts: qcom: add PDC interrupt controller for sdm845


> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..8e15392a6f64 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1278,6 +1278,15 @@
>                         #reset-cells = <1>;
>                 };

nit: the above node looks like the tail end of pdc reset controller.
That has a unit address of b2e0000.  Your unit address is smaller than
the the pdc reset controller so you should be above it, not below it.


> +               pdc: interrupt-controller@b220000 {

nit: Maybe the label should be "pdc_intc" not just "pdc".  This is
just the node for the interrupt controller, not the whole pdc, right?


> +                       compatible = "qcom,sdm845-pdc";
> +                       reg = <0xb220000 0x30000>;

nit: apparently common practice for Quaclomm dts is to pad the address
in the "reg" field to all 8 digits.  So the above should be:

reg = <0x0b220000 0x30000>;

NOTE: it's important to _not_ pad the unit address in the node name
(so you got that right).  Only update the "reg".  For context:

https://lkml.kernel.org/r/CAD=FV=WrvRH6QpaQ67yw2MFz8RP59ozkSfQC4+OAM_8fAbGZuw@mail.gmail.com


-Doug
