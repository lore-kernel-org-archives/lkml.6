Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED8CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DB02133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeLQLXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:23:54 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:57974 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeLQLXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:23:54 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0089E72CA5E;
        Mon, 17 Dec 2018 14:23:51 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E4340964720; Mon, 17 Dec 2018 14:23:50 +0300 (MSK)
Date:   Mon, 17 Dec 2018 14:23:50 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ptrace: cleanup do_syscall_trace_enter
Message-ID: <20181217112350.GB5778@altlinux.org>
References: <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207155605.GB28964@altlinux.org>
 <20181207185226.GB31278@altlinux.org>
 <20181210132806.GA4177@redhat.com>
 <20181210133655.GH11942@altlinux.org>
 <20181216172828.GA25359@altlinux.org>
 <87y38otn5x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <87y38otn5x.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 17, 2018 at 10:20:26PM +1100, Michael Ellerman wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> writes:
> > Invoke tracehook_report_syscall_entry once.
>=20
> Thanks.
>=20
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++---------------
> >  1 file changed, 31 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> > index 714c3480c52d..8794d32c2d9e 100644
> > --- a/arch/powerpc/kernel/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace.c
> > @@ -3263,32 +3263,40 @@ static inline int do_seccomp(struct pt_regs *re=
gs) { return 0; }
> >   */
> >  long do_syscall_trace_enter(struct pt_regs *regs)
> >  {
> > +	u32 cached_flags;
> > +
>=20
> Do you mind if I just call it "flags", I find "cached_flags" a bit
> unwieldy for some reason.
>=20
> I'm happy to fix it up when applying.

No problem, feel free to call it whatever you like.  Thanks,


--=20
ldv

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcF4dGAAoJEAVFT+BVnCUIqN0P/ROF4ZwS3xzAexyXGTVWOSqK
j/l3IVN+IZCQFAXjHBHn8b2p/6/WlQiImJFykJIv1SwkrbXZ66k387FdcbGywlix
T6vK3lq1r4jPqC3QhrBWQvYkpeX5hkmG698r4Z6WoMW9G12Z407ScGpSAlLEDNsR
PspeHVKs0keASgix/Xt7S0MHhryLgDhQjnKFzbJkLzSc8RtThNVtZY2JI/rzVYGQ
apa5KQ+rnhILwyG2yLA0qo4JJynexUeXHuUmXLyTyvlEEMTPloAO4WcFJxITWI++
ofwWoyJQZPDOpfIwo8JXO/mhs/Nds0X1Hnmo+eHOx4D0K91UGhlzfTbZ6IaoMKK0
mtLQPcyjflircLerqZ+HxslzovnVSIc3vLSTaHpqf75qLiEswwz1WucYhjWqvLMc
0ZkXBrsv4R6lVwLDtN0iRBMtUMpR7IbZpyz4qJV8+5vj2rJkOx6ayuk7HfjWN/Ir
UCvR/0lg3oZRPPZjMWf0pi1bjVeM2ivVdz2oCv79nYJ5AhVo46j5HZReFWAT8jrP
ZkqzbZE+cL++oHM/PbWBxDcbaM3Ai6bfm7kI7ti3f7abTC4pqgQIG8xsoZkcv0uc
1B81/fWYG6jtsr0G2mc9sS3EBOBLsLaipgD8BX5YwGAw+y6MMS9o3bLepPFOp+S+
NSfp2wySjVujD8Ti0h0u
=bfGc
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
