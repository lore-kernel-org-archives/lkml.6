Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0697EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23A020671
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23A020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeH1Qke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:40:34 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45857 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Qke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:40:34 -0400
Received: by mail-qk0-f195.google.com with SMTP id z125-v6so842600qkb.12;
        Tue, 28 Aug 2018 05:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlRGCqBRQzRaMDVRfqmQjv1nkc+fB6lAMZRslSIpNVE=;
        b=kXvgRSEXacmmc4Go0eL5vmKrt2wFy8pdDw3PM13VDFvWY7lnnqLOAlG2KwABZrLvLY
         AyLNSR3jj8RxL4EUIfiG6GETQwQZY8ts+SmgXwvYhArHDZL+jVXzB86pV8iWqantGZll
         0YMXatNcnJZpRS3alCzXiZ6ghnMraG02XSvJo/AJV0RqBq4xsdHQrSPZbXBqslz+XVnD
         8JPga00lVfsE4HxCAW/HIZoaMXa3VUGAtB8kXeZTEwUBHSGAA3gyfj5fAWPEGDfBVDF0
         uzvoMlhZoH3VPyF+FboDoYGu4aadmZnGVBgM+wwZ5MNK7iPIRTnq+3w0Q36qDhy1RH6E
         iLyQ==
X-Gm-Message-State: APzg51BBdlfsBMHPfO2AnEo9rotIDN/q/PDqICiPpg2MOVWguj7tQOK1
        Haszk7PUZx9eubEjYIESQQmRJDwNgFhXA6aqLMo=
X-Google-Smtp-Source: ANB0VdbOMZFsRhvvwTaIBsO4QtV/OdUkwgJi9IXHa7YBqbplG1W/prlML5U7ArBhoo6c52L5IVU6kzxGnG1cQIg8dtk=
X-Received: by 2002:a37:1b91:: with SMTP id m17-v6mr1345765qkh.173.1535460542743;
 Tue, 28 Aug 2018 05:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com> <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
In-Reply-To: <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Aug 2018 14:48:46 +0200
Message-ID: <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, sgoutham@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 2:30 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> On Tue, Aug 28, 2018 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> > >
> > > From: Sunil Goutham <sgoutham@marvell.com>
> > >
> > > This patch adds basic template for Marvell OcteonTX2's
> > > CGX ethernet interface driver. Just the probe.
> > > RVU AF driver will use APIs exported by this driver
> > > for various things like PF to physical interface mapping,
> > > loopback mode, interface stats etc.
> > >
> > > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > > ---
> > >  drivers/soc/marvell/Kconfig            |  10 +++
> > >  drivers/soc/marvell/octeontx2/Makefile |   2 +
> > >  drivers/soc/marvell/octeontx2/cgx.c    | 117 +++++++++++++++++++++++++++++++++
> > >  drivers/soc/marvell/octeontx2/cgx.h    |  20 ++++++
> >
> > If this is a regular PCI ethernet driver, why do you put it into driver/soc
> > rather than drivers/net/ethernet/ ?
>
> No, this is not a ethernet driver, as mentioned in the cover letter
> this driver and AF driver doesn't
> handle any IO. There will be a separate ethernet driver (will submit
> that as well in future) which will
> communicate with these drivers for configuring hardware.
>
> The driver in question here is for a serdes controller which handles
> physical ethernet interfaces.
> Admin function driver gathers info w.r.t current state of physical
> ethernet interfaces from this driver
> and notifies actual ethernet driver about changes, if any.

Ok. Can you describe the structure that the PCI devices appear
in? It might help to be make the connection between the differnet
patches to understand how things fit together. In the final
picture, how many different pci_driver instances do you have,
and what part are they for?

Is the idea that an ethernet device driver always attaches to a
virtual function that gets created by the main driver, and that
the two drivers share no interfaces on the kernel side, or do
you have multiple drivers linking to each other?

      Arnd
