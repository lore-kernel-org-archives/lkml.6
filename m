Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEB9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF58421726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z2KTpPOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAVXqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:46:30 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35029 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfAVXq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:46:28 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so234263vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8WHf7hkWnN/nMSBQaVLy22YEIon42+kV29du3uzw2U=;
        b=Z2KTpPOKxWwss3Pdzik/34A5WOV7IyCY4tdtyqUXTvdaykr0SuAgaXjMbn9BQTAppX
         JFdJ3GTGBrE9Vrw2iL1FS1Y3g7wwYz+RHHDD98QCC4y/1J5RCuaEj6gCS/f0T3c9+lXt
         awFydh9bDQjeABPf7vC1nC7S0F6f2KfcN5tSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8WHf7hkWnN/nMSBQaVLy22YEIon42+kV29du3uzw2U=;
        b=EJEHerXk7Lke7gbIZ5DVyoomYpglXy5Jfdy2sDNV55nnQ1wJbx56hMvVMz6gCgP+Sf
         NCo+99mrGzjijhyKySc1WAfA6WznjoeEDoLS/JjQiJgxHNeEjHJdbTeIs0hriNnQLVWE
         76P//34uQazxfAGOcumNmrOb7uqzi9EWQGCR8UrxF/AJNH33phzKKKCJ4MjYg/tbE+2K
         t0VwOk+nafNvRnkMN5Ffpw4XRODewAtciTIwmZ06g2H8q6ZrldJf3YNcW5KkCBnMmLDS
         NOSwIXpUZc5Gb9Ub7wkPq3nXPUN83DEY65SFIVoIPWvtabtiRvLGLndZa9AmRzNJCbgK
         ywYQ==
X-Gm-Message-State: AJcUukf/BKshKcnLZBL0WtfX+57rVXdGkAfD5+uZqFR85qlLDOA641om
        QBaVqoGjze9OTOCU6SwmK2bB6AUufjA=
X-Google-Smtp-Source: ALg8bN69V5Adpw0lPglAT/FaYjpTDhsdNX3cFf0mob+DaR91Ulcr2MX5YKg9V0AZiAaKB7/25g9pTw==
X-Received: by 2002:a67:e89a:: with SMTP id x26mr14729544vsn.80.1548200787128;
        Tue, 22 Jan 2019 15:46:27 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id w65sm34101970vsc.16.2019.01.22.15.46.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:46:25 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id y14so90744vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:46:25 -0800 (PST)
X-Received: by 2002:a1f:ab17:: with SMTP id u23mr14190434vke.73.1548200784941;
 Tue, 22 Jan 2019 15:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20190122055112.30943-1-bjorn.andersson@linaro.org> <20190122055112.30943-4-bjorn.andersson@linaro.org>
In-Reply-To: <20190122055112.30943-4-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jan 2019 15:46:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WXind-uk7V_XTDgM83LZbmtKb2Ln6pQjmUkaZMz8SFsA@mail.gmail.com>
Message-ID: <CAD=FV=WXind-uk7V_XTDgM83LZbmtKb2Ln6pQjmUkaZMz8SFsA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 21, 2019 at 9:52 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Add the ADSP and CDSP nodes for PAS-based remoteproc, supporting booting
> these cores on e.g. the MTP, and enable the same for the MTP.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v2:
> - New patch
>
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  8 ++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 58 +++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)

It's a bit of a nit of mine that if it's not totally obvious what
acronyms mean that they should be spelled out in places that use them.

In this case I believe ADSP is the Audio DSP.  Is CDSP the Camera DSP?  ...or ?


> +       adsp_pas: remoteproc-adsp {
> +               compatible = "qcom,sdm845-adsp-pas";
> +
> +               interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
> +                                     <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                                     <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +                                     <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +                                     <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +               interrupt-names = "wdog", "fatal", "ready",
> +                                 "handover", "stop-ack";
> +
> +               clocks = <&xo_board>;
> +               clock-names = "xo";

I've found that nearly all the places that refer to xo_board are wrong
and should actually point to '<&rpmhcc RPMH_CXO_CLK>'.  Maybe yours
should too?

-Doug
