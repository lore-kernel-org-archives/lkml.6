Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D92C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C8A2154B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDMDyONA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C8A2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933754AbeGFQdX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:33:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40426 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933616AbeGFQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:33:20 -0400
Received: by mail-lf0-f66.google.com with SMTP id y200-v6so10272773lfd.7;
        Fri, 06 Jul 2018 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HycbmqPb39YvsWuX/UZ7NeKRI0YbZDJtqzZrUXhaOLk=;
        b=lDMDyONAR5H0/MjroRMnG/UgO+PuEplOq9ts/693FYLQs/8/d3d2eBa38hOjX6WTXw
         NdVqr/bwwQh8Jdvg4hmG6WJiDEfH7RZpUq7qj/pfMyL4ACoo+lpV1EBVwkzQoq/v+FKh
         ooMjPFcL/UXSSym3Dv/emZSJT/0H7cTJL4vgWg6gQLgA8QslZIRNpPggX3/HEDUltXc8
         0bb3DoqG2Z8PpuVk39Kwy0ra/odZxkbeTnTa2dYTKSE4TTn3SAS5Qt7qk5qG2v+qd8o9
         MS3cWDZQy2ahKEX6oE4u0Q6nWYuOA93ZWR0H472c4PVERxaNfLaZ4vv74TxcHdAEvhDO
         F94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HycbmqPb39YvsWuX/UZ7NeKRI0YbZDJtqzZrUXhaOLk=;
        b=NrwnTdjoACXIM+j6bOy37Db53zmT5nnlTb0oIcLz2VZe6Owzirsm8QAewHgdun1LLt
         myC7jjQkM9fGWCxWiMaN3oN8TcsDUbRypX3G6LOFo6VfcYG5FQAJhMJnJsqPUuSt9qbc
         mAvw8BhUYOVUqyWWPcu6ofU/dj/z8nFfZ/KyjiYI77SgMAhwNd8Fahyfa004EdIrNDWZ
         lLqI3UUiuWKPB/EAUKxlelWZ2xwmyGv7c7Dh0mjaJ+a+i+21kKXMCYDaQATkgAMSWg1Z
         Pff9vhpmBWb9+Imw5TCbt2Bl7W4CuspIZipdZGDjUpOaE37TWhZM22tPEZp+RNt27SPa
         sFFQ==
X-Gm-Message-State: APt69E1DYrHy7pA2e4IFyOkiB81XLiLrpwL01CBfmdJ6WUwvZEjr5tJb
        eCxIT4D+Xkv0zScSXC7f7f4=
X-Google-Smtp-Source: AAOMgpeGawrFU/WSV92TwvVJUAgshg8jYIkUdFChPUevcfngfEEkpSM/8SjPqB3P8U7wpFjxMEPtMw==
X-Received: by 2002:a19:9481:: with SMTP id o1-v6mr8179178lfk.38.1530894798014;
        Fri, 06 Jul 2018 09:33:18 -0700 (PDT)
Received: from dimapc.localnet (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id c83-v6sm2176863lfg.18.2018.07.06.09.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:33:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/2] drm: Add generic colorkey properties for DRM planes
Date:   Fri, 06 Jul 2018 19:33:14 +0300
Message-ID: <2513788.CeRymH5ehq@dimapc>
In-Reply-To: <20180706154027.GB17271@n2100.armlinux.org.uk>
References: <20180603220059.17670-1-digetx@gmail.com> <2295190.xHWjP7Ltc3@dimapc> <20180706154027.GB17271@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 6 July 2018 18:40:27 MSK Russell King - ARM Linux wrote:
> On Fri, Jul 06, 2018 at 05:58:50PM +0300, Dmitry Osipenko wrote:
> > On Friday, 6 July 2018 17:10:10 MSK Ville Syrj=E4l=E4 wrote:
> > > IIRC my earlier idea was to have different colorkey modes for the
> > > min+max and value+mask modes. That way userspace might actually have
> > > some chance of figuring out which bits of state actually do something.
> > > Although for Intel hw I think the general rule is that min+max for YU=
V,
> > > value+mask for RGB, so it's still not 100% clear what to pick if the
> > > plane supports both.
> > >=20
> > > I guess one alternative would be to have min+max only, and the driver
> > > would reject 'min !=3D max' if it only uses a single value?
> >=20
> > You should pick both and reject unsupported property values based on the
> > planes framebuffer format. So it will be possible to set unsupported
> > values
> > while plane is disabled because it doesn't have an associated framebuff=
er
> > and then atomic check will fail to enable plane if property values are
> > invalid for the given format.
>=20
> The colorkey which is attached to a plane 'A' is not applied to plane
> 'A', so the format of plane 'A' is not relevant.  The colorkey is
> applied to some other plane which will be below this plane in terms
> of the plane blending operation.
>=20
> What if you have several planes below plane 'A' with differing
> framebuffer formats - maybe an ARGB8888 plane and a ARGB1555 plane -
> do you decide to limit the colorkey to 8bits per channel, or to
> ARGB1555 format?
>=20
> The answer is, of course, hardware dependent - generic code can't
> know the details of the colorkey implementation, which could be one
> of:
>=20
>   lower plane data -> expand to 8bpc -> match ARGB8888 colorkey
>   lower plane data -> match ARGB8888 reduced to plane compatible colorkey
>=20
> which will give different results depending on the format of the
> lower plane data.

All unsupportable cases should be rejected in the atomic check. If your HW=
=20
can't handle the case where multiple bottom planes have a different format,=
=20
then in the planes atomic check you'll have to walk up all the bottom plane=
s=20
and verify their formats.

I'm not sure whether it's worth to check the planes intersection and fail o=
nly=20
if top plane intersects with multiple bottom planes having different format=
s.=20
Perhaps that could be a driver-specific implementation detail, userspace=20
should take into account that atomic commit may fail on changing planes=20
position.



