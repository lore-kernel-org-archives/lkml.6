Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E847BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13E120820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYhl9bj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13E120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeKAQgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbeKAQgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:36:06 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC77620820;
        Thu,  1 Nov 2018 07:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541057657;
        bh=/3WweoXZd2tr7VCvp1S/EmYFVHWMTorNiQD5Vwamv9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYhl9bj6giUyTl4TPCCmRY9DepoO0Owz356TUE/Ys7K1G3XhO8MPjf5Mx8czCVLLx
         KRqLDgf1+VFOYM+FysLrlPWN/xMCJGEoyTdXa63w8PZyVHbdyWEetpNOfNvU/WltIn
         N2mj4uYZWa/BwXR3aUaoBFJ7M5p3xPeubu/nu9qI=
Date:   Thu, 1 Nov 2018 09:34:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mlx5: Fix formats with line continuation whitespace
Message-ID: <20181101073412.GQ3974@mtr-leonro.mtl.com>
References: <f14db3287b23ed8af9bdbf8001e2e2fe7ae9e43a.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="apbmkPN6Hu/1dI3g"
Content-Disposition: inline
In-Reply-To: <f14db3287b23ed8af9bdbf8001e2e2fe7ae9e43a.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--apbmkPN6Hu/1dI3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 01, 2018 at 12:24:08AM -0700, Joe Perches wrote:
> The line continuations unintentionally add whitespace so
> instead use coalesced formats to remove the whitespace.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> v2: Remove excess space after %u
>
>  drivers/net/ethernet/mellanox/mlx5/core/rl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--apbmkPN6Hu/1dI3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb2qx0AAoJEORje4g2clinWpkP/09XlGPvkyX6zrG6u4zHwDu6
dTQu4lQ7xkqVyul/QumZRgGv/9EI78I9NyUlnRZjeA9gZSLkoexxinEF5VZirtOo
5r3/d7GeCZLBYc9NXN2lJvVO1C3oT0w/+995qAhCqhEBBFVqB6bKyJhiMf4B+ets
dQnvU0PQN1q0Uwhm8q9fjURUr2erA9B6QdeXlI2+wE6J5BZ57IkTLFUl70Xuudgn
kENJWj06f2WmUR2JZz2ocwROE3eqPzVIEWxe8FYuwFnzu4WTeA6A5BCxuFrzsQtc
mUWf4P7dRVHtf76lX6khdq9aqw4GykKnaKTX33qjZJ++vVOZHHyj4ozcJlva9xIQ
W/6yfqXbJllBMs1FRIPvCnq3kYuEPDL+KGqyFOkucueabYrqAXJyiTy2R67TW1AZ
a1oeVmsFxuJGsqtFi6/IuSeAvaPO2vjXacp+A7DtgMj1+6IiNF+fyc5U582lw8hb
Q2no9s5VgrUaXT6pmgyQtyEe+NOPgVxlKThDHOf3oye8XG+8g5IGTmezeBrqm8Ll
7JWO6BnnUqvzid05uKQ8zCSA0LDyDj/UixsxRSA3+fOE9kfZOIGNvDTnhysJOjJj
ZEEQa8kHtjNgkR8e2EAs89M9Q7AO6hOcl39RapzVfP1lp3I9rNYSt5S7Qz2FAREp
2kmbOfzeC9P/5U9SUtxA
=j94Z
-----END PGP SIGNATURE-----

--apbmkPN6Hu/1dI3g--
