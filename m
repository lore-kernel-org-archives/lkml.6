Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40C320855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N+eJs+Ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40C320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeKZLpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:45:17 -0500
Received: from ozlabs.org ([203.11.71.1]:37819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeKZLpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:45:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4337gN2FNFz9s0n;
        Mon, 26 Nov 2018 11:52:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543193568;
        bh=7SkV6QFeXwKdKf5TYYyLcwsZvKUdmYHX8KyPX9xQZkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N+eJs+Ys42dqVc1CHiNo61QQk/cqJgBVKzymLEW3yeoeyQ2w5IZQtRLoVcYXNudOL
         7ZceJ3kgfmRqy1w2DeAP62lecQrU3JkyQsMcZmazgUib6kHrITIxO+xfsG2TDK7DoG
         3rxW4LhAPiTxnxWGG/KIBROmJwXAYyl9opEbtONBz5DZQO4pKF3OIyw1eDZm2BHegt
         BynDonBM5irOdNl/TrSGqfea5EiE+eCCbaxeeMYMVkslVbMa0yDF+JLY4aM/5YIdto
         4SR/RM0aDbnD6NglkUq35TpLKmqZWwDB+LShwaanM9NNHI3NQTvlt9timSzSoF4iaC
         O0J14uhRCyL+Q==
Date:   Mon, 26 Nov 2018 11:52:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     Sachin Prabhu <sprabhu@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>, keescook@google.com,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the cifs tree
Message-ID: <20181126115247.53cbf7be@canb.auug.org.au>
In-Reply-To: <CAH2r5mvtFzp=nYK+J92vh9y4tsNLT3rD4a2+mB9LMyWcFN-EHA@mail.gmail.com>
References: <20181126111415.5cf17f39@canb.auug.org.au>
        <CAH2r5mvtFzp=nYK+J92vh9y4tsNLT3rD4a2+mB9LMyWcFN-EHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/914m7+LezhCz7kA/2bBuqhG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/914m7+LezhCz7kA/2bBuqhG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Sun, 25 Nov 2018 18:31:40 -0600 Steve French <smfrench@gmail.com> wrote:
>
> Both of those cases are intentional fallthroughs and there are
> existing comments in the code noting the reasons for them to
> fallthrough
>=20
> (also can see the reasoning for these in the commits which introduced
> them from Sachin c369c9a4a7c82) and dde2356c84662)

I am not questioning that :-)

The gcc warning can be turned off by adding a /* fall through */
comment at the point the fall through happens.  Kees and others are
working on the several hundred other places that need annotating.

This one just popped up.

--=20
Cheers,
Stephen Rothwell

--Sig_/914m7+LezhCz7kA/2bBuqhG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7Q98ACgkQAVBC80lX
0GxJXwf/YbJmvqG4cflEZDjeqL/qziZ5xfP7S3vWetuFVBU+fYrAGVxeKhRHmb2F
6fk3UNhtanCj895jn4xW7JhyKJ3PBkrtwJRcYtnfGR1TwhXvLX/wwGOFi1PqfUKe
1tdBF29iXUoKik8lqMGUpJFCDpTSems77gMSuvz1I3B5/rMMueXqdLBaQpGROm1q
/OrNs0yJ89EKiIrGNLH/ii6c5Fx2z66/P6fkx2rO0fACbgJy1V3UimaStofutHJw
8WyLjhiYzUBnuEnLB8GbBJCIz8iFUw6UnfrZgdXsjpIwxNhPd3t/38oScK+FzWm9
9eaTlVopq0D91mJbp5BVElIsdjC6aQ==
=p9lr
-----END PGP SIGNATURE-----

--Sig_/914m7+LezhCz7kA/2bBuqhG--
