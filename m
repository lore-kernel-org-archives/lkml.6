Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E60C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B910821479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKpz4O8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B910821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeKURtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeKURtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:49:51 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124B92145D;
        Wed, 21 Nov 2018 07:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542784592;
        bh=isg4VFayM4ya7r9XPXdOYjxiYWKi6Ez/4YGtjGE1sH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKpz4O8kvoP+xwFVxWZqFyUlbw2LiunOu0KWTnLRiAMn8V0Zt4aJoTXmmzwmXeXdG
         9J9NPrJauBVAp+G/jP7wTL+a/9JzqPCLuR3jmiSbCGHUEpDQT2TStYZSk7/RJhJuGN
         OVDjgHyEYwZlJxJOgUKEBvlHN/wz3fM3RI4yyKUM=
Date:   Wed, 21 Nov 2018 09:16:27 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with the rdma tree
Message-ID: <20181121071627.GA7276@mtr-leonro.mtl.com>
References: <20181121110432.64a379f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20181121110432.64a379f7@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2018 at 11:04:32AM +1100, Stephen Rothwell wrote:
> Hi Leon,
>
> Today's linux-next merge of the mlx5-next tree got a conflict in:
>
>   drivers/infiniband/hw/mlx5/main.c
>
> between commit:
>
>   9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")
>
> from the rdma tree and commit:
>
>   f2f3df550139 ("net/mlx5: EQ, Privatize eq_table and friends")
>
> from the mlx5-next tree.
>
> I fixed it up (the former removed some of the code modified by the latter)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>

Thanks Stephen,

You are absolutely right, the removal is correct.

>
>
> --
> Cheers,
> Stephen Rothwell



--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb9QZLAAoJEORje4g2clinzt0P/RLWoZPvwtl5H2/YEPjCiDCu
K62avmczxvSU67MW5FTE7Ks/0nE9yd+WIWYIydqWxg3dXMbYn8N0vlaN385i20kW
8DLrOsjILysS81fUHK8wZCc553oUKp+qpwMTY4ly/3JvMo3vofe1VTMUQsAJ160A
vAFU9vyFea4YfhYnL9bHwNuXjsJLye4zy8Vp8r3tiHfuYk2HNX8R8oniNo9hyy8u
75oZNegT15fIRqG8zucv+qcyFmuzvNX2LrN3econSKnnE12feqrO7aSTU0nuactO
WNzRjJjwIazkoOufp/pFYAL+7gvlaQKt+abHA7wlmXuKNF5E/Yk4pndWdtzuCjdK
3IDoyS9HWGvG1MY/v/wzOTDChOImH8Z8pXlSzMhx0FNcTavn3ELkSXfwlFOFiTpe
i7JojUWY3wLdRuQMa81Spwwr7qhSmu9A8kOGomPUoagRLmDhNrb421Pj+KeBcHgK
Jlot/hsdOThFHZB7eFT3Jt1qix+RlqzP0qo0wxFy/196LfHpZemx1hanCXmRjQbz
kzA3+5ZGe3fREAMf2T1+sW9fiiwh7MJ0ofXIJaMH7hIR/qo2ckH7xDyIrg9cLACd
aTB3ehdywdgWXmLYXi/g9QsS+NiKai7uox44QSCOajFh1937bgwIQ6IIFurBZjdL
gnvjr9Av3DtZDrG0l7Wq
=MGL3
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
