Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB863ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963272075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oxdh+Soe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbeGRS0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:26:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48154 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbeGRS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7TbVlsQamTYkxHMvYsMyk13grD9wAqAb0kNgvbFkptE=; b=oxdh+SoeT+o5rkYVno0zGOsLt
        5dZP0q+hXdFDoZdpgTVf7F3CuGPn2AY6ihiRy3oodDteEzfsEriB+Qac8685t2a7ynbzKzXw+aYBY
        cY+n5E21V4afl+7NIzU55wBYJPOxReFM6qKSYz0smSMk62JNJXl2QV9CBRxnFwqtq7D9A=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffqYE-00041B-4S; Wed, 18 Jul 2018 17:47:46 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffqYD-00010i-HG; Wed, 18 Jul 2018 18:47:45 +0100
Date:   Wed, 18 Jul 2018 18:47:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, agk@redhat.com,
        snitzer@redhat.com, herbert@gondor.apana.org.au,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        jonathan.cameron@huawei.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 4/5] crypto: Add IV generation templates
Message-ID: <20180718174745.GC20360@sirena.org.uk>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <1531899055-29362-5-git-send-email-wangxiongfeng2@huawei.com>
 <b6eaf471-7279-ca4f-bb7c-d25df8db2419@gmail.com>
 <20180718164625.GA20360@sirena.org.uk>
 <82248c13-42fe-b598-0cd7-68e5db0b51be@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <82248c13-42fe-b598-0cd7-68e5db0b51be@gmail.com>
X-Cookie: Marriage, n.:
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2018 at 07:17:45PM +0200, Milan Broz wrote:

> I think the last iteration was this patch
> https://lore.kernel.org/lkml/1498106510-19793-2-git-send-email-binoy.jayan@linaro.org/

Thanks!  I'd got v5 but v6 went AWOL for some reason :(

> 2) If the reason is performance, please provide numbers with the patch.
> What I see now is that the performance is almost the same. So why you are doing it?
> Any real hw that benefits from it?

The main focus was performance with accelerators, currently we can't use
ESSIV acceleration which is implemented by some hardware.  Xiongfeng, we
probably need to discuss offline before sharing any actual numbers for
the hardware accelerated case since people can be sensitive about how
those are shared.  Software only benchmarks are only really relevant in
showing that this won't harm existing users.

Some of the relevant systems are somewhat CPU constrained so even if the
I/O performance remains fairly consistent with the accelerators in play
it can still be a win if it frees up a useful amount of CPU for other
purposes.  That'd mean CPU usage is probably interesting to benchmark
also though I don't know that the systems Xiongfeng has access to are
particularly good models there.

> I added 4k sector support in dmcrypt and IMO this helps much more than
> some hw IV accelerations (AFAIK is is already used in some mainframe
> accelerators this way because of performance).

Right, that does help too (and an out of tree variation of this was one
of the original sources of this work).

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPfUAACgkQJNaLcl1U
h9B8qgf+LfQM8Qe1bjGgClEG98e6vLvtPzUtMpCCpORZ79FiFTdVXzv+Bw0lhg2F
OrNDPjeY0tFbjUqr4LcwVFMFgt/wdfiiwqDB9Kho5SinTHSjS+fagqEA5hgFCLOF
7gKLxNbfK029N9sjcxq991bE58pLbXsV1GZrhO/KE3laja5uvY+lyb9EoNCU3/L0
d2L1GdJ9dm3Kue8uFNuAfnWEekBrUa2oyxV1JCFAD9AhDADXeXkpxtWH3RZMru8P
mU+hHoYtOZ/AZOfWMn1sM2N6mjuGfWJWBNuWpc21PxAj7IyJJ7hEEeoXEshhC/OE
hFdYPmNkjcsBO8tcM7IS1Yr788xbXg==
=z8lU
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
