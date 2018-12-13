Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE0DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C622D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544718111;
	bh=c/j66IG/dT41g4E31OoZrCGY8G7Q1R97z6/EfNmw3d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J+JogHgFXLrMqBxIhRYDEPqMwwfag02Re/0/H9qS9TDGQe11oH/7QPFFOwZyJJsvz
	 Eem+GocEV6NPP5oCkZR9IC0WL4EfkkqID8aXHkoVR28sxBRN4124NlPH+DNG7JNNVo
	 uXpxe1uat1gzVhMTFudMhVdftB/bhyFUB/FVNaII=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C622D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbeLMQVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:21:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1ZPyUi+NucTkUmx5MvjHpi6IlZV+xVgDeYM4R4Ictdo=; b=Rr4WWjlgkn1w8MTqQ/Em/Fp27
        ZSxWWEBhl7i+BbJrHhux/uArMuCno/gmJyjz2pXdaCrBuytw/B8gSEG91BynaFt/uwKcXva7dyaou
        oewlXjj+BAhQFQI9atxGKOjy+VlA9Mt25WTUUrwCcJxDZbyrLnoKkoko8a3/m0K3T011M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXTk6-0001s6-6J; Thu, 13 Dec 2018 16:21:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C5D4711254D1; Thu, 13 Dec 2018 16:21:41 +0000 (GMT)
Date:   Thu, 13 Dec 2018 16:21:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Cristian.Birsan@microchip.com,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andr3i.stefanescu@gmail.com
Subject: Re: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Message-ID: <20181213162141.GQ10669@sirena.org.uk>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
 <20181211164706.GL6686@sirena.org.uk>
 <6a35df06-1309-f069-9b22-8c2cc5cca56e@microchip.com>
 <20181212155502.GD6920@sirena.org.uk>
 <2f24d81a-5271-6ea7-32a2-bc2e708521fa@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KHqYxKoy+XnO4RVf"
Content-Disposition: inline
In-Reply-To: <2f24d81a-5271-6ea7-32a2-bc2e708521fa@microchip.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KHqYxKoy+XnO4RVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2018 at 12:19:16PM +0000, Andrei.Stefanescu@microchip.com wrote:

> I tried with both suspend_late/resume_early and suspend_noirq/resume_noirq.
> Everything seems to work ok.

> Which one do you think is more appropriate? I am guessing that during
> suspend_late some devices may still need to be turned on and that it would
> be the safest during suspend_noirq.

I agree, noirq is going to be the safest option.  Can you respin with
that please?

--KHqYxKoy+XnO4RVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwShxUACgkQJNaLcl1U
h9C/zwf/Q9S+epb2YtPqpjlyCkUDkJehQHR8TCNGVpUBk2xmCbAb2Fl9ggO3wMFA
l7rsBe74p6O9e3j0eKXlCXhK/t+PwgLYDnF5s8a9mTRtCxJ5o36xQ2HaNd9RiONu
gglSeDYP2j9GSvwj5phIBYSe2YlhIm616SHLOTMx8GMZCwtU1Vf0HxO5itpelnuM
3EJOd/jE31Jzmjsmd2c0hneaAReu8S8NaC28wX8gRPtF7nVFyVHxKhGlWTRCWxWr
tTpfIMyuN2RPdWRYM0HbLH1qfFpfdDHHe/vQbF8H8Euw/RWFIciEprNfWuoN4en4
PiX/rGxZYtRyD1/3Sk96iufnjs74XA==
=9cSY
-----END PGP SIGNATURE-----

--KHqYxKoy+XnO4RVf--
