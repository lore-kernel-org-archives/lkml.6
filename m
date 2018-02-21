Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeBUM32 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:29:28 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:53647 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeBUM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:29:26 -0500
Date: Wed, 21 Feb 2018 12:27:19 +0000
From: James Hogan <james.hogan@mips.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: <linux-kernel@vger.kernel.org>, <linux-metag@vger.kernel.org>
Subject: Re: metag build errors in mainline kernel
Message-ID: <20180221122719.GI29460@jhogan-linux.mipstec.com>
References: <20180220234443.GA27059@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8/UBlNHSEJa6utmr"
Content-Disposition: inline
In-Reply-To: <20180220234443.GA27059@roeck-us.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1519216112-321459-20032-55512-5
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190260
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8/UBlNHSEJa6utmr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 03:44:43PM -0800, Guenter Roeck wrote:
> The following errors are seen when building the kernel with the latest
> available metag toolchain (4.2.4 (IMG-1.4.0.700)). Kernel version tested
> is (v4.16-rc2-64-gaf3e79d29555).
>=20
> metag:allmodconfig
>=20
> arch/metag/kernel/devtree.c:54: error: implicit declaration of function '=
pr_info'
>=20
> arch/metag/kernel/perf/perf_event.c:831: error: label =E2=80=98out=E2=80=
=99 used but not defined
> arch/metag/kernel/perf/perf_event.c:822: warning: unused variable =E2=80=
=98cpu=E2=80=99

Thanks, these are easy enough for me to fix up.

>=20
> metag:meta2_smp_defconfig
>=20
> kernel/time/hrtimer.c: In function 'hrtimer_run_softirq':
> time/hrtimer.c:1431: error: unable to find a register to spill in class '=
Yr_REGS'
> time/hrtimer.c:1431: error: this is the insn:
> (insn:HI 41 40 99 2 kernel/time/hrtimer.c:576 (set (mem/s/j:DI (plus:SI (=
reg/f:SI 15 D1.7 [orig:84 D.45290 ] [84])
>                 (const_int 368 [0x170])) [0 <variable>.offset+0 S8 A128])
> 	(reg:DI 99 [ <variable>.offset ])) 211 {*sto_di_1_1_off12} (nil)
>     (expr_list:REG_DEAD (reg:DI 99 [ <variable>.offset ])
> 	(nil)))
> kernel/time/hrtimer.c:1431: confused by earlier errors, bailing out

Hmm.. ancient shelved toolchain. Perhaps this is the excuse we need to
say goodbye to arch/metag/...

Cheers
James

--8/UBlNHSEJa6utmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqNZaEACgkQbAtpk944
dnol8BAAgtQ1cyWZxvAUbbeMIIyQr7C5wOt2LYgR9okcnwxhIMvd/JhsljUwFCPn
UI04DlydGvKdUCvpTtuCciRmA6YDRaNcQEFrt+5Gsd6PTylaUGqG/D1rig/luiil
fe7+MicRtQNvccECjx8cwNVdYXUca10vEeJyLl7NN45N6DtO6YXth7WzFXBHhjRg
cQ08/3WOrQ8HsNTPfScm9oPbbC/IB4497ZLIGfY3FA4U3PIx11/0Bdz9jS1reciH
91M/XkfOOQzio+2/mZVrB1GCPTdM3agLCsh1Pt42Owj69DhpemqMlYU2B42ZXl9+
HeXUWrHYOqnn+S754MQSY8QYw+f74Y2hC9jie+mefKH8JkZpgmGPmzStnCNSBW7U
V8q5bNBLfuN+V3vr2w5e5RTGTYjimG9QVYWVBHiqNMxYqIW+E44Dq95nSXsDZNF3
B31KRWme9ZUnuKFreC2scWeplEJNYGJBMbVGaM36AqO5IEG0f718e/BUVa5TS8mt
Yf4DNR1dlPqB+JnDdUCrTvyNisIy7GM/jcBdzL7+xXGpr9ItGZ1YE+LhRkarApp5
3NDos3mtbIoVLWrAluLGwNfVJyRSuPuQxrZyHwSxzmLZvTXPA2ffMheLJlxsHNJN
teOkJDUkMS1iEqBMztcExM2IjJpM8rewQvo2y0f1Wax51DjeEUM=
=Y/QI
-----END PGP SIGNATURE-----

--8/UBlNHSEJa6utmr--
