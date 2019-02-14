Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64272C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C002229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9nzvc86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436589AbfBNIRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:17:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44909 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394592AbfBNIRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:17:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id g2so3839431lfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPR1WVmRND6fGxP+NireOF7H4JstuMcUfT75OEhtKJQ=;
        b=w9nzvc863hqrtVkGM9xMKtel52paQMG+/lc0HGfmxgGhf7o7Y0wlxpvPyLH3cmO6h7
         hp3DwMmDXwo+eezk7fp/eWsLwURjvr+fwQrBA+UYWvEBwTd562LoIdHUZ0/x6m1V+XpI
         TUGkdngU0aSxmDrVaDbCa6HCKopUm8x49hWrddmt5F0aMarRBMLQZqBkQw8x+N34i3zl
         ZlGFCEfqG5EEoKVmUMI9eZ7RRUu9vgbhHPahCMZaWqCEyZgBPqUW9S/fHvf6FttZB0dq
         dBGTsHvWIoSZ3ApsVifYNL2yNopuOYc00sygGs8XE2NOCv9VjH4sES1D6CftLoyL+zEE
         kbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPR1WVmRND6fGxP+NireOF7H4JstuMcUfT75OEhtKJQ=;
        b=f4YYMoNJpfNN1AiIlBEHn8Uh/GuFX5B0H8aL1br8C8bmRx90WCEPxu0KzsVj1Xn93X
         eoQTo0ubgspzW7jLR+8ENR2SIBS/v5iw70dcFqOylRXIu2qCP4OSjwUpuziWHznmgyS5
         C8WH2D91TDH3gYpKqukwztNh3dcV+w5EB+yicSSndoz93vuAJK5o7/xFV8G01xx3lqTI
         AfNGU6ZqQmS6vUGjArUIsFT85OI+ICC44Iarhq1OK/llacOswldohgP8ZGMRVUR/MCkz
         u6Xr3gwPpW48d8WdHq+JJTz6dr60QztCnkVlpVHS3SOtyxzljTP9hYACvtwt1/trlRro
         EH0g==
X-Gm-Message-State: AHQUAuai/UnPxa+WH5LFjYRUnlEzc+UwKzU4Xqc592MM8lzcPdQMlKQf
        IdK+OVEc+qYGHKSCyeQoz1eeOih50eAzyQP6dj6b8Q==
X-Google-Smtp-Source: AHgI3IY891k4oY5LvArYdsCYim0iFFNySCOK+8CC8CugT3mtdYbv3IwsCO6upXZiv+TV9VRuZUoOv+UzVUn2zMHbL68=
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr1568421lfa.27.1550132234420;
 Thu, 14 Feb 2019 00:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20190214013641.9740-1-masneyb@onstation.org> <20190214013641.9740-2-masneyb@onstation.org>
In-Reply-To: <20190214013641.9740-2-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Feb 2019 09:17:02 +0100
Message-ID: <CACRpkdbYiwu6Bbd6uMaWUc2AzDZPve5_bq=_9RwRhadaMBf+dQ@mail.gmail.com>
Subject: Re: [PATCH -next 2/3] mfd: pm8xxx: select IRQ_DOMAIN_HIERARCHY in Kconfig
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 2:36 AM Brian Masney <masneyb@onstation.org> wrote:

> Select IRQ_DOMAIN_HIERARCHY for pm8xxx in Kconfig since this driver uses
> the version 2 IRQ interfaces. IRQ_DOMAIN_HIERARCHY selects IRQ_DOMAIN,
> so it can be removed from here.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Linus: For your ib-qcom-ssbi branch.

OK applied it there (might fold it in with the original patch, let's see).

Yours,
Linus Walleij
