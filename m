Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A772C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1B8208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C8Cs7fbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1B8208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeHBBx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:53:27 -0400
Received: from ozlabs.org ([203.11.71.1]:59547 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeHBBx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:53:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gr5s5Rq1z9s4c;
        Thu,  2 Aug 2018 10:05:05 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533168305;
        bh=za7DJLXg1Z6zw/26vzaRx/lqunlad2YyAVP3wiPB9Hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C8Cs7fbOd0CWZ+oKrIM/Uu9Hk6Xmv+AHpLaE4JN6h0QCqjB8y6kW0wR8bueHXzqD5
         Dl+sSYopJ22Vl5Nsxb2VG6F1w25DKmcSpBKK0cAjxU8fhYw2D+g1bd3F8Eo8AWIHgH
         qIwoQYEyyvwgK9Cba2rNXVWDi3T0JdW8YJQhxHKKhhfKWHSwpsnVKk4YBWXrzJWDVo
         oaAXUWWNIzMlaDGhfCT3MK5qUsUYK9lP3/lga2fV6wJwBWWkrZa/geyTYVWaLkJVrA
         yA3KjKAW8zpdCrUN/w2Qim8XFMqmJeXJZbUjbACTZlsz9xTUZ5DaBNaT0zsmQ+m03E
         hLcDSB5ZVpGbw==
Date:   Thu, 2 Aug 2018 10:05:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 1
Message-ID: <20180802100505.56e663cb@canb.auug.org.au>
In-Reply-To: <1533164454.3158.3.camel@HansenPartnership.com>
References: <20180801175852.36549130@canb.auug.org.au>
        <20180801224813.GA13074@roeck-us.net>
        <1533163965.3158.1.camel@HansenPartnership.com>
        <1533164454.3158.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.Gc82QXuAsDKDAkLmVLH09."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.Gc82QXuAsDKDAkLmVLH09.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 01 Aug 2018 16:00:54 -0700 James Bottomley <James.Bottomley@HansenP=
artnership.com> wrote:
>
> So what seems to be happening to cause this is that there's a patch
> somewhere between the merge base of my scsi-next series and the next
> tree and the patch just before scsi-next was actually merged that
> actually causes a boot failure with blk-mq enabled.  Could you try to
> find this patch?  I think the way to do it is to try to bisect this
> range of linux-next using the command line
>=20
> scsi_mod.use_blk_mq=3D1
>=20
> Which forces block mq to be the default and seeing where the first boot
> failure is (you don't need my scsi-next tree merged to do this because
> all the offending patch does is flip the default state of the above
> flag).

So this means using v4.8-rc1 as the first good commit and 453f1d821165
("Merge remote-tracking branch 'cgroup/for-next'") as the first bad
(assuming that this latter fails to boot with "scsi_mod.use_blk_mq=3D1").

--=20
Cheers,
Stephen Rothwell

--Sig_/.Gc82QXuAsDKDAkLmVLH09.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiSrEACgkQAVBC80lX
0GxqyAf9GEnk3PtbKGKuCpu3gU6yYxkBLE3UQNOQ2NEa+W1HXoNRNU6zFlv6kc/A
3iUTIpRY4YexnVw31f/qSVx/hbBjeslZ53zwAUL5bObMGMSxz5Ot+tvjH0It5Rwv
HbJ0MhG4Zs5mybjTBFUupfqyx0V3ttS96UpcfXda6kV0AMFUhB1WAJchMwPpMVcb
rbi++FUOSlrckC/pgND5IYXcXebBYZB/WDwaQA8Tt+ZfLLbEuMA0LEH55LIUU4KM
ivzSwf6czB8dotUJQ1mfoPX1AijHWA6XrR+g871fjzvG4MJ3xNllqo8qzRDvFHmS
Pd9ST22I2bmuMJIKZvbK2MvE/XUQaQ==
=UEl/
-----END PGP SIGNATURE-----

--Sig_/.Gc82QXuAsDKDAkLmVLH09.--
