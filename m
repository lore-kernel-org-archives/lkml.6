Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,UPPERCASE_50_75,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09955C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BD820844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ASmNm8+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BD820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbeGaSrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:47:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54470 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeGaSrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IcZJ0CDLQ6LRWs+nBmBDcw4bwX46BsNRBqRZCclzrVc=; b=ASmNm8+QahrL6Le4Lv2l4uLQF
        6N2UTXunL+jSFauLq+p2v9cXjTxNtchMFO5WqLeXMmUVccvl2qs5lxA/8JKlCqVORZRzGKJ4ZEOg0
        vXMWb0191viObrPE/ZwhX+6NQyqZa0KU7uD07AT6VqHYaF5YnNayNe2PETqwiwZLfJ6S8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkY5t-0008Lr-Tv; Tue, 31 Jul 2018 17:05:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4BD3711242BD; Tue, 31 Jul 2018 18:05:57 +0100 (BST)
Date:   Tue, 31 Jul 2018 18:05:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 05/10] ASoC: wcd9335: add CLASS-H Controller support
Message-ID: <20180731170557.GK5719@sirena.org.uk>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-6-srinivas.kandagatla@linaro.org>
X-Cookie: Save the bales!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 01:18:01PM +0100, Srinivas Kandagatla wrote:

> +	res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_0KOHM;
> +	switch (mode) {
> +	case CLS_H_NORMAL:
> +		res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_50KOHM;
> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
> +		gain = DAC_GAIN_0DB;
> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
> +		break;
> +	case CLS_AB:
> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
> +		gain = DAC_GAIN_0DB;
> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
> +		break;
> +	case CLS_H_HIFI:
> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_UHQA;
> +		gain = DAC_GAIN_M0P2DB;
> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
> +		break;
> +	case CLS_H_LP:
> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_LP;
> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_30MA;
> +		break;
> +	};

This is missing a default case for error checking, and you don't need
the semicolon at the end either.

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltglvQACgkQJNaLcl1U
h9DxCgf+MkCcuHxQonSpd9ITGrqpFrCSDOBZjOOepXTvj/tXAGLT9gfM3c/wNTNs
/j2LdASeN5XbRupEgD3WgxRQ3moXq3bwtqeFizFhz8UH1Bq612cVMbqmLNKvpDRw
uEws8494YPyxyXpEz2GgflOXiB5yUs9lSHaGJACZZU9M9BrR3wyeyBRO+1hw2Fk9
ugRL9wmNTz2pNimXaZ9qQSjZ5uaUJphoUuahXdNy+nhIWeESHskVR24vcZEyRiNr
gGOk1miiOwE2M0TO+MY1TuxoXLRQzZ7yDzuERvONQ7+RIy+iZnbFNwKO1+eP0Zzy
/kgca7nvIU19ro8aMU9+MI5WzV04iw==
=R8QF
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--
