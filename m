Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907FDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED82214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED82214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbeLFJMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:12:25 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37789 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:12:24 -0500
Received: by mail-vs1-f68.google.com with SMTP id h18so13862840vsj.4;
        Thu, 06 Dec 2018 01:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ml3kYaXG5ymCHTISsJI3Pi4MPA5abCZU4bJR0MznsKo=;
        b=dMzXEmcTxbfi6b7JCPwq1lusua8XkZgglbeokvAh8DCGTsZr3YwubPxgRfuNYw3cmC
         06Jcot0iDPvcMPk3XyDl/YCC936uSQdSodTeE4pqeDNk9IypEy8QqPz3vvQNYHa9lWmR
         icMPk1kV4DR2z2UQXSn1DIgmsUkbFgPRb9BGg69c95JmnVBBnT4qDzOT5+8Y/Tqi1Bmq
         b9W0OF+4T6Iqcob5ulaU58YLX6snigDMXLOi4TCsRCUcf9V4oAna0Gv7s5e74a6ijQr8
         UA6huKeBi3vrEbduRUJ2IE8Qc72EhwGH33DoBDZuitayyOHXnThGM0k09gBuobaTziOT
         jPOA==
X-Gm-Message-State: AA+aEWYV+Z9QngHIW8elfoD11ZyrBgCNG1DphJhsqFYDOH3Q8u48Rvhz
        rZF4rjvS1fAb5QpyMuTSrR2zs4iIJmCVtgZQbCE=
X-Google-Smtp-Source: AFSGD/XL0aYdZXAxDTuAdwwzZtpBxGvWD3RT3JAnzSde8fPCwRfysJwV0VnsxxE6vbFpX832Mc1AXuMZyc8dKhvH8gI=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr12512324vsm.152.1544087543711;
 Thu, 06 Dec 2018 01:12:23 -0800 (PST)
MIME-Version: 1.0
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com> <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com> <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
In-Reply-To: <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 10:12:11 +0100
Message-ID: <CAMuHMdWspyRq_K2Vd6Xk2tqft-oUoMvVhj-zKS-fuhv_edXb8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
To:     masonccyang@mxic.com.tw
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Thu, Dec 6, 2018 at 8:31 AM <masonccyang@mxic.com.tw> wrote:
> > >> Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
> > >>
> > >> On 12/03/2018 10:18 AM, Mason Yang wrote:
> > >> > Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> > >> >
> > >> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

> > >> > +   xfercnt = xferpos;
> > >> > +   rpc->xferlen = xfer[--xferpos].len;
> > >> > +   rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);
> > >>
> > >> Is the cast needed ?
> > >
> > > yes!
> >
> > Why ?
>
> Get a compiler warning due to tx_bug is void *, as Geert replied.
>
> Using get_unaligned(), patched code would be
> ---------------------------------------------------------------
>  rpc->cmd = RPC_SMCMR_CMD(get_unaligned((u8 *)xfer[0].tx_buf));
> ----------------------------------------------------------------

Using get_unaligned(0 is a bit strange for accessing a single byte quantity.
Please keep the normal pointer dereference (including the cast).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
