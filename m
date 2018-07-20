Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BFCECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE2220673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE2220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeGTHLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:11:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:58998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727289AbeGTHLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:11:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD1F2AD9F;
        Fri, 20 Jul 2018 06:24:25 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri, 20 Jul 2018 16:24:16 +1000
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH - revised] rhashtable: detect when object movement might have invalidated a lookup
In-Reply-To: <20180717063020.rpqsgrbpwavklxz7@gondor.apana.org.au>
References: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au> <87k1q8yh70.fsf@notabene.neil.brown.name> <20180711.224658.2077863065492745521.davem@davemloft.net> <20180711.224801.1129067473269289703.davem@davemloft.net> <87fu0kt5m0.fsf@notabene.neil.brown.name> <20180716005134.q4rfkfn3m5zzwt62@gondor.apana.org.au> <874lh0t1ls.fsf@notabene.neil.brown.name> <20180716021653.xtbyetdfc2uzxub3@gondor.apana.org.au> <871sc3uah9.fsf@notabene.neil.brown.name> <20180717063020.rpqsgrbpwavklxz7@gondor.apana.org.au>
Message-ID: <87y3e6qvan.fsf@notabene.neil.brown.name>
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

On Tue, Jul 17 2018, Herbert Xu wrote:

> On Mon, Jul 16, 2018 at 01:26:42PM +1000, NeilBrown wrote:
>>
>> Look in Documenation/RCU/rculist_nulls.txt.
>> The very first example is a typical lookup for a nulls list.
>> The above sample code would read:
>
> OK, but how will this work with rhlist? It would be very bad to
> have a feature that works for rhashtable but fails in strange
> ways when you use rhlist.

It should be easy enough to handle in rhlist too.
When inserting a new object, we put it at the start of the chain, and if
there was already a list with the same key, it gets moved to
the new object.
A walk could see some objects repeatedly when this happens, but that
is already possible.

Thanks,
NeilBrown


>
> Cheers,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltRgBAACgkQOeye3VZi
gbmD4Q/6A17Rg4xFwye/fH2dwE/5rCQu0XOZF3q9MZyezggXgnTkreqh+lkR3pdt
FtYHnDCps9vCrVeGwbnFun6TD4Q5iMnstdRddsaq1xCQykvbg+obRqU0N3bbzcJ6
JRsmg9TaxAv4OYX3LTrUhcdLEKLs4Hq/t0D64SFlBsHUR/GiYPGVioPZ8f+SmwV8
xBC8ulaGXh901f7NUT/KklHi8MAEa2nCSIJxng1dCaayjOZaXcgf3mEAc3gu4TV+
m4QrgnXAnhn3+yknKxNBildy1/ZIBYWpR283vrW1XDkmr63lbN0VstlRLM+VaTV5
yGexu+Riy3+J1/utX+Ruz+iq4WCiZBjoGtHIapBiHNXaZsWZlNS/2rPRdtNDOHjm
iCk/xWt/1Avp0Y07mV4ikqtWdQtvMyGCDi+CDJX09KJLxLJlBJeJDMnXz2odiFCN
fThGKNyD2zKJA8GGNumlR9YKr0e+DjuTS7RS0coI3U9W4tgCxLWSVZvs4H8FokSL
oB+gd/SpqUgcmjp1DzRBWIdz5Vg6JkPE6dNjCQKx+h6XqBITwLHKbEGW8OJhW3CG
WnWZH08NfjgV1oVSG+5EWlVvGiqwEyNQJNABW+sFmF72QAUNr5epu4pIedkhszpC
SYWiUTvLHSYxdr9QnsieZLdX0c8399JS0ojFOEQ5cX/7+Fwm3r4=
=6aZF
-----END PGP SIGNATURE-----
--=-=-=--
