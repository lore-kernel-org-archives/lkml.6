Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088BAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A774220BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ms6JUH2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A774220BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeGLKe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:34:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57096 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeGLKe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gb9EqTq6/vuwDMs0sCYxaKM3vjF8RDxpUaV0hxObpqU=; b=ms6JUH2LIYzimTu5NBjVZFjyJ
        wbWwtqZPeLK+WGVxEb7VBc+0OClbaVzyaNu+6qYY7sa7+IGgTUV2NwqB6al7ZlytTAS43VUtHgZTZ
        w26xJWOeIBkcguz27rbe9D5/+dbNQA28XryD5C3xGOs9cmnKlGBbUAa/VnAXo/tK+m+5Q=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdYmv-0003gU-HX; Thu, 12 Jul 2018 10:25:29 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdYmv-000609-13; Thu, 12 Jul 2018 11:25:29 +0100
Date:   Thu, 12 Jul 2018 11:25:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        pascal paillet <p.paillet@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] base: core: Remove WARN_ON from link dependencies check
Message-ID: <20180712102529.GB10369@sirena.org.uk>
References: <20180712080623.21203-1-benjamin.gaignard@st.com>
 <20180712085501.GA25313@kroah.com>
 <CA+M3ks5nj2gfc+ePYg1y2w3P0cW861YkRqpuHh49n+noktPVUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <CA+M3ks5nj2gfc+ePYg1y2w3P0cW861YkRqpuHh49n+noktPVUQ@mail.gmail.com>
X-Cookie: Kleeneness is next to Godelness.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2018 at 11:18:26AM +0200, Benjamin Gaignard wrote:
> 2018-07-12 10:55 GMT+02:00 Greg KH <gregkh@linuxfoundation.org>:

> > Why would a link already exist that is asked to be created again?  What
> > code path causes this?

> It could happen that the link exist because a device use it parent as supplier.
> That case has been describe by Marek in this thread (I forgot to add
> it in the commit message, sorry):
> https://lkml.org/lkml/2018/7/9/356

If we don't remove the warning then we'd need to have some way for
generic code to check if a link that it wants to create exists already
since if more than one thing adds links there's always a chance that two
of them will come up with the same idea for a link.  We could export
device_is_dependent() and have them check that, or add a new flag that
skips the check for example.  This is however probably going to affect a
reasonable percentage of potential users.

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltHLJgACgkQJNaLcl1U
h9C01Qf/Yo8mNsWOqLp3z3EqeLhbvMwTrMpea8unVff9E7aS/LrnUPVLxIiW8X5O
znojR6MJEZESFT/yTUlzjEvEMP+XQPEixtj+4aSRfrGqhOA9s8nsQaTqsJdE4nqV
BRJtJ/lSX62yu01wBhvbi8jMjYPmAc4zPKMXCZ74vmcpZ1pUFGhFCJUMvPKdHY3W
QVlRGygDQvFzVTpa4CqJ8TVuiSGCxwP2YXWpVQ2iDTe3591yJasARhuGThMPFv+k
jhgIQPhWyL/pPYcfkTaWFSGYNBVjB7F4si+8SRUqfJC37cyJn3xKtpOJftxQTWe8
uUnAMJ7rJiqdShqN8ucv33SCvlC+rQ==
=SpG8
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
