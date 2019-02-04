Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F1EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39E02081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2v2mR0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfBDKEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:04:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34594 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbfBDKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:04:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so9882517lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 02:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7FHYP4WCte0n2jLKNs3+2YvyzzFVKlfPJ8JKEwhsWI=;
        b=K2v2mR0BPGCK9AUrcRtb7Lq6y0NUQlwdMXAHqEKYG7FaG3wzhASDvPnIX5J8ULPW+3
         iSzwa56BLYjhvCQNUE8cVOuD2tXiII4buXdFvOuwg+vxr4ApCsB4sR4Ulqqs5Fwq4OTP
         nPfu1C6IN89R0VwNDHRHob5mnDj4e03SEBlys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7FHYP4WCte0n2jLKNs3+2YvyzzFVKlfPJ8JKEwhsWI=;
        b=il7+3K47N4vY/Knz8vL5JM5GM8FnIsm3GEcLen9hjFo28Th38U65vhBtOaAVehImZQ
         PhERN7Zlp9zcA6qdDXuniYEt8p46QujQC+m42YJzLInbCq6eMs12SQzbh0m0V+ntgkhL
         L+BmrIWM1SqdI/KDtDbdPWCiXZ51gae4HJJxita7LfVZA8NavGkLuyBS2vmrKb+SZE9X
         SkGrHOQwsw2eCBUWCAxrZj+w30Iv2IqGPsP6GgJk5lAwvuyeVEoJGIylMfU1+MU7F0SC
         KPfWJ13eml1JDTTdNZluh0c7ACFOYktT/CxpIKHiy6VOv45lH15mEJeLvn+cylOKBBTw
         2RdA==
X-Gm-Message-State: AJcUukcrcPMeC9liht0X5h7olvfUk30AgXTQYojgB9EZfgJqEnZqT3I7
        jMFW3vRVJXluBbzj+SoaJEG6QWCCLL/M0YN3w10rMA==
X-Google-Smtp-Source: ALg8bN63d5+JEf+EaXiUaRPcWX8h0ld88o//YdCI/FGHzpksxGTQD6ARuazMzHyNPu3PFbLDQCBi/JGk2FrWQ2Jo690=
X-Received: by 2002:ac2:53b1:: with SMTP id j17mr37596335lfh.167.1549274678234;
 Mon, 04 Feb 2019 02:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20190204095853.12212-1-masneyb@onstation.org> <20190204095853.12212-2-masneyb@onstation.org>
In-Reply-To: <20190204095853.12212-2-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Feb 2019 11:04:26 +0100
Message-ID: <CACRpkdapj4xo2JBBw=xo3gVAWOb1dMG8DUVvyW4qw5CAVupEfA@mail.gmail.com>
Subject: Re: [PATCH v2 -next 2/2] pinctrl: qcom: spmi-gpio: select
 IRQ_DOMAIN_HIERARCHY in Kconfig
To:     Brian Masney <masneyb@onstation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        linaro-kernel <linaro-kernel@lists.linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 10:58 AM Brian Masney <masneyb@onstation.org> wrote:

> Select IRQ_DOMAIN_HIERARCHY for spmi-gpio in Kconfig since this driver
> is now setup as a hierarchical IRQ chip.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v1:
> - None

Patch applied!

Yours,
Linus Walleij
