Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D74CC677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31FC204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31FC204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeJKXl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:41:28 -0400
Received: from shell.v3.sk ([90.176.6.54]:59335 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:41:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5C01DBD0FE;
        Thu, 11 Oct 2018 18:13:31 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yw6kOBjXi2Kn; Thu, 11 Oct 2018 18:13:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C319CBD102;
        Thu, 11 Oct 2018 18:13:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zIMknuu8GaIR; Thu, 11 Oct 2018 18:13:27 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B7583BD0FE;
        Thu, 11 Oct 2018 18:13:26 +0200 (CEST)
Message-ID: <a13569d534e4393abff2ac704cee45df2bcd9656.camel@v3.sk>
Subject: Re: [PATCH 10/11] spi: pxa2xx: Add ready signal
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, quozl@laptop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 11 Oct 2018 18:13:26 +0200
In-Reply-To: <CAMuHMdXmsw3jjp8wFuuK_Vz8kwCP4=L59sc4kZafXzrb=hKv7g@mail.gmail.com>
References: <20181010170936.316862-1-lkundrak@v3.sk>
         <20181010170936.316862-11-lkundrak@v3.sk>
         <CAMuHMdXmsw3jjp8wFuuK_Vz8kwCP4=L59sc4kZafXzrb=hKv7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-11 at 09:28 +0200, Geert Uytterhoeven wrote:
> Hi Lubomir,
> 
> On Wed, Oct 10, 2018 at 7:10 PM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > Strobe a GPIO line when the slave TX FIFO is filled. This is how
> > the
> > Embedded Controller on an OLPC XO-1.75 machine, that happens to be
> > a SPI
> > master, learns that it can initiate a transaction.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> Thanks for your patch!
> 
> I'm repeating my comments on the RFC below:

Ah, sorry for not addressing those; it somehow slipped through my
fingers. I'll wait a while to collect more feedback before sending v2
and then I'll include fixes for those.

Thanks for the review.

Lubo

