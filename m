Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeA3TzE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:55:04 -0500
Received: from home.keithp.com ([63.227.221.253]:53188 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbeA3TzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:55:03 -0500
From: "Keith Packard" <keithp@keithp.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Check for lessee in DROP_MASTER ioctl
In-Reply-To: <20180130093447.GG25930@phenom.ffwll.local>
References: <20180119015159.1606-1-keithp@keithp.com> <20180130093447.GG25930@phenom.ffwll.local>
Date: Tue, 30 Jan 2018 11:55:01 -0800
Message-ID: <87k1vz3ywa.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Daniel Vetter <daniel@ffwll.ch> writes:

> On Thu, Jan 18, 2018 at 05:51:59PM -0800, Keith Packard wrote:
>> Don't let a lessee control what the current DRM master is set to;
>> that's the job of the "real" master. Otherwise, the lessee would
>> disable all access to master operations for the owner and all lessees
>> under it.
>>=20
>> This matches the same check made in the SET_MASTER ioctl.
>>=20
>> Signed-off-by: Keith Packard <keithp@keithp.com>
>
> Similar check for setmaster already exists, so looks all good. Do we have
> an igt for all this? Iirc there was one floating around, but no idea
> what's the status. Might also be good to resubmit them so i915 CI can run
> the tests (now that the code has landed).

I've got IGT tests for leasing which have been posted to dri-devel but I
don't think they've been reviewed. Looks like they could use some more
test cases; I didn't catch this one until I was playing with my 'xlease'
hack, which runs the X server on a leased FD.

> On the patch itself, minus lack of testcases:
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks!

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAlpwzZUACgkQ2yIaaQAA
ABH8Ug/6A3v914XXXE9EsN6Xn/vBO+/7nw/VFn+Z4gbwgsU5Sadx9KENFncF2GFY
ypYlQwPdRIt/VNwjM0Zpekn+Q6TzP6oFF1yoVEi74FD3Ds+sf5nSTncmBeC5tGWl
eLCPFRF5llZoxClecfItvmVSI7c07Lnk0WK0ofzl5kQH3ZnGfiN3eoiBkxdXcPs/
6cAfH/2UyqrPtuDAKkv5R+ZOJ9ldXU5KytmTGAHED+76iwoukk1YAvFAVu+Wsruy
BGI0YIv3CwUrLLsFL6Cfly7QSpJDWEGp/2V8QNHXzCtxnsw4qCrBQcQ7K2dH5CDT
uv32r0ipW3oyUJWOcgQPQmY8YiAT4tUmj9DMvAS/BH69m/wUIYnMuJW5bxP5inQV
C/JnF5qhljyUDrPMT4RBE77ietKzvgZXG/7gIdLfZpzRvpzZeUZjW5CL8QfMRQ03
O0vx++UPcYz0Ij1VG20wNsLWu83SBO1/5OEboeKVL14Gk6ex7UT+yCE103ulOX0V
i6T4fGduWUgzOqgBTCp3BthvOEX2krgN5IfVnwus7NHSRFXv4XmE1aMHFUNINXL/
japqiFC13ywl3sD7OPMuU1fYYm+b046NzncDmnY+K0KfmnqA7/mJ/4vH8QxcekMF
+uVtta97uhJuBDk1dZ64POlk92iF81AFX1KOor/Yorr9WFSFjyE=
=07F+
-----END PGP SIGNATURE-----
--=-=-=--
