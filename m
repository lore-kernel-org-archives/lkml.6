Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B200FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7619620825
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iR8pZO9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7619620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeKQWnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 17:43:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37849 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeKQWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 17:43:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so18280294lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 04:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IeigedvkfxgJMUouO/J4sx8QqEmVqmvwLkSWXRc6mqM=;
        b=iR8pZO9EI1bupGmvQyArzrb4qW/SsCoX+/Um/fH7lMXDjscqWfyxDVyBdPXexdmfWK
         wfSVrZhrwrHJCDjKwA8TEMfIypHpsRTHQMrAeinymh271KK1Nk5dEh6QX6aBoRZebGnQ
         SX2XH9roYDEXIqfe2fgXVl1cmrmv2WHKcPn+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IeigedvkfxgJMUouO/J4sx8QqEmVqmvwLkSWXRc6mqM=;
        b=jIA1taVJZytd99Ji2d3sbxZbdSGDMnj86jGtX+E8vIL6S/hy5QDm9GZktFgUdzTIPj
         wVQjPfHfivWN4xBuh3PPMwlRcVt3SKA/qEa+LFSyT+e4V0vKq5S1k3ElnhVFykhTPWw1
         VZzTCHZtvi3qJu2CUCG9iPxNmjNDvgy7I8vHd56hWmNnaEiQzJTuQE2G59HsMhO0CefX
         SJ/Ho+mKSO/LYVyRrI2hEEqjlG+66VoojCv8LhUj+jUK39bN04faD4lyedJqHkyX8FBS
         vzKnStHG5Rv/GLvZF4yP240X344sBUapLX5oj+KOTxPqK1Y+IKy7SM4CoIsMyIHlAfFd
         ullw==
X-Gm-Message-State: AGRZ1gKnGKF5Tr0CziwPEKsut8Xo42YANy/u7+i2oDktZPay92Y4EOQ7
        7xwciLWMJVNx/Oiv1Im9jmVbm/Cb41pNUoCBilkw05Yd3Nc=
X-Google-Smtp-Source: AJdET5dSuujMoTJCZsrKfS8TVb2pgeIZsUKCC4tqdDxUvLcny5yVPf+AKu+oAH4W7GGimMDLM3ceCm3sdqJUgNRZ/GM=
X-Received: by 2002:a19:2752:: with SMTP id n79mr7930064lfn.11.1542457636795;
 Sat, 17 Nov 2018 04:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20181113060111.16374-1-vigneshr@ti.com> <20181113060111.16374-2-vigneshr@ti.com>
In-Reply-To: <20181113060111.16374-2-vigneshr@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 17 Nov 2018 13:27:05 +0100
Message-ID: <CACRpkdYtvD+unm9sCRxJ1DYWM1viC8Pc6ge2TpRHYko4u0Ah3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux definitions
To:     Vignesh R <vigneshr@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        ext Nishanth Menon <nm@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        ext Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 7:00 AM Vignesh R <vigneshr@ti.com> wrote:

> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
> defining pinmux configs in human readable form, instead of raw-coded
> hex values.
>
> Signed-off-by: Vignesh R <vigneshr@ti.com>

I guess you want to merge this through ARM SoC along witg the other
patches so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
