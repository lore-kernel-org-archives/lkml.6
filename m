Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA3CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B382080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y81JlI6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B382080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeKQWci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 17:32:38 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38343 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeKQWch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 17:32:37 -0500
Received: by mail-yb1-f195.google.com with SMTP id u103-v6so10838877ybi.5;
        Sat, 17 Nov 2018 04:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sm1uhpx0p5QSG2eCHz2i+ElYJBmnc3zaH89bkZJAWzQ=;
        b=Y81JlI6jkeWI0BaMf1HHkj8o3bb/VkueClljYvfDF/6Ok2T7nOySRqtcyatdTxx17X
         Jk8zK0a9mUXY/KoOaFnaIXRDR1WcQGRfmkEL7TngyI/qKwZxnyFvifib0KqNo4ATRox3
         tPKgkfdV8AjtahngfyUy1w1+y3qofmB+ATiI1Ee6bibR+XQOYjr8zjbSwC8XMfJ9dXPA
         aILguiPINzjevCOaStpX475K+7Zs6CoViPKGN4Tf9vVAN3mMYkqH3gU9+phJfIQ0eYdV
         uVx4cWxbEy6mtaBV4gO/XHkrL261xW6/iR4v6bglmmRiSyGDYLSwZbHdU1mwuSPMKnyq
         X/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sm1uhpx0p5QSG2eCHz2i+ElYJBmnc3zaH89bkZJAWzQ=;
        b=QHd6GNYVXcoP6wtwk1qj+/pPfM8dwp1+ZtejJgK31xAFE+IoH5u1+B4ytRQ5JchzHX
         A6DB12HtKenTyiywbTzhThvgukD1MatEEhWZAAJTw/bCGXBBHVu5XKELXpcYp87uS1Oo
         ONGsLFw8Irf5oIainBMF8yioRGImVQaHrREXloC4RXd33wv/Fz/JTbY2kPywnSwxawL2
         Pex362mJ3dizDByZsON5hSXoYNT/Pf99KbNT8pCd+MZACRBpzwkykCPxQ9DdOrpPvS/n
         8Zgx5UUK4nynrmS/IQB4oaZPnqp/wMH8sebdQlL7d5G7I5hnjX3JJ96aJsCWsPMNevXZ
         ELRw==
X-Gm-Message-State: AGRZ1gL+ZJMLdUttPzJLHZ87zNbiHD6WHaYMzJdXyB+T7NTg2HSoOAw9
        QoZetsub4OSy+2m+mKRUOiYcnqssVkj64Uc7nBU=
X-Google-Smtp-Source: AJdET5cVFjkVaI7fG4JGp6ZcFjXG3DSdH7qoqCz7Dftvgcsa2uFT+Wv0vFODvJJ5hCRW7w90v4D0PBmTg+R3C1KDe5g=
X-Received: by 2002:a5b:d06:: with SMTP id y6-v6mr13720292ybp.147.1542456967102;
 Sat, 17 Nov 2018 04:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20181105135802.30486-1-peron.clem@gmail.com> <20181116025938.GH5829@dragon>
 <CAJiuCcerEanEobbi8zPb1-eb=zCJsDAbM=p6T64+wtuXjtaMTA@mail.gmail.com>
 <20181116144520.GO5829@dragon> <20181117030947.GX2089@sirena.org.uk>
In-Reply-To: <20181117030947.GX2089@sirena.org.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 17 Nov 2018 13:15:55 +0100
Message-ID: <CAJiuCccLyd0wBdCyOfjW41i1EQ7Uuj2ZpdR0cSz3Oirdd8n3Ug@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-audmux: complete dt-bindings for imx6
To:     Mark Brown <broonie@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Colin Didier <colin.didier@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Sat, 17 Nov 2018 at 04:09, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Nov 16, 2018 at 10:45:22PM +0800, Shawn Guo wrote:
> > On Fri, Nov 16, 2018 at 11:25:07AM +0100, Cl=C3=A9ment P=C3=A9ron wrote=
:
>
> > > It's still quite new for me to submit patch, but if this patch should
> > > be sent to ASoC maintainer maybe there is a line missing in the
> > > MAINTAINERS file no ?
>
> > @Mark, comment?
>
> Adding a file pattern for this seems sensible, yes.
OK,

I will send a v2 for the IMX6 Audmux bindings with ASoC List and Maintainer=
s.

Thanks,
Clement
