Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398EA21741
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeL1CXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:23:43 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:35866 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeL1CXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:23:42 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2701072CA65;
        Fri, 28 Dec 2018 05:23:39 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 1654A965691; Fri, 28 Dec 2018 05:23:39 +0300 (MSK)
Date:   Fri, 28 Dec 2018 05:23:39 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org,
        qemu-devel@nongnu.org, ericvh@gmail.com, rminnich@sandia.gov,
        lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de
Subject: Re: d_off field in struct dirent and 32-on-64 emulation
Message-ID: <20181228022338.GA27992@altlinux.org>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <87bm56vqg4.fsf@mid.deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 27, 2018 at 06:18:19PM +0100, Florian Weimer wrote:
> We have a bit of an interesting problem with respect to the d_off
> field in struct dirent.
>=20
> When running a 64-bit kernel on certain file systems, notably ext4,
> this field uses the full 63 bits even for small directories (strace -v
> output, wrapped here for readability):
>=20
> getdents(3, [
>   {d_ino=3D1494304, d_off=3D3901177228673045825, d_reclen=3D40, d_name=3D=
"authorized_keys", d_type=3DDT_REG},
>   {d_ino=3D1494277, d_off=3D7491915799041650922, d_reclen=3D24, d_name=3D=
".", d_type=3DDT_DIR},
>   {d_ino=3D1314655, d_off=3D9223372036854775807, d_reclen=3D24, d_name=3D=
"..", d_type=3DDT_DIR}
> ], 32768) =3D 88
>=20
> When running in 32-bit compat mode, this value is somehow truncated to
> 31 bits, for both the getdents and the getdents64 (!) system call (at
> least on i386).

Why getdents64 system call is affected by this truncation,
isn't it a kernel bug that has to be fixed in the kernel instead?


--=20
ldv

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcJYkqAAoJEAVFT+BVnCUIcosQANvtFPNcdpTeqDv4BvJh1mmD
tLkXHBOml79JQ42kYPcOV3iwQ4WJNkOdL9TzjrIGfEiwUVC8Kd6zJDt4SIeUGTlk
JvKVizkgH7vtPL3dFwfBb4GSiBdRTK3+NP0MwbHjbIgHI0o9kmghqyElbMWdvhlO
qUHuNcoAMI05qd0ZFJ31jHylo747iIQXmVha5CaK/4ntDYcx2/v+HFLzzgW7Ymm6
B14TgVRFDQGZtRjrAfp0cFFPiluXSfWwmLYUOnnqgGqxscj3uxkUIVdb4PSLEt3C
BEfkBq9I9et6UVUh1Yunu9pYArOoZzYgJZOeoLm3QTijMKWeDJ5mqF33swjHGNQD
71ef9YTrWaZ0HnYgbiGTQCMskOSTgSMc7iugHNMdlba56QK/urmwiCP1Bc/4uiMO
QrUziTdJc+pH7ZB4IG3n+3JK1LcSnlhv+i68BfvgJ5ZtN1v4xuLupe1K8JhLn0hT
rDUJWdH+VQKSUZe4tKy1ElsvKF4yGrmwaILHE6fGwtY33XGUSKxGsidyWHZSVOms
nk4P5w2hWrlQ0oCwqJ3d9uErV5Ih0UkxmRK9sNHmQXKw3cC3RjOSc33x8k6XAeAQ
DIw4pRx94ePNbkavwVgr67DxGo3CmTcdlbfvFMf7J58DodxLZRBJENqeZAF4GTtN
A091yYWKMqB/+28jrJD5
=C0vz
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
