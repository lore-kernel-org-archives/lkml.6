Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5BCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3809217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V48hZkPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfBFJiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:38:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34006 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbfBFJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:38:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id v14-v6so2625904ljv.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 01:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pksc5xSW35axSafhA+jwace7jvXGf7lqu2z0eWnBdv0=;
        b=V48hZkPKaS+bOM1jlo510IXzADyWjwkM/ESRjz82/nuuO+VWMl8JiOU7TDE7WTIrXq
         Q/KWKSlQggzMNzaS+7tLMpHtdVEJIf8tL6JI+7ZnYDwjFY2nXj5Sl7OxPnnUFCICw7EE
         r2Y82MXXr30qCcK/toWS+3+txnMfmn5oq5LoajJzAbVDT12jmGZaoeSWDnMWcUcPppXj
         BfmDr/G7Zph1inNDfasVYanmN/syWOTfDuS+K+tiKEm3drhK5GQfW7+q4hRXp3U+Xw4B
         LorxHlBbAWj4+u1Mpq3gwLnZB8GsIDcLJjTtH/CpBthdDIZiM4z40jWMO8lICuxKlOVq
         m/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pksc5xSW35axSafhA+jwace7jvXGf7lqu2z0eWnBdv0=;
        b=gffFZ+D9ARUstLpMqD9dhNR2fYeFxcmNPYBzE6+28x3Py6KovHAPK1ffHvT/jqQJ7Z
         K35yn0JgxATyHSBfuNfLQgR0LwvKkbb7DlU7XKhp9lExKB7DjnmhCIHoa5NgFmbdL/yy
         OpGQw/f7yOI5ACcdE5mFkmFZ3bGUagOZ3kVcvZZJdBHKQaIpKX4W4g9+ommxIl6nlYaO
         0MilyFEMQkv7RCt8B0vUW1WSFEumcf8PCLrCJVL3b+Ad3qjAQMpBtdCTMYTtjVd1ZRoY
         mfTWPJNRSLsfzrue8TG4f82C9YbUC5xCh6EZ3fuKjQp5zjxeHiWog/AEqYHrv4ld7mys
         Ig6w==
X-Gm-Message-State: AHQUAubEmQ9Xu8JA4miHZ0AT8KTVx7ejD3Gdz0KNbQpzjsSKo7haWwlW
        Ji23KK74Q9baQBQzRCJww2tG+N6WmMu27C81jUflAg==
X-Google-Smtp-Source: AHgI3Iafif5Np64QikzkJkDaJRLrL8DihqqSgatdfIW1U/95LFQCGFYDRbK1UX3UPySc67XHpKWKfaaBvHnt1va79GI=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr5816253ljh.135.1549445900688;
 Wed, 06 Feb 2019 01:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20190125162302.14036-1-masneyb@onstation.org> <20190125162302.14036-2-masneyb@onstation.org>
In-Reply-To: <20190125162302.14036-2-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Feb 2019 10:38:08 +0100
Message-ID: <CACRpkdZQcJ9ZrUdMdgYFN2H1QkOsgdKfsz4PEnJFtYra0+RM1g@mail.gmail.com>
Subject: Re: [PATCH 1/9] pinctrl: qcom: ssbi-gpio: hardcode IRQ counts
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian!

On Fri, Jan 25, 2019 at 5:23 PM Brian Masney <masneyb@onstation.org> wrote:

> The probing of this driver calls platform_irq_count, which will
> setup all of the IRQs that are configured in device tree. In
> preparation for converting this driver to be a hierarchical IRQ
> chip, hardcode the IRQ count based on the hardware type so that all
> the IRQs are not configured immediately and are configured on an
> as-needed basis later in the boot process. This change will also
> allow for the removal of the interrupts property later in this
> patch series once the hierarchical IRQ chip support is in.
>
> This patch also removes the generic qcom,ssbi-gpio OF match since we
> don't know the number of pins. All of the existing upstream bindings
> already include the more-specific binding.
>
> This change was not tested on any actual hardware, however the same
> change was made to spmi-gpio and tested on a LG Nexus 5 (hammerhead)
> phone.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

I found a bug here:

> -       pctrl->dev = &pdev->dev;

Do not delete this line. Subsequent code makes heavy use
of pctrl->dev and crashes.

After fixing this I get other crashes :D but those are from
other patches so I try to locate those problems too.

Yours,
Linus Walleij
