Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BBBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BB420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="GU0xCc7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BB420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbeGXMMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:12:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44288 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388308AbeGXMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lpxmNjuxya1iKPYA56mlRfufSyBXWg6ZYzE2nufeo20=; b=GU0xCc7U3G4+A8yXi5fFqUyuy
        IEI5QHq0zDAc6ENEeWGtYz2UKx2ztppt7x+YlSN8STs6IC6w/siMPEHV9A5cUDc3y0A/wDyzFJmL4
        3fgTUGRu79/U7FXZWIREqhaXeLk67iNhjCVCJ+3/SBt5fRFVOY6Rz4eL81BTyGHjZYAzc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhv8k-0005J1-Ow; Tue, 24 Jul 2018 11:06:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2D97C440078; Tue, 24 Jul 2018 12:06:02 +0100 (BST)
Date:   Tue, 24 Jul 2018 12:06:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 04/12] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
Message-ID: <20180724110602.GA2414@sirena.org.uk>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20180723155410.9494-5-srinivas.kandagatla@linaro.org>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2018 at 04:54:02PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
> and I2S/I2C interface.

...

> +Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
> +It supports both I2S/I2C and SLIMbus audio interfaces.

This is a standalone audio CODEC but it also has a MFD binding?  I'd
have just expected a single binding for a single device.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXCBkACgkQJNaLcl1U
h9DjUQgAhEc7q7FN5HJ0PcoeN33FJ2gHFVad+B5osDVH7AtT2KJYhuyKyooPmCKf
G7AoBrcpFbPac9r0AkPW6EwwjEbNKHKUuZplf+vTX9dpBceUivyjDMXS3oykxt00
EauORHigaj8nADXX/dq8uRuMn5Tv5NGJNfSzWJsw9FPJRsVKzduaT7wbTLiPAbeO
37hN9sO58B1OFPVkQHInWOlhzCsNMFlvtRBR2EDmegxqb4DolDllJza1u+nwWHIm
2hbHe+VgPvy/9LRZ2T2G0kdETrY/oI2L/noucOlLqWbCftHn0b99CY1DkcsYsh8j
sdwGSE68wbIh8lw3V9zA3+brtjpWuA==
=opx9
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
