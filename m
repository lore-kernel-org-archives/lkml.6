Return-Path: <kernel-hardening-return-13067-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqSv3qMNMRcImuPnF099XULCYFZU69IwcZSUHu8mtKJc3ceal1u7CVLSCgz552brXIMXRjf
ARC-Seal: i=1; a=rsa-sha256; t=1524206662; cv=none;
        d=google.com; s=arc-20160816;
        b=ooyT5UQkrmKHU0xbwgBn7vnhZls7dCxinrCPSDP6Hj2ItXZcONYnASWdKiDPof2MlQ
         2sZJVlIlUQsGGN5HS3WYJMsQLYsGX1OuDmirdZSIFeZV0p5luua7XporHaIsMqHnaT2Y
         Vv7T2FDjJqJBEpx2NFIyEZFs9Fz7yWUzZtG8rIWNGLyrtYo68jLe9fmlaYsS91ymwATE
         pLFgede48s+bccsXHi8J/sxydzPPuWvluPD2IdwkI6gUNAbSbIXGjV0wGWTGyshjgxnd
         bTpvPv6tHlV5ZrPEC7U5RsrW5AcINEIebkfOyZRWbkRTScl43rin+ZTxT2AGDfvqTwMW
         M5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=5ZttJ2E9ClVE+y2GgK4QpI89z61fl5SfdNf8pBWYqfM=;
        b=Gq6A//zWPCQpsg3WteBwmGJYz4Fyv6IQZjN4UCGJGOszsItRnzQeW65pbXUqhARCiL
         +tMqRucO8gCMMePHo5B8zyf6YIrY0vFNuWDn0x/z9ceQRfFMYZiWaVGbAQaCXLtb2RWA
         4aOxXZcBjNGIf0cd015j4W/vCgi3dgplUjXCisVrKWja1v8bM7MRsL3Dclx5dqGo4l05
         CVxz8AJi/Uxu0Qg5vl4/J3S+9QRtPRjMM1y5azTahVry3cKVMPKk66WzPDk0rhQ9c7UO
         YDhGDpx8qztJ7ePBDHe4ETHjUJUBUJCMBPCzaRyh8hogD8zP4bquRWgz2VHX7CtjhrGU
         sfag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13067-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13067-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13067-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13067-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: NeilBrown <neilb@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, Mike Snitzer <snitzer@redhat.com>
Date: Fri, 20 Apr 2018 08:16:10 +1000
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Segher Boessenkool <segher@kernel.crashing.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Andrew Morton <akpm@linuxfoundation.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Alasdair Kergon <agk@redhat.com>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [patch V2 7/8] dm verity fec: Check result of init_rs()
In-Reply-To: <alpine.DEB.2.21.1804191551520.19539@nanos.tec.linutronix.de>
References: <20180419100441.548834519@linutronix.de> <20180419100935.340306831@linutronix.de> <20180419134647.GA9817@redhat.com> <alpine.DEB.2.21.1804191551520.19539@nanos.tec.linutronix.de>
Message-ID: <87o9ieq1ud.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168985985100525?=
X-GMAIL-MSGID: =?utf-8?q?1598246525112820916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19 2018, Thomas Gleixner wrote:

> On Thu, 19 Apr 2018, Mike Snitzer wrote:
>
>> On Thu, Apr 19 2018 at  6:04am -0400,
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>=20
>> > From: Thomas Gleixner <tglx@linutronix.de>
>> >=20
>> > The allocation of the reed solomon control structure can fail, but
>> > fec_alloc_bufs() ignores that and subsequent operations in dm verity u=
se
>> > the potential NULL pointer unconditionally.
>> >=20
>> > Add a proper check and abort if init_rs() fails.
>>=20
>> This changelog makes little sense: init_rs() isn't in play relative to
>> this patch.
>
> 	fio->rs =3D mempool_alloc(v->fec->rs_pool, GFP_NOIO);
>
>         f->rs_pool =3D mempool_create(num_online_cpus(), fec_rs_alloc,
>                                     fec_rs_free, (void *) v);
>
> static void *fec_rs_alloc(gfp_t gfp_mask, void *pool_data)
> {
> 	struct dm_verity *v =3D (struct dm_verity *)pool_data;
>
>         return init_rs(8, 0x11d, 0, 1, v->fec->roots);
> }
>
> So init_rs() is part of the chain, right?
>
> Yes. I missed the NOIO part. But....
>
>> And it runs counter to this commit's changelog:
>>=20
>> commit 34c96507e8f6be497c15497be05f489fb34c5880
>> Author: NeilBrown <neilb@suse.com>
>> Date:   Mon Apr 10 12:13:00 2017 +1000
>>=20
>>     dm verity fec: fix GFP flags used with mempool_alloc()
>>=20
>>     mempool_alloc() cannot fail for GFP_NOIO allocation, so there is no
>>     point testing for failure.
>>=20
>>     One place the code tested for failure was passing "0" as the GFP
>>     flags.  This is most unusual and is probably meant to be GFP_NOIO,
>>     so that is changed.
>>=20
>>     Also, allocation from ->extra_pool and ->prealloc_pool are repeated
>>     before releasing the previous allocation.  This can deadlock if the =
code
>>     is servicing a write under high memory pressure.  To avoid deadlocks,
>>     change these to use GFP_NOWAIT and leave the error handling in place.
>>=20
>>     Signed-off-by: NeilBrown <neilb@suse.com>
>>     Signed-off-by: Mike Snitzer <snitzer@redhat.com>
>>=20
>> Seems there is no real need for this patch.  Neil, what do you think?

I think the code is correct as-is.

>
> The analysis above forgot to look at the mempool->alloc() callback. So ye=
s,
> while the NOIO is good at the mempool level, but init_rs() uses GPF_KERNEL
> so there might be a different can of wurms lurking.

The ->alloc call back is not relevant to the question of when
mempool_alloc() can return NULL.
If the ->alloc() callback returns a non-NULL value, it will be returned
by mempool_alloc().
If it returns NULL, that will not be returned.

mempool_alloc() *only* returns NULL in one place:

	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
		spin_unlock_irqrestore(&pool->lock, flags);
		return NULL;
	}

so a NULL return is purely dependent on the GFP flags passed.
GFP_NOIO contains __GFP_DIRECT_RECLAIM, so NULL cannot be returned.

It seems quite broken that init_rs() uses GFP_KERNEL. It should take a
gfp_t arg for the allocation.
If the mempool_alloc() above really needs GFP_NOIO, then it could
theoretically deadlock as it performs a GFP_KERNEL allocation inside
rs_init().  So in that sense, the code is not correct as-is.
It could possibly be fixed by calling memalloc_noio_save() /
memalloc_noio_restore() around the call to init_rs() in fec_rs_alloc().


Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrZFSoACgkQOeye3VZi
gbmLsRAAxMcISn8430PLb2pWi84yysdQvxdbkQ2zEW8SCTzs+YO37RRAQBqW4NrW
/80BpwUTDQLqogu3QTifQoxeEKEKl9oWr1FVVm2T0pITzhBtaE7xiurUgo3zSdtK
T/ApYrTUILAKcP2WHIn0d4ksgfasi5am1mOpdhnSFVpjaoikVTUIViiWwVxxX+tL
bOkxqobl9pbc0SkUHXH5h1GE3ncaiPnBMDjBR8u2+BZRj8Tka1eqpU29eqb8Rt3m
P6/qSZPiDjwS5eI8ANH3itoGIfk74RZvH7+snzqN7N2PhXA5vCBRo2wcVB6KUhGb
Qe67qGPVQKNLMjTunt99ud4t0gHmEiw9zRsBlPlQp/OJfmkK2X9fw8Ll4VCri8m6
N363pkrcir58SUcxcthqL9DriHY43uBENSSgW0UOqfvbnjWU9sr2FVblXh0rUC3h
hayF7PJnPBT1DIZWIM6quy92Hp3IVcd24HZDucyIg5+8d9UT41OwsoGLbAT+H/pz
KENO/wqpE/JexVfFPeipnQbhT/TKiqCFOZEpEcgYErbs4H/hUspeVJxR67iqtpj3
YCE6hZhWvsca7JETXpBtlteG1Ifzy1rlMEYz4WvxTHutMJR1pelz5I9qHCzXwXFf
tMcxI0CkB9DNHNzU2OFRqUOiZ5+ZXSnJfgCxWqHJimbkYV/wTzQ=
=+r10
-----END PGP SIGNATURE-----
--=-=-=--
