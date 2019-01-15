Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B3AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5224D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547548753;
	bh=mZbzH1MVq5a9i74ImhC225TRlaGmCyVWn0xG6/CWXy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=us8GNytqBOxTNdjgT49x/HtLCNkK0cjmYaP8KJL6XJaYC0OawhBTLGtsLYEXVQ7mY
	 p6vp5KUMGOrpSo0D9u/rYoktEb9PnGetIJsyE5cLx75kSwFfBmiSR4l3e/cfnTlhOT
	 uvHXqn5ipaU29ayc67ftBzQ1yDRDrHtI2D2XU3LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfAOKjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbfAOKjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:39:11 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE91920651;
        Tue, 15 Jan 2019 10:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547548750;
        bh=mZbzH1MVq5a9i74ImhC225TRlaGmCyVWn0xG6/CWXy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbyCgek6oXEjPdcWCWdGvM8mL5HJU5cmewfoFXH0HECbW8efT84GELvtv2vVXOt47
         kENMsqXT0uEKbsxxQ2t1HEn0pYuo/xqaTpxmQqTjMrP08XvkoiXYr1aWYqFWYqCSqU
         1CwjYLZB3AwQKaNheSeaQQQviJlPdevRwe6DjjXs=
Date:   Tue, 15 Jan 2019 12:39:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Replace kzalloc with kcalloc
Message-ID: <20190115103907.GI15600@mtr-leonro.mtl.com>
References: <20190115060048.GA9911@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20190115060048.GA9911@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 12:00:48AM -0600, Gustavo A. R. Silva wrote:
> Replace kzalloc() function with its 2-factor argument form, kcalloc().
>
> This patch replaces cases of:
>
> 	kzalloc(a * b, gfp)
>
> with:
> 	kcalloc(a, b, gfp)
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcPbhLAAoJEORje4g2cliniacQAKa27GuwRv6bwOSYLFEEo2FW
9F/qhfIjupxHk3BWle8XXPFrYiRNlYoL0nO35tFHL6ViXu7o3+seq1/SQk42xBOE
1A2zU5R5fqfpqyLxCPuuEr4ax4Y/lARi55sv9AUVfbNnQvgWgKa99JPq5C4VqM1r
x7unh4Xusi21huqIwOYIeFYKh974r8BneVRkbQjKF/sM9RNPEH5kFTI6Maj37Lcm
NfjN/Rm4aKnbtPeIPBF2CIdS+U9J3x2PGKrrZkjOa3aWXaMMMjqlyjscDd9KTxPB
Plpyf19pLpFa3qRHqCjPs4w5aRj/SMh9Q8O7pD99L4fECh6ujPmL6OihOfvdVjld
pPyZuABuc3GCr4w+BoDjAeXl2xvifoBOYQx3nAVH/JOe7q3xBNDUIRcH9K6lDdNU
cybYso3NBlZb78GoT+55flpjpFFNC3r6ybH6bMrNdaNlCNYK0Mok/4y1nacn4CKn
aU8eoEziIwj778teTkK0nHohsy6pVcMyqv/9SK32Oe3Xu2rAwdg8EWG7gd2U3c0m
5Pkq4iEw1Gut4E2r17tE++RrET1+it2i6c2JHlG9Oz3NlymFkQigKUaLrSdiaUFC
/rk+GNvDx/h49d2XgZAMrZA2x4k6fY0SViBFvFhTAZlSrNUwIFzgPFM7GKjzQir3
O+PSSEVJd/0YuUp0qbX1
=z5kD
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
