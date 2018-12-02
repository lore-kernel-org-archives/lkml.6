Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DFEC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239CB20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uj9dlfYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239CB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbeLBX2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:28:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40646 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLBX2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:28:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so4841233pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 15:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zj7tCjPivy25jz/52Kl7vSRghtNwUpCnCqUHIG/8HFQ=;
        b=uj9dlfYCJYBABx0MIIpXI36Qo/WWeasgUJjO0iJ/ZkR1HV7my6Wcfj/lFem7qYd4Es
         S9AxeoRxl10cRuduJmyIkHvfOhq0ahSDa5OFAucezcJZvzn7U5AgMBADJW5SkX+FemcC
         C5QaSqwZUwO57Dt5oU+DrnfyrvHa2roI64+AC1pXbpCy1qy7DOnv0vkt57UQiQwMEIE2
         rZ2KREnJ/KVgko6erWa2DoVjawPDozXH+j2FKGl353BUiTZigxIExFJacKxaXCw/CWgA
         HYYkjDSUudxlP45HUZJIYXth7A2BbegbF9Yz/HVkr9rKs1Us6TfE/07P2QP6uXxwctT2
         3bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Zj7tCjPivy25jz/52Kl7vSRghtNwUpCnCqUHIG/8HFQ=;
        b=QVREVaPRZEsbbrkGLXPgXDWuUx2dq4CW0MXQq6c/HBS7PBpbnp1SB9I00l3RKTm605
         FgfOeYXR6XMT8wii3dscaOJ/myJ4rgvchpZkbSsDnZN/ZQv0y2rg2pjEc08FSCMVwAOo
         JjgVtDoKRqVH7dGn0QwMrOM/4IjAOSUdLRVRrx3INXRNROXelVqB92S+59fbDgI200zo
         QPC2Qv4HI+Hy+FiWbikTchdlvbqKXyRbVFsqXQ5Z9XuVT5i5ppYVFFwD9Ph0cvG8+5Iq
         IeM0hgRs85buePIU9kGT4CjHq+XgJavxVUoWRXmpkwRLbbGNBR5eoJ02TsUw3wsC1ckH
         iwbw==
X-Gm-Message-State: AA+aEWaItDPTjO9buh4JwdxcKhhlwVzp37YpM7/op1hmqfQA92UY2xs2
        gQNJw1Ql7sNIh7j+LrhIwsU=
X-Google-Smtp-Source: AFSGD/XyMC3QA+MQoDHzpkOrA1osHbsselGGRiFnVurfHRo2akJAatVT230ckgqlbJJHKjq/90YUvg==
X-Received: by 2002:a63:6984:: with SMTP id e126mr11601005pgc.143.1543793315340;
        Sun, 02 Dec 2018 15:28:35 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id v76sm29272072pfj.145.2018.12.02.15.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 15:28:34 -0800 (PST)
Date:   Sun, 2 Dec 2018 13:28:32 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 0/7] zram idle page writeback
Message-ID: <20181202232832.hou645rlbvo7z5ar@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <20181127055429.251614-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6shwijuvv6x6jsdl"
Content-Disposition: inline
In-Reply-To: <20181127055429.251614-1-minchan@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6shwijuvv6x6jsdl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 02:54:22PM +0900, Minchan Kim wrote:
> Inherently, swap device has many idle pages which are rare touched since
> it was allocated. It is never problem if we use storage device as swap.
> However, it's just waste for zram-swap.
>=20
> This patchset supports zram idle page writeback feature.

Revisions look good to me. Will also try to give it some testing this
week.

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

> * Admin can define what is idle page "no access since X time ago"
> * Admin can define when zram should writeback them
> * Admin can define when zram should stop writeback to prevent wearout
>=20
> Detail is on each patch's description.
>=20
> Below first two patches are -stable material so it could go first
> separately with others in this series.
>=20
>   zram: fix lockdep warning of free block handling
>   zram: fix double free backing device
>=20
> * from v2
>   - use strscpy instead of strlcpy - Joey Pabalinas
>   - remove irqlock for bitmap op - akpm
>   - don't use page as stat unit - akpm
>=20
> * from v1
>   - add fix dobule free backing device - minchan
>   - change writeback/idle interface - minchan=20
>   - remove direct incompressible page writeback - sergey
>=20
> Minchan Kim (7):
>   zram: fix lockdep warning of free block handling
>   zram: fix double free backing device
>   zram: refactoring flags and writeback stuff
>   zram: introduce ZRAM_IDLE flag
>   zram: support idle/huge page writeback
>   zram: add bd_stat statistics
>   zram: writeback throttle
>=20
>  Documentation/ABI/testing/sysfs-block-zram |  32 ++
>  Documentation/blockdev/zram.txt            |  51 ++-
>  drivers/block/zram/Kconfig                 |   5 +-
>  drivers/block/zram/zram_drv.c              | 501 +++++++++++++++------
>  drivers/block/zram/zram_drv.h              |  19 +-
>  5 files changed, 446 insertions(+), 162 deletions(-)
>=20
> --=20
> 2.20.0.rc0.387.gc7a69e6b6c-goog
>=20

--=20
Cheers,
Joey Pabalinas

--6shwijuvv6x6jsdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwEap8ACgkQ2rGdfm9D
tVLl1xAAr3tJ07J2CYMtIxO+HjgIOOKKxRD7L7RS0eTFhuOR3kq5vIYTyWUQMuLP
r18sOjS2BTQw4PnWutxcgWay9h/MO+Htm8+O06muiybgEwTHo1w+yRJyZGjc4tD1
QRDN9R9xHRu1djq0jlBYhVR7ARUt80n8Mp4JVzpPRqehofCXAnjNoE9TmxQphdN1
10TZYgtjOtt/aQHl8yGMwuby2Vwfo8XSzGXNd/khmI76tZn82TVheAioyzDXT6i0
+pB1Hglktvdsg+AGfA9IUEnbnyihlpbjaIlDVyWoe0mcar/BjBdlvD+6G0PzShzs
u32ZjrC4qe6I2FL+nENoXsb3efjVF7QBOIaysVMOUFas+4h1a8oKj0qp5xSS5R6U
mNQ5DiBYCSdaXPctN+E00NGoSoBCLZlWAh9g15xtxdA5PTz0282SlRQ8w8UKhXUe
OhU/lryDluYV+Fz8OlWFsRWHE3/Rmb20KVNNkld4E98tPzqoTeRqa670nJFEj7Xg
nhtUL35nZ9aiEAZpHqQE87UZAjWB+8uuYYSaiDAz7RFbWknOoudvI2B2OAEo2/u4
/l5PL4LHm5m/dTLgJIsHJIijTAVRqc2lv0ZOL6UQjO4PHu/O0kPYLAn3GDqveUkS
ld5f361vqLY3oVGeX2h90vfrJH+5ke/G7F+MDk9mA6+CoLQhp6g=
=mDBH
-----END PGP SIGNATURE-----

--6shwijuvv6x6jsdl--
