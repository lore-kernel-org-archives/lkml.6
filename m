Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175F2C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED4C21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZGjzMudV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED4C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeJFBkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:40:04 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59661 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbeJFBkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:40:04 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d7db8103;
        Fri, 5 Oct 2018 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=0KK8ySgqtXWyvI77mHHL3ERXrcc=; b=ZGjzMud
        Vv4oGKEzO3oQm9zMYhT3EsK0cDFbNzgm7/BJRGPnw0YgZZSZxVHSRRZtQsRurzxG
        rlj0+VO/yGDsGXmkdvnD2q2LZQW065l89X3fwXFXzyFL/kdWkJ/bm5w05Vim0rkg
        f0U3R7XVTaUpxAKWWUF767eTkW+Se3WYFCWBVtwfloSfWtHYo8Dwip/BXI/sIPYe
        R3m5bRMF+GQ6hiYLm4Ckjs+xOAM5dviXnl5zjlwxS/eAFizLi9xxIAbX+vAZ074B
        trxnnCcLtM2M+PAAh6PPnkdn9vkxfE4hCeZSuAGfTlIujl+DGZQ6sJfvZx9J+sRN
        YPEAhIgt3P4mA8w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4e134b1f (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 5 Oct 2018 18:39:39 +0000 (UTC)
Date:   Fri, 5 Oct 2018 20:40:03 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org, sneves@dei.uc.pt,
        luto@kernel.org, jeanphilippe.aumasson@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        peter@cryptojedi.org, djb@cr.yp.to
Subject: Re: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
Message-ID: <20181005184001.GA10106@zx2c4.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
 <CAHmME9rp0Fi5ObK5oi8FHj1_nK5hP4T2Bq7_dAmzq4OQ0mp0uw@mail.gmail.com>
 <20181005150538.17006.qmail@cr.yp.to>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20181005150538.17006.qmail@cr.yp.to>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey Dan,

On Fri, Oct 05, 2018 at 03:05:38PM -0000, D. J. Bernstein wrote:
> Of course, there are other ARM microarchitectures, and there are many
> cases where different microarchitectures prefer different optimizations.
> The kernel already has boot-time benchmarks for different optimizations
> for raid6, and should do the same for crypto code, so that implementors
> can focus on each microarchitecture separately rather than living in the
> barbaric world of having to choose which CPUs to favor.

I've been playing a bit with some code to do this sort of thing,
choosing a set of implementations to enable or disable by trying all the
combinations, and then calculating a quick median. I don't know if I'll
submit that for the initial merge of this patchset -- and in fact all
the current implementations I'm proposing are pretty much okay on
microarchitectures -- but down the line this could be useful as a
mechanism.

Jason

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEq5lC5tSkz8NBJiCnSfxwEqXeA64FAlu3r/8ACgkQSfxwEqXe
A64NZRAAxHqb5/Z9ObOwhJ6OLx/HnHRBt35TCF7ZOS6CtnOwHr7KYFeWdny4GUvF
saghZ8OkUK9g7DVDzDDFOsTtFAjBqrZiqrL7eQAlNszz8Ru2ijsUUqXrgzC2Ikms
FDMCZqkbIwHLon/8UelYHz/MW1MgId+HVMjhNzxleE3fdMhgLwGmRkiUMHmBUMBG
Xuvljbqfl2Y0jgytW6Np+GeIMHqbWPQjcbsk3lfIsfwAsMcCeA063nlf6f5uVM8Y
l+bDhSm2oB9laOXZJc6fl5e+J1TMIQIlpGldXBhHXZU5JrRWr5XnVIbGQYQ3DXSf
2GVdf+Mo0AgkqoMXqIOd07k65dFXDyui0PG0oypxknKRG1d7+Gke8avIOVME+UrK
aWGPA74qubEfVzV492wbKrpYhiaeV+VL7qi/4+FP76pRwUFC2KloAi3NFotFXDCA
VFzlECZ8H3Ryla+ZnHA7mAJHsIuBZXYqMQScoHUG1zbSg6a8bjUt1gTdAO/vkVvc
WZXpewhL23FLOR0C3/J2dkoRdBh3iKb/xG129w9PoA3/v52cCnKe760ZD7TpwSh2
toG7zwJMssriYB+GTvFV1om6Rli+dAP1o9OvqTW8IUA2r3BYJrmVLtKsSIQ1RDjJ
M++c1/sfq3ca2bNkoZjFahmNEwP+dMhCcNGXO9RKpYRHzm1agBo=
=yJNa
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
