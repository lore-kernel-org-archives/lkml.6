Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4981FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93E620821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Eb5/Zwmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93E620821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeLJWJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:09:44 -0500
Received: from ozlabs.org ([203.11.71.1]:39283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbeLJWJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:09:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DHLF3sD3z9s3Z;
        Tue, 11 Dec 2018 09:09:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544479781;
        bh=XzA18pdIAdb0cc3iJwAthSUgx28hH2Ns53Q++J4zrTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eb5/ZwmqR1a73VRVKnxzWP0QZdc2CE+1eGmCa2ySI7libuCsMwKVjCOMlLCGLSBpS
         rnfqDZdkmQJhpvenWGa4I039GMwuurjCQXzuXFOUdTwM/Bum13WjU+oM6NjQrIm2Xi
         0ROu5HVT+GJ59j9Bf0ym1IFpCu625VevZFgK5WicXiPDFbXEFV0mlS5JA9jydWN1kw
         3HbL8zv1hbnTgI0Og2CGvkELpoy4ibr+0KjiWyRLa3eZuofttHOQd/RmJOeiJocPkd
         pVWwGcUcpaP7uRC3wMk76TuFKRWuHDZ5qiMWg0cnuzP/yhZCoWwHke8nuO9b0mYFHW
         sZgZbP4537D2Q==
Date:   Tue, 11 Dec 2018 09:09:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, gor@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kasan: add missing Kconfig dependencies
Message-ID: <20181211090941.4d856d92@canb.auug.org.au>
In-Reply-To: <CAAeHK+y_ySWM7NLsAvX7UzeBjYdofQHGgG_xbOMwX_pVsQJJKA@mail.gmail.com>
References: <20181210205929.3213516-1-arnd@arndb.de>
        <CAAeHK+y_ySWM7NLsAvX7UzeBjYdofQHGgG_xbOMwX_pVsQJJKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+VxqKKdl0v=Ct.yAgfI3DPC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+VxqKKdl0v=Ct.yAgfI3DPC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

On Mon, 10 Dec 2018 22:14:57 +0100 Andrey Konovalov <andreyknvl@google.com>=
 wrote:
>
> Is this a patch against linux-next? The issue has been addressed by
> v13 of the patchset, which is now in the mm tree and should end up in
> the linux-next soon AFAIU.

It may be in the mmots series, but it is not (yet) in the mmotm series
and so won't appear in linux-next today (unless Andrew updates mmotm
soon).

--=20
Cheers,
Stephen Rothwell

--Sig_/+VxqKKdl0v=Ct.yAgfI3DPC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwO5CUACgkQAVBC80lX
0GyvCQf9HpyylRArfGcUnzd+U8MLe/Uk1m+C2zu7XtGby/Wj9eSkPXHzpTiO9IZm
LLVKjS1JOCKxigTtZRDX/ka/4P84dSTJB4m97Pm7Xle005SVDiK7nfdV0kXq6nMg
DmXBI0jSeOZcrdobi0v0q0RAZRQ6JdZrdbinH37bakVgSny1SVk+ssgmc40L/zJF
3jOgrMZGQewvKdbEKFIjmmKZ4ZRhACAaSWrdxuM2HcEpF5/0UO8kfmc9GzqpYaQs
c5uQgoSx5w+ozniGV4FcyrJ/FRDWThRpQLIU1LkpRLNQ4wOyBB1Nd83fQcHNyWJs
6+nX1iG87U6GOknRrYcjbCSMyBg8IA==
=gN+w
-----END PGP SIGNATURE-----

--Sig_/+VxqKKdl0v=Ct.yAgfI3DPC--
