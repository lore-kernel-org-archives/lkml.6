Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C73F6C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EF0208E6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnG/DNpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EF0208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756136AbeFOMew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755869AbeFOMeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:34:50 -0400
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49595208B2;
        Fri, 15 Jun 2018 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529066090;
        bh=kDih1bauOB/02noVKq4tJpYkjSZDmo/6itWCZY5KZFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnG/DNpa6CVGWIk/f1IaRFrxBmjB5TDnKPKLjYLaLa9MsnEBNZ5jsi0qr7aXvugEz
         E7uFuEu8hgPWK2P4OFa++aZqoR+07QM2lLa948H61et37Nk7c/bR0GVG0bL7mpYP6I
         kOK3Thwc93dqkc3VDz1nUFT/v+3zewx7LGspqTpY=
Date:   Fri, 15 Jun 2018 13:34:46 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, matt.redfearn@mips.com,
        palmer@sifive.com
Subject: Re: [PATCH v2] nds32: Fix build error caused by configuration flag
 rename
Message-ID: <20180615123445.GA335@jamesdev>
References: <20180614142852.22226-1-jhogan@kernel.org>
 <CAEbi=3d_muKnGnmfu8OJZqO=2EUTSf-YjLPChupDVXxcacJejQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <CAEbi=3d_muKnGnmfu8OJZqO=2EUTSf-YjLPChupDVXxcacJejQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 02:12:58PM +0800, Greentime Hu wrote:
> Thank you James and Guenter.
> Should I pick it in my tree? It will be ok to put in your tree. :)
>=20
> Acked-by: Greentime Hu <greentime@andestech.com>

I think your tree makes most sense for this patch, since it only touches
nds32 code and it was nds32 that got broken (and I haven't actually
build tested it for nds32).

Though it'd have to be based on that MIPS merge I mentioned or 4.18-rc1
when it is released.

Thanks
James

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWyOyZAAKCRA1zuSGKxAj
8j65AQDqr4M08MZKR4z4n5AxVL2ozSzJKjNAuA6IzzwtHF7LKgEAggON5hirs31U
H9TNtNafsZ7kM0zW4m5d7bgv0E9u2w8=
=uOv2
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
