Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A51EC04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4E420865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4E420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeKYPAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 10:00:13 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:40178 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeKYPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 10:00:13 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 817B872CC61;
        Sun, 25 Nov 2018 07:10:03 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 719397CD0D5; Sun, 25 Nov 2018 07:10:03 +0300 (MSK)
Date:   Sun, 25 Nov 2018 07:10:03 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        strace-devel@lists.strace.io
Subject: Re: [RFC PATCH v2] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181125041003.GA3258@altlinux.org>
References: <20181121165806.07da7c98@akathisia>
 <CALCETrV3TPCkYyhoLLcikXVeF-RdZUuLTCvKReK3Qb9LSS9Csw@mail.gmail.com>
 <20181121235634.GA14146@altlinux.org>
 <CALCETrXea_uRAqw_srW5CWgOzeM=RubaDbjnxZ=cUMy5Zv1TsA@mail.gmail.com>
 <20181122191504.GB27204@altlinux.org>
 <CALCETrXvXzRzoEqwEY_VZ7Vpt-sLwaF+rZPg+y_eG2xyzubXtw@mail.gmail.com>
 <20181123040139.GB2572@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20181123040139.GB2572@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 07:01:39AM +0300, Dmitry V. Levin wrote:
> On Thu, Nov 22, 2018 at 04:19:10PM -0800, Andy Lutomirski wrote:
> > On Thu, Nov 22, 2018 at 11:15 AM Dmitry V. Levin wrote:
> > > On Thu, Nov 22, 2018 at 06:55:29AM -0800, Andy Lutomirski wrote:
> > > > On Wed, Nov 21, 2018 at 3:56 PM Dmitry V. Levin wrote:
> > > > > On Wed, Nov 21, 2018 at 02:56:57PM -0800, Andy Lutomirski wrote:
> > > > > > Please cc linux-api@vger.kernel.org for future versions.
> > > > > >
> > > > > > On Wed, Nov 21, 2018 at 7:58 AM Elvira Khabirova wrote:
> > > > > > >
> > > > > > > struct ptrace_syscall_info {
> > > > > > >         __u8 op; /* 0 for entry, 1 for exit */
> > > > > >
> > > > > > Can you add proper defines, like:
> > > > > >
> > > > > > #define PTRACE_SYSCALL_ENTRY 0
> > > > > > #define PTRACE_SYSCALL_EXIT 1
> > > > > > #define PTRACE_SYSCALL_SECCOMP 2
> > > > > >
> > > > > > and make seccomp work from the start?  I'd rather we don't merg=
e an
> > > > > > implementation that doesn't work for seccomp and then have to r=
ework
> > > > > > it later.
> > > > >
> > > > > What's the difference between PTRACE_EVENT_SECCOMP and syscall-en=
try-stop
> > > > > with regards to PTRACE_GET_SYSCALL_INFO request?  At least they h=
ave the
> > > > > same entry_info to return.
> > > >
> > > > I'm not sure there's any material difference.
> > >
> > > In that case we don't really need PTRACE_SYSCALL_SECCOMP: op field
> > > describes the structure inside the union to use, not the ptrace stop.
> >=20
> > Unless we think the structures might diverge in the future.
>=20
> If these structures ever diverge, then a seccomp structure will be added
> to the union, and a portable userspace code will likely look this way:
>=20
> #include <linux/ptrace.h>
> ...
> struct ptrace_syscall_info info;
> long rc =3D ptrace(PTRACE_GET_SYSCALL_INFO, pid, (void *) sizeof(info), &=
info);
> ...
> switch (info.op) {
> 	case PTRACE_SYSCALL_INFO_ENTRY:
> 		/* handle info.entry */
> 	case PTRACE_SYSCALL_INFO_EXIT:
> 		/* handle info.exit */
> #ifdef PTRACE_SYSCALL_INFO_SECCOMP
> 	case PTRACE_SYSCALL_INFO_SECCOMP:
> 		/* handle info.seccomp */
> #endif
> 	default:
> 		/* handle unknown info.op */
> }
>=20
> In other words, it would be better if PTRACE_SYSCALL_INFO_* selector
> constants were introduced along with corresponding structures in the
> union.

However, the approach I suggested doesn't provide forward compatibility:
if userspace is compiled with kernel headers that don't define
PTRACE_SYSCALL_INFO_SECCOMP, it will break when the kernel
starts to use PTRACE_SYSCALL_INFO_SECCOMP instead of
PTRACE_SYSCALL_INFO_ENTRY for PTRACE_EVENT_SECCOMP support
in PTRACE_GET_SYSCALL_INFO.

The solution is to introduce PTRACE_SYSCALL_INFO_SECCOMP and struct
ptrace_syscall_info.seccomp along with PTRACE_EVENT_SECCOMP support
in PTRACE_GET_SYSCALL_INFO.  The initial revision of the seccomp
structure could be made the same as the entry structure, or it can
diverge from the beginning, e.g., by adding ret_data field containing
SECCOMP_RET_DATA return value stored in ptrace_message, this would save
ptracers an extra PTRACE_GETEVENTMSG call currently required to obtain it.


--=20
ldv

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb+iCbAAoJEAVFT+BVnCUIS3MQAKeeh/Bd9DjwDYgYnBn54D86
QBdDnegpvIpajluY994tUaCT3vgNamR+SmwRmi8ED7IXsLD6oImZR6ctmN42HSaM
t7SJc82r6p0yQJ7H/7c78jmlMIQFSGmnCM4H69AUkxYdoDQ3ehSRXPN2w0g5+y1u
r6F2XAUGgNi9jnwJmz57kkD4qVw32rVfNSWhCl7XxT5aJznozUJk8JRDVk2dbmMw
vg/WHD47HFcBKkkEPUH9edzFqzHdZcbwqIYQBaAbJpbkxexGIEVF5o26g/kC1Mts
UL4mmy0LfAsf8GGjomuLsRsGKEEs58oiRdmKWqGmeKi0l0EPCBo+1e1Rb9UbDs9p
Mepp7tvbh3T/BjS7rBmNgEK7mXUEV4prJq6Os6TJs4mTptaisYRZX+MNYNEahLRg
+c/RGFO5gnsulYoWv+HrTkGjv44MoiespBAwkHIPh873inpcGM4SnMO8nZW0PsDE
mL7Wei96TDkv1db8Q8dAIz3fb+c9S4uEli+Q2vtGIAc/2bjK1+VL7ZXra0uJCAdT
Xz3aiQPVZ5Ie65f2rVoLTwr/QlujImY6k64vfRxQrwM9BQei7859QStHr7PtAi8V
4Gt23TfCWgxg9Lw/Zk8TRY3g9UUc2TsuWQQJ2CikQFkh+sKVpKb2hbe7t12+nWOJ
fV3T2OM5XZn6FHDXmA8i
=y+u9
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
