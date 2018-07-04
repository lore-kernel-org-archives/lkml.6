Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EABC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41EC208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/LP7s3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41EC208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeGDLZm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932576AbeGDLZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:25:39 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1D1E208B6;
        Wed,  4 Jul 2018 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530703539;
        bh=TpYjtRXL1q58vFqqFI9x8XKzAnp90qSBGvz3c9Xh/6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/LP7s3fTTLGQNDtP1QDzO2tsOBOlPMgi3TKmd8looa/qzuLEiCCkeLut+QwM1KDK
         19KiiolVaqOF/ix/jEB/xObnvCOVVD64E+WgIwsrkPFi6Q/9EtAmxSEqswrWePhFEA
         6zi8pGPq3Loipub03hb7IbYtr57uRRFIks1rraAw=
Date:   Wed, 4 Jul 2018 14:25:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tarick Bedeir <tarick@google.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, dledford@redhat.com,
        jgg@ziepe.ca, Eric Dumazet <edumazet@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Test port number before querying type.
Message-ID: <20180704112536.GN3014@mtr-leonro.mtl.com>
References: <20180702210234.107361-1-tarick@google.com>
 <20180703062111.GC3014@mtr-leonro.mtl.com>
 <CABwnudxZbGumr+XNjOsz5+_iZkZ9mn0zhk+UOmxDNynAQJfWtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NJSRbAqOy4NeGDns"
Content-Disposition: inline
In-Reply-To: <CABwnudxZbGumr+XNjOsz5+_iZkZ9mn0zhk+UOmxDNynAQJfWtQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NJSRbAqOy4NeGDns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2018 at 07:44:25AM -0700, Tarick Bedeir wrote:
> On Mon, Jul 2, 2018 at 11:21 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Jul 02, 2018 at 02:02:34PM -0700, Tarick Bedeir wrote:
> > > rdma_ah_find_type() can reach into ib_device->port_immutable with a
> > > potentially out-of-bounds port number, so check that the port number is
> > > valid first.
> > >
> > > Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
> > > Signed-off-by: Tarick Bedeir <tarick@google.com>
> > > ---
> > >  drivers/infiniband/hw/mlx4/qp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> > > index f045491f2c14..4f1dabecf9a5 100644
> > > --- a/drivers/infiniband/hw/mlx4/qp.c
> > > +++ b/drivers/infiniband/hw/mlx4/qp.c
> > > @@ -4034,9 +4034,9 @@ static void to_rdma_ah_attr(struct mlx4_ib_dev *ibdev,
> > >       u8 port_num = path->sched_queue & 0x40 ? 2 : 1;
> > >
> > >       memset(ah_attr, 0, sizeof(*ah_attr));
> > > -     ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port_num);
> > >       if (port_num == 0 || port_num > dev->caps.num_ports)
> >
> > Did you get any warning from any checker about out-of-bounds access?
>
> Indeed, I observed a KASAN warning for an out-of-bounds read in
> to_rdma_ah_attr().
>
> > According to the line above, port_num can be 2 or 1 which are valid ports for mlx4
> > and the check above doesn't do much.
>
> There are mlx4 devices with only one port.

Thanks, I never saw such device, but found one on ebay :).

Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--NJSRbAqOy4NeGDns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbPK6wAAoJEORje4g2clinE/0P/1KOJLHRI5cY9hwSqHSowxGs
CxY9Ll55LxDcJICOdNXHJEq4IPZ+GvKaz+d10Tg6bTTxFm87YLJDgInRQ/Qud7//
QlQ4CAdILhzxk2R5+MZAfb3QQ5UIby9eF8RJiwvLTKM6B1z6pg3ZYHveM3adGNeC
x0WqOxsL0fhwY7CkWy3w0d0qGJUBEUApdT4rMesh2QlszuWpfD2NjmWNRFmDZAqx
O+7QuV3GLz70gEOfJMlyRZDwbLMHnK3n8XPF5aksxJ120Z1i9J1edA06zIirPQLM
vjdi27Bfy6yu4R8GB3ewHLahxWpm4IqU7EMr4oQQVLY61+rbtMuM7zZUGnabdWAU
la/5eaXNy64lug5lPA9yRgsVgfT3o3ULlEtGUjxPVu/88CqMvHWx5nWd/6Ov4h7L
HURmNNBAkvBpu8OTIff482ZwqC74CNY4MEdV7anQZ59uPYCUXx4LRRQ2j2CkF2Q1
J0FEBDOsKQUxE/hoDa9YrtEDe4URTr5CSJ6/tq9g7HsV5dFI2FOYg2jSlHVdEGVy
UXrrI40oEOdcuJIlxbjUDLgGUksS1Gw/2jIJrJCTdm4B2rjNm0btl7PTEIn5l/Yk
QLDoZmjfctampO0SlPGvvTWT+0wg2QjGYahw/X9t96VmsfZHAxkHuwU38TWhFyAe
/DeqShfGBBDO8/Nro5ch
=a4Nn
-----END PGP SIGNATURE-----

--NJSRbAqOy4NeGDns--
