Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E8C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ED02085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/PWM+er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ED02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeJLBOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:14:24 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34043 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbeJLBOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:14:24 -0400
Received: by mail-it1-f193.google.com with SMTP id l127-v6so19359564ith.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VredD68RQkdLGxjyI3KHSZPYpnDTy3F4zyzvuM0YGVM=;
        b=j/PWM+ertg5d9cYAS2iqL1n9XaJrlDiMdINmSdx8ZZU19S7KBFe+glzGsqPMtzDumg
         w0kgaRLPMbYBrQxOccRI8sw1A8SbRQQKZHr6IRr1xIiaz65GS1CAziHiXILCQoaPPkvw
         E5sy3NxBWmepfhiMqjNij5cY2RCe+tK2PRpDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VredD68RQkdLGxjyI3KHSZPYpnDTy3F4zyzvuM0YGVM=;
        b=r5XP2OpeNniGWPibuxZlz/MkqZpMfOwsjap61/zN3wp/Ipx9NGOFmUmLvbAsqYXkk0
         UoXOflx7oK687HicW1QCR68syZwFnS9aiIj02sFC8viK8847O6hqxyHYoP6HoyIWWqas
         cshG+Tub/A2brLa8tKnyh3tZG48QLEaq1wxno+GL5ysKXDSirTc+pQQNPKX8Ov/TmcLf
         htE6o9kMYy5sImjtDEkLT38o0kt4zEWVcxuBW1KfulSTcRVUxZnPDIm8Lm6Cxjh4ZFZC
         AfLR3Gi0Wbfpr0h0Dqto7EJS1X8zvmSLtTcHeKKJ3dukM/22x7MRftGu1IyK15ob4BXQ
         yADQ==
X-Gm-Message-State: ABuFfogfArGPlYn1N7D1yrU/8g3Svt7iF+sWoRjcHk30fshDlSJ3wvN1
        IyAOEmofFrEMqBqd8Vw+V499BKSiXQK9wU/DHs/2Hw==
X-Google-Smtp-Source: ACcGV61iqN2TbDIp+8GhHdOaxzo8DtSQQbN020Oqt8zyT1XaHGsGUwNaIeUZzWbHP4tr275BavYfzWjmSTRT2ib30pk=
X-Received: by 2002:a24:e0c8:: with SMTP id c191-v6mr1467468ith.156.1539279968266;
 Thu, 11 Oct 2018 10:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org> <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com> <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
In-Reply-To: <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Oct 2018 19:45:54 +0200
Message-ID: <CACRpkda+J6R99SQP9yFVH2HANJSi3M4GjT0duaHdv8wZcs7ahQ@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Thu, Oct 11, 2018 at 5:00 PM Jon Hunter <jonathanh@nvidia.com> wrote:

> This also appears to be causing a regression on the Tegra124 Jetson TK1
> that also uses a shared GPIO for two regulators. The 2nd regulator that
> uses the GPIO now fails to probe [0] ...
>
> [    0.680021] +5V_SATA: supplied by +5V_SYS
> [    0.683964] reg-fixed-voltage: probe of regulators:regulator@14 failed with error -16
>
> Not sure if you have one of these, but otherwise I can help test.

Would be great if you could test the patch I came up with for Marek:
https://marc.info/?l=linux-kernel&m=153926854327176&w=2

FWIW what makes it so confusing for the GPIO maintainer with
multiple consumers is that unless there is some mechanism
(as in the regulator core) to pair them up and avoid them shaking
the GPIO from two ends, it makes little sense.

So I guess in the long run I should pull this into the gpiolib somehow.

Linus
