Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-384599-1520091237-2-3631731879879200036
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520091236; b=w+KAxd5nIfQyCjMx/UgphlEJC92awP4Kl8icZ4USZJ4tCct
    dgWEErgo/XawoYrJQBZizOs/Mt66gBwhjj+N47h1/ZCeTKWGBSPce2AUJFDRTii0
    KSc1f64FUjeU1WpL9xbj5pA8q/7jyUFdNDTIMbHJy15DynUFagVdfJppCdIdodDN
    dfMLstuRCZuc5dtIjydTXHmhLagPhBHos3KdXOK0dGQTHpvr9CupV3lltLUSKYlE
    q3NpanNDfqgmGA0E5dwD/fxNtKdUjUYpmfaEsOEspUQ/VWJKrrNEoIeOiFGrup0U
    w5F3HKYnuj+Ce+pvHlNyHgOojpPkvRKJVLQFF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1520091236; bh=mkP0UasnJdTbhDxKhaG1gwi2x7
    shRELsKMNAkpF2Ob8=; b=KrYMtlcKhJrpcFQJafuTb0kY3cAeSatLVB4Ch00cus
    iOml0d08p+v7R4Ca/e7aQWRHi8mRvJRq3Plqi1ANQ64JzqBHRhTD6dT2dJRO+z++
    GIjdghKMQMs2v7HD1mymi6Wc/BRPyPkuxB7f9od51Qrx79SQzHooQXDZfWL/wZNp
    Mvt5A5ttQRuHACOORaP0iBinConcbwISQQw2GZU7UOgIYcmd0G+HcKKeqz1ZgobA
    bFkpbqpK0ULet/C0vypJfLu+bePMQZ3tdjwwYPatWlljPbeOoDd9mAjYyAVB1Mbt
    tugn4MRlboY8LWN+Ksg/YP9E27kqS+Tygx0nkZr1aM4g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeCCPdz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 10:33:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:58199 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752088AbeCCPdy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Mar 2018 10:33:54 -0500
Message-ID: <1520091209.2617.372.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 083/254] dmaengine: dmatest: move callback wait
 queue to thread context
From: Ben Hutchings <ben@decadent.org.uk>
To: Adam Wallis <awallis@codeaurora.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Sinan Kaya <okaya@codeaurora.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>
Date: Sat, 03 Mar 2018 15:33:29 +0000
In-Reply-To: <ff67c838-e4e4-c254-1a6d-4b395e63604b@codeaurora.org>
References: <lsq.1519831218.227690932@decadent.org.uk>
         <ff67c838-e4e4-c254-1a6d-4b395e63604b@codeaurora.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-lK8q6GBT/0Os3ohxPX3z"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-lK8q6GBT/0Os3ohxPX3z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-02-28 at 12:47 -0500, Adam Wallis wrote:
> Ben
>=20
> On 2/28/2018 10:20 AM, Ben Hutchings wrote:
> > 3.16.55-rc1 review patch.  If anyone has any objections, please let me =
know.
> >=20
> > ------------------
> >=20
> > From: Adam Wallis <awallis@codeaurora.org>
> >=20
> > commit 6f6a23a213be51728502b88741ba6a10cda2441d upstream.
> >=20
> > Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
> > introduced a bug (that is in fact documented by the patch commit text)
> > that leaves behind a dangling pointer. Since the done_wait structure is
> > allocated on the stack, future invocations to the DMATEST can produce
> > undesirable results (e.g., corrupted spinlocks).
> >=20
> > Commit a9df21e34b42 ("dmaengine: dmatest: warn user when dma test times
> > out") attempted to WARN the user that the stack was likely corrupted bu=
t
> > did not fix the actual issue.
> >=20
> > This patch fixes the issue by pushing the wait queue and callback
> > structs into the the thread structure. If a failure occurs due to time,
> > dmaengine_terminate_all will force the callback to safely call
> > wake_up_all() without possibility of using a freed pointer.
> >=20
> > Bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D197605
> > Fixes: adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
> > Reviewed-by: Sinan Kaya <okaya@codeaurora.org>
> > Suggested-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> > Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>=20
> [..]
>=20
> Make sure you pick up the following bug fix on whatever branch you apply =
the
> above patch to
>=20
>=20
> From 66b3bd2356e0a1531c71a3dcf96944621e25c17c Mon Sep 17 00:00:00 2001
> From: Yang Shunyong <shunyong.yang@hxt-semitech.com>
> Date: Mon, 29 Jan 2018 14:40:11 +0800
> Subject: dmaengine: dmatest: fix container_of member in dmatest_callback
>=20
> From: Yang Shunyong <shunyong.yang@hxt-semitech.com>
>=20
> commit 66b3bd2356e0a1531c71a3dcf96944621e25c17c upstream.

Thanks, I've added this.

Ben.

> The type of arg passed to dmatest_callback is struct dmatest_done.
> It refers to test_done in struct dmatest_thread, not done_wait.
>=20
> Fixes: 6f6a23a213be ("dmaengine: dmatest: move callback wait ...")
> Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
> Acked-by: Adam Wallis <awallis@codeaurora.org>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
>=20
>=20
--=20
Ben Hutchings
[W]e found...that it wasn't as easy to get programs right as we had
thought.
... I realized that a large part of my life from then on was going to
be spent
in finding mistakes in my own programs. - Maurice Wilkes, 1949


--=-lK8q6GBT/0Os3ohxPX3z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqawEkACgkQ57/I7JWG
EQkjDRAAkIzuFVpuprq24A9GEVH61iItmznSP58ucuso2y3hlgG9AqBAvbLePfg2
QhLEmyse65u8l35ijZR82JZAnhZ7yVfhSZSs75nUAK5hN2lQEVsWGgtdk4+b/enR
BT1oQeal4/B31ImfstVHHgkFW44qgWXdgrzr0d/42hbSUVlSn8luZzzDJTXmKxIC
psuOcPTwLPvw1JUGo51BCwDoMKO/V4GkynE31wbrXicpoR/bLXsoL4iklyNEOBu2
DWE7CFJmWld23Flf+bU4S6zQpUhEQ/FzM2Xd5/tp2+V9sK9iLAqkjA7vLCkpIqhk
43qBETRph3qJV/gTA79nCKCfKhdBg2y971XmFlCkqF0dhmLosoCOI0ZFdAMzCe9j
67rAcMNI1qVBsDCWfr71Jbf00/BoQ7ILn/DyvT0H8WS4huLWfnDpZFYcvC+msSnK
XCcAuF5R0SnAQp5is795VWF8+/5eLXh3XG+jCFOp805h62YYJs3HFc61pCnr0kGh
VW2NUbUJFwbJGb0r9VZbQfpNq/hLrGt9wSITXYBhkussOlFJ5DJlvf6xyp2wh52g
MOexHvkyafzIb1rg8zDqetmgk/Uv5QLTOpv4/hO5ZMIqpaHi62KpALiS7x11gh0y
eVJWmnofZFpfdSkxAjBg3nBHbsIdm9OG3B/GL9gDO0jv5kvEvEA=
=uxPe
-----END PGP SIGNATURE-----

--=-lK8q6GBT/0Os3ohxPX3z--
