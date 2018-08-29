Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A68BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AF120644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AfAT3f0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AF120644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeH3BtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:49:12 -0400
Received: from ozlabs.org ([203.11.71.1]:54401 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbeH3BtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:49:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 420znN4RjLz9s2P;
        Thu, 30 Aug 2018 07:50:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535579417;
        bh=9NMFKUVJTI3ugdeBQZgPKc997aXP4iQ/Q3bijeSF9zk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AfAT3f0W9Tz0bqlqcrknn5sM6TjmfYci9PsXTMF+tEDT4VFEni1+G88DpRMjwKmiM
         zYem5fPGcwsvr2RULlbfj0KLnEI3B5IhSFcfN7yPcoH8xrWa8CrpPLWDaufydbK/9V
         FNHP8ueMakG7TgPH9uFzqnHFmfgF7ZFbE7rSScLn5YGu4CL1NkAdlvfbP0HtIdW79L
         I08gp21c0ZsYGXv2cJMs92lw/lv0WPmpDe4DgfYnCnSEXpFyOPX62wo6h7cOqBPfPs
         uxDH1BhzxP3IBzwD/Ai3kC72pnJ4IhF1Dvl1nUlbP2d1KVG0zwQ3Vf/+MOXTjEvtiI
         zG+APQU0woZ+g==
Date:   Thu, 30 Aug 2018 07:50:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod <vkoul@kernel.org>
Cc:     Linux-Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Add SoundWire tree to linux-next
Message-ID: <20180830075010.05310cfd@canb.auug.org.au>
In-Reply-To: <20180829171133.GL2388@vkoul-mobl>
References: <20180829171133.GL2388@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.HzYarUdFFIAuJWXgA0BcmW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.HzYarUdFFIAuJWXgA0BcmW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

On Wed, 29 Aug 2018 22:41:33 +0530 Vinod <vkoul@kernel.org> wrote:
>
> I maintain the SoundWire subsystem which get merged to Linus thru Greg's
> char-misc tree. I would now like this to be added to Linux-next and after
> the Greg's char-misc tree.
>=20
> Please include next and fixes branches of the soundwire tree located at
> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/.HzYarUdFFIAuJWXgA0BcmW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluHFRIACgkQAVBC80lX
0GxBhgf/StOCHsRDAtjCYuqnme6EHLn4g9CJ9z5TLmZ9HQRDZRIIXvQ7NSVzGUPn
Rv2etKk8Dm8UStWdXk4OnJwHZu55pUDkKFefWh5Z4ch0/5vWtmaHlZY9U4Zc4Vbf
RyYyXA3P5xbpcNvZJDoxvjGy2gj6bly1OFjNVpVeYHXBMBWrCxDmv6CzXj/4j0Qf
YQNhXYoqgoosUozi5XS3Ms5gi4HJ/gz64VRluGgJygQ8HXCweMCzw2KMFLVMM2qP
7IwLrxt8edHrc+UrENHYtinhySnS6gelXayfuKOH2uQys+yuK3cHHltk6D2BMbxh
VAewgfom2hjxtPOkWnADNLORErX81w==
=yvLQ
-----END PGP SIGNATURE-----

--Sig_/.HzYarUdFFIAuJWXgA0BcmW--
