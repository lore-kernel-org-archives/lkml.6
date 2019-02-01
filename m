Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97869C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6595421726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfBAImL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:42:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46285 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfBAImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:42:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so6494151qtm.13;
        Fri, 01 Feb 2019 00:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBU2TNZakMyKOC4KxmPqNQYRaxeZHiXAJWu2gQGpFiM=;
        b=DOzscFkfhJaINqhALv3EGoQR52jLB0yfu8mT3LGRqSmdUlbcuyVl6j6AvQXSpiCR7d
         PmoqBZkZt8XPE83FADKUbmBZ+M07aw0NQIkpvSr4YUcNaje3VveuiKifkWuX1mS5+lTP
         daLrUfK9s2LiDFhtqwocvrOPMfPBpTZP0YY7gWB8gOfwzVYgWUlkpnSeErjDN33mTl9+
         e89pN+xkOuXe8WyVe9S7aVTHMSHBJqCzvLsxi1zdpJ7Q1C7xQWKqS95VQkZ7RgjSHk/q
         yzw9bADLmHHKUT+sI/33mCsjsAlEVE4v9W47A+zP97+AYZp1rRG4DFHwOexntQtRDOLK
         mkEQ==
X-Gm-Message-State: AJcUukeehJAi2gbZ3PIGzlAjtvjBde4wRzwKoY5vANOll1R1Uo4xAMeD
        Muh9NXT9KaYtUL+h7qa2LWOuG+leIR2TdGj5RvU=
X-Google-Smtp-Source: ALg8bN404msL6/fDmHYgSbisuiK3UViMZuqgpO9BZAt1LX1eLUijpX2MXOEsNjlrBP7uSKgfh4ceMVr6lSeEHxfP0I8=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr37347128qte.212.1549010530162;
 Fri, 01 Feb 2019 00:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
 <CAK8P3a3Y_w5_ZavpyUh0VKrS8FeUPTJKkchtGGLc1qe3nG2mfA@mail.gmail.com> <20190201035005.GA4283@Mani-XPS-13-9360>
In-Reply-To: <20190201035005.GA4283@Mani-XPS-13-9360>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Feb 2019 09:41:52 +0100
Message-ID: <CAK8P3a3DVniy47azCP=NAWecCZST_huaeXjLKRczBsit7e4uKQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019, 04:50 Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org wrote:
> On Sun, Jan 27, 2019 at 10:24:09AM +0100, Arnd Bergmann wrote:
> > On Sat, Jan 26, 2019 at 5:11 AM Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> > > Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> > > processor subsystem, a single core RISC-V subsystem and a Tensor
> > > Processor subsystem. This patchset adds support for only ARM Cortex
> > > A53 Application processor subsystem with UART, which enables the board to
> > > boot into initramfs with 2 CPUs.
> >
> > Nice work! All patches in this series
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks. What is the merge strategy for this patchset? Shall I send a
> Pull Request to arm@kernel.org with topic branches?

I think we should take new platforms as a single topic branch separate
from the normal branches, so please send a single pull request for this
one.

Also, if you have drivers that are closely tied to this platform, that
branch include those as well, provided that you have an Ack from the
respective subsystem maintainers.

     Arnd
