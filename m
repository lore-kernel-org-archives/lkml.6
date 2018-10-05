Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE3AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2F020652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tUb2opUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2F020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeJESNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:13:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55386 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbeJESNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7CBKC+VmJsvjSvU3//TMV0eoTl+emmDOBz+Iesn+GRM=; b=tUb2opUQy2GyKidkDJRzq/JI0
        ScquuBmyAFMsVVPPBV2F3lvwVZ7s/ZPs23OW4gjs8tHrjm2S1Lq68AVZAxcnr0d+XUlnCewnVCjv/
        VAopkbxVfslubjT2zd7NKJusMPrN+UPgx1Te4FZ9uxk3j5nhzzriF24lzFlXuLxnIYqfo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g8O4x-0003AI-PG; Fri, 05 Oct 2018 11:15:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 150991121C82; Fri,  5 Oct 2018 12:15:31 +0100 (BST)
Date:   Fri, 5 Oct 2018 12:15:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hartleys@visionengravers.com, mika.westerberg@iki.fi,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Message-ID: <20181005111531.GA6266@sirena.org.uk>
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004103247.GC6412@sirena.org.uk>
 <20181004160432.GA7674@flashbox>
 <CAKwvOd=bZWsgggLMODN0OPSu=c=pQZsREvTtNcUn+arEEVJQjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <CAKwvOd=bZWsgggLMODN0OPSu=c=pQZsREvTtNcUn+arEEVJQjQ@mail.gmail.com>
X-Cookie: We are not a clone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2018 at 09:41:20AM -0700, Nick Desaulniers wrote:
> On Thu, Oct 4, 2018 at 9:04 AM Nathan Chancellor
> > On Thu, Oct 04, 2018 at 11:32:47AM +0100, Mark Brown wrote:

> > > Please remember to CC driver maintainers and authors on patch
> > > submissions so they can review things, copying in Hartley and Mika.

> > Thank you for that, I usually just rely on get_maintainer.pl but I'll be

> If get_maintainer.pl doesn't cc the right person, does that signal
> that the MAINTAINERS file has some omissions?

It can do but there's always cases where it misses people - someone
working very actively on a bit of code for the short term for example.
Especially with drivers if you're only seeing subsystem maintainers then
it's worth checking.  The --git option helps a lot here.

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu3R9AACgkQJNaLcl1U
h9AHIQf9GFVHGPHQ7YZFhuWEKEWwg69MTbUwi1B9Rcct/3SJv1FTD5NQ6REoKl4Y
1zKO0GtixckrgUjZ4sBLNF6rz6p9ukgoUA0J5OSzS1zxsCp3F1I1waP/4NU4LYFR
htTf2/5n11eImDo69ZHZTxm+BjrWheOO8LQNxN1JOLHjQOqjZYPVzFVgz6mb3GlM
zTm3pgwAc+xcFUV+VLTuNysGCdmVP6pVGJwmiel2VtG0YN9kSColHjnGEJJ6518Y
7p+SUu0CVIP0lvtsPu+0lpl5QsjwSdY+S1Hzkv1+DlSkJsAHsxnij+5OSeUysBdp
U2OTdae3TSHqmEZrCAbObl4yFqP++Q==
=16fG
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
