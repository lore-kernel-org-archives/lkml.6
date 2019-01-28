Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A880C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA0B2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfA1LyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:54:20 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38147 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1LyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:54:20 -0500
Received: by mail-ua1-f67.google.com with SMTP id p9so5480483uaa.5;
        Mon, 28 Jan 2019 03:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBK/T64ixR5DtwckaexWOZMCICtbVoglbmytCfsmntA=;
        b=KcQE6qS1KFCHhz5DFlh7osKeOC/eAyUDP1voIvQtrnNjeMiZkbAikhH7xHW6K0CptB
         kriH2gs3UkJEfm1X5i5XvAYEsVrXD/dNgZuO5VTFwNPV4Y4153XwGRZYjxFIWxhm2DtS
         4k1puM7tEMIY/NlHZ23XvMcpCuIgfLtfD1IqKlk9Zyws+XoQi5/04ifsfsDvy/v0QiQB
         N+3dBPAL18m50rwWiaA/InM2/xtgjf+WOzVLbHzJAcQ0B83osHqv0fEl+nQapPc5iJqM
         oadrqmT+g35vU7grwBt6pfPSvELVwd6likkYb67UHUR6d4rrUtt0elZ9/0STcmPLKbR0
         WlMQ==
X-Gm-Message-State: AJcUukfGoo5LagGgmFefenXyvtxOazUgUV0hY/n8vW6n5dmYyg+b3YbH
        CJsDqtZV3LmIzK86ZKZu5umfj5mynV+ZZsuua0Q=
X-Google-Smtp-Source: ALg8bN45afQ1wNT+QpDS3x3GHPrguf+O5YB9XQmwTwHEMX0mSwg6lwb+zGVehJzLQdPke75fNGoTA2uJAN/mmsHWcn4=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr8475366uad.78.1548676459070;
 Mon, 28 Jan 2019 03:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20190125114429.20066-1-jonas@norrbonn.se> <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se> <20190125174713.GA6939@sirena.org.uk>
 <20190125175031.GA25898@sirena.org.uk> <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
 <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com>
 <ed62564f-d36b-1492-8e65-60166c0aa4a6@norrbonn.se> <CAMuHMdXQONq1UFuFHwny_xfAtxY7sOv2K3yi2i9T22OovMqFhw@mail.gmail.com>
 <20190128114757.GA11699@sirena.org.uk> <94c7514c-de1f-ff70-d2b7-6394f9747942@norrbonn.se>
In-Reply-To: <94c7514c-de1f-ff70-d2b7-6394f9747942@norrbonn.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jan 2019 12:54:06 +0100
Message-ID: <CAMuHMdVzstrjbKvNr8mbW_XLH6sYE+Asd=St-bZKt+rKjJhd+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On Mon, Jan 28, 2019 at 12:51 PM Jonas Bonn <jonas@norrbonn.se> wrote:
> On 28/01/2019 12:47, Mark Brown wrote:
> > On Mon, Jan 28, 2019 at 08:41:05AM +0100, Geert Uytterhoeven wrote:
> >> On Sat, Jan 26, 2019 at 4:40 PM Jonas Bonn <jonas@norrbonn.se> wrote:
> >
> >>> spi-3wire: again, only set by MAXIM DS-1302 which always needs this
> >>> setting; driver could set this
> >
> >> For DS1302, this is probable true.
> >> Some devices may support both 4-wire or 3-wire mode?
> >
> > IIRC yes.
>
> Just for the record, the datasheet says it's exclusively 3-wire.  But
> it's not important...

With "some devices" I meant "some other non-DS1302 devices supporting
3-wire mode". Sorry for being unclear.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
