Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC06AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26F3213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ks3AIEQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26F3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeK1PjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:39:06 -0500
Received: from ozlabs.org ([203.11.71.1]:59275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeK1PjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:39:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 434SbD1vs9z9s1c;
        Wed, 28 Nov 2018 15:38:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543379928;
        bh=vTtdpWWd2Ukvgfokrh2ifV2FNucxizPHQOIvGK5IJ6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ks3AIEQOUHqJ/eV8YvxZdwCq/CDrEqDq6eloXmptLqPkNCdBkgv4kEkfS8SDDWHor
         WAx+itxANF9UdOXYu1zKQ0fGlpVkBjS7W8SQf8yUxoMGAvAgWa/7sQsvPtOP0glqpJ
         62kvvhPE2GssZcWXXwsu1NAQ+EMVyIqamg04Z9U/N67RLI78DF8CcJ8jj3KS9IySd0
         NJH9i5vSrkCnWWf++u6zi3jzRjwmfebrP5ECAkFbfUnnpgbNRCQPJl5KFcU0azW1vV
         dnpBjHvz3DRD2jYgzOJoTVYD0xQq58gxDEUW4eM3ZUYPmJQWHHrtdSvEP2IooS7EqJ
         vVdvvQ08FuSmA==
Date:   Wed, 28 Nov 2018 15:38:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Tree for Nov 27 (scsi/aha1542)
Message-ID: <20181128153847.08ead1c9@canb.auug.org.au>
In-Reply-To: <ef9090cf-e86a-7fd0-dfa9-6810eaaf7e65@infradead.org>
References: <20181127152539.55426063@canb.auug.org.au>
        <ef9090cf-e86a-7fd0-dfa9-6810eaaf7e65@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UQWXzwPW6x4LyBoYK=gMBs/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UQWXzwPW6x4LyBoYK=gMBs/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 27 Nov 2018 20:14:58 -0800 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> On 11/26/18 8:25 PM, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20181126:
> >  =20
>=20
> on i386:
>=20
> ERROR: "__udivdi3" [drivers/scsi/aha1542.ko] undefined!
>=20
> somewhere in aha1542_interrupt() according to objdump.

Presumably caused by commit

  1794ef2b150d ("scsi: aha1542: convert to DMA mapping API")

--=20
Cheers,
Stephen Rothwell

--Sig_/UQWXzwPW6x4LyBoYK=gMBs/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv+G9cACgkQAVBC80lX
0GznJQgAhVR9Ayj/3/ionZLz8Fdbqjs0Hr2rG5KDRY9cHogF7ZusSUhjOGTMwzZD
0yc461rVUKyDosMl4sy9zuN0v87dAgTLMoIGRsiPaIQu/jsnqrrEKnALBsc5HDx/
RbsFqUd04+XWXQkXAUDNxOupxqSumb8e+EkAW/NZcXXVRqOA6cmrUo3Jgnd+IVNO
NOKUlQ5DJVKl2MKNOd6SUuh4cqPTUBl15gbhLR3wzXLok2D/HbQgUgJrPXC4h/Dp
WJxWfeK66+77ID9DUywQb5+hIgP5Hhg3JBxUAZpUHH0klEMKmO1gH2pN3xdfEA9P
8z6d+Xp6Gg9xlT5QzrxLq+tYRVRvAQ==
=2/vb
-----END PGP SIGNATURE-----

--Sig_/UQWXzwPW6x4LyBoYK=gMBs/--
