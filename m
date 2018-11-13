Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D09EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22852082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OL0ba4W7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22852082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbeKNJQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:16:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5VfuggXMmDOtXMJwdTIOGpp5vVtx2OtZZvrZvCjNQzQ=; b=OL0ba4W70EcSJKsu3oNbRIT0q
        cJhwCDRtwuuYi85l6wSp0LPquD7m5umyEvXDnwApFjbekJRbgfOgRZk5zsuK6fMyTJwjBScg9/kkc
        jsxTa4AK/Y0yGMpGsmPzxq1crPRZPbydyieP4MO+Wv5E33NOOM1h0KoCUCRv6RtPKgiCU=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMhuK-0002kF-0O; Tue, 13 Nov 2018 23:15:44 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EAA31440078; Tue, 13 Nov 2018 23:15:37 +0000 (GMT)
Date:   Tue, 13 Nov 2018 15:15:37 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>, acme@redhat.com,
        frederic@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
Message-ID: <20181113231537.GR2089@sirena.org.uk>
References: <20181107171010.421878737@linutronix.de>
 <20181107124855.328133e7@lwn.net>
 <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
 <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
 <20181108074920.4c601ee3@lwn.net>
 <20181108150517.GV9761@hirez.programming.kicks-ass.net>
 <20181108162133.GC1080@thunk.org>
 <20181108163223.GH6675@sirena.org.uk>
 <CAPcyv4h1ABBz7OaZB5d--fjtwvfrM=TZs7XFCG54PYRm_Fr8WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nHJAUhyIZkPvF01C"
Content-Disposition: inline
In-Reply-To: <CAPcyv4h1ABBz7OaZB5d--fjtwvfrM=TZs7XFCG54PYRm_Fr8WQ@mail.gmail.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nHJAUhyIZkPvF01C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2018 at 09:32:18AM -0800, Dan Williams wrote:
> On Thu, Nov 8, 2018 at 8:32 AM Mark Brown <broonie@kernel.org> wrote:

> > I'm not 100% sure that people will pick up that the topic is about a
> > handbook for working with maintainers rather than a handbook for being a
> > maintainer from that title...

> The intent is a handbook for being a maintainer. However, in the
> process of describing how a given sub-system is maintained one also
> needs to describe the local rules. So contributors should be able to
> glean what matters to a sub-system from a description of how that
> sub-system is maintained. In other words the direct audience is
> maintainers, but it also hopefully makes the process more transparent
> for contributors.

To me that sounds like a document aimed at contributors rather than
maintainers.

--nHJAUhyIZkPvF01C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrWxgACgkQJNaLcl1U
h9CVtQf+NJ3R8Z+2crtzJgNCWc01DnKrsAnPPJRHqdmeaCysVTFPRaoQvGjc+4A7
LqKdRa2tMvEChUEAdWYfvRyVsf/ueqKPIcd96XniOA9OVhbww+JDR444zTcULEEX
M6V09WDsqLC4eJoFO8uVtg7T91Ni/A6olPtUiozjXBfV5bnQ3J6gOqsv8IQXRqbd
XZEX4SqolgOiMcozVdg84OXEioq0cVvD7x9T5kHd27uccXtZauxBwItdqZb+ZQTr
U8yKFQLZbIfSMnLwMtgoGDugAsNm45056k4mMZMAlX4H8OmSZv1RZoQzkj46bWYO
YzTbPI8KgJZRXsa6bvpd0oGMdhFZEA==
=A0xH
-----END PGP SIGNATURE-----

--nHJAUhyIZkPvF01C--
