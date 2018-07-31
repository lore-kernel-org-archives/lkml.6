Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760EFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2932A20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IUFtO+K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2932A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbeGaS6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:58:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeGaS6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m2NsakjDFLNnEMXqOiv349r4kgMt8GLdJYu9Vj2hSoM=; b=IUFtO+K0RpqTQURKCnNeNpKjR
        hm+rJTnfbT+zkMbXthV4DxQ+rWYxgmavum1A6s8VtOtUtIxQrWFJxrrGNeACdoimBQJTagwZ3n+SD
        4Y2aFaCjE1k8i1ed9szsVhXGTiqRXReZ6l1/mHFixAaYM3OAPMIpofYiCT8CGOG5QPepc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkYGV-0008MP-Bl; Tue, 31 Jul 2018 17:16:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 06BCE11242BD; Tue, 31 Jul 2018 18:16:55 +0100 (BST)
Date:   Tue, 31 Jul 2018 18:16:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 06/10] ASoC: wcd9335: add basic controls
Message-ID: <20180731171654.GL5719@sirena.org.uk>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hTKW8p8tUZ/8vLMe"
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-7-srinivas.kandagatla@linaro.org>
X-Cookie: Save the bales!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hTKW8p8tUZ/8vLMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 01:18:02PM +0100, Srinivas Kandagatla wrote:

> +static const char * const wcd9335_ear_pa_gain_text[] = {
> +	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
> +	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
> +};

This is fairly clearly a volume control so shouldn't be an enum.  I
don't think we have a standard control that enables you to skip values
in a regular volume control (we do for enums which you should've used
rather than having the undefined entry) so you'd have to have custom get
and put operators but that's better than abusing an enum.

> +static const char * const rx_hph_mode_mux_text[] = {
> +	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
> +};

Use a SOC_VALUE_ENUM to hide the invalid option from users.

> +	wcd->comp_enabled[comp] = value;
> +	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
> +		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;

Just write normal if statements unless there's a reason not to, it's
easier to read.

--hTKW8p8tUZ/8vLMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgmYYACgkQJNaLcl1U
h9Adxgf+MFHKxg2WF8v6N+AeOWmjQ3J0XB/mq1WgTIgaPnJwCEbIPpDUhpq4DGdW
LDcrzKwVlNkeoGkubTMFqlDEGU37VKRNLKHZ5iydaNdVdnkN0AGmoY/70wfYA9Av
WN8I5pN+v5r1AlorDMLn/XwivKMOp2ekAhDYR7IC3bctHnG6yl8n/AxBCRH0vAhq
fQVg3GT4Ezd6X3GQJaFg12TLIBk5NfCJnjTD0i4M4g8oSsOywWnfaaYZ8TBhIx3g
DTX80aK69lqEDYB0tP/gW4Sqr5Hz1JmkPXG17YND/BvDBWUlFp3HunKy4m3Z+yWH
8rNVq0I2fbE2AZCNeaYb1Ck0ObH6GA==
=UnyX
-----END PGP SIGNATURE-----

--hTKW8p8tUZ/8vLMe--
