Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D325AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8686C20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ehDr+Ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8686C20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeJBVD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:03:28 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3591A208D9;
        Tue,  2 Oct 2018 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538489990;
        bh=s0OGTJ3+GT4oO+ZgJdmyKPsZdh5UZA1ymz6LotmV5sI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1ehDr+AgSAff7uue5ggkZd4lW1X2PMaYMuZVG1NuE0IErsGwZS90BXK+JaxBwLE6o
         +gejNUgDS5SLjt9d+JKIuTNbDwfyOd3TYwceeolzFLpLdTo0RAfN0Nma+GyNIzdqp8
         jP7JOHoe5UfRV4i9YHrleOn6N/Yi4BnbuZHauxvg=
Received: by mail-qt1-f177.google.com with SMTP id l2-v6so2044055qtr.12;
        Tue, 02 Oct 2018 07:19:50 -0700 (PDT)
X-Gm-Message-State: ABuFfoisWT75zaL1QgLqfvo0dk3UXmrYbFrri8eIEONA+TC+1mK+Z6gS
        IR3UrbkwmmEu7QzV5aQ18mp+Txvtu/slYONrww==
X-Google-Smtp-Source: ACcGV63e0W2YZ1Py46nZFBidVtpMgjuZ3clv2aJUborqvurSqXvEugKLVhuk6qKm1jnKareiTZEU+XJc/WaQbCPplg0=
X-Received: by 2002:aed:3983:: with SMTP id m3-v6mr12859979qte.164.1538489989351;
 Tue, 02 Oct 2018 07:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com> <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
In-Reply-To: <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 Oct 2018 09:19:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJy_+f5NDA4L7H+toD0gJRb9uvzqjyQw7BiqpX=NoF0qQ@mail.gmail.com>
Message-ID: <CAL_JsqJy_+f5NDA4L7H+toD0gJRb9uvzqjyQw7BiqpX=NoF0qQ@mail.gmail.com>
Subject: Re: drivers binding to device node with multiple compatible strings
To:     Yang-Leo Li <leoyang.li@nxp.com>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 4:01 PM Li Yang <leoyang.li@nxp.com> wrote:
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
> "fsl,<chip>-pcie" compatibles.

Having "snps,dw-pcie" is pretty useless IMO. There's lots of versions
of the IP and variations on how it is integrated by various SoC
vendors.

> Also a specific PHY
> "ethernet-phy-idAAAA.BBBB" with generic "ethernet-phy-ieee802.3-c45".

MDIO device probing works a bit differently, so I don't think there's
a problem there. Drivers for specific phys should have a
.match_phy_device() callback. I could be wrong as I'm not all that
familiar with the MDIO bus code.

Rob
