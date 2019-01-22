Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2EEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3710121019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULo0J/+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfAVPbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:31:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37953 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbfAVPbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:31:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so18387829lfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 07:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOUGIsOmORGCKF9e/Rej5bdFQhHGp65y62/iyDGaMw0=;
        b=ULo0J/+95/RFJrwpNuWhU/t4wKC6IbzdkhWhQL5xwrq37MATb03ijwLLIZf0XGgWnR
         4dh5TDSG2+VdozXVROc8nR2JSTujGVlw1iqPYOhhU2d0T7TDGYkFnDTo2+TJEik0d5ti
         kAcyD1rSRh9OnitYwHPMiKMcGJ5wXc5nYdSCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOUGIsOmORGCKF9e/Rej5bdFQhHGp65y62/iyDGaMw0=;
        b=OVedLDIIloLQXUtnm5rgchMqLw7rfIsG4VOTe33a59DHJ68Z26qNlsyOM571BxkVVT
         027yEspT2kKcu6QzOwOgomftf/BzEdOTFt0dj8QSxBkZJUmMTq50M83BxZO91SSSm4m9
         /WhQYxkHjm1vvu2VaIggM4UWd+XwdUxDGhBR8H+RWgc26lX+mqwpfuspH7mI8BW1l7x1
         uBKaWjszkZFrlHyJKT6xKZHsJp+34pX0mWQG37hpZxFMmLFPddH1Ao+UIq84Wu13DJ/f
         8OejFpxEGSh73kzQpY9hApzbRtytLeghfDbjM0rGkDFKxOsgTH/O9t5wljJBiQajZHYD
         6NJw==
X-Gm-Message-State: AJcUukfXmjP2sZ5uUMHtIY3VS8yML8KEFNhsguVLqKwZx5g9JUmlVnp5
        xtAJeyzIcvmmWY+9xElahf/eHUpVrwSyY2dL59sCTQ==
X-Google-Smtp-Source: ALg8bN6DBUGFQHWcspfZphc6neU6bI0ryWZmZUGOC9abaQY+j0kFSe9L7BbYFmKeGXIvsue/NXBP9kxVXEXMuxE5K3c=
X-Received: by 2002:a19:db82:: with SMTP id t2mr22237666lfi.130.1548171092168;
 Tue, 22 Jan 2019 07:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20190119204252.18370-1-masneyb@onstation.org>
In-Reply-To: <20190119204252.18370-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Jan 2019 16:31:20 +0100
Message-ID: <CACRpkdap+AJ+eDVusg=ShwRKXOuR=tAyNLBeCxsxuu28DSfisQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] qcom: spmi: add support for hierarchical IRQ chip
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
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

On Sat, Jan 19, 2019 at 9:43 PM Brian Masney <masneyb@onstation.org> wrote:

> This patch series adds hierarchical IRQ chip support to spmi-gpio so
> that device tree consumers can request an IRQ directly from the GPIO
> block rather than having to request an IRQ from the underlying PMIC.

I have applied all these patches including the DTS patches to the GPIO
tree and pushed for linux-next.

If all works out well I will solidify the branch, pull it into the pin control
tree as well and offer the branch to ARM SoC.

Yours,
Linus Walleij
