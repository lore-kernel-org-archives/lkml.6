Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD34C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9EB20779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9EB20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeI2DpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:45:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45386 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeI2DpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:45:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id b43-v6so2941819otd.12;
        Fri, 28 Sep 2018 14:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVJ1BzTPqVwuEsAYNRRGQSay6V5VghQOpTKMdwNYelU=;
        b=cvff++gfMog8f8PbOE1x7qy2VrcU8Slh7ldbsai12YoQIDi6iD3xwhBZEZkIJzhNNm
         +XrYAy6R5hb5QcIGFs+gv2E4xIzDCMezDbNJFdaqAS9l8r0/MiU/0EdtbFXoNHo49KEV
         2KMGCarDGJJAw+6orjghfQGeKY6KskLD02t7aQyqPNHmdbECOT1kWaq3xTd0YPj3KgK0
         VrbNNyZnCeHoiduU/w/gxXrPpyGvd0aN06hdBbj1pv0tBZngj8C+Ief/cgkjqNJ8pOhI
         VIX+lSv38cgSPg3D8BFiJ5F1QmFm+sdWSDoDAUxX2Bcp86DbAtgvr7WZkJuiO6+2guO9
         BHvw==
X-Gm-Message-State: ABuFfoiVImQDGxBW56tX5AIN6AbcR5kcPqMljSrx+EUvszf29BwNSrOf
        PWUUrM+hKUHSInjinDFQhBulE837GUE=
X-Google-Smtp-Source: ACcGV61uXh6PQa1dgG7qlM44h+0HE6EpHFFy1SVLo2/5KZlE/vVmIeL768k4XmCIFe0BtELDqGr8nw==
X-Received: by 2002:a9d:5f03:: with SMTP id f3-v6mr320691oti.166.1538169565271;
        Fri, 28 Sep 2018 14:19:25 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id l60-v6sm2091395otl.52.2018.09.28.14.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:19:25 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id m23-v6so7419945otf.0;
        Fri, 28 Sep 2018 14:19:24 -0700 (PDT)
X-Received: by 2002:a9d:1ab:: with SMTP id e40-v6mr290858ote.68.1538169564711;
 Fri, 28 Sep 2018 14:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com> <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
In-Reply-To: <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 28 Sep 2018 16:19:13 -0500
X-Gmail-Original-Message-ID: <CADRPPNTovoNaY-suhmeM2YCGHTe6UsQ5FnkOCuPef=uUxi74-Q@mail.gmail.com>
Message-ID: <CADRPPNTovoNaY-suhmeM2YCGHTe6UsQ5FnkOCuPef=uUxi74-Q@mail.gmail.com>
Subject: Re: drivers binding to device node with multiple compatible strings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        frowand.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 4:00 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Fri, Sep 28, 2018 at 3:07 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Sep 27, 2018 at 5:25 PM Li Yang <leoyang.li@nxp.com> wrote:
> > >
> > > Hi Rob and Grant,
> > >
> > > Various device tree specs are recommending to include all the
> > > potential compatible strings in the device node, with the order from
> > > most specific to most general.  But it looks like Linux kernel doesn't
> > > provide a way to bind the device to the most specific driver, however,
> > > the first registered compatible driver will be bound.
> > >
> > > As more and more generic drivers are added to the Linux kernel, they
> > > are competing with the more specific vendor drivers and causes problem
> > > when both are built into the kernel.  I'm wondering if there is a
> > > generic solution (or in plan) to make the most specific driver bound
> > > to the device.   Or we have to disable the more general driver or
> > > remove the more general compatible string from the device tree?
> >
> > It's been a known limitation for a long time. However, in practice it
> > doesn't seem to be a common problem. Perhaps folks just remove the
> > less specific compatible from their DT (though that's not ideal). For
> > most modern bindings, there's so many other resources beyond
> > compatible (clocks, resets, pinctrl, etc.) that there are few generic
> > drivers that can work.
> >
> > I guess if we want to fix this, we'd need to have weighted matching in
> > the driver core and unbind drivers when we get a better match. Though
> > it could get messy if the better driver probe fails. Then we've got to
> > rebind to the original driver.
>
> Probably we can populate the platform devices from device tree after
> the device_init phase?  So that all built-in drivers are already
> registered when the devices are created and we can try find the best
> match in one go?  For more specific loadable modules we probably need
> to unbind from the old driver and bind to the new one.  But I agree
> with you that it could be messy.
>
> >
> > Do you have a specific case where you hit this?
>
> Maybe not a new issue but "snps,dw-pcie" is competing with various
> "fsl,<chip>-pcie" compatibles.  Also a specific PHY
> "ethernet-phy-idAAAA.BBBB" with generic "ethernet-phy-ieee802.3-c45".

The ethernet-phy issue is not related to the general device binding
framework, it should be an issue with the of_mdio framework. But it is
still a inalignment with the device tree recommendation.

Regards,
Leo
