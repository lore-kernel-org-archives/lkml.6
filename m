Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B00E6605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeFFFII (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 01:08:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:48304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbeFFFIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 01:08:07 -0400
From: NeilBrown <neilb@suse.com>
To: Tom Herbert <tom@herbertland.com>
Date: Wed, 06 Jun 2018 15:07:57 +1000
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH 10/18] rhashtable: remove rhashtable_walk_peek()
In-Reply-To: <CALx6S36Ce-rXQMzmFYZVPGD10Bo6udvRAHiZ5gWwnzVwoTVv0w@mail.gmail.com>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824964.30340.6329146982899668633.stgit@noble> <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au> <87y3fvpf40.fsf@notabene.neil.brown.name> <CALx6S37AYrFoJNrdToRc84J=B4f57jaHS077UsxdEoQ-xwyCeg@mail.gmail.com> <87sh63pakb.fsf@notabene.neil.brown.name> <CALx6S35sf4oj=x73SfhUxi1e9-u4Stxgr9BAj5E7KKmbufntwg@mail.gmail.com> <87r2lmnj2c.fsf@notabene.neil.brown.name> <CALx6S36Ce-rXQMzmFYZVPGD10Bo6udvRAHiZ5gWwnzVwoTVv0w@mail.gmail.com>
Message-ID: <87in6wo636.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Jun 05 2018, Tom Herbert wrote:

> On Mon, Jun 4, 2018 at 6:00 PM, NeilBrown <neilb@suse.com> wrote:
>
>> On Mon, Jun 04 2018, Tom Herbert wrote:
>>
>> >>
>> >> Maybe a useful way forward would be for you to write documentation for
>> >> the rhashtable_walk_peek() interface which correctly describes what it
>> >> does and how it is used.  Given that, I can implement that interface
>> >> with the stability improvements that I'm working on.
>> >>
>> >
>> > Here's how it's documented currently:
>> >
>> > "rhashtable_walk_peek - Return the next object but don't advance the
>> iterator"
>> >
>> > I don't see what is incorrect about that.
>>
>> rhashtable_walk_next is documented:
>>
>>  * rhashtable_walk_next - Return the next object and advance the iterator
>>
>> So it seems reasonable to assume that you get the same object, no matter
>> which one you call.  Yet this is not (necessarily) the case.
>>
>>
>> >                                           Peek returns the next object
>> > in the walk, however does not move the iterator past that object, so
>> > sucessive calls to peek return the same object. In other words it's a
>> > way to inspect the next object but not "consume" it. This is what is
>> > needed when netlink returns in the middle of a walk. The last object
>> > retrieved from the table may not have been processed completely, so it
>> > needs to be the first one processed on the next invocation to netlink.
>>
>> I completely agree with this last sentence.
>> We typically need to process the last object retrieved.  This could also
>> be described as the previously retrieved object.
>> So rhashtable_walk_last() and rhashtable_walk_prev() might both be
>> suitable names, though each is open to misinterpretation.
>>
>
> rhashtable_walk_last is better, but still could have the connotation that
> it returns the last element in the list or table. How about
> rhashtable_walk_last_seen or rhashtable_walk_last_iter?

I'd be quite happy with rhashtable_walk_last_seen().
I also be happy to keep rhasthable_walk_peek() but to implement it
as
  rhashtable_walk_last_seen() ?: rhashtable_walk_next()

I'll send patches to that effect some time this week.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsXbC0ACgkQOeye3VZi
gbkZuhAAsgPnKaVXRaxpSuQjpP/5Uv26QazeZGXEGuqEaywafv5HVuH+ASeh8WUm
cY6uTseJ8QGiL3t7wi0lEtC/Iy2bpUj6etS8ScdRnaiv/Ye2Zgi+tL3G1AjOujKf
0mqW+NREBlqRvdJ2fVTdjg3obatwfhhKFObmZk2GCzAMEZ30+K42fkKUVKWk6+vb
ARKqycsZ8IvoNRYq4v81Sf4g25LdylotHtdkEN+jfKVn67WoUNAsK3YqtHPHpQGc
iA0fFxTdBQPG91zJdgt/IyquVoI+7vfqxgKxFgYGCHg12jK5DHhMKQGBHq4ObShA
mJI4YyfOPDnz692oQYztt9+4zmOia+M0j/Yvq8+uXJ9NrA5KmeZ2YvUi542gPS4C
JS6uPG0mUEgw6JQOkeqJ6QbnBihQggrfRnurJ22133rnvQEW0hjaYrP6p9W2LIv1
tbPGKqN1q3KaYQr5ix1WqT6k7qkv3Ffd5yaWCbcZPMoYWEMyN1VZWI8KKMpGEvlT
stK5ywQl4+VeURG/sAWrYaIWO7/3f+mbJEtYANoM4qwLmC1mC+sJOwKazftmOkxS
9w2nE4XCul7dF/UO/kulcwbblyUuaBL97FEHMCV7TXnbCOJAy/mAK7G+JwXq91SE
jhkVWp8yWsFcwPoDtwSXz79o8OgC2qu3N72QsK+N9Kmepekec1E=
=A1Fg
-----END PGP SIGNATURE-----
--=-=-=--
