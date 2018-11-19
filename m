Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54287C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AD12089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AD12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbeKTGCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:02:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35739 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeKTGCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:02:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so50658627qka.2;
        Mon, 19 Nov 2018 11:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+Y60y4lGm7XkCPftRN73fmQbY1Flo3OgfwrHMQgznk=;
        b=fcRVNjLKPDFsQitAvaJ/PhE17Pv5V2/Yi+bujWUkvPVSBB55BR56vPB8UD/KCxuEjv
         uojFFxrYuEQoJMighW6bVsLe7RH3jq6TEz7XY6Q4NSbp2zW88pKzQcfCfM0id1ybzd4X
         WDMNRGf5/K6alavDOf126ygwCYWTcgKHTEIWHo0/8GcanDTPi3FnaWLEOSLH0avEKII5
         jCZcr0qUXV+OYKE6OjsJA6sp0BqSoW0dyQHfIlcVTreokCGJxx64r2ZkisPEEYxJjcYX
         IkXVAl5XEApfBBKsDdoLKaIv4VcReOI+E72FfKq2HNR0EaF1NERF0oQTx0ddqkGY5sKd
         JwmA==
X-Gm-Message-State: AGRZ1gLO5Pd60yzY7rQg/37j3XgaUResO8qFIWnpZbCTNqcm5qi7do1X
        /uUZojF2lNKSFmPqnnwDvQJI1EliCrGq2MDBGl+h2w==
X-Google-Smtp-Source: AJdET5eG+P0vhxl2Wk+a/73Veb1POYsj2lir/wgHdNZ9Q6bwXcPzhDRFKbZ4eunQilg0YTLipxuo7FU6Ktb08QzN0I8=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr22265057qvl.180.1542656251185;
 Mon, 19 Nov 2018 11:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org> <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 20:37:14 +0100
Message-ID: <CAK8P3a1ZOTrUFKvBCdMX-1Fj5Pnk__+GJdee7pOieb2oiWkpuQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] arm: dts: Add devicetree for RDA8810PL SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net,
        service@rdamicro.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 6:11 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add initial device tree for RDA8810PL SoC from RDA Microelectronics.

> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +       };

Better move the aliases into the board file, there might be boards
that only expose one or two of them on physical connectors,
or that count them in a different order from the SoC.

      Arnd
