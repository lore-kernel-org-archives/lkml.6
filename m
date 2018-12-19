Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F08C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0F72084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDDr24EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeLSOUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:20:24 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46189 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbeLSOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:20:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so1678694oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enBpW9z2Q8IDP1LWc6WGS6iQ8kJbCzIT6SFHV+eQdgE=;
        b=BDDr24EWhuTYnFx0pv5ycZQ7z0WxedpC+1VJuvbJz7aeGO880GbRNMwR5bFpX7QPjn
         qbMayO4/Ff3VMCin3leNIakB+9Xw8qGX09NONQnBUe0HwzYFV/sxnlmVAReVkvf74QSF
         JzPhk5EymwyIL8PCECiQIOSY6WXgc8QnWpAbbLhYnTweH1r3wABlXzOJuKeWF8ZOlwlq
         3z5sfIZnELtVaW97pEUAA5Ij5VifrGJklO8knLcvse2tD8VymuCCrPpXzT/40VA0gybi
         +A+ndZJnD04pIslS/CFP6cy4E9VLQgh8AAvT0lFH1qGtKnMyA3ZRw3/Zlx3sVd/tAF6u
         9u0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enBpW9z2Q8IDP1LWc6WGS6iQ8kJbCzIT6SFHV+eQdgE=;
        b=Bd2ry5lDtVY1Ytekcbzd3ppwaohegU8hfFmub7ZBOdC+Y/jBSSwreDtIM4BQ/fUPRX
         wKcxzH7AjrX8FQlFH5adcKE9S28ZLRwlLQAQddGSgJbI6UAYXzmYF1xRfdaS9xdZ9F7d
         F5KFyC4fTa8JLI9WNV+ITvgGGjnWxphAZ8CJEASQ+0wAsxdjW7QPh3R0YFe8XAoPRHRC
         sO8kpQ+XdlyOG1dlEregPzxoLMx3VHdmf5vHO/4ird7xQXJKvNPibD3Fpm3xY+oqa3hv
         QKqjqJJmsgDcHonJT04Eulx03VsYygDKMHsyu1fUVE/eF0lGOzB0AMfaa7yD+KRp5OJG
         RDpA==
X-Gm-Message-State: AA+aEWYSV7OZqF44O+hUvzj+g+2apnMNpmz+ljS/EmA2cSjCgpsAtuWE
        s77C3i3/sipcULSs7MoeTqkgGh7tJYE/UYS83jA=
X-Google-Smtp-Source: AFSGD/V2VfVgcdu67cktBky77q+AnN6zdP2WRORfE+XWRlSe4o7dc4B7BdKQRJ/25Hb0n60Fve9IVzAbt2AnTlUfltE=
X-Received: by 2002:aca:6155:: with SMTP id v82mr1236205oib.259.1545229222825;
 Wed, 19 Dec 2018 06:20:22 -0800 (PST)
MIME-Version: 1.0
References: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
 <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com> <CAEnQRZAHE77GsaES--LtWs3F4uHP2ePp3-KmP4xmZDh7NM4njw@mail.gmail.com>
In-Reply-To: <CAEnQRZAHE77GsaES--LtWs3F4uHP2ePp3-KmP4xmZDh7NM4njw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Dec 2018 12:20:17 -0200
Message-ID: <CAOMZO5AmaQgz+X_dYgafVYHooY649CBBP6ERbX6B+Gt_A-1s5A@mail.gmail.com>
Subject: Re: [REGRESSION] imx_v6_v7_defconfig: undefined reference to `__hyp_stub_vectors'
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Dec 19, 2018 at 11:32 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Wed, Dec 19, 2018 at 3:17 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> >
> > On Wed, 2018-12-19 at 12:42 +0000, Marcel Ziswiler wrote:
> > > Hi there
> > >
> > > I noticed that at least today's and yesterdays -next won't build with
> > > the imx_v6_v7_defconfig giving the following error:
> > >
> > >   LD      arch/arm/boot/compressed/vmlinux
> > > arch/arm/boot/compressed/head.o: In function `restart':
> > > (.text+0xa8): undefined reference to `__hyp_stub_vectors'
> > > (.text+0xac): undefined reference to `__hyp_stub_vectors'
> > >
> > > Has anybody seen that as well and knows what is going on?
> >
> > Hmm, works for me.

Yes, I haven't seen build failures reported by the autobuilders:
http://kisskb.ellerman.id.au/kisskb/target/7464/

> On the other hand I'm getting this warning:
>
> arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge):
> /soc/aips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI
> bus
>   also defined at arch/arm/boot/dts/vf610-bk4.dts:107.8-119.3
> arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
> prerequisite 'spi_bus_bridge'
>
>
> Maybe Rob can jump in?

Yes, I have already reported this warning to Rob and Lukasz. Hopefully
they could help fixing it.
