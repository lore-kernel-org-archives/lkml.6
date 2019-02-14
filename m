Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A9BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC05D2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uh0eGBum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbfBNIhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:37:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32833 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfBNIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:37:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id q12so3944474lfm.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlAXueGcvjHiLE2O4ktb9Vz2iI347OJ62TIAr8BaCuk=;
        b=Uh0eGBumTRJ2CwK+wQQeh2BtQUzWSfhwOoGYKq3uZutjboyx2oRb375JQagqBajbDZ
         ozwsCW0j6bmekP/kiicbSPCLWjSmPSoXkoWv2SMpj5L3WLemVDv8Bt53vlleOBPUPIw1
         RQWuxLxTkW5u30yGstgrzlA7UaUSMmZKLRoXbkTsq7gbCt3u6w9490rV2VnoJLcMmcJT
         l3WKh8F9rH7aBFY8Ul1kpWt7iEnv+9VfF4fgxMd3z5L+NgAkgFLsbiqo3wwgbT03okhH
         RXHEP1e4+KbpRkhn55OtLrnumHZGWW4YpxKajMEWc3bYH1pEin7G+GyKc4oJNuQYf0Z7
         Rq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlAXueGcvjHiLE2O4ktb9Vz2iI347OJ62TIAr8BaCuk=;
        b=piBEgabTJzUTr6zZkqUZ+SFvVA5zlDWt/TIVdoiGjHUIRwfXbTyVn7h4n24D0tTAec
         cYRc0uelk45vl0VOphMkR4aPPnsXuvoi/md7GCHConGE6PIv5cx6qTDlYxmPb/SD4YiF
         FuJaco4nPADGGxpPGIm/8iSMKzC5YIio2hy2Idg3xfVBAy0W8V3lrnk2DwTQO++sQErQ
         wopStnSlBtghUGAmra1z4EvJ5lztpLQuoBMgD0IgSqwEKIsKQ3adQJMVoBKWYz2CIiCc
         Z5vpy5Y80NucEhIyE4QtnVhAnbrQvcFM8mdJ3mmLUZW2+yNck2hZoQ2WvFrrQrFKtxHo
         IdYQ==
X-Gm-Message-State: AHQUAubZjBOvOBLn5Av7Kl201dRkNlmDitW5zYlb8igGA+tHB9f/yI5A
        bv8WouVykT8dxKBHTdtGXK9i+9H7aKQ0YXA6PIR29A==
X-Google-Smtp-Source: AHgI3IZnMnsbA6HFvtkDegBmlNI9gbBmVki+3Z2hKdUrUB9wKMk4JZ17kL0X4GfCePgAUcD72dbZALrR85T1VrvJ5Y4=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr1389261lfl.129.1550133439774;
 Thu, 14 Feb 2019 00:37:19 -0800 (PST)
MIME-Version: 1.0
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com> <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
 <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com>
In-Reply-To: <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Feb 2019 09:37:07 +0100
Message-ID: <CACRpkdb4Q0efW5MaDmPTmewq-RFwXOTp15DCE1VpPf6g216iBw@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Suman Anna <s-anna@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, Marc Zyngier <marc.zyngier@arm.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Lechner <david@lechnology.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        nsaulnier@ti.com, jreeder@ti.com,
        Murali Karicheri <m-karicheri2@ti.com>,
        woods.technical@gmail.com, Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 4:13 AM Suman Anna <s-anna@ti.com> wrote:
> [Me]

> > To be able to use hierarchical interrupt domain in the kernel, the top
> > interrupt controller must use the hierarchical (v2) irqdomain, so
> > if this is anything else than the ARM GIC it will be an interesting
> > undertaking to handle this.
>
> These are interrupt lines coming towards the host processor running
> Linux and are directly connected to the ARM GIC. This INTC module is
> actually an PRUSS internal interrupt controller that can take in 64 (on
> most SoCs) external events/interrupt sources and multiplexing them
> through two layers of many-to-one events-to-intr channels &
> intr-channels-to-host interrupts. Couple of the host interrupts go to
> the PRU cores themselves while the remaining ones come out of the IP to
> connect to other GICs in the SoC.

If the muxing is static (like set up once at probe) so that while the system is
running, there is one and one only event mapped to the GIC from
the component below it, then it is hierarchical.

> We have implemented this as an irqchip using chained interrupt handlers
> with the consumers using the event numbers on the Linux-side. The PRUs
> also access some of the associated registers for clearing an event source.

Chaining with cascading is when two or more interrupts fire the
same upper level (say GIC) IRQ. If there is a 1:1 mapping,
it is not chained/cascaded but hierarchical.

I understand you used old irqdomain/chip frameworks in the past,
because everyone was working around the fact that they didn't have
an abstraction for hierarchical IRQs. Using chained interrupts
and custom 1:1 maps and assigning a long list of IRQs like this
patch does was the most common workaround. But we should
step out of that habit now.

Different levels of the IRQ handling having to do different stuff is
what hierarchical irqdomains do best, so it sounds like a good fit.

We handle some stuff at our level of the hierarchy and then fall
up to the next higher level using calls such as
irq_chip_ack_parent(), irq_chip_mask_parent() and friends.

Yours,
Linus Walleij
