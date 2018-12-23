Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0592C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9DB21917
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545558031;
	bh=HquHmeckJjjzdh1ixKfuigXOQkZCJGrcwvMfWjB0c3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o7V7lHK+G0sOsUOHyo0CMVRg1kqlcYXvvlCW778ui2GQC5YVyKIgsg9WQREIc8nXP
	 Bu+ASQACzG0N4gZDshgp+Ju36m4tcAVijSgFtyUJjrK+49KgA8RGQXu7LvpLi8aEPz
	 XQd7UnQK5CX+lkzSaDCT3HGZEoDm2ASq4ygnUjoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeLWJka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:32996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbeLWJka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:40:30 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD318218FD;
        Sun, 23 Dec 2018 09:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545558029;
        bh=HquHmeckJjjzdh1ixKfuigXOQkZCJGrcwvMfWjB0c3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c52IASeR3syD9q7FhBK/uaZIyTgdL0r/4f3hH4Nhal0G0qgw+aBVJm59ygAxivBeJ
         8/c7y7A1Oyu0awHzdgyb+2GJoG0+Ts3aC/b1EF1Zms3477fC2neFYSBjrSDmpyviKr
         uSu+bpLwWdLtYrMJc5AJRQGD22U08lkmA0p4zcus=
Date:   Sun, 23 Dec 2018 11:40:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/20] net/mlx5e: drop useless LIST_HEAD
Message-ID: <20181223094026.GO3940@mtr-leonro.mtl.com>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-3-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hHiQ9nAwW5IGN2dL"
Content-Disposition: inline
In-Reply-To: <1545555435-24576-3-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hHiQ9nAwW5IGN2dL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 23, 2018 at 09:56:57AM +0100, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
>
> These became useless in 244cd96adb5f ("net_sched: remove list_head
> from tc_action")
>
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>
>
> Fixes: 244cd96adb5f ("net_sched: remove list_head from tc_action")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--hHiQ9nAwW5IGN2dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcH1gKAAoJEORje4g2clinezYQALJ4CE1YSPVZl0v/mro+VPkd
ibEjMf6lCI9/I2ldfbwlvzZfEVE5KKILn0YCwn614zvcnR+Qvvb1Pt3tbsxWGsIj
IZ/oZMhuIUWME7TEiAmxK+UvqARbgqseVykG0/1f7CajispL5WVp8BdVCvAiUcgE
JtAkJtyjByHAvCWpWutQqWqJ4cq7PLlGKzOPFhdh/nfMpe53iKCRyhB3xrTEbCF0
ETU1GKujnbcQY6F30SNTjPn7I5EOCTZlfqop92o0391ypVXewnKmGACgm6fIgrnm
FADP2CckVunXd6jAodc5VUJj9cRBIRdV+k7O3YS0YOjOMk48K5JqM6VDbEmctdKQ
d5YV4alekhnN4dlSdktJod5J4npL6DX9OcNTZk8FnDmyX4X0nP+uODY5G9Aie3Iq
jb96mi4pZrQry/fky0DppS1SX6W5yrjiH/qhcagHFHKxmUc2sAE9L27wFUBVw0B6
wcJc6eWJxCkuoHc+xD1mZz/Eo3I60aVoJPX5WSSnchkgFNpT6ZnaMWl754JlBfbP
iok/mUYp2nYDqj+lJxi2a689T3ossODrS6x4rxmruvU4Y+5DVSZ0q3QcGD779kxi
XFdqu+O65uDcU4lx1HD5wWYjfCAvwnHLvTDFuXdkbDZ94lO7o1k/9OmFiIFNDe91
Yd4Rh70MvMJ1TQElNTJ+
=v4sq
-----END PGP SIGNATURE-----

--hHiQ9nAwW5IGN2dL--
