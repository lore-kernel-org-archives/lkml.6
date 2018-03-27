Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeC0Vup (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:50:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:56567 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeC0Vuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:50:44 -0400
From: NeilBrown <neilb@suse.com>
To: David Miller <davem@davemloft.net>
Date: Wed, 28 Mar 2018 08:50:31 +1100
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without missing objects.
In-Reply-To: <20180327.114941.997071660018188736.davem@davemloft.net>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718430.11435.5761213978298714527.stgit@noble> <20180327.114941.997071660018188736.davem@davemloft.net>
Message-ID: <87sh8l428o.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Mar 27 2018, David Miller wrote:

> From: NeilBrown <neilb@suse.com>
> Date: Tue, 27 Mar 2018 10:33:04 +1100
>
>> In many cases where the walker needs to drop out of RCU protection,
>> it will take a reference to the object and this can prevent it from
>> being removed from the hash table.  In those cases, the last-returned
>> object can still be used as a cursor.  rhashtable cannot detect
>> these cases itself.
>
> Merely having an elevated reference count does not explicitly prevent
> the object from being removed from the hash table.
>
> This invariant might hold for the particular user of the rhashtable
> instance, but it is not always the case.

Agreed.  Hence "In many case ... this *can* be prevented" and "In those
cases".

The doc comment for rhashtable_walk_start_continue() makes it clear
that:

 *   The
 * previously returned object must still be in the hash table, and must be
 * provided as an argument.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq6vKgACgkQOeye3VZi
gbnObw//fCvvgRZAV5Jq3DOSU7zZqrD7cn1CgGYgnkAu8lVTS9hga1/HqJ3hMLPv
LmhC8E24L8KjfgQi7GN7Q/4/+Or6/jAMY+TgO2KXJatEJl7FrMHIEnx6RTXCSEOI
z18dwBsRsZ/5H1EnjPeL5Yju8/P8dP82AAEZmrKDG5xHx4fyCzv7/q++Yxkl5dWq
3imE6lxu7zmv0h1drH88mK3XrIgKDARacuman7Gm4yfL08LPUxZnXVBRMhaiuI5m
wIpwjheDfdcjGaRqUVUYXqA2TfgpJiWQbaSrjyQS3xxolCY6lTy6FNqzSXNRGFQl
CEPxUEiSdZNO3eg5hU332orWnN3cCzk9SlcK38URVdrs6q9s8wRGMMGqLG8OWsts
P+h73Rp66uxT1r84jt2C5tRr+jhhllDO3/O7gMz5xTXGsz3XkCMLYCl5vbAONl7s
tMm6FXD2H3b+gFl7LfmVhISaCpRB1FwsUEgOgDeF1bGmHnWsHC55AQ9QeTP6T276
UwGK7e+Dc03pcnI7g5n68+blyR13NgaMNqP39Jw8IBWJ26weTrctU3zvS1WCS4pj
DBfQCn52sclgmLHdvel72tMEQGP98YAwJifkVzGlgDjU2df+g4v8D8pjO96moz8j
eOSjz9j0rcw+4Hx5oXxhYYzAVi4gMEQ2i9+yE4sLL4f9Tf3w7MA=
=2HhT
-----END PGP SIGNATURE-----
--=-=-=--
