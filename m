Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB8C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CE2223BD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CE2223BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeHJFpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:45:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:44888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbeHJFpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:45:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F2E4ADD7;
        Fri, 10 Aug 2018 03:17:22 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 10 Aug 2018 13:17:14 +1000
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
In-Reply-To: <20180810025251.GO23873@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble> <20180809173245.GM23873@fieldses.org> <87lg9frxyc.fsf@notabene.neil.brown.name> <20180810002922.GA3915@fieldses.org> <871sb7rnul.fsf@notabene.neil.brown.name> <20180810025251.GO23873@fieldses.org>
Message-ID: <87y3derjut.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09 2018, J. Bruce Fields wrote:

> On Fri, Aug 10, 2018 at 11:50:58AM +1000, NeilBrown wrote:
>> You're good at this game!
>
> Everybody's got to have a hobby, mine is pathological posix locking
> cases....
>
>> So, because a locker with the same "owner" gets a free pass, you can
>> *never* say that any lock which conflicts with A also conflicts with B,
>> as a lock with the same owner as B will never conflict with B, even
>> though it conflicts with A.
>>=20
>> I think there is still value in having the tree, but when a waiter is
>> attached under a new blocker, we need to walk the whole tree beneath the
>> waiter and detach/wake anything that is not blocked by the new blocker.
>
> If you're walking the whole tree every time then it might as well be a
> flat list, I think?

The advantage of a tree is that it keeps over-lapping locks closer
together.
For it to make a difference you would need a load where lots of threads
were locking several different small ranges, and other threads were
locking large ranges that cover all the small ranges.
I doubt this is common, but it doesn't seem as strange as other things
I've seen in the wild.
The other advantage, of course, is that I've already written the code,
and I like it.

Maybe I'll do a simple-list version, then a patch to convert that to the
clever-tree version, and we can then have something concrete to assess.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlttA7oACgkQOeye3VZi
gbkH3xAApCIb/A9UBynqqfnjJRW/vVHFLNxgfIH0mV+kWYcqqJjdk9OgJVXFZN8Z
pgmXWpOvIPgiEWvP/AJ0j68gr2SX0apqrRIJM4hC5PDUlZ5yd/HG6Boj9iSuuwxz
mleDidqXpu5zVsdgqrr6tVD9WoYmIDPj9fV6iK5oJlUez89rPnv6ota1CmDYJ/iz
1JherxaK9Pgsm9pZjmSx5q+xkg6dOf/wNOrwjImnuOUTUvtBWJWfiWzu8a6REyDr
kn+1skNaHIaX3xEtiglV85c3Yr88I4JEXzXmeNZoAvDvJmzXy6jb4kxW4zL8VTet
T6eTT97sek405Ljhp7EL7pnVcnk8Tpx7jovtvaaSvoA/HiOCz2JadOmzOcSheexi
gCl2xU0sSk34tjpImdUK95YMl+/qIud+ddsp/+z6m1bt0WiMXR/QqjlvtPps+tn5
Qy/gD0bzlkaGaWd9gGJ/fEHCkiYZ98OGE7Z3ZpBZLWSSTho9McWB8f6+IaoZV3q9
7bfoRLMacuS7j0dfbSSdjtxIsk6NKEO42w8msIRu78vZNA/2Kh/GrJ/PjRUHlwPq
mejxpHg34IvxvIY/TG3+bIbG0+ltXAHPlwpA8tpZ+QD6rB8fzOivBbzNODoWeGom
7GIrcEA0e1AwmFs1Bg7yQt/X5qLzMRUPuXxCrfMs6PvghkAhDk8=
=yBJt
-----END PGP SIGNATURE-----
--=-=-=--
