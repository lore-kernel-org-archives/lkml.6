Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2608B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZbSp0k9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2608B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030329AbeFSRsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:48:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37092 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967116AbeFSRsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:48:06 -0400
Received: by mail-it0-f65.google.com with SMTP id l6-v6so1637774iti.2;
        Tue, 19 Jun 2018 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/P9s6tEMq5A1RGD5V7J/uSUpIswvKu6OhO5YchdPGKY=;
        b=aZbSp0k9hOLiuutJy2q6AfMCgYp4QxwBDqlxBWvWyX4hiycvKCZZFjLOi4N8r/B0X+
         iEjZqnzxsZY0Ojsg42QIk3+cjMMg1qiQYPgPUDn2ZdG3XZBVe2GZvMG9TQ/J0UAbIXKb
         nnJTB6nni+3ZtTyVGRMdbLFtbNGZa3Q+Dcs4mmM6E5Z23mhKq1X+UkDw3yxAAHUZUbRS
         tpFqeUOyA9wqrX2ioEBG1RSvBZjw1nYpUmstc1t4hudltKptH6iya8Wy8bR4rhkC8rJM
         44CEAyZt/1aoVF0w1ZH+q2HoQTLLxk+6lCmeHhMmIc4Kzlu6S7oTqjtP+BxFxgL5ag2Z
         Czaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/P9s6tEMq5A1RGD5V7J/uSUpIswvKu6OhO5YchdPGKY=;
        b=mm1IBazTu86HnxBKa0vAtVCDjYpQ3UX3Ikl3PsDQMM5/3KBQn49RCWPuzaFY9JI+CR
         2n+It+yU1QVFoKu5UDpN/e+ID36ClkedWa86k+VCqyo6GtfDotdTq/OMq/BjiDifbYBx
         KX8ZiklYWW5JlPzi/bOdrSKpZRmKGvCsn9Z1pvwHUEc/gVvbRP+lmf/Yuxf25nRUpuFm
         g8s02tiF6O4Y9YTWJbij1yU44CeGxnAcFrHiCZV3geU0mCHYuFBb3FGtWYuCWP2qbDLd
         MvnbCSfQpaN/BdsFo3/aIH9jV1a/GBXsc7CQ2UvTp74v4cQGtZJi9iCTR2AM2a7y/TgU
         JqEw==
X-Gm-Message-State: APt69E2K+QJKdlljyEwi1hEqwnRE2NzIlF6q1J6p5/0l5p0JWLSS+aB9
        u7WNzwaYn9l2qHWX2jHYT44HwT3LYu6wWNDrww==
X-Google-Smtp-Source: ADUXVKL0a8ZVwQTWVO7Mf9dtRYzmHv1ZuEzPI8EMDWBnZutrBpRhraPwC9wFJS8HP6rhtGE1TAFP+QvfFSyejWK3QL0=
X-Received: by 2002:a02:6065:: with SMTP id d37-v6mr14782764jaf.106.1529430486034;
 Tue, 19 Jun 2018 10:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180619142246.104469-2-avifishman70@gmail.com> <Pine.LNX.4.44L0.1806191044530.1473-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1806191044530.1473-100000@iolanthe.rowland.org>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Tue, 19 Jun 2018 20:47:54 +0300
Message-ID: <CAKKbWA79=k-HEinMNNw7y8bCg2s2M+_S8uFDuR-sQz7A7zFSPg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] USB host: Add USB ehci support for nuvoton npcm7xx platform
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        Tony Lindgren <tony@atomide.com>, baolu.lu@linux.intel.com,
        Alex Elder <elder@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        hdegoede@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:49 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 19 Jun 2018 avifishman70@gmail.com wrote:
>
> > From: Avi Fishman <AviFishman70@gmail.com>
> >
> > This patch adds support for ehci controller for the Nuvoton
> > npcm7xx platform.
> > Most of the code was taken from ehci-spear.c + specific initialization
> > code
> >
> > Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
> > ---
> >  drivers/usb/host/Kconfig        |   8 ++
> >  drivers/usb/host/Makefile       |   1 +
> >  drivers/usb/host/ehci-npcm7xx.c | 212 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 221 insertions(+)
> >  create mode 100644 drivers/usb/host/ehci-npcm7xx.c
> >
> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> > index 9f0aeb068acb..e3100b249f0f 100644
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -185,6 +185,14 @@ config USB_EHCI_MXC
> >       ---help---
> >         Variation of ARC USB block used in some Freescale chips.
> >
> > +config USB_EHCI_HCD_NPCM7XX
> > +     tristate "Support for Nuvoton NPCM7XX on-chip EHCI USB controller"
> > +     depends on (USB_EHCI_HCD && ARCH_NPCM7XX) || COMPILE_TEST
> > +     default y
>
> Are you sure this is what you want?  The value defaults to Y whenever
> COMPILE_TEST is enabled?  Will that annoy people doing compile tests?
>

Do you recomment to change to:
default y if (USB_EHCI_HCD && ARCH_NPCM7XX)

> Aside from that one issue,
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
> Alan Stern
>
