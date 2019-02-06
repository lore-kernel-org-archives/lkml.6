Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6011C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9504A2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5VTA7OW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfBFMBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:01:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38085 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:01:31 -0500
Received: by mail-lf1-f65.google.com with SMTP id j15so5136842lfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 04:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alQXlRABZxGsBwyXN8vJmrW9qOB/AJZRlxeH7KjpRAs=;
        b=c5VTA7OWNNhUafU+dzUvFsl6/6LiMsQ6mov+mvu7UpfnE5xStimzn754fhXpfUFA3R
         WDnmoF0n+mzGq/FAQ+dBbIcd4RcXT6ehMjFzg8PbDqRqQb00DloN1ci1rQd3o2i889vx
         82YehowXfXpf/dZkmE7oJX3ScJZ38sbJ1etwQtGG/NBa1cReZdQ7SS/cJkFHLP/7knjP
         7sBQgPHphzOCNxIpCbc3uFBD4TGSdCWzEilmjg3M0RtlZ/MYdDgfGvI0PH9PV4yxAhJ4
         qz8wFG7V+6APZYrV8n7reNIoibnVr/NXq7H8I2owB8BfE+15vy449eKxqdR9XTeml0+Y
         8Ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alQXlRABZxGsBwyXN8vJmrW9qOB/AJZRlxeH7KjpRAs=;
        b=km3CdhyjNufVYfKARso7Zz3EWlJgrvf1GSluvqBvTDbxQVm/OI8TB+7Mr/AMEtVvRm
         P4tKC+NA0+jvz8vzbau9VRNtQkXiDhXhEpohTyAouWfowdHOJQqgxpOcvbjSb1uHPGPY
         IrDSdwZOYqP3KqPvdEaexD4CGZeCDw2SGONiNOcV5y0BtmuLSSvHczouehjf4mQ4LhR1
         FCm1f+rANBoLI06h/j9iz2OZY3kK//FZIeT+cn4rfPGulk8T3ZIU86FxfuTfqUxYRsyC
         VxasxG9B6QX1QfcfS3lAptnv15hJGfsbvyROHGDFrV+kLO7jQqbV8Dp/3IyFh4EGEjuT
         S+Tw==
X-Gm-Message-State: AHQUAuZje2vKFiOgUtmQBlQLIgnqZF0yzCVakMw3WYJMYo86gzpUojvc
        4yYJESh9cSUpiJrko0p9tD9nBPW26OzTG/4+thOYpg==
X-Google-Smtp-Source: AHgI3IZhDc4i7yy8Qm8fl3g6Cw1dB4dQS9WhhuTZPQufaiZmVzXEgSGYkRP7QIAybe7aMzbHG+FlGswYdfqgu8M/Fn0=
X-Received: by 2002:a19:9a08:: with SMTP id c8mr6283085lfe.8.1549454488940;
 Wed, 06 Feb 2019 04:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20190125162302.14036-1-masneyb@onstation.org> <20190125162302.14036-2-masneyb@onstation.org>
In-Reply-To: <20190125162302.14036-2-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Feb 2019 13:01:15 +0100
Message-ID: <CACRpkdb=xsWG+x6pQZYrnpubAiOEx7Bs-puhKMZcQPuvxjX5gw@mail.gmail.com>
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

I found a second bug in this patch:

On Fri, Jan 25, 2019 at 5:23 PM Brian Masney <masneyb@onstation.org> wrote:

> -       npins = platform_irq_count(pdev);
(...)
> -       pctrl->npins = npins;

Do not lose this assignment of pctrl->npins.

pctrl->npins is used further down in the code and the gpiochip
does not probe because of zero pins. You could
get rid of the local variable npins and just use pctrl->npins
everywhere though.

Yours,
Linus Walleij
