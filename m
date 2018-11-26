Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC359C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7186021104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WG6sWyxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7186021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeK0It0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:49:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45156 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0ItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:49:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so18104124ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 13:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usWN7YesMluLS/pLgjAZ8CkueIQfDt7WNpH7FVd6L1o=;
        b=WG6sWyxImRR7+7QS/hrYNuecnME+f7WCJLKLDvLKX2K4/H0kl8tGxpJlJP2hP4YUrs
         Gc3G0TrddzlffNL5g6FtQbEinsjYD9bPI5JGC24CfNZFLLhFyj2RABuSJ/R4MLsw1HH8
         Jy9x8T1eeh/U/ShKe824Vr0beZ3f8vMb45Uwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usWN7YesMluLS/pLgjAZ8CkueIQfDt7WNpH7FVd6L1o=;
        b=YKtcACNIWvOk9kebabDszpWhjFku8VidEM8pOQ9FotYH3qYxd3fvTrWbpPjPiwssRs
         nRy49FjvsxGVPIvd7RttgvYPIN/mbq1rRrs9yIN/bMLaWf+akGJF4MQsaWW7OajMcDHN
         b8k5jYU1xLD+zoKCwXkETcWTrVEe2FtgM/6QIgMIVfwMTCb49pDS6GsJPOVdUn/8YUxS
         q/Yz68WOXCBCwCasaeg3ywYpmf5B1qo8BOaSZfGSGZQG8iMzSsmWQcYvJTNDMMdjn8xW
         WlfkVfW8xO97loRlryD5E0mspEp0RfWnk4R4zmzzxM2bpROcO4opxIIOUbY8n/3oQy0k
         qp8g==
X-Gm-Message-State: AA+aEWYMiWTXtdgfEQBl1TKIYSMx9F068aFy6qm3I9IJZ80N5YZFbX88
        QSsT2aXEjhkRe2vNmCIbt2DdszJSXUBIl3h0FHQwsw==
X-Google-Smtp-Source: AFSGD/XZlyP2HnuJwcSzn2U4qsyoX1nKa2hKoiyqGgBcUoTCuKvx+sfhjbhlhszni1wV9pN++9Sk8DJx2difi8IHnck=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr17835793ljp.12.1543269232187;
 Mon, 26 Nov 2018 13:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-3-ckeepax@opensource.cirrus.com> <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
 <20181123105729.GM16508@imbe.wolfsonmicro.main> <20181123132522.GE2089@sirena.org.uk>
In-Reply-To: <20181123132522.GE2089@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 26 Nov 2018 22:53:40 +0100
Message-ID: <CACRpkdZKJGFmYFKBHdiayRsA2ona2zWfJ+xckJxD1UBsj39=sA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 2:25 PM Mark Brown <broonie@kernel.org> wrote:

> The situation with descriptor based GPIOs is a bug - the reason why the
> core does the request in the legacy case is precisely the problem Linus
> identified.  Once a GPIO is shared all the users of the GPIO need to
> coordinate with each other in order to set the value so the refcount by
> itself in the GPIO core isn't super useful unless it can also serve to
> help the multiple users find each other somehow.  I think what we want
> to do here is either push the gpiod requests into the regulator core or
> change things so that once the regulator is registered with the
> regulator core the regulator core owns and is responsible for freeing
> the regulator.

I think we see some problems with devm_* managed resources here
and I see Charles' and your point.

The managed resources pretty much assume
that you tie resources to the device model and let kref inside the
kobject in struct device do all refcounting and that essentially
collides with the refcounting inside the regulator core, they both
want to control this now.

If we try to push the regulator requests into the regulator core
it becomes complex, because that requires at least two different
methods as we move away from the global GPIO numberspace,
and the drivers usually knows best how to request it.

Indeed I imagined it like so when adding descriptor support,
as we do this mostly like that for other resources.

I suspect maybe the lesser evil is to bite the bullet, invent
gpiod_get_from_of_node() which is the missing API (we currently
only have devm_gpiod_get_from_of_node()) and simply
fix up the converted regulator drivers to avoid devm_*
retrieveal in the same manner as wm8994 (the already
queued patch). This will make the regulator core own the
refcounting as it does today.

It's a bit unelegant but it's very straight forward and I know
I can fix it up qucikly.

Unless anyone thinks it's a bad idea I will try to make a
small fix series like that and a GPIO patch you can also
carry in the regulator tree with it.

Yours,
Linus Walleij
