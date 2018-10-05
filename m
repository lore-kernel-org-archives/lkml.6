Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F99208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZyAfQ9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F99208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeJEWeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:34:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40282 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeJEWeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:34:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so11998760ljr.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNZJV5wwtc23+pvv2AdiInoVwx75g13CBJ8iteJPjt8=;
        b=WZyAfQ9KLyh8SF8UIHOFGAgeFuBQSA/mQwRfOIQQ9oWCc38h2n4+NNRxMHxZQhQKyA
         7lCd7k55CPujiNYE6xCFgYqm3eoKh7iGQrD6P8g7G5jy4xMbTcdsfTmu056dwKkUhqwn
         fQsj/yPUGsj41lHYUlPe8FYvIzEY6WkEV9UvUara55ERDDlFUgqnMtW8NHN5Da/t93hK
         6rhP2MDW52NXr1AJWZoimFZTNu7wPrpXvkYjRpUnYviwJ+jPJZ7Sx+cyIHJ519xgatPo
         8HDEpZSHvddKtA5MKFqEOIcogzBPKIckh7F0q8dRgMbTyftwgQEk0Vbc+/5JvTYWYbqN
         skQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNZJV5wwtc23+pvv2AdiInoVwx75g13CBJ8iteJPjt8=;
        b=NHPepvp2GkhyQZCa2cqelc635I8gChMikQBWNErxMOl9nQ8jN2s1H0E5bfzDhJZmmJ
         NgTRTvrYUaxz4va25kPHEZUx1v7hqJyQo5hFwHWGn+2Boxp/o+L85pIP6NcUF6tv6KiH
         JMHL7g7RmfjLJjZwEOKn7OqKKylEortQhNCGxlYJwwWf3d5ju7BAaw7JIzCm596LkvjU
         9uEvUX1GoM/KlKTRi+9UFRpQZMzWi2QgaaiAErk4FkaxoDC1K8AF4lkO6EXdBtIi95NJ
         UcaU1qZt9fKcMpIu8pT5cU/89PhQ50QWftTP/gL5g/CjlnkbeRNCKWSyDC7iGzZCJ7HU
         7TEA==
X-Gm-Message-State: ABuFfojJfSgZYDwD0Pu6tbVJXhOPEff2SC4AECQ7RQ8Xhib0lrMXGZnR
        sQTkFca8iqNcPdQuOL82t9SOkRXr7FRd8Hzho/Q=
X-Google-Smtp-Source: ACcGV62uSK6z36P6ZhI3Ntl4qpdphX0ZYrH93qv3cldNGwZj62ykUF0iyCwLFmAC6O8SIHre9aIXgiMIk7ZW/R+fbC8=
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr8552555ljj.90.1538753729067;
 Fri, 05 Oct 2018 08:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
 <20181004142942.11887-2-ricardo.ribalda@gmail.com> <20181005002125.12fd229f@bbrezillon>
 <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
 <20181005090811.6b7e9957@bbrezillon> <CAPybu_38xH2Cv+eONQmEJ1i6k=oiQM=WrcwOFR29LbtRvWfKXA@mail.gmail.com>
 <20181005103730.57d52e3c@bbrezillon> <CAPybu_1RMcro3xLNW5mbybYdObCTq=QwXgk+RT6hcmRGTh6s7A@mail.gmail.com>
 <20181005121235.7e64b64a@bbrezillon> <CAPybu_0TbeN+-F6zwN8XOMuY1EpgE6GRi=ExDx6O3Yun9kXjYQ@mail.gmail.com>
 <20181005164609.0058ae2c@bbrezillon>
In-Reply-To: <20181005164609.0058ae2c@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 5 Oct 2018 17:35:12 +0200
Message-ID: <CAPybu_2G8Kou3acrxWBQs1qff8Oa0DWGkfrQitnET89JXLnkFw@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris
On Fri, Oct 5, 2018 at 4:46 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Fri, 5 Oct 2018 14:04:52 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > Hi Boris
> > On Fri, Oct 5, 2018 at 12:12 PM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > >
> > > On Fri, 5 Oct 2018 11:54:18 +0200
> > > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> > >
> > > > Hi Boris
> > > >
> > > > Just seen that  you already did the rebase at
> > > > https://github.com/bbrezillon/linux-0day/commits/mtd/physmap-cleanup
> > > >
> > > > Thanks for that.
> > > >
> > > > I am about to test it in real hw (unless you want me wait)
> > >
> > > Sure, go ahead and test it.
> > >
> > > Thanks,
> > >
> > > Boris
> > I had to change this on your patchset to have it working on hw:
> > https://pastebin.com/78A7yhJ9
> >
> > If you send the patchset to the mailing list I can review it patch by patch.
> >
> > Also
> > mtd: maps: Prepare merging of physmap and physmap_of
>
> It seems to compile just fine here. Is there a problem at runtime?

Sorry, my fault, that is just me trying to review in github. I saw the
cahnge on the Makefile but not the rename. Ignore this comment



-- 
Ricardo Ribalda
