Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBE2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B722082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/iETpzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B722082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeKAQWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbeKAQWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:22:32 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3192064C;
        Thu,  1 Nov 2018 07:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541056845;
        bh=+PDl49jum3pHIvHtLyZkWL5wkOV4t0I6mfjv8s+doGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/iETpzNHKZe0jLlYA/8jvOt+E8MDTsp6V9qf7ndb+7tOh0Di4+j9kMWs0WcyN5zE
         wkhDUVBOSSET49Vy8cOK2q/jGEgvb6o54j/sXhd9CKG2AOzxENBdHFSXYzeP3W9yG2
         LZ1UKR0ROLBaHya4mTUwR3qkv7YrX4wbsfOCotzc=
Date:   Thu, 1 Nov 2018 09:20:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: Fix formats with line continuation whitespace
Message-ID: <20181101072040.GP3974@mtr-leonro.mtl.com>
References: <e076161b88d0c87f083f28450a130de8eead618f.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Az4VpBrmI9+OyhK/"
Content-Disposition: inline
In-Reply-To: <e076161b88d0c87f083f28450a130de8eead618f.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 01, 2018 at 12:09:36AM -0700, Joe Perches wrote:
> The line continuations unintentionally add whitespace so
> instead use coalesced formats to remove the whitespace.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/rl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rl.c b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
> index bc86dffdc43c..377b7e65ecf1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/rl.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
> @@ -188,8 +188,7 @@ int mlx5_rl_add_rate(struct mlx5_core_dev *dev, u16 *index,
>  		/* new rate limit */
>  		err = mlx5_set_pp_rate_limit_cmd(dev, entry->index, rl);
>  		if (err) {
> -			mlx5_core_err(dev, "Failed configuring rate limit(err %d): \
> -				      rate %u, max_burst_sz %u, typical_pkt_sz %u\n",
> +			mlx5_core_err(dev, "Failed configuring rate limit(err %d): rate %u, max_burst_sz %u, typical_pkt_sz %u\n",
>  				      err, rl->rate, rl->max_burst_sz,
>  				      rl->typical_pkt_sz);
>  			goto out;
> @@ -218,8 +217,7 @@ void mlx5_rl_remove_rate(struct mlx5_core_dev *dev, struct mlx5_rate_limit *rl)
>  	mutex_lock(&table->rl_lock);
>  	entry = find_rl_entry(table, rl);
>  	if (!entry || !entry->refcount) {
> -		mlx5_core_warn(dev, "Rate %u, max_burst_sz %u typical_pkt_sz %u \
> -			       are not configured\n",
> +		mlx5_core_warn(dev, "Rate %u, max_burst_sz %u typical_pkt_sz %u  are not configured\n",

                                                                 double space ^^^^^

>  			       rl->rate, rl->max_burst_sz, rl->typical_pkt_sz);
>  		goto out;
>  	}
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb2qlIAAoJEORje4g2clinIrUP/AkH9vV61DSNFqRmjCZfEb99
VtiIVVwoMu9aDK8AbxC7IYvUOXbZrmYOXG3+GDUY80S5TOWMnPcYu6hLu3HWUKRG
jTxvbvQ1sDnu47NGac+rb+7FMqfhzgxPEu6ldlSUXb+SDOPMA1vXNAny63am5+1s
LnfaifOJiXSa5T8SXwPkz3ghBUtcA7w+WaR4f8Z4VMeMQZR+1gXOh98byyMFgtg+
gZ3rYWCb21hLRa/l9Hb+J2CK5MwrAHjH2vVv/LsFqXS+wS0BN5ODbfs3qp8w2akn
gv6PrGwJH6/PTjrgkq7aWZa00wu7yM7zrMuDT0noC5mJ5JH0fNQ/aUZ7brEoDUao
yoFVbOS1uQEkzO1aI9ifumvuuWTGp1pbPNzLC2DpEc8Xs4Q5WBrB62JpVZ4kQgfk
ITSKkmNOvlv0wf/PtYApivJ0X04xEfWCz3xhZV4GZp2rwbWJRDjDkHDbffN1kD5s
zcJc2Memop1Wr+0Tg78VOXj2mStgaD9Sb5pr3/v6CSpWVkdDhsLulkO1vOicpUmN
K4L9SABlsvoTRmOjKTCuqFWvQc1N7gYfl94ie8uewZSUMo5E7NHHC/GPu8s8nSH5
237+ATjApCf35aFAbsgh/3NaSnmqFYEpwXfO191qowQy5pTohjyggv7aTWXsyfja
RrejBR12uEh0EA7YFJbM
=izpc
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--
