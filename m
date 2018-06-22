Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5267FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153D523DD1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153D523DD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeFVGg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:36:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:43827 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbeFVGg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:36:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4B13AB39;
        Fri, 22 Jun 2018 06:36:25 +0000 (UTC)
Date:   Thu, 21 Jun 2018 23:36:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     NeilBrown <neilb@suse.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/4] lib/rhashtable: simplify bucket_table_alloc()
Message-ID: <20180622063613.kcnkrfpyszphnf46@linux-r8p5>
References: <20180621212825.3059-1-dave@stgolabs.net>
 <20180621212825.3059-2-dave@stgolabs.net>
 <87sh5fbbma.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wctdmjbevz3t7pte"
Content-Disposition: inline
In-Reply-To: <87sh5fbbma.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wctdmjbevz3t7pte
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, 22 Jun 2018, NeilBrown wrote:

>On Thu, Jun 21 2018, Davidlohr Bueso wrote:
>
>> As of ce91f6ee5 (mm: kvmalloc does not fallback to vmalloc for incompatible gfp flag),
>> we can simplify the caller and trust kvzalloc() to just do the right thing.
>
>Hi,
> it isn't clear to me that this is true.
> With this change we lose __GFP_NOWARN and __GFP_NORETRY.
> I doubt the NORETRY is particularly important as this is if it
> isn't GFP_KERNEL, then it is GFP_ATOMIC which doesn't retry anyway.
> However I cannot see why this patch won't result in warnings when the
> kzalloc() fails.
> What am I missing?

You're right, it might be too agressive to get rid of the GFP_NOWARN for
the callers that do GFP_ATOMIC.

I'll send a new version of this patch along with a better changelog.

Thanks,
Davidlohr
--wctdmjbevz3t7pte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfFmxIPSv0bNouB8XTxsx2rK+gIFAlssmNMACgkQXTxsx2rK
+gIwow/8CXXnyoNLG+1OxngkGkphoIlpPy3H+ghSa094MS3CBJfQ3lEkxejDODm4
Jk4TXOSXJaCUqler7JZJdL9O+SH/H258gbJiKMqbxSFqvD57BzyYN6eoI8sBT916
dUdJcpfEarEq+w8Zc1qpZu9rxEQdKrV8LnooOkUrSKY8u3aMbSDhffXp4tDP5FGz
GHgg/VZPHsi4rZ91vbgl2FzOM92IDgp+eKLeTg6ncAxaf/uuoptFjSlPucfdVaqf
lujkgBuBdmTCkHL6C0orZN5Onn/xXt0O5IfA/wfC/pkTdaya8619OC6ZVDZQbU2x
DwWk1BtUqTaYuY9HkcPyrNNLxWFa0xsswRmcw9oawAiYyYYPvYzkf9IlxDNse6HH
oGQ1iyEAvMjkou1BfGGyCTdrxl9lu0oH/YxvwTIGGpDGy7aF082IXa+A0P7UVOiW
2Miw8N5L4wE1tFfiQ+UQHXYzapBXQzl6rIPeibd0ruYFyCMhDGRxJBdbSLbnfqU2
PW4mdfaAMkLPdS9G6+cNg+yPGjfWMqJ2IgFe9CABAKKYbWroZT6fjYGa7/ypSQL7
F5SF2dAygxJV2dK+r0arGKwBYlSaVbtYhaJHz5+nIUZQ8IhwyLGxnAgM7xDicQNS
qWiTbehv1V7Qut63bUgE3+pAKlO3SGNV/U7YDHf2fS28EIUu+FE=
=mzhl
-----END PGP SIGNATURE-----

--wctdmjbevz3t7pte--
