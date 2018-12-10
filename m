Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21703C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E9220821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E9220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeLJQVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:21:36 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:36222 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:21:35 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5FBDC72CC66;
        Mon, 10 Dec 2018 19:21:32 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 50DDE7CF2BB; Mon, 10 Dec 2018 19:21:32 +0300 (MSK)
Date:   Mon, 10 Dec 2018 19:21:32 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        strace-devel@lists.strace.io, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181210162131.GG14149@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043126.GX6131@altlinux.org>
 <20181210141107.GB4177@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20181210141107.GB4177@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 03:11:07PM +0100, Oleg Nesterov wrote:
> On 12/10, Dmitry V. Levin wrote:
> >
> > +struct ptrace_syscall_info {
> > +	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> > +	__u8 __pad0[3];
> > +	__u32 arch;
> > +	__u64 instruction_pointer;
> > +	__u64 stack_pointer;
> > +	__u64 frame_pointer;
> > +	union {
> > +		struct {
> > +			__u64 nr;
> > +			__u64 args[6];
> > +		} entry;
> > +		struct {
> > +			__s64 rval;
> > +			__u8 is_error;
> > +			__u8 __pad1[7];
> > +		} exit;
> > +		struct {
> > +			__u64 nr;
> > +			__u64 args[6];
> > +			__u32 ret_data;
> > +			__u8 __pad2[4];
> > +		} seccomp;
> > +	};
> > +};
>=20
> Could you explain why ptrace_syscall_info needs __pad{0,1,2} ? I simply c=
an't
> understand why...

I suppose the idea behind the use of these pads was to make the structure
arch-independent.

I don't think we really need to keep it exactly the same on all
architectures - the only practical requirement is to avoid any compat
issues, but I don't mind keeping the structure arch-independent.


--=20
ldv

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcDpKLAAoJEAVFT+BVnCUIQyQQAJcBexpZkT3KJAUbsDkRfHtd
gkDtUKrgIj6BpEzYUbIn6I8dXNIqyFMJGSh4lMWnhFbDXeHIQ91fNUoH5q/MifC7
PfbzH6ibiOTzflv/1/oTKLJ1RhzITuIlQQb6Xd/3BV+WEhPDs77tNJtPpgIlv+oK
z3Xa/mw3f0RXSAYpuvtCG1IiwWJMoy5YjpLBAWnldCxVH/jeiPU5xoSYl1DKo6Y+
YeNiM/mCEbaYzDWmAPiE5Mntarj3uT2g4XTLnuIFJo38z8jYp3QZwToMcYBFK0zx
i6NbYJ6oaiuUSCZMSM3X8NP2EsmmhVRi+3wc8WnzjqYbLqXa4f47aHunO/S17Bog
/8N5RexkAUM86J3Ho+SMZT3cDFi398vxb2f5gFN6DIPt4GLQYZaefJTc2hWvI7x4
xIm7+27/kSIURbcyVs7g/BtxjApz7kcY5ed3Uh5p2Z9HIxW4/TYiyRhh4P8oRddA
WEWTJaohjwF/QO3VJg7RbzTn2OsCTAX8KfzsEKTxsIIsNWeG+wHm1SSUsmvq+1ep
bDWVq09gvMogfl+U1qdpPhMlyXf5oTAZ9C64ZsUQZGtq0P8PG5M0a3VlT3fhktNV
yCGY93i50BA/fN8aBdMo+oyj8UIP1tZpuY0Lm6QjcNw8lPdBipEDCEi0+cPFwAmc
djVNelGXhg9dLjWz5UgP
=2aij
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
