Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9724F20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9724F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLGBTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:19:50 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:47540 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeLGBTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:19:50 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 193CF72CC59;
        Fri,  7 Dec 2018 04:19:47 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 0F8B57CE6D8; Fri,  7 Dec 2018 04:19:47 +0300 (MSK)
Date:   Fri, 7 Dec 2018 04:19:47 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Breno Leitao <leitao@debian.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] powerpc/ptrace: replace ptrace_report_syscall() with
 a tracehook call
Message-ID: <20181207011946.GA18558@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20181203031823.GE11573@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 06:18:23AM +0300, Dmitry V. Levin wrote:
> From: Elvira Khabirova <lineprinter@altlinux.org>
>=20
> Arch code should use tracehook_*() helpers, as documented
> in include/linux/tracehook.h,
> ptrace_report_syscall() is not expected to be used outside that file.
>=20
> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> v4: rewritten to call tracehook_report_syscall_entry() once, compile-test=
ed
> v3: add a descriptive comment
> v2: explicitly ignore tracehook_report_syscall_entry() return code
>=20
>  arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 19 deletions(-)

Sorry, this patch does not work, please ignore it.
However, the bug blocks PTRACE_GET_SYSCALL_INFO, so please fix it.

I'm going to use
	if (tracehook_report_syscall_entry(regs))
		return -1;
	return -1;
in the series until you have a better fix.


--=20
ldv

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcCcqyAAoJEAVFT+BVnCUIv3YQANKh5JInm3LUcCg1Lr4QIFuF
tnxoWgCsIctGlXXKzCwFCjeG3M7z8pNZmEkTYYQv1qcj3QVIXl5QT3KHtPx5QL/b
wKlgAHXE2NOHetBRmnz6Stj4lBk2LBWHWIO6RxwXvICCTQGF8HBYFjBtXoZALC4x
jL6BtMtdoysNm57rOPhagujznHz4qtQ9Q/JsaFO/Y2h0JrnbJ7CE9xi9cOAJuuPM
mYx0mN2eIdxQEQRL2UJJUbm0JjVJudC79HosgJ+E9s8uz3L6pb9K4fVkceglqHNe
yb51RFDoCSh2ZoJkoCYyDlLfIAUJ8Yca7kxA6on8471AHnyfap69sYsgOPBV05PW
5T+6vFjlrt4DTh1wj+cHgVcV6tH8QnVlIZkeziorizSGueNsgz+aBxrs2kguK454
DHCOcG1RTc4F9tnl+zHeSrh030qxB/ErjQPhmKCKV6YvbQmKheaVd9GvGjMLvdil
TQx+2MVHg0CWIv9lhEOYGIpYJsMbhjaJ+Ig/Q8kcc2qeIPi2OAmpuNYxgLKJ0CUE
RorHrwwqkRRHlJfo01uoQ++pz54xBT6dNvOlqTWDBoQz8yfkyTS6NDwVh1K5foEe
YCIbE0l+tsxIfE/BiMd9J3YYNWbQa8F1gBUj91w6/8qLroFpzpTCsS6iw9MXZH53
iZgyI2xUitmYWWsLTZFs
=+OO3
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
