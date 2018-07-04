Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95617C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D6924248
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D6924248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeGDVyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:54:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:40056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752607AbeGDVyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:54:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2968AE7B;
        Wed,  4 Jul 2018 21:54:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 05 Jul 2018 07:54:38 +1000
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 4/5] kbuild: disable KBUILD_MODNAME when building for mod.a
In-Reply-To: <CAK7LNAS22VUQytcX=BQt48qeAn9Rq00Sb555Gu98J+=8R_3OVA@mail.gmail.com>
References: <152929708853.17463.17302660556961083137.stgit@noble> <152929772052.17463.10728056000221362647.stgit@noble> <CAK7LNAR2n_Kf7HEwWgLwH8sjyVAiJUWkvV7ZAbkNn0KgVTUx1Q@mail.gmail.com> <87efgk0xx7.fsf@notabene.neil.brown.name> <CAK7LNAS22VUQytcX=BQt48qeAn9Rq00Sb555Gu98J+=8R_3OVA@mail.gmail.com>
Message-ID: <87po02zmxt.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Jul 04 2018, Masahiro Yamada wrote:

> 2018-07-04 7:14 GMT+09:00 NeilBrown <neilb@suse.com>:
>>
>> Where I've been using these patches I've sometimes been adding
>>
>>   ccflags-y += -DKBUILD_MODNAME='"FOO"'
>>
>> to Makefiles so that modules_params get handled correctly on non-module
>> builds.  I've thought about instead allowing "modobj-name" to be defined
>> and requiring that it be set if either modobj-[yn] is set.  Then it gets
>> used for the KBUILD_MODNAME when building modobj modules.
>>
>> Would you prefer to always require KBUILD_MODNAME, or to use a default
>> name for dynamic-debug?
>>
>> Thanks,
>> NeilBrown
>
>
> I prefer flat directory structure for modules.
> Most of modules fit in a single directory.

I'd prefer that too in general.
But some modules are bigger than others and some times it helps to
sub-divide a module.
xfs, btrfs, ceph, net/dccp, and lustre all already use multiple
directories despite the poor support, so clearly some developers
like a more structured approach to organizing their code.
Wouldn't it be good to allow them to make full use of the kbuild system?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAls9Qh8ACgkQOeye3VZi
gbnwbBAAukVXTvGp9Ex5BEkDF6fjnH5145HO5ImPrZ220H2P5fX1EmUxnxczah8o
dAA6tqgjRJXnTsK8VtnVIOu/aYqV2m7WS5T5vSQyMMrL32Jf56kO2vQlamCiMLNt
omOQqKDI21g6j3Y0N97ZF9YzXJFqKsZWhCA4Phm8L/a8MvyWOTonvylWUM0gN6ME
hOIlof6+vWj9dlVZAD50xxO6AQ2PrbzIhyeIIgqm7F7icU25ZLb53o3CV8w6d0mk
i1c5gdBLk/STw2dBBJwDKF9y1wZgLF1XryyOn3FjJQ/IKCzJjJAKyA3KKUWCcXSL
pWYI5b6W/qUh3XJ5SwboW6vQnhdfxMj+S5+EXgmnPG6EW/FZdOfZ3xVj9PNF1jTs
iWHdWAGXJVuOX9ot98Brp0z8Gy0Dvw9uFRNwRx16+rXnzd1lLkdNGey6QDqTtnbA
2EcVQxcqyVDp2LO0yIdl+Ye8GKC4HmPZnnfDOA9SqR7VF20C8IOLsSvd5PbCAvZq
CXqN7FDDZPHOk2hSt3sopaEq0o3hWtNzVRdq0WgXg9i97vWHqbwOcOM8P0VcSKs9
2nM5/OYNOY/euo5OqqVostcyKZNdiM5xwEm0+uytlugGHNFkAMXRMzoChxNBEyGc
4rJ78UR1l0H5mdq9ahC0IeX1HoO5G4MJlp6VdlYN+d9KmOoAMx0=
=l4yM
-----END PGP SIGNATURE-----
--=-=-=--
