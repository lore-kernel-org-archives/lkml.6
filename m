Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C192AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E02821A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JiRPFy/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E02821A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeHFQsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:48:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46196 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0P/R+W/frLk5I6rRtE6Lu/Wtjaf+I5DdsXeHUqu110k=; b=JiRPFy/txyse5q1lKzaY/7Jzy
        7FdSwysTEKeXEkY4ztBab7RSGEyD3HppMwRsycQ0XDLdBZvZHHkCs6cO1/9w/VcVVKEdiuPSxkkK4
        XEqUGw2xr2Ta5IzC/6AltTkOzbvc9AitPiIWuMVH8e/gWBbCiUgD0PoSBasNZo71Xj3Xw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fmgf0-00081A-AP; Mon, 06 Aug 2018 14:39:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8E975440078; Mon,  6 Aug 2018 15:39:01 +0100 (BST)
Date:   Mon, 6 Aug 2018 15:39:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v4 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180806143901.GP2414@sirena.org.uk>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p/1JFEOz/hVXxMAZ"
Content-Disposition: inline
In-Reply-To: <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p/1JFEOz/hVXxMAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 06, 2018 at 03:04:44PM +0300, Stefan Popa wrote:

> +	if (!regmap_volatile(map, reg) || !regmap_readable(map, reg)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

I suggested having an explicit operation to check if a register supports
this mode of operation when I reviewed an earlier version, I didn't
notice a reply on that?

--p/1JFEOz/hVXxMAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltoXYEACgkQJNaLcl1U
h9AJdAf+MuzrfAjV3XR/vvxIWIN5fNHaN8p8i6B479nzAsnIRY/IirqmWxYZ3+X0
7IJOxtvbmZR6EW6VVT5ccTAlAnbrduCT11AbwOpLDYf8Zkjldv3AfepOURH9lUI0
2/Ve5mb3F36MLGvOBqqdVKkAezpPb+MrWc44HuSofWo85mGGTeBWlMV7UGr26/HZ
uMYXA55IRthFAAHjrkVDRt/Y4kYmzRtBJNt1ihytVH1T3OMjyqdWeE3WGA50uv0r
GIZ3RIB8t9iiEFWFVxxR678VNa6bSBy1CjHyGN9TKVNPpwBEqUL11ToBFiobr9Jp
ef5nNuAxn/I22hkhVMmCRQCU01V5DQ==
=Prc5
-----END PGP SIGNATURE-----

--p/1JFEOz/hVXxMAZ--
