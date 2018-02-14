Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935280AbeBNUjm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:39:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:59660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934991AbeBNUjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:39:41 -0500
Date: Thu, 15 Feb 2018 07:39:33 +1100
From: Aleksa Sarai <asarai@suse.de>
To: Enrico Weigelt <lkml@metux.net>
Cc: Richard Weinberger <richard@sigma-star.at>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: plan9 semantics on Linux - mount namespaces
Message-ID: <20180214203933.55yraxue7hpup65x@gordon>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <2050418.Dl5pXkWGsk@blindfold>
 <4f620eb7-c00c-487b-2e06-8cc4c97af38c@metux.net>
 <60748622.exvCVAzLTp@blindfold>
 <e924b563-44c6-d678-a6cc-1181f4b820d5@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45q67fkve2bvqniy"
Content-Disposition: inline
In-Reply-To: <e924b563-44c6-d678-a6cc-1181f4b820d5@metux.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45q67fkve2bvqniy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-02-14, Enrico Weigelt <lkml@metux.net> wrote:
> But still I wonder whether user_ns really solves my problem, as I don't
> want to create sandboxed users, but only private namespaces just like
> on Plan9.

On Linux you need to have CAP_SYS_ADMIN (in the user_ns that owns your
current mnt_ns) in order to mount anything, and to create any namespaces
(in your current user_ns). So, in order to use the functionality of
mnt_ns (the ability to create mounts only a subset of processes can
see) as an unprivileged user, you need to use user_ns.

(Note there is an additional restriction, namely that a mnt_ns that was
set up in the non-root user_ns cannot mount any filesystems that do not
have the FS_USERNS_MOUNT option set. This is also for security, as
exposing the kernel filesystem parser to arbitrary data by unprivileged
users wasn't deemed to be a safe thing to do. The unprivileged FUSE work
that Richard linked to will likely be useful for pushing FS_USERNS_MOUNT
into more filesystems -- like 9p.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--45q67fkve2bvqniy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlqEnoIACgkQnhiqJn3b
jbRwxQ/7BE3wVUP9GsXPbxtByKmh4mlHGR1IkTlzxGs09+IVxiOF8mmfaGviElD5
i6vWhYhv9JFzTvONadYoGFy/BhYiDW5QxYN9HUduHOA4aMpW7nrnq3HVbZQSumU1
7tt1ULEXzm+LSJdFFk5o3VaK+twkmFYaa9F8C/pH1Ywy6k4Cq16eP9aj08Qt1ADW
1ORXyVKPrr5j9o39EAZNu/qu6Xzv5WVa8LvAxshAUQDrhIxmQqqyYZ9nSAc9ecQt
0MouBo8I3HzK3YQDTeQwKGTWIPFtLsnoL+p69CtiKuhSVTTjcN20xGDgohpCYQud
7mMZt4GrHgSE0JV8gwgLhMKeHPmD7I0QTIoODJbXh5xL/Q1gt5cjZ4fOMk20DsO1
mBSNlrYyH8WlLITwNpxi6XecNDb6CBwh3rOnMoC5ELl2v9zsSsPll//ENTJIqz5P
U1dvn9hahHvSnDsz8A6cjtvPBYHB8gofaHKUxhFMrqn1vakP8uQEkvCLx/knnR4K
JlmTlUxgx+JDm1lmx9ai+JHXjzjyI6f6LtKlvWOqPeIvCD5rWRbTZvkOOn7s8mLV
sEdeOFkLrKNIGfvOaipY2SEMgsfzbc3yGXBrWbaydjDAMeFwiqWycdQlQ7NyRhX5
TxU7WphcjR+4QBAhFL6xuAkjsXe1dkBHTeNAkUSQ7Vli+iuMo+Y=
=j1bi
-----END PGP SIGNATURE-----

--45q67fkve2bvqniy--
