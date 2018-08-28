Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8345CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE9020897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5SGM5bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE9020897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeH1RBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:01:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51072 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeH1RBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:01:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so1882060wmc.0;
        Tue, 28 Aug 2018 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4RaJg2+OXHYnQivrqN7FZQFg9ukF+dMUNqAIMmjRKQ=;
        b=P5SGM5bpCxPrfFGqvF+SiVnpNFLkXIEYchKtb8yf5FAFMG8lFpnuwnBw1X6wccPEc5
         smGXSmILHx54HTlM4d8w0a105V9sL3x2hrsK0lpDu819Zp9UXq9BzUDp3ekOkMGBWr+o
         /hNKo4331mgBhei5w+a7+42QOHDm1VcgkEvnH7IfxGh44aXTg7EuRDUbrxu31yPHPMm/
         DnyGxmDx1IXMe9G8xH11y6yaPo7rUvO9UQPO3gwmeEOtk7g2PbmMx/ZVvKNEhsB0HzcR
         rsdkAs77FrSnOSxHr3Opgrgsq6Fav/NSIc3e+Exqugk4x1lNjxLFif415GUC/VXffqdS
         9B5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4RaJg2+OXHYnQivrqN7FZQFg9ukF+dMUNqAIMmjRKQ=;
        b=o5OH+N+cpvEcAAw/bDN6IJtJvownB30mGNGZLL6kyYhydIUC/XE9C5hXAA9oBtNSsH
         B1iiRaLoAmE2f+kc0MUZO5v29v+Hte3qAOYN1saJVPOkxojqcN5Bw53IS/lTCmoWNxDa
         AHhxr6UR3B1wruQExg0IwxveD3FFtX++YiQT7uGl2VdkaB26HuViKhWRgdn6ejx7XFGb
         EvQO+1PG9su8KK8gtqMe9ssQDy0vQw2rImd+9x9mGg83pxEdKzbRdy6ZEF/hSn6PCeSH
         hUH7BSE6UE26qvKW/zG0MuiQ5XGnju2AhXQjuOiOCW6qp3KiP8+JMS+uKOaksscImSoZ
         YEsQ==
X-Gm-Message-State: APzg51BquRq7jnAZrWU6/nU/ZijS/FzO5G5iPKgfdfD8wrstPxQdwUGT
        DAjG5EBiLi4aXDuRDIC66Tv3QtaHInPWKgdRXDh1RQ==
X-Google-Smtp-Source: ANB0VdZ4NVchxUJ2QKo+dwMy+EJNNqnR2LpMUv2BYM+r4rwdLVOxM+r6UgccXVIW+Qq2lm0+p+ytuQyBbWB5n+SaUNM=
X-Received: by 2002:a1c:1dc9:: with SMTP id d192-v6mr1438474wmd.140.1535461804505;
 Tue, 28 Aug 2018 06:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com> <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
In-Reply-To: <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 28 Aug 2018 18:39:53 +0530
Message-ID: <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > If this is a regular PCI ethernet driver, why do you put it into driver/soc
> > > rather than drivers/net/ethernet/ ?
> >
> > No, this is not a ethernet driver, as mentioned in the cover letter
> > this driver and AF driver doesn't
> > handle any IO. There will be a separate ethernet driver (will submit
> > that as well in future) which will
> > communicate with these drivers for configuring hardware.
> >
> > The driver in question here is for a serdes controller which handles
> > physical ethernet interfaces.
> > Admin function driver gathers info w.r.t current state of physical
> > ethernet interfaces from this driver
> > and notifies actual ethernet driver about changes, if any.
>
> Ok. Can you describe the structure that the PCI devices appear
> in? It might help to be make the connection between the differnet
> patches to understand how things fit together. In the final
> picture, how many different pci_driver instances do you have,
> and what part are they for?

List of PCI devices are CGX, RVU PF0-PFn SRIOV physical functions
and RVU VF0-VFn SRIOV virtual functions. No of VFs per PF is configurable
and done by low level firmware.

List of PCI driver instances would be CGX driver, RVU PF0 (i.e admin
function) driver,
PF1-PFn either netdev driver or crypto driver, VF0-VFn functionality would be
same as their PF.

The current plan is to have CGX driver, Admin function driver, PF
netdev driver,
VF netdev driver and PF/VF crypto drivers.

>
> Is the idea that an ethernet device driver always attaches to a
> virtual function that gets created by the main driver, and that
> the two drivers share no interfaces on the kernel side, or do
> you have multiple drivers linking to each other?

Ethernet device driver can attach to both physical function and virtual function
whose HW resources are provisioned by admin function driver.

Yes the PF/VF ethernet drivers and these drivers won't share any
kernel interfaces.
Physical ethernet interface is owned by ethernet driver only, this driver just
configures which ethernet driver instance uses which physcial interface.

>
>       Arnd
