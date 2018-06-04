Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeFDAbJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 20:31:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40691 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeFDAbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 20:31:08 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 04 Jun 2018 10:30:55 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH 10/18] rhashtable: remove rhashtable_walk_peek()
In-Reply-To: <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824964.30340.6329146982899668633.stgit@noble> <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au>
Message-ID: <87y3fvpf40.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 02 2018, Herbert Xu wrote:

> On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
>> This function has a somewhat confused behavior that is not properly
>> described by the documentation.
>> Sometimes is returns the previous object, sometimes it returns the
>> next one.
>> Sometimes it changes the iterator, sometimes it doesn't.
>>=20
>> This function is not currently used and is not worth keeping, so
>> remove it.
>>=20
>> A future patch will introduce a new function with a
>> simpler interface which can meet the same need that
>> this was added for.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> Please keep Tom Herbert in the loop.  IIRC he had an issue with
> this patch.

Yes you are right - sorry for forgetting to add Tom.

My understanding of where this issue stands is that Tom raised issue and
asked for clarification, I replied, nothing further happened.

It summary, my position is that:
=2D most users of my new rhashtable_walk_prev() will use it like
   rhasthable_talk_prev() ?: rhashtable_walk_next()
  which is close to what rhashtable_walk_peek() does
=2D I know of no use-case that could not be solved if we only had
  the combined operation
=2D BUT it is hard to document the combined operation, as it really
  does two things.  If it is hard to document, then it might be
  hard to understand.

So provide the most understandable/maintainable solution, I think
we should provide rhashtable_walk_prev() as a separate interface.

Thanks,
NeilBronw

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsUiD8ACgkQOeye3VZi
gbkffBAAlSQ2AhyyzxieA7FU8JyJKigEVXGXQpyCiyw0MQDhORq3h6ee59N0/28f
bZ3m07NlDO4TsII2CElhdQ2nwR51QCy+id8gnV2w2wr1c//9ksiUbCY44o7stdiz
u3ktzUNE/qEwD0qthP3qYMI480qFP22rdV8Oeo3XkV9kpl2C6uD3iu/81ntqxcJ3
XIHGwoTZTXlEUro93nitLfNc8pg7VJZSv4MJFLvFGwGP8r0WCXA1RCGg+wAGUDPN
6f6ir7NMio/2CplRtPL6ro1PSeggK9+DmKPdsgwIblFqtaZCvJotEwyU1FUODQOg
5HNQhIjn6ggLEWggYXEs9N0JEdCwq4ZyzDZI2D3iWmHVj29XReUQogLfGHFTbIGG
OBY1WbMPbo5QdReH/8EcPC5ufn+xjXxiQFQouCfZi7Fwzak9VPNir+BQIsi0ZDej
BbaFimVdgNDX2AIV5DsQbjwcU9eQ22fTyuAOOm3UPpFk3ftpqma9RDhTcaMpoyuN
ZADrQWFBkoQzjtfvUmil3JEQ6KXK1ocB3MXBste+L3WLt4BWMLDctR73FXxbgPtB
D49Wdu5mxAbDXzxagLfsb7jjPVvo71ioZP5WDEPJKM/EnJWhcd/F1bka1SpToeJr
4TkH4e9tOm9KvHETXKVrKw94beD0uN0pJL8pgkeXsLabgdQhjAQ=
=6adA
-----END PGP SIGNATURE-----
--=-=-=--
