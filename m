Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD04C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA63D213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwa6brfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA63D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeJLBPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:15:42 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51730 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeJLBPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:15:42 -0400
Received: by mail-it1-f193.google.com with SMTP id 74-v6so14799656itw.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiJ196eFkj504vfcnFsSqK9pXoBP0TBEjKHnm0WAbXw=;
        b=bwa6brfiVnoyTNOhUxIcPlQyszU/XlliG93FxmQ5VB+Hx7FC9sGk8CHfcCTMu6DukB
         EBr7+Co3+KapA+EJ+xwmQw+KzWnEwx3zaUAwxSEJzQdOVdxNDAIspCmh2YPTTutUeBWt
         uZCTdvJqpqvIXNW4Z6i3QAd4dvGwLSMHSrx2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiJ196eFkj504vfcnFsSqK9pXoBP0TBEjKHnm0WAbXw=;
        b=P9Iogc+S4MJCaO3f2PxU7CbQ2ZfPvrlgVM5toyMZQWKo68HLcOdn9IbX+0GkwVXn75
         M5/l67XzonD8SlgRNoCqc9KgagTVbJH1bNFBipikoe2pzY3vc6s+n2+nNtHEroqY4JN2
         NhLiBWZC7KAWyc5g+cF+vUUNS3rtR5YXEkAInwGTV78T4wBq1KZC9rlCCtXRz7YvLKTz
         GokNGrM8TsRz2XlPKZ7g2eGFDFqJvg5HdrZd1xM3wXxEmZRSPYYtpM7757HDwVoLB59N
         mfwEygE9waBvD6/K0rVNXkbbUxnQnTBiVyT53xMRNwPwdzcR/rpBJQLW/VjYjroJJTFx
         WoyQ==
X-Gm-Message-State: ABuFfogM4d5ZFA6/DOwlMFLoIOWS4ZSj/UmKkjY+wmm6+9NfaU9eob6t
        xtA7uuvLEAYMtHchy4P2b/p89k4t21jpeWG5awVDbA==
X-Google-Smtp-Source: ACcGV62ps/EQ1u394LAl0QIt4XQeKOnVpu6qvYtLizFrFW47tAfLgwqUoB1/1TxMcAR5BYRVRC4AMuwQowXjLV2dzo4=
X-Received: by 2002:a24:e0c8:: with SMTP id c191-v6mr1470699ith.156.1539280046494;
 Thu, 11 Oct 2018 10:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org> <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com> <1539272073.18645.12.camel@toradex.com>
In-Reply-To: <1539272073.18645.12.camel@toradex.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Oct 2018 19:47:13 +0200
Message-ID: <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        jacopo <jacopo@jmondi.org>, Mark Brown <broonie@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
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

On Thu, Oct 11, 2018 at 5:34 PM Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:

> I guess that is also what broke HDMI on Apalis/Colibri T30 causing me
> to submit a fix [1]. I may also help testing.

I see there are many ways to skin this cat.

Does this patch fix things for you as well?
https://marc.info/?l=linux-kernel&m=153926854327176&w=2

Yours,
Linus Walleij
