Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A66CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AA820823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqp4/9c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBHQae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:30:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35417 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfBHQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:30:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id z19so2741453otm.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruNsJkoEGKPrNxL8c8lzTuNNRb55OLq/l++uIdTyhi4=;
        b=rqp4/9c5ooYD+zO76YuYSxMzpr+y0/2vVrF1KzZz7WY2v/8SWsBEs7slV3IznxjmbO
         drAw2hCtKs0/bpTBB+OR3vc7RpmMBh4Q/DhNu5oruAsGPYynvW+yYDOV7V6wwlCtVsb/
         d9GzpioWFud/UMq7sLaV/YkZYPXBfLwTyD41TEb9l9O5Q1pnxYamW5R4xAg/iM7UMjOq
         5cVvLc4440S6R5efrh8G8TvUZVzV0FQcC2qFEHO37r/kgiSd2SUlEcLgk/ZOAJ6BzWy/
         P1QjPH5LtZ3yVfVUfKQVstxD73gBSGauox1BLDHfQz+VUtbw502+M0QMSP6JgTw4Fx70
         I35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruNsJkoEGKPrNxL8c8lzTuNNRb55OLq/l++uIdTyhi4=;
        b=oxN6xxeYHlpdLDM5hzsgNLIRnMSYYzWVZSF85xPdw+SMllo4R/H+PL/L9f9EIV1nuD
         KD2vMQJkY++j4ifT0y9k0BzeHz/WfJFzRz2Wqvb8qm01k1X6phAjO1l8D8Oy9/EDqwq9
         rdcm45QniYb61pI0uptSsTTyTelqFrvG+V1AUnBsrmheoScT0YSegVEUs3tmVCrxhmLe
         bzDMLE0REwRYeMm8mnXe1IRYbCqMxtlIryJjeENEA2/EoMAYjijV3jchRumge2Wsq/Ft
         ZGKUnlujQ8709da0Qb2voWlsDBhYgyv+5PBS6y4pDJOMx5y4qnhjKB8Z3luD5kTn7jG4
         amng==
X-Gm-Message-State: AHQUAuaEUCxCxz1rm/QsL8MV1IptdYqos8fEpgYtz8asXn7H0TVYVI8d
        nbXpCzTqv3dD07f/2n3JjnAjFeXgXZFZOkFGLuE=
X-Google-Smtp-Source: AHgI3IZ2fZyA9SHPh4ol7Rje2/csS1AKK+8Gc9mynCzUYxnFMQZYjq1FQXbxKDRDeR1ns8wXeH3yuYHKKOu+kdotsyc=
X-Received: by 2002:a9d:d21:: with SMTP id 30mr13945049oti.245.1549643433256;
 Fri, 08 Feb 2019 08:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <20190124201251.15159-2-TheSven73@googlemail.com> <20190208121810.GD23483@kroah.com>
In-Reply-To: <20190208121810.GD23483@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 8 Feb 2019 11:30:22 -0500
Message-ID: <CAGngYiXjJtGNLAV_jvoj2NsjD+UCnK_Q+ZssgSwAukYAXdgE2A@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] fieldbus_dev: add Fieldbus Device subsystem.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 7:18 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > +static DEFINE_IDA(fieldbus_ida);
>
> You forget to destroy this ida structure when the module is removed.
> It's a common thing to get wrong :(
>

But fieldbus_ida is allocated on the heap. So as long as calls to
ida_simple_get() and ida_simple_remove() are matched, there
should be no resource leak?

What am I missing?
