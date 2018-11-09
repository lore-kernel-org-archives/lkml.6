Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8C6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C2C20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C2C20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKJH0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:26:51 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:48644 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeKJH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:26:51 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0E49B72CBF9;
        Sat, 10 Nov 2018 00:44:23 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 02CEF7CD1FF; Sat, 10 Nov 2018 00:44:22 +0300 (MSK)
Date:   Sat, 10 Nov 2018 00:44:22 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] elf-em.h: add EM_ARC
Message-ID: <20181109214422.GB1907@altlinux.org>
Mail-Followup-To: Vineet Gupta <vineet.gupta1@synopsys.com>,
        Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181109031536.GB21511@altlinux.org>
 <C2D7FE5348E1B147BCA15975FBA23075013A59237C@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075013A59237C@us01wembx1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2018 at 04:41:36PM +0000, Vineet Gupta wrote:
> On 11/8/18 7:15 PM, Dmitry V. Levin wrote:
> > The uapi/linux/audit.h header is going to use EM_ARC in order
> > to define AUDIT_ARCH_ARC which is needed to implement
> > syscall_get_arch() which in turn is required to extend
> > the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
> >
> > The value for EM_ARC has been taken from
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__www.sco.com_devel=
opers_gabi_2012-2D12-2D31_ch4.eheader.html&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXW=
qB0tg&r=3Dc14YS-cH-kdhTOW89KozFhBtBJgs1zXscZojEZQ0THs&m=3DUCr-dDO1BWV4K-CXh=
pcDRnN4Urr4_UgSKBeEaczUAmE&s=3DXmSWUKeqq324aU46NSTbHc12dH-1vVnA4G3Rm-01WD4&=
e=3D
> >
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  include/uapi/linux/elf-em.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> > index ba3696e3d694..56ff3f9d9633 100644
> > --- a/include/uapi/linux/elf-em.h
> > +++ b/include/uapi/linux/elf-em.h
> > @@ -26,6 +26,7 @@
> >  #define EM_ARM		40	/* ARM 32 bit */
> >  #define EM_SH		42	/* SuperH */
> >  #define EM_SPARCV9	43	/* SPARC v9 64-bit */
> > +#define EM_ARC		45	/* Argonaut RISC Core */
>=20
> Please use EM_ARCOMPACT (for original ARC ISA) and EM_ARCV2 - both define=
d in
> arch/arc/include/asm/elf.h

OK, but we would have to move both EM_ARCOMPACT and EM_ARCV2
to include/uapi/linux/elf-em.h file first, so they could be used
to define AUDIT_ARCH_* constants in include/uapi/linux/audit.h file.


--=20
ldv

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb5f+2AAoJEAVFT+BVnCUINs8QAK8S8CIiVI5h33SFSEr42QKV
HTACxj8d18EPr0iAXn/DQWqQH6e1hUhaJJpdrKVw2RyKNrw94sg59z9lmFH94hYp
6EdleM370/XxSStIV/gUGX8PtUl6b9Li0MckxkZVmJttpXhyyxp6dVQ7NEpjLrML
cChbO7krmDDWLL56RH11xNX0ULITidAMIWXQy+9s42O227tyxPK6i5f376RwP02d
2ZPBC8tRrb9DUzReRjRw3F6FnCeXuRCaYZTWDjLOfJy6ufkHg9mejbII3ikeF6yY
XYEWKxLLU5myk6LSm+ayu82Neak+y37rpnTneGvm2XSlV28/nvk+aMARpTNqjPhL
8tGZZcfj6yVyKibVZTGGMn5xsegxtkDSJgex2Gg+1r1j2k2WM3T5FbpF4L4ccvWN
yIiZZsOJgKJ3GR5rxQrlVjLZDm6AWLySETHhnimxDkDZRH67j/okH02AKAB7lZ6c
RCjuZ4IaxvQAsNtcHtcNgUS0Q/tFdRxFYJWl3XQg4A9anraQ82fn5S9gCgGLVuc7
jIKBZZWD2s+tIpNnBQSz294rdAukS5y14FzCEaBfgc9kSXxMQXiFhnP5fOQ3OOgt
u0OOwAStHlxhwb1VmzMOfeaxOa6lB6YNi42ycT5sV26gjHVGfMsM4IArfCF5/ZYW
Gm+7HRaq8bxSptAjU0BX
=v5LH
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
