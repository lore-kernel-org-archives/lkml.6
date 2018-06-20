Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FF3C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA54420872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="l1uYqSCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA54420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbeFTNZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:25:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53306 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeFTNZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vjdPmdgD0XPPag6T4t/1E3lWSsCXTkDH/Jl7ScdBFzM=; b=l1uYqSCueGB3KCQbNHcRlpdV0
        bQtXhkOFC+ekbTVm3JwxKdP9Eb5MpmnkWMLH3rv0DYd/VeUNJ6l5hv3xF0G7G9YVGeCcZizC2QBVO
        4F+wxHe2t8t7Ihh/4eIwOtrohNKBovxtDQKzoX4Rt2WyPEyNrub8XZZoL8h9pC7vVU6ls=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVd6i-0002HV-Nx; Wed, 20 Jun 2018 13:25:08 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVd6h-00082m-SD; Wed, 20 Jun 2018 14:25:07 +0100
Date:   Wed, 20 Jun 2018 14:25:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change
 notification
Message-ID: <20180620132507.GE6242@sirena.org.uk>
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
 <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
 <2523505.Jaak4fIuPm@aspire.rjw.lan>
 <20180620103558.GA6242@sirena.org.uk>
 <CAJZ5v0ju3F7qWxMUDuCyWBzFQGyrmxVo90yytFbKnCmENvRuew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ju3F7qWxMUDuCyWBzFQGyrmxVo90yytFbKnCmENvRuew@mail.gmail.com>
X-Cookie: No directory.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2018 at 02:15:38PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:

> > The flip side of that is that either suspend and resume or poweroff are
> > broken for userspace unless they know about this magic sysfs file which
> > isn't great either.

> But to me that isn't that much different from an RTC wake alarm, say.

> Enabling it to wake up the system in general isn't sufficient, you
> also need to actually set the alarm using a different interface.

It seems more like hardware breakage we're trying to fix than a feature
- it's not like it's adding something we didn't have already (like
setting a time in an alarm where the alarm is an additional thing), more
just trying to execute on an existing user interface successfully.  I
can see that there's a case that it doesn't map very well onto the
standard interfaces so perhaps we have to add something on the side as
the hardware is just too horrible to fit in with the standard interfaces
and we have to do that.

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqVbMACgkQJNaLcl1U
h9A/8wf/edSKCvLJfA8FPCcWaXKtd7YTc71TCr1jz7RBfueoY8ZUUIo4igRRyPuu
uec0o3k/XlxOHFyoEu/BWzRkQlkDAjWB7te8TxEuMmgVsQ2qxh0fZnCzvi7I75an
94HqrYQiMJula4JgZckA6qc0E2lKMGnIdcwcACaHd598CqNU3EXg/3PaO+1xF+rt
oRiBzprQ08xkv3NV9YxYtl63K7s4QctQ4+90WlZv4R1GNTmLCVOU1QvY8dbtTPtn
1vchVgmbdLsNpQ1A54xehaesFfrPTzOWzpkSIrxZAhZC3KX564gRDehiDgRfCANf
apyvr5dp1gK2UstjWXV1VoaRG1p4VA==
=4PTh
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
