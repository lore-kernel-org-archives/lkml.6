Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6DBC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B122173A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbNCNNYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B122173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeHNRMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:12:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40659 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNRMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:12:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so12473367wma.5;
        Tue, 14 Aug 2018 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QGhkZVlxuhNbrKjVcwZjBlRbz5zA6lX59VqL04ya/EQ=;
        b=qbNCNNYCPzi3AAEApHDLHRc70bd06C6Q9/Y0ykJZrxEO0RGDTRO0MOAdvgWGBvxqH1
         c6OKBc73UQP/lSJm8jNxNgdzvKOdb3IQp6iRCAHJlsaqA9i9aTWmJUp+8m07iCvdxCuG
         44q0RvasHDZ3aW7dKB4SYmCWLyVmSgovHflv9xS7EUa8tXDpy1b//zjRrhrZ46sdyUzT
         F5Pr+O/F3X3gi5+qozuoNrA9hksMTQUs8Y9pNPAP9CIbEPgx+CRiRWM7jCVMwk2naZvg
         a8BjNxrTABreyQTpFZb72kheVGEXmZL50000VZeXve1BoQEPrB9AmptUd8yk9+y4F46H
         v1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QGhkZVlxuhNbrKjVcwZjBlRbz5zA6lX59VqL04ya/EQ=;
        b=oJI4HlzNrN/yvkPMk2w3EL/99Bt4/b9O0+ZxBk8hSROvqzlMFi/CJzXSYlNhuqEyqR
         OaRC9NNyd4VKnC6wF/RdezTUfnfPTlzViJPukTOwiS6aayO7qje8d3mZ1ZWgWirT9kNp
         EqzxKnW0mJzs2NweOrTagkftuPhwPoxoq4Y49ZUIjGj01r6onN5ApiOc27aYdPiukYvN
         NaMLW3dblsSQ/0HnY9h+KXC36mg/kNpJSU8C2DlHlTigx6uc7Mmu/Go8ikJp4xIn/bA7
         FWrTbglKJ+aBIyJq0+cAFzgn3HiZHeSNfXskYxwd0huLjA8L2St/Ev5JTbjN14okJ5f2
         JLqg==
X-Gm-Message-State: AOUpUlG0cOYEeD7FeX9yZ5+T/1ZXGxIGyT68Yw+Gup9gz9YgEjG1RsiP
        F+YKRIv4lgDsRMuESVHEZNQ=
X-Google-Smtp-Source: AA+uWPzW4a+AO9yZ7ZcRif8Su9XOctHsW4613elJXPhAWVTZZZgUy8mV+7Txwh739XOF05RhwshlFA==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74-v6mr11585059wme.70.1534256696143;
        Tue, 14 Aug 2018 07:24:56 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id o10-v6sm14336623wrw.79.2018.08.14.07.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 07:24:55 -0700 (PDT)
Date:   Tue, 14 Aug 2018 16:24:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH] soc/tegra: pmc: fix child-node lookup
Message-ID: <20180814142454.GB21075@ulmo>
References: <20171115094458.31666-1-johan@kernel.org>
 <20180322142432.GA5853@ulmo>
 <20180813143317.GI24218@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20180813143317.GI24218@localhost>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2018 at 04:33:17PM +0200, Johan Hovold wrote:
> Hi Thierry,
>=20
> On Thu, Mar 22, 2018 at 03:24:32PM +0100, Thierry Reding wrote:
> > On Wed, Nov 15, 2017 at 10:44:58AM +0100, Johan Hovold wrote:
> > > Fix child-node lookup during probe, which ended up searching the whole
> > > device tree depth-first starting at the parent rather than just match=
ing
> > > on its children.
> > >=20
> > > To make things worse, the parent pmc node could end up being prematur=
ely
> > > freed as of_find_node_by_name() drops a reference to its first argume=
nt.
> > >=20
> > > Fixes: 3568df3d31d6 ("soc: tegra: Add thermal reset (thermtrip) suppo=
rt to PMC")
> > > Cc: stable <stable@vger.kernel.org>     # 4.0
> > > Cc: Mikko Perttunen <mperttunen@nvidia.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > >  drivers/soc/tegra/pmc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Applied, thanks.
>=20
> I noticed this one still hasn't made it into linux-next. Looks like it
> wasn't included in you 4.17 pull request and is still sitting in the
> tegra for-4.17/soc branch.

Indeed. Looking at my tree it seems like I applied this to for-4.17/soc
a couple of days after the signed tag for the pull request. It probably
should've gone into a for-4.18/soc, or perhaps into fixes pull request.

I've cherry-picked it into for-4.20/soc now. Thanks for the reminder.

Thierry

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlty5jYACgkQ3SOs138+
s6Et9hAAnZ04tRIizkcPqVJmHyaTRnw4dedbCFiKwJCInlc/o6l8lj9+g52bazTb
1tbqzzrMqVT1zWtILFZsoPKDXE5OMOv98twCGZEwIJ6Got6w5TsJbI0ctPhdL2Be
B+nUNM0wAOyaQluqhHSWikJJEvkHZ6rftXUwzQMVhwxVEh01QzIwRW/jGHDB6Twe
a06gnfKHGCqhZm4Qb5aeA4mUopTbad5VCrXclWAXGMcfUQA/KV2BKz7Stj0dTWlA
Q09/CPgMFnBTqCR1n3Pd2HZp0H8TAx3YopQr1r6SGsiZdh/udjvmIoo2Ih4GFXy7
pN5y/kjiuOKrsjx3FkmAxwN8SkJfi4BwzsL7ACpsqr5cXJJLmuQguotjm5q20fSQ
4Be+SrOPt91eeLEDIrXO5Zgs0O3HmGjpzBBsZZQuzbMa009lQPGyOqVjN85trx2o
73lrfZKdecVEOVQivaiHdLX8QTeSVbgm79HSdnQjSrTh1SfmuGpJIwAJczIj+l6l
l9PCnznTGQiQoLpBpXnEgjZEKE1KQa/rJxZBhbTk/D7fqFMJkklexXW5o6pkS7sN
fOsZXeldMXvhdkxH53fZOUBj6nX/8if+jqLa9wGSIW4Z03Ic/tgTM7reC72EjqYT
SmB46t/mz4qG1bph2pVeax6+bogJS6SfW9eiLAGztrCgczEwXAg=
=Usxc
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
