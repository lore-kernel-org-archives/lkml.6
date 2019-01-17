Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81829C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5750B20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfAQITY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:19:24 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43915 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfAQITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:19:24 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so5676849vsc.10;
        Thu, 17 Jan 2019 00:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hh3Z0RghUaMaoqGpdmhHutrXBZb2RgqZ2OpSfdiqjLQ=;
        b=jlTC8epnncCROnGRAo3RuJjEvikMFya9RPG8Bdtzm6Mf9NbrwdVSEfiYUFUc8Gi7jf
         EpGVBH50cGgI4pnics6MN5izPjVCzPOF+sFfy1/KBeel4qHvBNCmYf2hY6RkvG9r1N9U
         FMyMxLcPc3VN+ssVAE8NqYUpufxsJ0b1NjLyAl7kEz+Yd+adecHk41rz+DtEPg0F8Dvv
         FboSrJ0ZtDW15OIIp9jefN9ulHY08/Lu4GcM3QbUQe+WV+h7KtFKt1ANZuSmUa1vQeuF
         Cuo2dLEC1+TJXlpg6glkXyyczMx+wvERTaVh3xmC9hPihi1M/uwdPBilLBpm3ZYmGf/h
         qlog==
X-Gm-Message-State: AJcUukeom+CuzhZUZvqlMlJpcXaqfr20JBB/DGq3VIczREUhSJSR+DDU
        JPQUESRkiCnuTUqm5wdRPZa32t2kBMgyqDFtf0c=
X-Google-Smtp-Source: ALg8bN4P1nOqQVnDmhFh641wRpQOFCA/OG/1VL8CMa22hBJlwjBi4kqRMWi6NAYbq3net61AQ4b2PX8YUfbZCwupLkw=
X-Received: by 2002:a67:c202:: with SMTP id i2mr5413265vsj.11.1547713162494;
 Thu, 17 Jan 2019 00:19:22 -0800 (PST)
MIME-Version: 1.0
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
 <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com> <OFBBA60D64.FFD34553-ON48258384.00315BB0-48258384.0034A5C7@mxic.com.tw>
 <30d678b9-2b49-1f82-3027-332d213b488e@cogentembedded.com> <OFFCBB6F75.77BB80DE-ON48258385.0020045C-48258385.0023EF3B@mxic.com.tw>
In-Reply-To: <OFFCBB6F75.77BB80DE-ON48258385.0020045C-48258385.0023EF3B@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Jan 2019 09:19:10 +0100
Message-ID: <CAMuHMdWQm1hFxS6ScUpP=xbPPQObuyzDoJLaNr1vpJuhtakasQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Thu, Jan 17, 2019 at 7:32 AM <masonccyang@mxic.com.tw> wrote:
> > "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
> > 2019/01/17 上午 03:36
> > >>
> > >> [...]
> > >> > +#define RPC_WBUF      0x8000   // Write Buffer
> > >> > +#define RPC_WBUF_SIZE      256   // Write Buffer size
> > >>
> > >>    I wonder if the write buffer should be in a separate "reg" prop tuple...
> > >> Have you considered that?
> > >>
> > >
> > > I don't get your point!
> >
> >    I mean that the write buffer should be a separate "reg" property
> > address/size tuple,
> > so that the RPC device has 3 memory resources. Our SPI driver used
> > this scheme, and I
> > like it.
> >
>
> I got your point but I think this RPC_WBUF@0xEE20_8000 is in the same group
> and it's size only 256 bytes, not like external address space read mode
> @0x0800_0000 w/ 64K bytes.
>
> Maybe Geert or Marek could comment on it, thanks.

Given the writer buffer is separate from the other registers (it's in
a different
4 KiB page, and thus may be at a different offset on future SoCs), and not
present on RZ/A1, I think it's a good idea to use a separate reg entry for it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
