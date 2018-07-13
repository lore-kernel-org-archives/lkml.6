Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D51ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707E520873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WPbWim1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707E520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbeGNXFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 19:05:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58148 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbeGNXFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 19:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z4maOZ2CkPOs0t9oFOGIue56CLuSzOq45Dh9+mfZs5k=; b=WPbWim1KbKn3r4nsuyj2SW81V
        01P8waqdCqu4md9z6LPDTr9tndAq5imlkIGeGvvtb8/J1Xqkzb3irg5WDMjXnSo/CNbYGCGF3NASG
        CFch2piICvlY3YQTmbVtfQE1YskXXY5oS9EsmfcCM7JZbK33J5c1BmgAS4dPa70d/ISr8=;
Received: from host86-174-189-173.range86-174.btcentralplus.com ([86.174.189.173] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1feTH6-0006ho-5o; Sat, 14 Jul 2018 22:44:24 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3B0A744008F; Fri, 13 Jul 2018 17:15:54 +0100 (BST)
Date:   Fri, 13 Jul 2018 17:15:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     lgirdwood@gmail.com, m.purski@samsung.com, p.paillet@st.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] regulator: core: fix _regulator_do_disable return value
Message-ID: <20180713161554.GF16228@sirena.org.uk>
References: <20180713125624.13783-1-m.felsch@pengutronix.de>
 <20180713130715.GC16228@sirena.org.uk>
 <20180713154854.qmnraejcdq6gqn3x@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <20180713154854.qmnraejcdq6gqn3x@pengutronix.de>
X-Cookie: Reactor error - core dumped!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 13, 2018 at 05:48:54PM +0200, Marco Felsch wrote:
> On 18-07-13 14:07, Mark Brown wrote:

> > This is fine - consumers shouldn't expect that a disable will cause
> > anything to actually get powered off, constraints or other consumers
> > might mean that the disable doesn't actually happen.  It's just the same
> > as a consumer with an always on flag.

> Okay, I understand that the behaviour should be like the always-on
> contrain. But now the behaviour of the core is like my v1 of
> "Re-Enable support to disable switch regulators". It's like a 'simulated
> off', which wasn't a good solution for you. The difference is, that the
> 'simulated off' is now made in the core.

Right, there's a difference between what the core (which does actually
explicitly turn things on and off) sees and what the consumers (which
only increment and decrement reference counts which may happen to result
in something being turned off immediately but also might not) see.

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltI0DkACgkQJNaLcl1U
h9C8ywf7B5uF/moFNSn3GVXaDhx5OWuQgti3nKcypjL+jmX88cH9qjXixNRGSmS8
76dAopKcdiyowZGPX4sQS+3l601EhtuDoq4iohUQH6BRY7DSq89beV49nAFulx+v
IMZsAxuoT1lNhjImFwFNVklHiFmI/LUL/z4nhsyyuwtX3ldNRQ4lKpU3Lhb8ZjA1
lA/XJO4LFiex+YjtQugDvM1wtaCMCSkC5fkzaRO0ZPf1fk38uFEDn3zBJYaalveD
s1DftTpYmpBCKcMllyMsdOlMfsNvAeyGmthf6vC/mx/5Agougm72jH7Nzknoqhuj
o+bJKq/P8mjPFdHEwOiQXy9r0slgXA==
=BGkR
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
