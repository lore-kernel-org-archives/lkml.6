Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C5C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2194F20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kT7pn5ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2194F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbeGSONY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:13:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55046 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbeGSONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MkK4pznakyWXY9Owr/A3QCNbsuzG51B9EZWb0m2IIIM=; b=kT7pn5agPW73brrdyPTKSWnCr
        ISAx5fTQPXfJirP1e12NuxJbkuwCRR+lL0fHlIdkz098TlZrWMBZnTN6SzDLfYC7sQXY70pSI9EvG
        tcZkbLF8wA+YfhpTX8E5qx6e1ALbOtr+hvyI5CksWXxupNo2eUC/dOSapf0pjJuW38fhI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fg90P-000701-GQ; Thu, 19 Jul 2018 13:30:05 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fg90O-0007T9-Kp; Thu, 19 Jul 2018 14:30:04 +0100
Date:   Thu, 19 Jul 2018 14:30:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Milan Broz <gmazyland@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 4/5] crypto: Add IV generation templates
Message-ID: <20180719133004.GB27938@sirena.org.uk>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <1531899055-29362-5-git-send-email-wangxiongfeng2@huawei.com>
 <b6eaf471-7279-ca4f-bb7c-d25df8db2419@gmail.com>
 <20180718164625.GA20360@sirena.org.uk>
 <82248c13-42fe-b598-0cd7-68e5db0b51be@gmail.com>
 <cda1d3de-3f21-2dfc-0423-c1cf456838b4@huawei.com>
 <CAK8P3a2oubqRKg1tnoG6CsmUs-U5Ab6q5rwpfg08PRNJLhEjEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2oubqRKg1tnoG6CsmUs-U5Ab6q5rwpfg08PRNJLhEjEw@mail.gmail.com>
X-Cookie: I'm having an emotional outburst!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19, 2018 at 10:50:12AM +0200, Arnd Bergmann wrote:

> There seems to be some support for at least essiv(aes) in
> drivers/crypto/ccree/cc_cipher.c, is that compatible with your essiv(*)
> template, or is that something else?

Yes, that is in fact a driver for one of the pieces of hardware that
was one of the prompts to do this work.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltQklsACgkQJNaLcl1U
h9DKogf9FafVKu2CEVULfjn/Tjw2Po/LC5FSUNn2BywvQ6HZ/i9qFnVLLXQqxZgd
3FwGgBKTWr7wQt3SyB4PifBGVUdHWaCVEPxaITgdmfKaUihuXfDrTt7BOSn3K0xQ
2RDPZW7+3M4/S/brNpAd9MuxT7BzXD8YSMal5RyuCvJwcSXhvBhe+RApKDew21sm
L7pKZ9Tf/qFujYDq6RLMu8bSbxftuT65hABDp5/lS8p8dJCWo1OrVmhwqtjjf1BA
o5Bxig7tCwdQBtqiOtpJa04UadA51uUvsxbyDFx9e/Otd3ndsO3V63ZqYoFnVd1x
lvBYFv+FptHA6bpX7j6AGAUFgvz9aQ==
=rdnV
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
