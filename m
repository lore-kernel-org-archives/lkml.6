Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF37C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079002086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079002086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeH2MW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:22:56 -0400
Received: from sauhun.de ([88.99.104.3]:45118 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbeH2MW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:22:56 -0400
Received: from localhost (p54B3352D.dip0.t-ipconnect.de [84.179.53.45])
        by pokefinder.org (Postfix) with ESMTPSA id 8139C343ECA;
        Wed, 29 Aug 2018 10:27:09 +0200 (CEST)
Date:   Wed, 29 Aug 2018 10:27:09 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/6] mmc: tmio: refactor TMIO core a bit and add
 UniPhier SD/eMMC controller support
Message-ID: <20180829082708.2li4opnruodugo36@ninjato>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFore4GkGyMn-4VA-2h1MbNp9sQ0Szif+Mjj5qtM-7autw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cebslwlmy6zsog4x"
Content-Disposition: inline
In-Reply-To: <CAPDyKFore4GkGyMn-4VA-2h1MbNp9sQ0Szif+Mjj5qtM-7autw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cebslwlmy6zsog4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 12:43:31PM +0200, Ulf Hansson wrote:
> On 23 August 2018 at 06:44, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Add UniPhier SD/eMMC controller support.
> >
> > As a preparation, I changed tmio_mmc_set_clock() to a platform hook.
> > The clock rate setting is platform-specific, and UniPhier variants
> > will add another way.  I thought it would be better to split this
> > to a hook to avoid a mess.
> >
> > V3 is rebase on top of Linus' tree.
>=20
> I have queued patch 1 -> 4, waiting for further reviews for patch 5 and 6.

I have re-tested patches 1-4 as applied to mmc/next and it all works
fine. For those

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Now, going to check patches 5+6...

> > I dropped 6/7 because Renesas added more quirks
> > in the current MW.

Totally fine. We need to cleanup HS400 support more, then we can try the
simplification you did for tmio_mmc.c, too. Thanks!


--cebslwlmy6zsog4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluGWNgACgkQFA3kzBSg
KbZx3w//Wl0REQpw7bHVLUNFsr+rZYLXxVh2tOiagstUyLIo0LEbSWgT8v1wD2FM
f/fAVq0/YABZRHJdF8T8yq7nsHicxhkbEmQEmrAfpYOL6HOCm9U3YiMZXuKx+NFZ
mex9FRk3VyqPKDeKoYNvMoFSVkQeWwAB1WqKxgym0AmbggLK/mg2ehNQHrMYMCVE
p1u6rTNEkx48nDvmsO/zOU6Nm9y7A59+dBjLz94Fzm85+Xq2daSKiOysERXEgep/
plj22wcdeIoFMSZTl6hrB6n9wAhQeAferpvJQ74sE3Zd9QTcAujylS4SxGC62F2p
Pz3rO7Dm31xuI/3jwm4UnPqXqEooeO7N90NoX8oeaTOpITLCHst9o7u2dbL8EYUL
epQCGH/4eLarrYm89bQ2VxOz6ELoiRajVpeZo2naThKFT3YILRNc666C3YpfEbDj
a/cBh3j9MiqkkjsfMuFXrPhSoA5/Z0LvEbQ6tI0N383NIgqGif2w5uKudvOl+tdL
s4seGwFYFAs+SA55IeabRMKIB0SGlzEIjIJEyCb4mfA3gyrs83xdUHqVDYvULCGu
/YRqwFZLltX27jxvgO4TrTH2Ad37BM2i8thINpSsgp5tyz42ZPiZalhghlnxhsYD
unrToWX16xTd6yf/vQTtopZ7lbCbPQTNuILCXxENBRA9rYM6YKU=
=7Y8v
-----END PGP SIGNATURE-----

--cebslwlmy6zsog4x--
