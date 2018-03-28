Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeC1Atr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:49:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48255 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbeC1Atp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:49:45 -0400
From: NeilBrown <neilb@suse.com>
To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?=
        <andreas.gruenbacher@gmail.com>
Date: Wed, 28 Mar 2018 11:49:28 +1100
Cc: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH 1/6] rhashtable: improve documentation for rhashtable_walk_peek()
In-Reply-To: <CAHpGcMJgys_gMOw-VEpbO6w+NFaww-P6OvL=jwZfie9TxD9ZYA@mail.gmail.com>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718418.11435.11573013181393548255.stgit@noble> <CAHpGcMJgys_gMOw-VEpbO6w+NFaww-P6OvL=jwZfie9TxD9ZYA@mail.gmail.com>
Message-ID: <87h8p13tyf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28 2018, Andreas Gr=C3=BCnbacher wrote:

> Neil,
>
> 2018-03-27 1:33 GMT+02:00 NeilBrown <neilb@suse.com>:
>> The documentation for rhashtable_walk_peek() wrong.  It claims to
>> return the *next* entry, whereas it in fact returns the *previous*
>> entry.
>> However if no entries have yet been returned - or if the iterator
>> was reset due to a resize event, then rhashtable_walk_peek()
>> *does* return the next entry, but also advances the iterator.
>>
>> I suspect that this interface should be discarded and the one user
>> should be changed to not require it.  Possibly this patch should be
>> seen as a first step in that conversation.
>>
>> This patch mostly corrects the documentation, but does make a
>> small code change so that the documentation can be correct without
>> listing too many special cases.  I don't think the one user will
>> be affected by the code change.
>
> how about I come up with a replacement so that we can remove
> rhashtable_walk_peek straight away without making it differently
> broken in the meantime?
>

Hi Andreas,
 I'd be very happy with that outcome - thanks for the offer!

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq65psACgkQOeye3VZi
gbkwQRAAwbCY1Rwltcli5kVgU5Zj/ArXur9n6fsd+TJ3sW1uH39F3OGC2yL6Fa92
qaWJndvvTEo+QNsxlm0h6xeFg/vKYyw6KZCKSYQc8HLGVgsCkbgS/uSw0+hjxRUh
9JoRQt/NAwe51wTQl+JlJDQv+oKlPofEVSrKbOk1YvH33vueKMGDMgwoVB4GNH7a
Z4/3SRRNfL1nFvjk9Il/91TT4N5PLIDGMKjtu52gk9y4kHiJ2oTfRIdNGkE74cz3
+q4GJchoHc0T+Rl8bK2a1AegACHfkt/XkmVbBjioeURJKX1MgTTeXcTNgtdpwnMj
U9UeoRlsDodS/T9xg47yGyfBreJqlzNpSpW2JSQigAD3bP+nyJ8kVIHIc6Q+2jmv
swW829PmWeXgrTLW0IKSudaeqBfyyChCDG47aZNx5reU2Tjz1Y2jf+B9tx4MwVgq
5OAft+wBEw7F2+YXLxu6k/TJb5nvLJseG62Lz79G+OBpi+8AAcOCtxqDjTNP28Cg
ARgRpWdFJuJgLPgwzK4+BAYTP/7xn+Q8clHD3qH9sLN+0gZ9TGPXWxt2BeUN6dB5
AJHqPkFQD9tox++g+dYTGA95bWkqrKUdHAJAlffbFH5sGW22x6tdRCIHkhCEXGNX
IXltrEl2E0m88LpUQvHEEKS4askZqaNSFTTgBO7MctKbwnGfiUY=
=nr7B
-----END PGP SIGNATURE-----
--=-=-=--
