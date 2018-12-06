Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F40C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605CE20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/rFko+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605CE20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLFScn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:32:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44102 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLFScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:32:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so1321752otl.11;
        Thu, 06 Dec 2018 10:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drG8Th9e5jDmcsamqNY+hh1a6qkDyio/PwrU3PlYmb0=;
        b=i/rFko+Kk7pEx3qd9/85f8rmO+SrPWpQw+20vMyKi+3fpf1OmtvVJLmBGOBE2YO7TU
         cUo7czADwTLWoz1F7AfbDKX8esVzGefN5uGbGTcwtnrqZVq176FMNpJLo/RK8p0LRaQi
         3cUneQRqiEmDjsJ5HmgZeo/iLoflb2AcsmRwPA3k4jNzklsLuz4I/g8UX8QaDs0JPN3K
         5BuXEBVB8p9+CmTGJaVBxHdwvnVdCBXnMqRc4L+eBPwY0zC96JSLNUVVUfbCRUCn+zaF
         OcGwPVQ6S7UFbpuL9n975E3bbnIwWbK9ga8swmpf7eTOfmk2FnhO/c5EVJttW0Y1HOUg
         wbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drG8Th9e5jDmcsamqNY+hh1a6qkDyio/PwrU3PlYmb0=;
        b=oxEyyiEoAV70fpy2/fq/oOceH1naJy9nA6aixI9cnCnl4YQP3CbPL1IP38QWRtOEYZ
         NQR61cezOeHGXzmd2wngAhNjhOka8GH2dzYwisNRLFlyJ3vgtK/PlclCvfoaUD+gNly7
         qWbLTTkFx7SNs1n2NymeiESOfUZWVOByaasWugC3PvQhWlVxGIdUtq6AUB13FQA18yMy
         MYoAtmSVoa9T3VXFSNM2L8NcVmoINDVYqMLWvKBknosNVzHysiV4Jgq12XdJ+urt+pvW
         QktbTrWxQ9yuqvfvSdvLpcKACLcIrYs69MGREhtPXhXz3lbBRXqekgZEixRsCp+CpmHZ
         jjUA==
X-Gm-Message-State: AA+aEWZBoYYUOTgCmOlt+j9JBbwuKhyUUbIWZtaGmQv+CUv2xK1jnLd+
        dWVcKoj8TxC5epkgpPmCRP/VF/KNM4KQDzGZffQ=
X-Google-Smtp-Source: AFSGD/XHe/mQOHNYHmaAUW1os13oPqlPe8wTuq0uHMfYrx7svgNcDis0hbGT/W4E6pIUNS+XZg2UWgX5h94OJWQ3X6M=
X-Received: by 2002:a9d:781:: with SMTP id 1mr17530139oto.250.1544121161651;
 Thu, 06 Dec 2018 10:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20181204220224.27324-1-TheSven73@googlemail.com> <3b0b4c5c-23a6-428c-6060-3e5c314bd9e7@lechnology.com>
In-Reply-To: <3b0b4c5c-23a6-428c-6060-3e5c314bd9e7@lechnology.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 6 Dec 2018 13:32:30 -0500
Message-ID: <CAGngYiVz5sqiaKQAXoAx-TyocDNDf+5ZKNXJRr+h5gXT+KA_sA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add Fieldbus subsystem + support HMS Profinet card
To:     David Lechner <david@lechnology.com>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, thank you for the feedback !

On Wed, Dec 5, 2018 at 9:05 PM David Lechner <david@lechnology.com> wrote:
>
> Does this actually need a new fieldbus subsystem or could it just be
> implemented as a new network protocol?
>
> Then this generic interface to a fieldbus device could just be a socket.
>

This is a fundamental question, and I'm glad we are having this discussion.

Caveat: I am by no means a Fieldbus expert. HMS Industrial Networks are. They
have recently become aware of this mainlining effort; but they are not Linux
focused. I really hope they will participate.

Fieldbus is a collection of network protocols for industrial networks.
The underlying network technology varies: e.g. Ethernet for Profinet, RS485
for Profibus, just to name a few.

The actual layout of the raw packets exchanged over the network is proprietary;
fieldbus cards will typically implement this internally, and hide the details.
Some fieldbus protocols have hard real-time requirements: the CPU inside a
fieldbus card will typically run an RTOS to satisfy these.

Could Profinet be added as a new network protocol? Leaving aside proprietary
and hard real-time concerns, the main issue is that cards implementing the
standard won't provide access to the raw packets.

As a result, the Fieldbus userspace API can only consist of whatever these cards
are willing to expose. This varies widely among implementations and fieldbus
protocols, but there are a few commonalities. For example, every fieldbus
card will expose 'process memory' which you can think of as shared memory
between a device and its controller (master).

The fieldbus subsystem proposed in this patch exposes a minimal set of
functionality that every fieldbus device is supposed to have. In many
instances, this won't even be enough to get the card to work. For example,
there is currently no way to provide initialization parameters. These vary
from setting the card network id, to configuring a built-in HTTP server
running inside the card (!!).

Linus Walleij suggested that the KVP nature of Netlink sockets might be a good
match for fieldbus initialization parameters. It sounds promising.
Yet when it comes to accessing shared memory, I cannot see how Netlink could
be of use?

It would be ideal if actual fieldbus experts could help shape this interface,
but I don't know of any that are willing to. One possible explanation is that
the fieldbus corporate environment may be a strong believer in proprietary
technologies.

Sven
