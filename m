Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F75BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B7D206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZcHJtAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B7D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGQWJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:09:12 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39268 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbeGQWJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:09:12 -0400
Received: by mail-ua0-f196.google.com with SMTP id g18-v6so1628764uam.6;
        Tue, 17 Jul 2018 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SSgaQbajrGW516224Z0u0OepwxYlwlsqhHVnIr8soto=;
        b=pZcHJtAU0xHm+vg+JmHZABs0UejizdoMyDV7396hiaJFSbWEE9mudHbwxwHOZ7Lxvp
         XT9PAFhFINT03cRDwykLyXosHqPTXVMIeV0udlhHef8L7IUsqCSXOsiQPYMYMDgEbAHf
         w+FShurAz7wa9OcBcUHlqWqqt81AfXIyHaKOXWxAoGcyviOCrsXKiS25Ps3Gc3OeFHF3
         yrLx84kePrMkPQZ4lQuIuZfoVWFG7a97Jqo7xORqDTNQUkaKPQWpAOsA0fo0hjLBv0iX
         vfXdAxza+6c5v62v9C6yNflAgaeA8B9byZbw4yM2rYxeUHHvJrbI72LSNOKDIeJ37NqQ
         mUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SSgaQbajrGW516224Z0u0OepwxYlwlsqhHVnIr8soto=;
        b=kjiQQfTw0nJGCpJZ8YgQfFf5x2PO/ySugVs7WJKEFWqq+sNB8miPisPm3/s9jZTnm6
         e9p3tz9R7mR7DQ3xNbdap9YYljJ7nvzxVmTy+LE1G+cRTiTonqf3ocTQPQnFvhSo1FbV
         pCopQuqf8V+b/QaGsq93ZQR9a2WyJ6XbVEBfPNEBsWjopozV9Sc4y27xw8jIyJDaakoR
         ub3KNoHFXpqoDglv4YajGeI0YDNyz3pl84D/2VTrjXvw1c4sFy9LPZloa+k++Fk3EeET
         LW2WuZtAeADt5gIi4Pr/JBpi8RZav5pUQHaiQgqXEnSOu748EyEA+rm463eycTK1e1w1
         IuRQ==
X-Gm-Message-State: AOUpUlG7LbnXlaoBbP0cOAc0orEtfzoOXeXrEGfqD2mDt8/Mb7cM522p
        nNbWVJoODD8umBI0c1YzJJWprFy7ikVXqiz88wvNEQ==
X-Google-Smtp-Source: AAOMgpf6rCJmS8l58CXw86X7rfgeUEKgAAEvl8dcVrtWFx+CVYmLtUd8N6KXGCG6nJOkqTVTNTz1nEeqiBpCXMUYGGw=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr2192189uaf.199.1531863277679;
 Tue, 17 Jul 2018 14:34:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 14:34:37
 -0700 (PDT)
In-Reply-To: <20180717142314.32337-4-alexandre.belloni@bootlin.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com> <20180717142314.32337-4-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 00:34:37 +0300
Message-ID: <CAHp75Vcvqqv4kHHDE2wbtVFFa3a5FLqg8meDeOa59-qaDFGFTw@mail.gmail.com>
Subject: Re: [PATCH 3/5] spi: dw-mmio: add MSCC Ocelot support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Because the SPI controller deasserts the chip select when the TX fifo is
> empty (which may happen in the middle of a transfer), the CS should be
> handled by linux. Unfortunately, some or all of the first four chip
> selects are not muxable as GPIOs, depending on the SoC.
>
> There is a way to bitbang those pins by using the SPI boot controller so
> use it to set the chip selects.
>
> At init time, it is also necessary to give control of the SPI interface to
> the Designware IP.

> +       ret = dw_spi_mscc_init(pdev, dwsmmio);
> +       if (ret)
> +               goto out;

> +       { .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},

Looks like you were thinking about something like

init_func = device_get_match_data(...);
if (init_func) {
 ret = init_func();
 if (ret)
   return ret;
}

?

-- 
With Best Regards,
Andy Shevchenko
