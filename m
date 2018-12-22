Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ABCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692022054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500837;
	bh=FkTytOFSwT+NbYB45UYGJ7vwRi84bMx0xFwZgr3C2bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PrezP4NFc7sX/JxIF0jowcCpYMaMS5US4D2QVDZkHJNEdRKszWskwvGng/U2Km8G8
	 5u8R3lhfWDz/JhYu26uy3tO5+1LAdodf3I5Vu3NiMcZGhWcFkTdoiNDhTwqold3/8o
	 LEbhpOxIQ3zS7/U9mf8qJJwChZhS4Qd6HVEKBUnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391702AbeLVRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387725AbeLVRrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:13 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C97EC21977;
        Sat, 22 Dec 2018 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545468087;
        bh=FkTytOFSwT+NbYB45UYGJ7vwRi84bMx0xFwZgr3C2bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdQ7q8ZvEOc1RwCOeAWg7BySU0nZ2hvN0dF8No7ZEk29qUqgHu/ht/92Nhj20yCZh
         V9FaqOIMRHdlQN2L0YQA86vfxfWvfBvdc5jpujIbXip3SaYqnx2nk5Zd2tod3YdaWE
         yAIYq54GU00G73SZ49xsfFvfuakteokZ+ShDy4HQ=
Date:   Sat, 22 Dec 2018 10:41:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Fix error handling in UVERBS_HANDLER
Message-ID: <20181222084123.GJ3940@mtr-leonro.mtl.com>
References: <20181222081335.GA13088@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3CAnR4CLEnEWqRMR"
Content-Disposition: inline
In-Reply-To: <20181222081335.GA13088@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3CAnR4CLEnEWqRMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 22, 2018 at 02:13:35AM -0600, Gustavo A. R. Silva wrote:
> Currently, if uverbs_attr_ptr_get_array_size() fails, the returned error
> turns into a huge value, once it is being store into a variable of type
> size_t (unsigned long), hence never actually reporting such error and
> causing unexpected behavior when executing function
> mlx5_ib_create_modify_header().
>
> Fix this by changing the type of variable num_actions from size_t to
> int.
>
> Addresses-Coverity-ID: 1475957 ("Unsigned compared against 0")
> Fixes: cbfdd442c43e ("IB/uverbs: Add helper to get array size from ptr attribute")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/hw/mlx5/flow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for fixing it, but I see that Dam already sent fix for that.

--3CAnR4CLEnEWqRMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcHfizAAoJEORje4g2clinTKYP/R3gmbow9BwPZ/P0wzi+dHgP
Mo+DZ6OTUYJwo0laRvsUxZOAZQIXWIfUTmHu2fFhblGM1W0jGB7yLqDJZnbxSsqs
j7H7yfa/A16u16sKIzLOUMP+hUE8o6PY/YAnePDG5glslSy4EAMOnPdJqYf7rFtS
DTcnycP/4XlquXqybg5vT8dYbqQ8kMVSYozvBEmMgfaQw0Bmd9ndyWJuXllFvtDh
w/4HW/36xZ35fvubTQKTvXYvJA3YzUmG0cSJNjKRITUOzNhfJ+bjrVpBony1xOHr
8b7bwlH3+FgmV1IU64NKP76x95CYatM60Z3TxdW6PaUxJB0fC9YvlQlf831Nzd3H
1WRcR34XOLaE6l+aBtecmRRj0BCtXCJI3lwgLkt9ZjR0iLD9nMqqs2jAD0EAEBD0
9E23lHj0XMER+mGOL4FGCfRiVO8mkykskziHEeHZHUezdcRCm892ncdfwM6oel0l
VRS+F83T2b3uV8Qm2K0BF9RZv46oZq+Qbz6tVthSznjCvPjitIYwm8l2kKEWQWIf
GenObXOsy5e4JK/hgzNL0ASGIzB0HlPSrKjZHmIOGOKGHERMlqHPopO31ZpWX5tt
YROR5RuGtBOFwuDoDUHxwOtyGIEdu+Ct7sYwkwuaPST9Oz6co17p6KI0dsrFJYHS
ArWAqzzwNKawEjSlMLiK
=y/w2
-----END PGP SIGNATURE-----

--3CAnR4CLEnEWqRMR--
