Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069C5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53DB20873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="WZouweCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfAMD5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 22:57:25 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37784 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfAMD5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 22:57:25 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so8135087iti.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 19:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqu6axINzyiZQ74GsAFKNqQhj6wyvRbQQ23+z1nV1Eg=;
        b=WZouweCff/bMf3//LHqqgxEgS9MI8g+8HbIsbhwHeTwSxTm41ylr5UB/1PoEREQm4F
         nnAM2j7Pl9BOsrVz7RVg93aidyfn3X79wWnEk7GxZfLIVQ0xn/90xjbXgrtw5QDsE96j
         CQzCxJY8E/sng6bC+lEvh/wGnLNt5raAXr8xZ8+sDnmIxUu7nZH4dQCFgUJAMydZnEGL
         0WnuKJAjltX8SOUxzbdGHJ6ShhqqPHZMCcNe4c0EjJKRH4kWEiFbqyiXhEbm9BOydlhX
         CAjWG1nJ2vYC8wK0VdAhCa/G0HcoMgDP8gHJoQ2amBwILY0lWbAiZqcnsKv+8UywnAYp
         vgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqu6axINzyiZQ74GsAFKNqQhj6wyvRbQQ23+z1nV1Eg=;
        b=lV6Ch2Q0XwSy7Y/pOIUE78Zyu/bsagBmajR7+MQQsh0o7JQ4S/g9rtFwYEbV+Fyn6x
         Qz2k9gnj9n6punWK4I8Aza/8kmlZKtH2/aetnaRJXJzvPRMt/HCbw5BTK2cTS1dvbsfw
         5UPswcqo6YMTyUueoodx0AYLe+lSMHHrhqpsK+3LkSIwvbEX+uibmqpmlpb6ceYjT5+t
         qc/LG9c0dPaPPrOH42crIQVs8SgTpnMawaAY1HSMafMuEGP1mEUQpbzLVm5ur5vZw4Tf
         NaHYDDL1VDHMPG60cHn6fLaV3yQVxujd3e1NR9gHjQcQygu1uA3L97tIPkIIvuEpUlql
         x1rA==
X-Gm-Message-State: AJcUukfxQU1VVWSxWZugoUG3w6U7D0+plh+huPXhUQ/mmS1j49oRASZJ
        fylwgHFtJVYacxU/UFFYQtYwUJ+RWlgenM3pNiMy0A==
X-Google-Smtp-Source: ALg8bN7NIdEtKvEeg25+nl0a/w/+8O05OcgWP8UwNtxdK7pWLv4eUi0zWs6UeeJfJZaG3g/58MwttmVQTKiPY/NJR2c=
X-Received: by 2002:a24:6e88:: with SMTP id w130mr4797484itc.103.1547351844122;
 Sat, 12 Jan 2019 19:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20190113012909.11986-1-jhubbard@nvidia.com> <20190113012909.11986-2-jhubbard@nvidia.com>
 <9518922c-ab17-ba06-0670-f0202b436a8c@kernel.dk>
In-Reply-To: <9518922c-ab17-ba06-0670-f0202b436a8c@kernel.dk>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 12 Jan 2019 19:57:12 -0800
Message-ID: <CAOesGMjiYkThVa5BQo0w3B1wC3NJpmsrYFwXVCN0VQqYqF_MWg@mail.gmail.com>
Subject: Re: [PATCH 1/1] phy: fix build breakage: add PHY_MODE_SATA
To:     Jens Axboe <axboe@kernel.dk>
Cc:     john.hubbard@gmail.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 6:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/12/19 6:29 PM, john.hubbard@gmail.com wrote:
> > From: John Hubbard <jhubbard@nvidia.com>
> >
> > Commit 49e54187ae0b ("ata: libahci_platform: comply to PHY framework") uses
> > the PHY_MODE_SATA, but that enum had not yet been added. This caused a
> > build failure for me, with today's linux.git.
> >
> > Also, there is a potentially conflicting (mis-named) PHY_MODE_SATA, hiding
> > in the Marvell Berlin SATA PHY driver.
> >
> > Fix the build by:
> >
> >     1) Renaming Marvell's defined value to a more scoped name,
> >        in order to avoid any potential conflicts: PHY_BERLIN_MODE_SATA.
> >
> >     2) Adding the missing enum, which was going to be added anyway as part
> >        of [1].
> >
> > [1] https://lkml.kernel.org/r/20190108163124.6409-3-miquel.raynal@bootlin.com
> >
> > Fixes: 49e54187ae0b ("ata: libahci_platform: comply to PHY framework")
>
> Linus, this is probably a better option in terms of what should go in to
> fix that commit.

I'm OK with this, but it does beg the question how the patch was
tested before submitting, if it didn't build.

Is there functional breakage behind it? I currently lack online
hardware to test myself, unfortunately.


-Olof
