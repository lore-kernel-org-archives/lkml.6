Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2564C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF6A2250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmX7LdtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF6A2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbeKMKNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeKMKNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:13:21 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3072250E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542068271;
        bh=VJXRssMjUBid54GFDjXxLrLek8w4ubGoHOxMsppJLyg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JmX7LdtF9OAEPVlmZdzDoPqSKI2JYZ5TjHfUx3pxWWLDbWwRERWYZWOu2rGe8Dwlc
         NXFsH+pWpVSblmMkibdZyVWc/EP8GY5fzF0s9fjvJRpZUyKFNBZ+70NY9AkxAgbMXH
         JKVxu/TUtl1CG7KlZktToyXT8lnBWYPy+omApmA4=
Received: by mail-wm1-f43.google.com with SMTP id z8-v6so3613936wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 16:17:51 -0800 (PST)
X-Gm-Message-State: AGRZ1gImStl8esvQpXwSWaebTHaYW+o5o8E4SPI00jdGBmXTDe+HOUwN
        llnwqC2neVNjjI0xpC5P93AqabhzYt0fJyQwVuabrw==
X-Google-Smtp-Source: AJdET5dK22sasz3zQ25hECLYzkOWw1yqRTRcn9j4rMpqqc6eL59acIV5CU/ghEw+AhmsRdc0lmnbfR+kyJ98qpDnBn8=
X-Received: by 2002:a1c:1f43:: with SMTP id f64mr1402920wmf.64.1542068269632;
 Mon, 12 Nov 2018 16:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20181110232034.17277-1-andreas@kemnade.info> <20181111024648.7rt7rlhaqihtqecv@earth.universe>
 <20181112215812.18ebca35@aktux> <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
 <20181112222726.73m2oca7hankvcjs@earth.universe>
In-Reply-To: <20181112222726.73m2oca7hankvcjs@earth.universe>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 12 Nov 2018 18:17:38 -0600
X-Gmail-Original-Message-ID: <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
Message-ID: <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via serdev/devicetree
To:     sebastian.reichel@collabora.com
Cc:     hns@goldelico.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, johan.hedberg@gmail.com,
        marcel@holtmann.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 4:27 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Mon, Nov 12, 2018 at 10:19:02PM +0100, H. Nikolaus Schaller wrote:
> > > Am 12.11.2018 um 21:59 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > > On Sun, 11 Nov 2018 03:46:48 +0100
> > > Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> > >> On Sun, Nov 11, 2018 at 12:20:34AM +0100, Andreas Kemnade wrote:
> > >>> This is a first try to be able to use h4 devices specified in
> > >>> the devicetree, so you do not need to call hciattach and
> > >>> it can be automatically probed.
> > >>>
> > >>> Of course, proper devicetree bindings documentation is
> > >>> missing. And also you would extend that by regulator/
> > >>> enable gpio settings.
> > >>>
> > >>> But before proceeding further it should be checked if the
> > >>> general way of doing things is right.
> > >>>
> > >>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > >>> ---
> > >>
> > >> Patch looks good to me, just one note
> > >>
> > > I found one thing myself:
> > > Shouldn't we have a generic compatible string like "generic-h4".
> > > ehci-platform.c has for example:
> > >        { .compatible = "generic-ehci", },
> >
> > There might be differences in h4 compatible devices (e.g. default
> > baud rate) so that I would not bet there a "generic-h4" suffices
> > in the long run.

It will not because that doesn't define clocks, resets, gpios,
supplies, etc. and the interactions of all those.

> My suggestion is to use this in DT:
>
> compatible = "wi2wi,w2cbw003-bluetooth", "<something generic>";
>
> The driver can start with supporting just the generic compatible
> string. If somebody finds some incompatible differences, the driver
> can add a custom handler for the wi2wi chip without breaking DT
> ABI.

Any idea how many H4 devices there are? Somehow I doubt there are that
many to be unmanageable.

Rob
