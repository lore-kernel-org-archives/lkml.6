Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20B0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD7720C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD7720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGQNem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:34:42 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:43586 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeGQNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:34:41 -0400
Received: by mail-ua0-f195.google.com with SMTP id x24-v6so597253ual.10;
        Tue, 17 Jul 2018 06:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTsNEzTAW7/1uLisgf+Fjr24kxMJ8/bLGOfcGlQkJg0=;
        b=qStyDeELl9rDTJipGg0+sCvTIXiOCjTxC1+kUVuFeL3ifXbIYLsZOsD438fx9Gaj6u
         +OKECV3w0gncVE8IRTyRF1as/s0RZnLFFfXW1ciWhJAE8QXIpdMcCe76WWX8IHkBwK7E
         FlCTDFs4o5mgM1CwNvf/JZzi2vz+sXh4zIihSWnUH1ebnPwlwXLzNOD+4bfFjwgpOvHO
         UtNPYhRd05niVIXsiFs7HnY5xun4G/wxmxI8KryaiphdXrVc6+9yL83mHngEVu1a2CMT
         AFfpGktRx2ORzf9gCu757/+UcF4kDY/8m2hiG15ZpngEw+TNMRJ+k3HGpGPxrT554mpM
         t/GA==
X-Gm-Message-State: AOUpUlFEuOcXg5srSoYnzF/WegccXOuCZJ1m+5aLY1L4HXvF8L25koW5
        y5VUvR5cuPwD+cJTgurLZbP9oytxvnY/ubAleI0=
X-Google-Smtp-Source: AAOMgpeXHxRReDFYNLlLKYfpjSxGt4W+0Z2ybqd1E3K+UdH9EK+IW6ORLmfm9u1VngrBPNgAGjMs4zh316vRjJCgDCY=
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr955593uae.72.1531832526582;
 Tue, 17 Jul 2018 06:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
 <20180717120737.bipotpki3yhn6klf@verge.net.au> <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
 <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Jul 2018 15:01:54 +0200
Message-ID: <CAMuHMdX8Q4wJtQ==PW0HrQpWS=CY1zPuasJPQCuQwhN0PzVfpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Horman <horms@verge.net.au>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Tue, Jul 17, 2018 at 2:42 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On 17 July 2018 13:24, Andy Shevchenko wrote:
> > On Tue, 2018-07-17 at 14:07 +0200, Simon Horman wrote:
> > > On Mon, Jul 16, 2018 at 09:59:13AM +0100, Phil Edworthy wrote:
> > > > The Synopsys I2C Controller has a bus clock, but typically SoCs hide
> > > > this away.
> > > > However, on some SoCs you need to explicity enable the bus clock in
> > > > order to access the registers.
> > > > Therefore, enable an optional bus clock specified by DT.
> >
> > > > +         /* Optional bus clock */
> > > > +         if (!IS_ERR(dev->busclk)) {
> > >
> > > I suspect that error values stored in dev->busclk,  other than
> > > -ENOENT, should be treated as errors.
> IS_ERR catches all errors and is the correct way to check the value
> returned by devm_clk_get.

What if it returns -EPROBE_DEFER, which means the clock is referenced,
and thus not optional, but not yet ready?
For optional clocks, all errors but -ENOENT should be propagated up.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
