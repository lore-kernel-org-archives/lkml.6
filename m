Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A16C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FCD20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeOdmwB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FCD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeJLSfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:35:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45305 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeJLSfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:35:45 -0400
Received: by mail-io1-f68.google.com with SMTP id e12-v6so8878980iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4UHiGkAZ+o+54MjXN/yqnBdpTfXdZRH6F84SVbUT1k=;
        b=jeOdmwB30cAhnGhKftD9yzdjIlqS7EtT9j9azHjcO1/vmEvtdHqr1R8pP6DX6T58a5
         pa2/sQYs75ueDtSkYr87yN6Kqh8vU6EAV/LossiGWf01hlMGFToIL3+zAL/lZtWCO4Ac
         HPbOZxNR2XEbA5C6ws3Yj0zpSl1WovamtiO1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4UHiGkAZ+o+54MjXN/yqnBdpTfXdZRH6F84SVbUT1k=;
        b=ehTXfLrj4eSujb8bT+wjeqQCk0CumQHb/DgWnrwYbVx5/iSSZaXQmJgqmTuUQnby3V
         CW5FlaaMIXadjjUbabQuh2Ic4AVrqM+LofdAuEitbn8eFkW3qalnW9jcmTVe/AH0ndv8
         ncy7BdZeKb4G+VlrqncIh6G7YAYwwE0Px1KRX6tN8PLG0GtHqPfcTZSmu5jgKqZzGAo1
         8ggOW3wgYNWpkJ2wx6FXPxK3MxzGi7SXkYdEgz3qwrM8BQ+Zx0dvlZitRYM3OdVEN1Xa
         5lO3fXGlhTZCmpXAFoAZD1/qp4dcnoFO7Sd7xqe/5yMjhzNIsGV8fl7qixfaHe3zWAn5
         OSzg==
X-Gm-Message-State: ABuFfoiBsBTsmc6la3qPghAFTeAzXZHVIorIzPrMSO22fCx3SN/3k7Ov
        L+nScgqijzxZ6ywdSP9x6pkYxwZzMeCmwXlmgQFhJw==
X-Google-Smtp-Source: ACcGV60DgJl45Yx1ZlzlQhwwMDhBlGVBehf2Dg4O20I/poNC/iVbg1Kh1V7Lsu2+SakOfb3S+oTghyGS2hwBKZtntvc=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr3843503iof.304.1539342230966;
 Fri, 12 Oct 2018 04:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org> <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com> <1539272073.18645.12.camel@toradex.com>
 <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
 <1539337415.30485.21.camel@toradex.com> <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
 <20181012104338.GS30658@n2100.armlinux.org.uk>
In-Reply-To: <20181012104338.GS30658@n2100.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Oct 2018 13:03:38 +0200
Message-ID: <CACRpkdZNzUwLG2virD_UqxN_SwO6S_xZASfXZnaSNBiXEk2DWQ@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Russell King <linux@armlinux.org.uk>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        jacopo <jacopo@jmondi.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        linux-tegra@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:43 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Given that DT describes the hardware, not the software implementation,
> it must not change just because we move from GPIO numbers to GPIO
> descriptors.
>
> The existing DT description is reasonable, and introducing ficticious
> regulators in DT to work around the implementation is not reasonable.

You're right. In the electronics and the device tree it
makes perfect sense for the same line to enable/disable several
regulators.

The patch I made is a quick hack to allow multiple users of the
same descriptor, I think the long term fix is simply allow multiple
users where applicable and maintain a reference count just like
the regulator core is doing, assert the GPIO when the first
consumer asserts it and de-assert it when the last consumer
de-asserts it.

What the old and current gpiolib does us just
call the callback to enable/disable the line immediately as
response to the callback asserting/deasserting the GPIO,
which is just too simplified.

Yours,
Linus Walleij
