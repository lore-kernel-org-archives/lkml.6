Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0A9C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05E120652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FvuNYnr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05E120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeJKVN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:13:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42298 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9G+Eyo7zQvZlsHZ1xpO/mwWllSioeAheCPATCBduf8c=; b=FvuNYnr/75Sm5/VOp4M2kvw14
        DK1oSu/ZiMjAzkSiToTbStDShwzPUhNB2RJfCRsgLwHkx30bM0BVumlqA0/uV6YTNtE1amqXh6wrK
        7DQzLKHmUl94N4YIX+ltp/vxiWqQWE+aTeRSUq76QwHJUIlBws6komvuacCUNWJPTBB1Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAbIS-0001gi-Hv; Thu, 11 Oct 2018 13:46:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4E8E211223ED; Thu, 11 Oct 2018 14:46:36 +0100 (BST)
Date:   Thu, 11 Oct 2018 14:46:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "talel@amazon.com" <talel@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "barakw@amazon.com" <barakw@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Message-ID: <20181011134636.GC25351@sirena.org.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <1539210111.1944.31.camel@impinj.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <1539210111.1944.31.camel@impinj.com>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 10:21:51PM +0000, Trent Piepho wrote:

> So that's the problem!  I, like everyone else I suspect, switched to
> using GPIO chip selects with this driver because of this.  I narrowed

That's generally a good idea.

> it down to a CS de-assert when the bus switched from TX to RX, which of
> course makes a SPI register read fail on most devices.  The TX FIFO
> would empty at this point, so that would explain it.

> Did the designers of this IP ever read a SPI device datasheet???

> Got to agree with Mark Brown, why would anyone ever want to NOT have it
> work properly?  The previous behavior is not "alternate correct", it's
> Broken.

This isn't even that unusual an innovation for hardware to have, for
some reason automatic chip select management is *really* popular and
rarely helpful.  It's far from the most entertaining thing I've seen
hardware do.

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu/VDsACgkQJNaLcl1U
h9ABMAf+LpTg0hfmKHD8PJyE/3o5CLdISGYbgbh/3uyhir7nDoi1nZz4BEferKLN
VGI3KRpgRAHm784pLf+YC7aBMb/xmPEfsI3F22xz4+3leFd6Oj/gix9fJXak9Fxv
jmzHPPqMu2VlN3jW0jJXX+SnmIQXtjEQx5IrFVJAkO9BjtUYEhLu2Pj1ra998XAF
k2GHIq4lNwLvYA79HaXSk3fQnc9asagNhdjOVFcqDZ/FkAPdajynB6jrmZp/nEOV
ip4TmDodXwHGJbOgiLd7aSlUDwyQzJbtwnwyLbAGMVH/dbXUrPPDXFQriW9BHDFV
OdLIoq8jBQ74bJD0ypcjPZ1LSzZ4/w==
=Nr+X
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
