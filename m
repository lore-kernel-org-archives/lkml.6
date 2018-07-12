Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF406C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FB32147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vhNQQRm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FB32147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbeGLQ1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:27:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54974 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeGLQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F4/vIbGvf448O3+o8PZnmFNU+LxaMxMKgRz1iHO53mg=; b=vhNQQRm2fojAHljFAaNuQeAFx
        c7vF+GxmyPI0LIWggZ720rkvDGLXMmMiR3dQrL/kr4gLTYXlCr/uokpnTnP1o8O76vl1+gfirvrSN
        0fiutOoc3wYV2hXBhKPKYzn7zcZrhbZeS4Hk6metjdYPLtTxzTOf7ZP+bu5Gsi+axnSTQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdeHZ-0003ob-En; Thu, 12 Jul 2018 16:17:29 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdeHY-0007XS-7T; Thu, 12 Jul 2018 17:17:28 +0100
Date:   Thu, 12 Jul 2018 17:17:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org, vkoul@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: core: add support to card
 re-bind/unbind using component framework
Message-ID: <20180712161728.GH10369@sirena.org.uk>
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <68715fbc-9447-dfaf-3fe5-4200684c2cbc@linux.intel.com>
 <s5hsh4o8nq1.wl-tiwai@suse.de>
 <0f437d5d-5857-a608-8d8f-345c832a0ee1@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Content-Disposition: inline
In-Reply-To: <0f437d5d-5857-a608-8d8f-345c832a0ee1@linux.intel.com>
X-Cookie: Kleeneness is next to Godelness.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2018 at 10:54:05AM -0500, Pierre-Louis Bossart wrote:
> On 7/12/18 10:42 AM, Takashi Iwai wrote:

> > It's basically similar as the hotplug like USB, so I thought it would
> > work as is.

> Such transitions would probably not break userspace but they result from an
> explicit user action. The DSP going off and back is less clear, you might
> want the system to wait before triggering re-routing to different outputs,
> etc.

> Again I wasn't trying to push back but rather ask what the side effects of
> this patch might be for userspace.

For userspace it's just another reason why a card might hotplug, it
doesn't make much difference - this doesn't add hotplugging of the DSP,
it just supports components getting removed like we used to.  If someone
decides to start randomly rebooting their DSP that's probably going to
be disruptive no matter what.

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltHfxcACgkQJNaLcl1U
h9Bw+AgAhT8K4srl7HkIx2mBtvLuCjm0LISYc8fMwQvNLJJpvgSw1a3/+XsVKrP/
jiCaOTnFAN7Nll4pgFqpGjj68DnkNsbteheJgSjdzDqT9ySbE64bAkcAN7VyQZjo
3v05gsMQySzB5MSqZMxZ3SzDC+LFjgOuM09QwkBY+DRDJZyeoMLofLRU/LKKeglW
rHS+/qusiDrQuq09yhNXpXXtMJDiEH5h0n4XaMIgJ/EMRudOOTJPDt4eT6TkyEF7
x1AHxcLs3gAt9fmkuxMQZaONAhI+i9I4g3aQrUJxYQtcpw49+r9xg0tPIQRNQJoU
kJdeN57fxLeAkxv7vn/o0xNRBMfRaw==
=JfnE
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
