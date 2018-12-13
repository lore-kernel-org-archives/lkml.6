Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBDDC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EA12086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544704849;
	bh=WHz2jgBkZmKTEOjKSNezVMlxGOUitAURhKFHYdVjYpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sR5hzcpAdEIn9RWcmtdwbA3HR21RzEar116KLiLj0fGiQcuVgd73FD5FS66ucbGmV
	 T29c5UFUP0lR4b8LITy2TeW+eb+4pxkmGPcLWEdxiWntWEMFeaGwOaVGWXL7txCplN
	 AV8bOUKZknH32mTQy8pUP6cucAhtCJtbg309VMic=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EA12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeLMMkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:40:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46824 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbeLMMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WHz2jgBkZmKTEOjKSNezVMlxGOUitAURhKFHYdVjYpM=; b=S5BaPGc9SFzsyMkH79BLXdx+U
        mv7QshaHvtqal58jcwPJh4qhDkBL+ftfzuzvWlN/CsNBxh/Xy6LXj8udCAxTa9Qb7KiqMKKltenZ2
        7pRUTKnb6AT2h5e10shbTjpKBs2jh2ILcTgOH+OycFmmE3D1IQGyJ73UeM0PoYswb5Mwo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXQIE-00015A-GZ; Thu, 13 Dec 2018 12:40:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 102C411254D1; Thu, 13 Dec 2018 12:40:42 +0000 (GMT)
Date:   Thu, 13 Dec 2018 12:40:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, mingo@redhat.com,
        rostedt@goodmis.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 1/3] config: provide a fragment to enable gdb for qemu
Message-ID: <20181213124042.GG10669@sirena.org.uk>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
 <20181213122910.24193-2-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <20181213122910.24193-2-anders.roxell@linaro.org>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2018 at 01:29:08PM +0100, Anders Roxell wrote:
> Adding a fragment to make it easier to know what options is needed to
> build a kernel to get the that you can debug in qemu.

> @@ -0,0 +1,7 @@
> +# Enable debug info for gdb
> +# CONFIG_COMPILE_TEST is not set
> +CONFIG_DEBUG_INFO=y
> +CONFIG_GDB_SCRIPTS=y

Is this specifically for qemu or is this just good for debugging with
GDB in general (eg, via JTAG)?

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSU0kACgkQJNaLcl1U
h9CJSgf+JoSC5WlMXPrwaqWqdvGhMgwkszPHMobyuzsHn3AKk0dpx5VUMUFmslzx
P6mP2XvVdUZxdYHhxE07jGMaSEYKzMia4AFawsFfgH/+iFcR1heSqPfQtpLq24Te
x1Nj3WK+GPrCqVpnVrUjNG7dT3o8HjxnN8mvOyQHgs1HCDt7ifQhqlQJugHPGRPc
wzTOtQJyeMRSsADs1sZFeJTmi3yWqN5LmHsywpMQiQ3ZaAEiqbbu3GU8R5AacFjL
LNsmFMB3TYAYIOHc8dl+fxZl2n6ndH5TzDDCpFDe85tDRam0n4jeQ07PtqHpm/ws
W6SvU3XSsJ91W0sP6fgZkVe1t5FzvQ==
=+pgG
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
