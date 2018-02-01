Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeBASqG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:46:06 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35389 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeBASqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:46:01 -0500
X-Google-Smtp-Source: AH8x227f4d9+uxN3nUPeNM0YQk3N4XQnwBSNYAUQM2E/iOgcfTz/Be0qjczaOSfhICkw0X6gBelnRg==
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <95FB622E-4E2B-4EFC-998F-4A3522BA27BD@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_60404382-764F-4132-8ED9-DE5809D17D4A";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] x86: Align TLB invalidation info
Date: Thu, 1 Feb 2018 10:45:55 -0800
In-Reply-To: <20180201093847.GZ2269@hirez.programming.kicks-ass.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
References: <20180131201118.1694-1-namit@vmware.com>
 <8bb352bc-4e1f-4e87-80e3-a8e65d618d2a@linux.intel.com>
 <0E65629C-0D7D-4602-A43D-B18E62F330A6@gmail.com>
 <f7270e0d-d1d1-599d-d2c9-ddc2c263e090@linux.intel.com>
 <DBF48795-2F4B-4C65-A5DD-A78D2214DF9B@gmail.com>
 <20180201093847.GZ2269@hirez.programming.kicks-ass.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_60404382-764F-4132-8ED9-DE5809D17D4A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jan 31, 2018 at 09:38:46PM -0800, Nadav Amit wrote:
>=20
>> I used ftrace to measure the execution time of =
flush_tlb_func_remote() on a
>> 2-socket Haswell machine, using a microbenchmark I wrote for some =
research
>> project.
>=20
> However cool ftrace is, it is _really_ bad for such uses. The cost of
> using ftrace is many many time higher than any change you could affect
> by this.
>=20
> A microbench and/or perf is what you should use for this.

Don=E2=80=99t expect to see a remote NUMA access impact, whose cost are =
few 10s of
nanoseconds on microbenchmarks. (And indeed I did not.) Each iteration =
of
#PF - MADV_DONTNEED takes several microseconds, and the impact is lost =
in
the noise.

You are right in the fact that ftrace introduces overheads, but the =
variance
is relatively low. If I stretch the struct to 3 lines of cache, I see a =
20ns
overhead. Anyhow, I think this line of code got more than its fair share =
of
attention.



--Apple-Mail=_60404382-764F-4132-8ED9-DE5809D17D4A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE0YCJM4pMIpzxUdmOK4dOkxJsY0AFAlpzYGMACgkQK4dOkxJs
Y0AjLg//UxeP4uEjeGONOHuutXmuNK8dtDwZ+h79vjBw5wha9Bq0GmPobCOziq8x
ezK3PSO9L/VYqyZNJJvpm6NWTEpf9P73003R7w0Vul0h5cUz9kjPPNl5TOZrvA4T
phQ6eCeNJ2c/zMqEqTKAXo76XQlBhb2Z6qY6xW8I9Fu1k3pCBRnLMwevlE4xlCjw
ARNubo0AW3o5vyXu7r00eK5C5dqDAgGiLdnZSK2TOPdPSAcHlNYsewNUET2MDzQT
43/sa43ezPJv0T60vddHS340cMR/CZUbDf5K2wuWVnEV/qk8LBPHPmZ2s7S2/49z
JKfqa6nbfen5xCV+pBinW4JvK8DKHr87WEc5LENEz1NlrkJzdDmbtKr3kIrWYiWd
zPf0mxCuSiyZYHTOjStRL26wpjdyNnNRp5SLGvZwQd5cB2CX+oV6qNr73Mm1FC2P
omS1k55HZJDCMoPEA3xVZ7AVZtaHQC9T4tc99rnTiOtCNH8jFl7bLvaCMEZTUjru
fBGoxgaPrL04n6cFafs9VmToYuoTBjq7lFW44EAnmowHgnl8hAuLi5LBYObuef+i
9nSTDCy6iZiLdTE4mC4l9TszN6MOASX/1OGINMPrV5VS5AJx1HzVzXcSlEUcDMUq
mbDhfXdXmAA2OS9C6g0CNnzQX1hAkwPofOlG7bNHQ9iy3vua86s=
=BRsW
-----END PGP SIGNATURE-----

--Apple-Mail=_60404382-764F-4132-8ED9-DE5809D17D4A--
