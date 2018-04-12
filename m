Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbeDLV7C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752981AbeDLV7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:59:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF5221737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 12 Apr 2018 22:58:55 +0100
From: James Hogan <jhogan@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
Message-ID: <20180412215855.GB27802@saruman>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20180412215149.GA27802@saruman>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 10:51:49PM +0100, James Hogan wrote:
> On Tue, Apr 03, 2018 at 08:55:04AM -0400, Sinan Kaya wrote:
> > While a barrier is present in writeX() function before the register wri=
te,
> > a similar barrier is missing in the readX() function after the register
> > read. This could allow memory accesses following readX() to observe
> > stale data.
> >=20
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Both patches look like obvious improvements to me, so I'm happy to apply
> to my fixes branch.

Though having said that, a comment to go with the rmb() (as suggested by
checkpatch) to detail the situation we're concerned about would be nice
to have.

Cheers
James

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrP1p8ACgkQbAtpk944
dnpJyxAAstKXPj/zy7GXQYwhwrZE/0uBT5rfc6zSDKgjqCN4L9GzQ5vsKpg5BZd4
autxPPEiuq+GeAfalW5rIlHOZikjLwrmiV0m5i4YE+PRxlc5uMjzCQKgb41FMFkd
BKuX+bT0bxUZ8Om5JrLzYGouIp2hocYiqXideYavBU+4Lm3398knuEWURT3gMvpD
r1sCgr7xJFAJL0dqkV9ePwM3WV6xyvTSZ8oFZ3r7Hqtg5rLwpmOGxxZmjGEeGT82
5jy6zbIJr2J7KelJdmgUkDZ+c+xhoQ10Cop737YXBDeLOO8y6isbigT5JXJrE3Xw
2TVpfA/S/e5l+nhyoTvWxCsoo1FsAaX+gPigBBq36MYlVlV7MfgnCjmkC+NzpvKi
xjgP5fH6GWP+S3rYY/sULJY2afnhqqk3Nu8soI4ilNpp5GccHZYu3ZLWTYG0x3Ag
B34iQMJphD1MDQqny54Zrz1uVaEkBfHClNXkhGO9d7SotAsXFO930jnvqEVbSLU+
picWBzRyh+wTvqe+N4Rvg94dEsZP0Oh0k0xhNZSN6cALDy4dh6bdbzlYG0Ff0Hl5
JsJj6TQiUlAf473/RrpeFy/2po0DUT69txdhv3vLJYmO5ZGXVuf2qHnFh4SafffB
1O+QpxB7kj1iEmQeLn8154GbRBurKTAIVWT2H0JETzBFSMDls1Y=
=HuHl
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
