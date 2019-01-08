Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF9DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A4020850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6dNAG9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfAHLYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:24:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38801 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:24:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so3665618wrw.5;
        Tue, 08 Jan 2019 03:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jv4kLnvFJZDPXlpA3z1ngmDwmsXZHiLpVCYwF7XSMjo=;
        b=U6dNAG9dZHQw6LGnge03dpnGhKhoUp79tdZDR8s2yBdbXOiRCxjfKIitW5dOoAuUNG
         Xs4ztvD9dKIb0X/LPtaTPqUX0I1exIEsTQISabzO4v5GQQ9WlAfdTvRbvVQJsMWsRF/p
         p1zFM8GZUgbkgvv3p9/ejDUODfuZQLqQnf02lhvesXwj0uSNLtTbzN77zLvWsIEH0oZ7
         zUvTczEMpluK3x9uA/4hmzJGmg2nsb8BUNIg2Oo0sMjJPMpyQn1q5n89AERwm4aPrluP
         GHREa37wvfLtzcPkZalnYKH9n3f1BXGGHzibayuzv1HtvewS+EUASP8mpjHCkhRD97IW
         dKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jv4kLnvFJZDPXlpA3z1ngmDwmsXZHiLpVCYwF7XSMjo=;
        b=UpcKB8HVQAPf6qIpuuj+T1P1rbebUAp9qsJWs3SfzA0/pEfE1UTCbAGgRSKP0rK0O8
         Y8ChI+3VZGBLpgLmPSCaqsdCPrYoK14+FzcsWehyXHUe1gxihlgn+4uGH9105DCOaN3F
         iaZbT62kRd3a6l3Q59BmqberMPD2FXUewpyFySqayHldHt6/6V1+7CIBWSha1RFBuODh
         dCJyBmDBU7ydIB9PNJD1AfJ1420Qc09A060CoqKpcVp3U7gojZKstRMP5fVLoL8u+I8a
         UvQaGlKnI92eAFlLrCstGdqmugTG/9cNDG1ntc7k+30bkzSvTHBjHiwNFYWcQUody9Ow
         IAlg==
X-Gm-Message-State: AJcUukdbH2mwjztgn7UuXK9e9ZskAcwgDfOvtV4ko5dB/VNFu2fMtbE7
        YtDVMnJokx9TM+/x0I+ws0M=
X-Google-Smtp-Source: ALg8bN7j5Au1R9f3CSe75teB4L6ZU9LiIpYfC2gKtdhhaNum9eqBJADrUEP79qY4XO/9aTAa5d72Cg==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr1177240wrn.264.1546946653249;
        Tue, 08 Jan 2019 03:24:13 -0800 (PST)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id r69sm13270822wmd.4.2019.01.08.03.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 03:24:12 -0800 (PST)
Date:   Tue, 8 Jan 2019 11:24:11 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        gerry@linux.alibaba.com, kata-dev@lists.katacontainers.io
Subject: Re: [PATCH] vhost/vsock: fix vhost vsock cid hashing inconsistent
Message-ID: <20190108112411.GC32358@stefanha-x1.localdomain>
References: <20190108080703.70050-1-zhabin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <20190108080703.70050-1-zhabin@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 04:07:03PM +0800, Zha Bin wrote:
> The vsock core only supports 32bit CID, but the Virtio-vsock spec define
> CID (dst_cid and src_cid) as u64 and the upper 32bits is reserved as
> zero. This inconsistency causes one bug in vhost vsock driver. The
> scenarios is:
>=20
>   0. A hash table (vhost_vsock_hash) is used to map an CID to a vsock
>   object. And hash_min() is used to compute the hash key. hash_min() is
>   defined as:
>   (sizeof(val) <=3D 4 ? hash_32(val, bits) : hash_long(val, bits)).
>   That means the hash algorithm has dependency on the size of macro
>   argument 'val'.
>   0. In function vhost_vsock_set_cid(), a 64bit CID is passed to
>   hash_min() to compute the hash key when inserting a vsock object into
>   the hash table.
>   0. In function vhost_vsock_get(), a 32bit CID is passed to hash_min()
>   to compute the hash key when looking up a vsock for an CID.
>=20
> Because the different size of the CID, hash_min() returns different hash
> key, thus fails to look up the vsock object for an CID.
>=20
> To fix this bug, we keep CID as u64 in the IOCTLs and virtio message
> headers, but explicitly convert u64 to u32 when deal with the hash table
> and vsock core.
>=20
> Fixes: 834e772c8db0 ("vhost/vsock: fix use-after-free in network stack ca=
llers")
> Link: https://github.com/stefanha/virtio/blob/vsock/trunk/content.tex
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
> ---
>  drivers/vhost/vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for tracking this down!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNIhbAAoJEJykq7OBq3PInaoH/ji5ogIrLawH19suKLZrlABN
9XRO5FJrUISYIksh6jpjW2x2hPtts2MjaKLYAm8LrhBMw2c8yquB7AkdIwCS7RXK
1mo0raIPCuFBLFmrqVaogPzzraHTH1FFSr+S1VXVjp9VBZIP2eogLMR2KaUbbVaS
num4kgLF0hOtQUeP6XwQIXVPzdZ8kKlO7ytaJaPxmTXA9CZD0/9NoSWq+FSY4gpk
RO+LiSETk9TgyuEf8zpvCAtRoIL8ohlmoXEy/rkhgM6JpOyQSWF0X6bzqlRaRrvX
HSWB9fPfEKSLVO8G1cZTAVGUVv9Ku/5l09TcrQxZfTbhgjYbI8XMWHGtN2Nf5cg=
=ZJ2v
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
