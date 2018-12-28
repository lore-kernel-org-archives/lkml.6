Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD11BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E192184E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iukieoM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeL1Vx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:53:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43171 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeL1Vx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:53:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so10480616plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:message-id:references
         :subject:cc:from:user-agent:in-reply-to:date;
        bh=6qz1J4MMw4nI/1NgI3i1H1ACJ2Y9IwK0nr8WJ/mYHTE=;
        b=iukieoM1WLKuxLN+Oo+G9QG7vo+SwUz9dbDU/lFatcBq6wAPdS24d6mit5yQdZ9+7g
         vOnC6J7QSTzD/DrLEvMoQJuwfs9T/l+ZnNJV5P5Ms7tmfuZ0lpuayNiLvSllGF2WLA0F
         HwWj0Y0Apg/CGUBNTk7DdPAwK5lUZsArERIiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :message-id:references:subject:cc:from:user-agent:in-reply-to:date;
        bh=6qz1J4MMw4nI/1NgI3i1H1ACJ2Y9IwK0nr8WJ/mYHTE=;
        b=m+6SOP/foOXm2ITdjM2fPbfOKWiCuLDgdTMcUpvxXiJgPXiauJ+1cCKsLKQKS551Wo
         J2kYnSejOgrBtZglMQkd7e282Qqq6/m4QRKn/hYYBFYtSmLkUDCD55LuT/Xj7/zAkpfb
         94MBKh/HYRLF1hi9M55KkG+MzL55nJegbFYvxchi0ve2lJcADJPNZzUxKAj1Vqgr6lkb
         HImSZSBmSG/d5YkFW3HqfLqeqjifGJOSFS5LkMrB3bl0sESHpsVSffRGTDQjIohrxt5h
         YR4QYQWai3EuixAGTeUKUN0cnhP4SbSgLi0sC0vXuJXqb46jxkl/CfKtUE0crIf4txf1
         feLA==
X-Gm-Message-State: AJcUukfpRvsgu1Vmc3y6wjZNLsfKvoE652cK5NX1CA/b7mNxo0Tczi3q
        4Nq9WUG+gTYyjXDyKPDyhfLjdQ==
X-Google-Smtp-Source: ALg8bN60M7BC+G3+vor8em3TLFj1peiHcTtZSLiDeiCzpRLOeQhTurS9n1rDM4p5JyFQ4TFhxAylFQ==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr28320270ply.143.1546034007274;
        Fri, 28 Dec 2018 13:53:27 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k15sm70220612pfb.147.2018.12.28.13.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 13:53:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Message-ID: <154603400565.179992.15420757926696319367@swboyd.mtv.corp.google.com>
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com> <20181222072452.186726-1-swboyd@chromium.org> <20181222103320.GW26090@n2100.armlinux.org.uk>
Subject: Re: [PATCH] driver core: platform: Add an error message to platform_get_irq*()
Cc:     robh@kernel.org, a.hajda@samsung.com, andy.shevchenko@gmail.com,
        b.zolnierkie@samsung.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, rafael@kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
In-Reply-To: <20181222103320.GW26090@n2100.armlinux.org.uk>
Date:   Fri, 28 Dec 2018 13:53:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Russell King - ARM Linux (2018-12-22 02:33:20)
> On Fri, Dec 21, 2018 at 11:24:52PM -0800, Stephen Boyd wrote:
> > A grep of the kernel shows that many drivers print an error message if
> > they fail to get the irq they're looking for. Furthermore, those drivers
> > all decide to print the device name, or not, and the irq they were
> > requesting, or not, etc. Let's consolidate all these error messages into
> > the API itself, allowing us to get rid of the error messages in each
> > driver.
> ...
> > +error:
> > +     if (warn)
> > +             dev_err(&dev->dev, "IRQ%d not found\n", num);
>=20
> Please don't use the notation IRQn - this is normally used when
> referring to interrupt numbers (such as those seen in
> /proc/interrupts) rather than a per-device interrupt index.
> Grep for IRQ% in drivers/ for many examples.
>=20
> dev_err(&dev->dev, "IRQ index %u not found: %d\n", num, ret);

Sure! I'll use that one.

>=20
> would be better - note also the use of %u for unsigned integers.
> Using %d for them is IMHO sloppy coding.
>=20

Ok.
