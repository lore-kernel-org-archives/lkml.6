Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA6BC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109D92199B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZP10S2am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109D92199B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeHLVF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 17:05:57 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46613 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeHLVF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 17:05:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so23669054oie.13;
        Sun, 12 Aug 2018 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS1nFiUxhWrligeidaRBQXtVHr3YpXQGq+U0CEJidkI=;
        b=ZP10S2amePBgdq5z8w8O1rSQVycqeEGN7U4lJLoEM/T5sbvFZpfQvWuyKZ+u2etQhs
         vTryBxnUfj/kDmXK3MM+njQiqV205k8kTvon1DiTA2nAdBEC1TzpwglpSHiZCayto/ZI
         895kOcDWckBYUp9Dl40DPOkSTHNSaOh3IkpUuBnJNhwYNPaN3Kpn6/hYKRcYOij7R+N4
         hYzGKliCeVgtIdYxIT/Dm7IHa8fvQp+kQgfPZs2A6N/fF/wx4gDN1MjDeMuZoPjTJ21W
         +I5XA9MMeLjavvZpL36sPL5vawBW22LrFC04nceejhPrcNOhtEOP0BJD9x1WBicu/ygE
         1JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS1nFiUxhWrligeidaRBQXtVHr3YpXQGq+U0CEJidkI=;
        b=JGWuAH/Wg17PGmFUDrHqbyD4p35zHNeQ7LKX31Ed3N07ExOJ4bNHSwMwNQ2Z+jEdub
         9n4n3X75PDQc3FV5FfqubvYFL6rFh219R4soOxyctRYS7SSKHSJmKJPnQkm8rJv7efiP
         VqJAUnUPkgfT6mzyxiUOren2Zvq1kvLreghtWgHi1Pr0W5hgN98lGBDErmonGngNh4Yp
         dvhbzk10iVxwBvQ5j1X1uT3aEOb0jjmKFUPPX8vqqYEETYk6f7uxE/bGqAlX93neefzD
         q4zGXOECPmQ5bc/GnVl0GFSUouHrnCqcbHSx1DjZ/dOGK6dwNhK9MBcF/70rIgcOMzcL
         RyqA==
X-Gm-Message-State: AOUpUlGNUUNgPzbPQ3VYqsjYTP/Mvbavy/hgi/pQ1auQvXYXQAiPb+LL
        Qf5O7+qKmnMrme+iihUQD5qJTqPViMFhmFO2B1k=
X-Google-Smtp-Source: AA+uWPwgX9f+kIRLV61pI11yaN0wesOMRlExdGP4z/HHPitjmuHmChIokuam7zHmSvVbkhhIa1bOr2kk5nby8ldtvlo=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr16209849oib.116.1534098423906;
 Sun, 12 Aug 2018 11:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180801140053.25899-1-jbrunet@baylibre.com>
In-Reply-To: <20180801140053.25899-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 12 Aug 2018 20:26:53 +0200
Message-ID: <CAFBinCCNY3=yo42hQUqJJzeSetLni+whtWaBZCL-MV63DDYQow@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] clk: meson: clk-pll driver update
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Wed, Aug 1, 2018 at 4:00 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> This patchset is yet another round of update to the amlogic pll driver.
>
>  1) Enable bit is added so we don't rely on the bootloader or the init
>     value to enable to pll device.
>  2) Remove unnecessary CLK_GET_RATE_NOCACHE flags.
>  3) OD post dividers are removed from the pll driver. This simplify the
>     driver and let us provide the clocks which exist between those
>     dividers. Some device are actually using these clocks.
>  4) The rates hard coded in parameter tables are remove. Instead, we
>     only rely on the parent rate and the parameters to calculate the
>     output rate, which is a lot better.
>
> This series has been tested on the gxl libretech cc and axg s400.
> I did not test it on meson8b yet.
>
> Changes since v1: [0]
>  - improve commit description of patch 1
>  - remove unnecessary CLK_GET_RATE_NOCACHE flags.
>  - add missing CLK_SET_RATE_PARENT.
>
> [0]: https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com
>
> Jerome Brunet (4):
>   clk: meson: clk-pll: add enable bit
>   clk: meson: clk-pll: drop CLK_GET_RATE_NOCACHE where unnecessary
>   clk: meson: clk-pll: remove od parameters
>   clk: meson: clk-pll: drop hard-coded rates from pll tables
for the whole series:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

as well as:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
(tested on Meson8b / Odroid-C1, even CPU frequency scaling still works
with my out-of-tree patches)


Regards
Martin
