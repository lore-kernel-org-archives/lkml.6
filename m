Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C664C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038B9216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Qrd3Hsgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038B9216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeHULuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:50:17 -0400
Received: from ozlabs.org ([203.11.71.1]:39027 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeHULuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:50:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41vkQt1GbXz9s4Z;
        Tue, 21 Aug 2018 18:31:02 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534840263;
        bh=0F5iC4KDEnrMwLvyq8f5NRzHer0w5vP6yn70A7YtuqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qrd3HsgcMuQ6duT2SZHNxuz5MbvXa3tEBc8QVWlYu4s5elTKOVJy401h127YTHR7Y
         Rc41aYNmyizU48Gqob4SRLdVVHOhUMv/v4ASm32tOxCrVj8QIx6ZaFTUrVuGm1l3bR
         BZC4ZR+dvHVZCoNpgcFD5TlkL3Lu0VuNy2rnSJoxaY14G3x8r0AO+E4dIDF8FKbNyn
         Xy+hJIroh8dxqbz5X2vsXRw9iiOCz98GRI599xW4/vMpSJamikcmiPcfI+ChuJVImg
         80hk8HV3lGphFIr0GdRp5JouZMkDuKtr+mpbO/WILHI5HHtJvRtWXylwLUOoX/JlYP
         IQdNZnooCdVVQ==
Date:   Tue, 21 Aug 2018 18:30:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        rf@opensource.cirrus.com, Linus <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the mfd tree with Linus' tree
Message-ID: <20180821183012.3b9bc4f3@canb.auug.org.au>
In-Reply-To: <CAMuHMdUQcoMxb=0_i1PYyymUpQ1VBOub+EgDbRJWmrq8_xJ-uQ@mail.gmail.com>
References: <20180817103913.52544928@canb.auug.org.au>
        <CAMuHMdUQcoMxb=0_i1PYyymUpQ1VBOub+EgDbRJWmrq8_xJ-uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o/rc/HqUFPGy6qX3Oe14Lpm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o/rc/HqUFPGy6qX3Oe14Lpm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, 21 Aug 2018 10:08:54 +0200 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
> To obey sorting rules, the CIRRUS LOGIC entry should be before the CLANG
> entry.
> Upon closer look, it should be inserted before the CISCO entries, too (in
> the mfd tree).

Thanks for noticing.  Unfortunately it is badly ordered in Linus' tree
now as well.  Feel like sending him a patch?

--=20
Cheers,
Stephen Rothwell

--Sig_/o/rc/HqUFPGy6qX3Oe14Lpm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt7zZQACgkQAVBC80lX
0GyJPAf+I6h00MmuBtxb47tUmnuVKLFuXkD7XfSse+Q4s7hxqynqPtJaNWgS1vXT
SIAqUFdLO2e2PjlMFlxaOci8wQUk5+oOaC5QqBkI1HdSRHNVqtzdMuKpXJqB+xfY
PL+f66ygrpLNJEdUKEvIfOfLf7ykFtAZT6gzunxGuHQJ63lAWJUsVzV6X5uR5P2h
jUvLy/LYCRcT4o6Em0LfR3n4HNeL57fWHyCqarq/TgZguOvePictRJvL87L0cBzd
QYwOLin3Gv9GwanIYwYMNezAMepgBUzvH2W+SM7G9PnPJ7b3IrFb24g6X0igT/+I
Ntm0+9OOAOGcIvHjuB7+x3KJ7Pp2dA==
=9pJG
-----END PGP SIGNATURE-----

--Sig_/o/rc/HqUFPGy6qX3Oe14Lpm--
