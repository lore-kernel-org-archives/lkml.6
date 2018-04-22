Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3622052-1524436157-2-12381296547737313474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524436157; b=n4+TL0TxXUM/JOwA0ndxSi3uZtLfFRtKDkAoh39SrUw6qBIJaG
    F/rLiQFjRi+8AsQ8UiqIzEzmJfboY+Tl1ljJIx0DQzf98wr18GHoEyt6AIYmTntp
    /ZBIfF0Vyn4oJBJr3K9ga6dU3IwsHDgh2e31s3OhRZgY26wuOkpaTac5jkuxCFTQ
    iOtXtnoweyQtM29EjYDejyZPL/ECJQb+uXrzAC1N9wAaht8PW1RE+/+IkjwJ1jQV
    /1E3jCzDkviVM1kOc4WSAicU4fcZn70wniMo29p6HPjfdnY6UOznPhZN4frLiOXa
    cgxv2G83o9fop+4XuhZA2bBxL61ap5824k2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=fm2; t=1524436157; bh=JZXwaGkQRib3RloAFIuxy8EIaMX4pM
    7IL+u/Sbu5HDY=; b=LtaoMcigr6r2g7q9U73I2ETjZKnq9SmMy7mHi6JY7+aZyU
    8fZn4xROgvUTzwcgTcBpA8iKtIEsl6jEQXfAtLexJdN3JSMzyYIYO4tH5nzyOvcw
    hpwabM8k/PxmnXxSvXInvdalEmZ7TaSPwqFWJdm5Nv/UnLZM1FjbwMqVgnnZc9GN
    k68SD34vfNVgPqaWyow7seu41+TtpRh4t24ADaTuxUOeJDLWdRBWoKRfwIENt8Jd
    qnRB5NIddqXCbsexdmYSYeu1xl9aa+WU7EcSvZzEFWGngdVCCSTK8zforWg+u1ov
    Krt8PSPiWG2CdjaBlGjKCikib1MRfoT6XUC2zdwg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHUx1E1e430SXPZaGz/CnJ5NEq5WjuIz3bXfbMgYl1d3csw7xoAcCfO3PorQw/bYg3aVREQ7KEweved45BOyXrih6wqCHVo4s/XEckJ2e1Zo1+tT0DNh
    /kuvpxn3FEsBMVMKAS/xR70PuDJFA6O4kLFLkAxMyJdidLYQhhJxHCAVg+URMQzIp6JWR3PLqzgeLq2M3lNZC+EypcRPVZIEtTXLyvw0NbdnnTituXoABkU9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=FaTVyrhZTwAlvuTN2ksA:9
    a=QEXdDO2ut3YA:10 a=6cnNWI2bf8TKgDK_wg4A:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753716AbeDVW3N (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 18:29:13 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45626 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753700AbeDVW3N (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 18:29:13 -0400
Message-ID: <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after
 the CRNG is fully initialized
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        stable@kernel.org, Salvatore Bonaccorso <carnil@debian.org>
Date: Sun, 22 Apr 2018 23:28:52 +0100
In-Reply-To: <20180422135213.491879480@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
         <20180422135213.491879480@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-vihau1uszm3Xy1rY40DC"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-vihau1uszm3Xy1rY40DC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-04-22 at 15:53 +0200, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Theodore Ts'o <tytso@mit.edu>
>=20
> commit 8ef35c866f8862df074a49a93b0309725812dea8 upstream.
>=20
> Until the primary_crng is fully initialized, don't initialize the NUMA
> crng nodes.  Otherwise users of /dev/urandom on NUMA systems before
> the CRNG is fully initialized can get very bad quality randomness.  Of
> course everyone should move to getrandom(2) where this won't be an
> issue, but there's a lot of legacy code out there.  This related to
> CVE-2018-1108.
>=20
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: 1e7f583af67b ("random: make /dev/urandom scalable for silly...")
> Cc: stable@kernel.org # 4.8+
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

In 4.9 (and probably older branches too) this leads to a deadlock:

crng_reseed(primary_crng, ...) takes primary_crng.lock
-> numa_rcng_init()
   -> crng_initialize()
      -> get_random_bytes()
         -> extract_crng()
            -> _extract_crng(primary_crng, ...) tries to take primary_crng.=
lock

I think this can be fixed by backporting commit 4a072c71f49b
"random: silence compiler warnings and fix race" but I'm not sure
whether that depends on other changes.

Ben.

> ---
>  drivers/char/random.c |   46 +++++++++++++++++++++++++++----------------=
---
>  1 file changed, 27 insertions(+), 19 deletions(-)
>=20
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -818,6 +818,32 @@ static int crng_fast_load(const char *cp
>  	return 1;
>  }
> =20
> +#ifdef CONFIG_NUMA
> +static void numa_crng_init(void)
> +{
> +	int i;
> +	struct crng_state *crng;
> +	struct crng_state **pool;
> +
> +	pool =3D kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
> +	for_each_online_node(i) {
> +		crng =3D kmalloc_node(sizeof(struct crng_state),
> +				    GFP_KERNEL | __GFP_NOFAIL, i);
> +		spin_lock_init(&crng->lock);
> +		crng_initialize(crng);
> +		pool[i] =3D crng;
> +	}
> +	mb();
> +	if (cmpxchg(&crng_node_pool, NULL, pool)) {
> +		for_each_node(i)
> +			kfree(pool[i]);
> +		kfree(pool);
> +	}
> +}
> +#else
> +static void numa_crng_init(void) {}
> +#endif
> +
>  static void crng_reseed(struct crng_state *crng, struct entropy_store *r=
)
>  {
>  	unsigned long	flags;
> @@ -847,6 +873,7 @@ static void crng_reseed(struct crng_stat
>  	memzero_explicit(&buf, sizeof(buf));
>  	crng->init_time =3D jiffies;
>  	if (crng =3D=3D &primary_crng && crng_init < 2) {
> +		numa_crng_init();
>  		crng_init =3D 2;
>  		process_random_ready_list();
>  		wake_up_interruptible(&crng_init_wait);
> @@ -1659,28 +1686,9 @@ static void init_std_data(struct entropy
>   */
>  static int rand_initialize(void)
>  {
> -#ifdef CONFIG_NUMA
> -	int i;
> -	struct crng_state *crng;
> -	struct crng_state **pool;
> -#endif
> -
>  	init_std_data(&input_pool);
>  	init_std_data(&blocking_pool);
>  	crng_initialize(&primary_crng);
> -
> -#ifdef CONFIG_NUMA
> -	pool =3D kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
> -	for_each_online_node(i) {
> -		crng =3D kmalloc_node(sizeof(struct crng_state),
> -				    GFP_KERNEL | __GFP_NOFAIL, i);
> -		spin_lock_init(&crng->lock);
> -		crng_initialize(crng);
> -		pool[i] =3D crng;
> -	}
> -	mb();
> -	crng_node_pool =3D pool;
> -#endif
>  	return 0;
>  }
>  early_initcall(rand_initialize);
>=20
>=20
--=20
Ben Hutchings
It is easier to write an incorrect program
than to understand a correct one.

--=-vihau1uszm3Xy1rY40DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlrdDKQACgkQ57/I7JWG
EQmiTBAAvsz01Ar4TLlzvgLUQSchwqO9Dm18f+pdk/T6CgVKUFdVIfcUl1lIzvsk
aSIuqimF6Tq9KceAzZAuPYPy6gEiMMkst7XGWHSY245fbhgy+ticsnJ2fDUkAbVH
XVaCkJoUd2gYk54IzmZwwuW/9n/EEufoKKSkDNrJkKoijZGIvUyXjsRsRHRHmHKp
SrTYhFdrpci4SnmWp6DcJXgrMcjyj1WmiKkWCkVbDgibC7ul+pF6mfO/ziuQEuK4
Ym3ktFwMwqhuBR/e56CqZ1Te9urkSJuXBSD4mhScL5HWdZUkjfJD2VeXd7xcsgXD
ilknnGXBChHwnwtZwVgwXjDQ/QUHqP9Vso5xiP5OaadZymRm98pF2B1lnobXJM0L
PvbZ/pWzVzDSaby6OaKTz1t1g5RANLoh+cVvWU1Z/9kpOrFv7ZHfTqsusXaFAWTF
vb/HtRCVS9BqB37+5KxT20Bl7B+0NF9WktPCD1+KNGRp5jCmlI7OQMh8Uu9ASO5z
olLG59Fu4DDMw9Jp8qwH9KrKCs8/oCOHYDr6dJTCsKAShTT/43ITmoVMZJSP4/2Q
4tryMtBpZzXBJLBj0H9WPA+2Jv5jMSQDAfa0IRfgRJHqKLIaPJtiIa5IKLcz3SZF
VVc8mR1cZnpSwD8SX4AJLRA7URkVD4hUcWCreATEHVeT87uaoZs=
=zlmL
-----END PGP SIGNATURE-----

--=-vihau1uszm3Xy1rY40DC--
