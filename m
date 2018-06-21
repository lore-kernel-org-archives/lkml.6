Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4974C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F962254B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="o/2Vql15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F962254B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbeFUXeq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:34:46 -0400
Received: from ozlabs.org ([203.11.71.1]:59583 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932686AbeFUXeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:34:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41BdMk28SLz9s4V;
        Fri, 22 Jun 2018 09:34:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529624082;
        bh=jhABNufG27D6r5hawukYpGbiBTxK1qvFykgEYYjKgd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o/2Vql150WvvgIJR+ERxdeV5HLSje4UjaGDELVrcAq/BB9bULEo1G3KL5nIoVAACD
         HzRt4LmLu/rg3zIAyf8y9RMZS/MwDEWAScHPwTY9QoD3wKHJDbRkuCoM8dhBSN0ImI
         EBmayuz4QaQcO31pMlxElMoOzxS9nhjrP+WqvYPJFE99PW5wAB4SAmKwW4cXKsDW3M
         zi1VgVQnZdeJ1fP23NFnkpYrE9ClN1N82SFXvh3au/NdE7S5KDRQ14FpOO7iY7fPDJ
         g/gkimP5FWxE4RCZKyYATt52WKDOrv9WQLeilCd8PFJqHvQkWMglgKzLeNNoBc+TNA
         lS6etUMjhaT0w==
Date:   Fri, 22 Jun 2018 09:34:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@gmail.com>,
        Mathieu Malaterre <malat@debian.org>, <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memblock: add missing include <linux/bootmem.h>
Message-ID: <20180622093421.6b060710@canb.auug.org.au>
In-Reply-To: <20180621180638.ahxpgzwrztopve55@pburton-laptop>
References: <20180606194144.16990-1-malat@debian.org>
        <CA+8MBbKj4A5kh=hE0vcadzD+=cEAFY7OCWFCzvubu6cWULCJ0A@mail.gmail.com>
        <20180615121716.37fb93385825b0b2f59240cc@linux-foundation.org>
        <20180621180638.ahxpgzwrztopve55@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WC=h_N3UJqTfkjWbdcO478n"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WC=h_N3UJqTfkjWbdcO478n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Thu, 21 Jun 2018 11:06:38 -0700 Paul Burton <paul.burton@mips.com> wrote:
>
> I was expecting to see the original commit, then the revert, then
> perhaps a re-application of it but instead it looks like the commits
> from master are missing entirely after 25cf23d7a957 ("mm/memblock: print
> memblock_remove"). Maybe I'm missing something about the way the merges
> for linux-next are done..?

Andrew produces his mmotm quilt series and exports it to ozlabs.org
from where I fetch it and create the akpm-current and akpm branches in
linux-next (and merge them, obviously :-)).  The mmotm quilt series has
not changed since Jun 15, I assume Andrew is still finalising it.

> In any case, could we get the problematic patch removed from linux-next?

I have removed it from my copy of mmotm for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/WC=h_N3UJqTfkjWbdcO478n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlssNf0ACgkQAVBC80lX
0GwqnQgAlpelxvvi6Yhl4qtdIeKBlovkV5kAuzpaae6QMIv0SQi/aiu8PhM8HfRY
pZrhXMQl281ZpfKW9pfECeyFbBSXMLrQmlBw2rtFHbIJy25t+AdrToPPDSIiqnWJ
JJ6kPJxLzaJ8j4NGL1qdbOh5R3Ast4z1+SxspWAa80aXbZxAokbtuBln5pcLvKWG
RpigTqwdlugHIPWYhRixQC3jqc1YbDt3uNq/pvimTNo5y5Aks57oA2dkCLPKTAfi
qXhx+67AvvUenF6ajZ51pM8f4agmksmAUg3e2dL0J3xvsLjTJbl/5BQKHj32LZpo
VD9hM1JFqNvAja/EiAJ3xwD2E2V4KQ==
=NXVc
-----END PGP SIGNATURE-----

--Sig_/WC=h_N3UJqTfkjWbdcO478n--
