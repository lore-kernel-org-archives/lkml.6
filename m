Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeC2BNi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:13:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:43408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeC2BNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:13:37 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 29 Mar 2018 12:13:24 +1100
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without missing objects.
In-Reply-To: <87zi2r3mve.fsf@notabene.neil.brown.name>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718430.11435.5761213978298714527.stgit@noble> <20180327155118.GB14001@gondor.apana.org.au> <87po3p421q.fsf@notabene.neil.brown.name> <20180328060734.GB16291@gondor.apana.org.au> <87a7us4qje.fsf@notabene.neil.brown.name> <20180328073023.GB17306@gondor.apana.org.au> <87zi2r3mve.fsf@notabene.neil.brown.name>
Message-ID: <87tvsz3cqz.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Mar 29 2018, NeilBrown wrote:

>
> How about storing the hash chains in order by object address?
> Then rhashtable_walk_start() can easily find it's place regardless of
> whether the old object was still present or not, using <= on the
> address.
> "Insert" would need to record an insert location and insert there rather
> than at the head of the chain.
> I might try coding that.

Unfortunately rhltables make this approach unworkable.
However while trying to write the code I found a bug :-(
I'll post a patch for the bug, and a patch to transparently make the
current interface more reliable when the caller keeps the current
object in the table.
I think this is sufficient for all current use-cases.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq8PbUACgkQOeye3VZi
gbm+qxAAss8awx1WkFlUay4HMozYWAxT9useCEUPcVjVrb2T9zBgmbJ2FK49PShG
i1Oki5t9CG7y2VYPt9I32wJdMjL6/PlzNV3OEXqNsvGKJwekoGX8qIJxyYjS7F9E
0W9gQhWKcjrZnBjDZT/bdfF1EAXpQ3U/pBA/jkLAZdTtTTu1sKO0FXW00sA9Gwwr
KBNp5TZGgQNz/Qm3G4lLQMDVxi9YF5K4LyZlL8v1XUU6lGqArWwUZiPAzUvsrJtp
GBvpVzPFNfdA6bYHJaY7tsxzIvIAQ33Yk2fjoGgaPOANvYnehGzBgb8aN8CmcwAM
yYQRvOk8q3M8//bHRURcOl+Up4X6p7wLclC0tllgmAxybeRbaPq/FC/Pd1MrU8BN
fMFU40PlSoE2W//NxkwLjKBFZOj5W0oVUfkLi0L3lscL2UyKuaedTfhpVkdqJcW5
yhUraxHmvXD4fVmKIDRg1eL3byZxscBHtUkl+3F78DiDrz19VQULHC62lQpM82ez
NldL7ufsklRel59U3gEf9QMLVeFPKu4LD+kN3IguDoSdEBTnGj+FYVuSQA54+mNG
aMiMYNDfi+uD0rHbe32mDzL4xXWACPUkyQAMnbq+y/0Fr5T3Pdj2sRcu0oZaUZBl
OrS1xEZyV9kZ6tEKULS61Lakwpe2ZKgfimXSREg02CXriGL0Y+k=
=6cxa
-----END PGP SIGNATURE-----
--=-=-=--
