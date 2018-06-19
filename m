Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C98BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AFF20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AFF20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966366AbeFSM6h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:58:37 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38979 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965883AbeFSM6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:58:22 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so12964717uad.6;
        Tue, 19 Jun 2018 05:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxATvKLX57hJ7bCxyNylZe+NAlfHbwl3QiuYrJOk/BY=;
        b=mfb8S53lnIxFJF5K2P+fu5oNGDOVDElexTipnO2urupRPgD417nyQ+SSYoiAcJ0BE6
         1Bke60S54ZCv3ijGSdbONNVYIvPGNVfao8djLNlRbOnVNif0RVkYNDltNmDUxHA9YZWD
         aCtFsmsX6FtD57T3kVO3ABkOOpI6EzTfOnBM/0I5cA0JQclTwX/MofRp3oP4YxbOc3uo
         AyHKahrQtM31xxTmh8oMguh+uAUWODBHP/ngVwXrAmLUag68s18PIuavAZ1Ql2coaV3E
         ll4GlaFUbluXxnS0y6EeRKW3e3XiIyu6FxPWttQoTNpX0BRhyQz4Q54gSa4NP9TsdyLS
         F2Vg==
X-Gm-Message-State: APt69E0nqaxCeEY53FjpQ9gzuEeB/xFF4VuPH4CyEfE67QbMhCP4hF3P
        jSbIgX6I2Z9LE3umJ5m7hDRxgqoZuSTmbMd7ywTWnG6B
X-Google-Smtp-Source: ADUXVKIlvUraGYP0R/hEv9tdxmyfsrrA/HkXvVEA0ZNMmlibvr+ukbyWfJCQFoIK1kN3VhuvYPua14UqN6OpzZ3NMME=
X-Received: by 2002:ab0:5b18:: with SMTP id u24-v6mr10477503uae.72.1529413101203;
 Tue, 19 Jun 2018 05:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
In-Reply-To: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jun 2018 14:58:10 +0200
Message-ID: <CAMuHMdVXrppnFEBmR3xhwNu3i0N3mVE1+FJRjEcWBYpHHbsAsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] crypto: ccree: cleanup, fixes and R-Car enabling
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ofir Drang <ofir.drang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gilad,

On Thu, May 24, 2018 at 4:19 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> The patch set enables the use of CryptoCell found in some Renesas R-Car
> Salvator-X boards and fixes some driver issues uncovered that prevented
> to work properly.

With DEBUG enabled on R-Car H3, I see lots of

    ccree e6601000.crypto: IRR includes unknown cause bits (0x00000098)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000C0)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D0)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D8)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000E0)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F0)
    ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F8)

during boot. Is that expected?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
