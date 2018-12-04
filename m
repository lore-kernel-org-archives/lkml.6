Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC942C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B458B2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApGrVQj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B458B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeLDSOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbeLDSOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:14:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9121C2081C;
        Tue,  4 Dec 2018 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543947249;
        bh=6bTTxQJOrUPlJgQrN8eLS03HzfWoHwHNP21kd4F5NXs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ApGrVQj19o5go1VatVaZHvHZ8c6OP2QZOvvGRFrQn4nWKn2+ZBCZ6DwHN4szytjco
         3IH08Y7CXpiWJbWmRgFu9RziSNn+674YJETm0flCilQnDUyTNVvGpEe73pg/iHLAcA
         pmalRRzLg+IBiD+OWxDVXbQA6cF9wqsWopobKUQE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
Cc:     sugaya.taichi@socionext.com, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
Message-ID: <154394724886.88331.4940706362054124931@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date:   Tue, 04 Dec 2018 10:14:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2018-12-04 03:03:53)
> Hi Stephen,
> =

> =

> On Fri, Nov 30, 2018 at 5:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Sugaya Taichi (2018-11-18 17:01:12)
> > > Add Milbeaut M10V clock ( including PLL ) control.
> >
> > Please give some more details here.
> >
> > >
> > > Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > > ---
> > >  drivers/clk/Makefile   |   1 +
> > >  drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++=
++++++++++
> >
> > And this is different from Uniphier? Maybe we need a socionext
> > directory under drivers/clk/.
> =

> =

> =

> This is always a difficult question,
> and I do not have a strong opinion.
> =

> =

> I am fine with moving the files to drivers/clk/socionext
> although no file would be shared.
> =

> =

> FYI
> =

> UniPhier and Milbeaut are completely different platforms
> developed/maintained by different teams.
> =

> They happen to live in the same company now
> just because Socionext merged the LSI business from Panasonic and Fujitsu.
> =

> UniPhier originates in Panasonic, while Milbeaut in Fujitsu.
> =


Thanks for the background info. I'd prefer to defer to however the dts
files are getting split up into directories. If they're all put under
arch/arm64/boot/dts/socionext/ then I would say combine the two clk
drivers into a socionext directory. Otherwise, keep them split out.

