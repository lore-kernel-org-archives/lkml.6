Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D27C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF06F20853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uu5mh78l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF06F20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeJVU6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:58:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33745 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeJVU6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:58:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so9125881wmd.0;
        Mon, 22 Oct 2018 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d5BNO6t4rgtdvwZQCkPiSjgKrHc9DMR51K2RRcbfJkc=;
        b=uu5mh78liFgYOewRWRFCVsuvz3n7C2pNbfrJOO7s7S33IkmmtdG1mzG9f5FGQ2uOz9
         4FUqOVaftszqFzZ3MIbpCF0Fbv6L/7cjBAN/cg7TY64djuCQrieUG2Ow0teS8RYYgyIz
         2NjEzI+ZyyoHUEMXye/g+OM+tYBGKdxaOiXhj60mMS15ZGpkw5RqbAfJUv4t+/GPUfs5
         vU/iUfwSI398AebDkSxcxzDdFup05Vx2BOd/oPRWc5n/kxvBkoSLnuds8DU7BLKub5mq
         Lqr+UUx1ksn4ty4wd+qyoQQfQrBLE/bNmO1CDi/Uq+pbNA5Wr42cn2ObhOGX3wbM4l9c
         X28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5BNO6t4rgtdvwZQCkPiSjgKrHc9DMR51K2RRcbfJkc=;
        b=YugO4zhJIPC6r55I8HgWShy1xZjvD38MAtk2JgaDlY5x7XMAbOI+fCqJU3VQ+uluY/
         hLGPEe3nOQ6JJdbK1y6k68Eu2pBlEt5QJeh6Q02pUV8a42EdPzM+w12PWYWmt2bbkJQt
         aZmMbByHdZxOnatvAvT7jXKp6gnF3kPdbJZygeqpv+V59796wh2nM5T4YhFxKnvAbCPy
         zduYg3HI3xsj+FU7/wGUv+jSgwBbkAQOhMSCOaAluj/El7LZs7uZVfbv1Ocu0SxOKAmk
         oXSUsinDA+644szzzP9JgJjpm3j0oAiavEjSiqbMLeg8fbnRPrWpUqf7tTG4XuEFd/Lv
         0+4g==
X-Gm-Message-State: AGRZ1gLY1fp+bXuJgeOfCC1u2Rhdacyb3atO+KmWbRjyJiai1vS426rS
        /VRE/cUyCAzj6xZbNJzlpMqQ9fab
X-Google-Smtp-Source: ACcGV62gdxJOPdhLW/LDVdyH14SitIRPLq1Iqj4LGeaqnXjz0k7Mat7+091JMDt3lPPN0yf06miXwQ==
X-Received: by 2002:a1c:1dcc:: with SMTP id d195-v6mr16144705wmd.119.1540211993863;
        Mon, 22 Oct 2018 05:39:53 -0700 (PDT)
Received: from localhost ([185.30.24.106])
        by smtp.gmail.com with ESMTPSA id p125-v6sm9831280wmp.2.2018.10.22.05.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 05:39:52 -0700 (PDT)
Date:   Mon, 22 Oct 2018 13:39:50 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Joe Perches <joe@perches.com>, stefanha@redhat.com
Subject: Re: [PATCH] MAINTAINERS: remove reference to bogus vsock file
Message-ID: <20181022123950.GA4857@stefanha-x1.localdomain>
References: <20181012154637.13242-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20181012154637.13242-1-stefanha@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 04:46:37PM +0100, Stefan Hajnoczi wrote:
> The file drivers/vhost/vsock.h never existed.  Remove the bogus
> MAINTAINERS reference.
>=20
> Fixes: 433fc58e6bf2c8bd97e57153ed28e64fd78207b8 ("VSOCK: Introduce vhost_=
vsock.ko")
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Michael: Can this patch go through your tree, it's related to a vhost
vsock file?

Thanks!

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40082e45b3da..05191d706bb8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15529,7 +15529,6 @@ F:	net/vmw_vsock/virtio_transport_common.c
>  F:	net/vmw_vsock/virtio_transport.c
>  F:	drivers/net/vsockmon.c
>  F:	drivers/vhost/vsock.c
> -F:	drivers/vhost/vsock.h
>  F:	tools/testing/vsock/
> =20
>  VIRTIO CONSOLE DRIVER
> --=20
> 2.17.2
>=20

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbzcUWAAoJEJykq7OBq3PISOIH/3MEUmJWlchiczGAHPG7lShS
zIlU29+6XuLTJmWrV4DP7tFKQqZXX6H09klp1mR5DOifbUXmndow6crbBhaXzyRY
mSy5qHbnEy3ROP+ufb5ahVTPBBh0Bc652ZCX1p6/QwZw7tKpX6WNgjQNGkXoOmHt
hnEmKUUkqRF0k1KuHK3DGAytTrDZ9qTlJ27+Ufe5LBs2OPzWqvWQPl6rZe0YCJrG
R9rfZ2BNzLSkDFroN5WJed8K9cZBzZybTshK73zzUIn5+DPHtp0DHaAtBVjC/rsx
Q9gWTAt0P7Cxj7UGJ/oWLEQVvvqETJU0FcczdThzSXU60g46KQRwRchiBk1VE70=
=CEBw
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
