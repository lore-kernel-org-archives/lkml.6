Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F41FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D828520866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VBEU5V1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D828520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeIKDBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 23:01:25 -0400
Received: from ozlabs.org ([203.11.71.1]:48681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbeIKDBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 23:01:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 428MY30jflz9s2P;
        Tue, 11 Sep 2018 08:05:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536617115;
        bh=SU4/b7RLr0A3LhfaYbFt2GVNjCR20zMe5Hd3z82R4U0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VBEU5V1ajnkx0IrlxA8PlPTtPR3aZ3lrz33wQdlTznIa0ksOBbLR/Hu+wn56iP23N
         QSU2mc8gVfHWIdav1j0LOFxwyWzh/YQTSSWr+Aio2106tpRU8g6Cvxi5v0lNkdj8f8
         3c6RytsMyTmZLcoPNZqgO/0Hg9X0LLzZfWNhv0Bb9SWXplmoPXAcN/gZbQtvskqJBF
         4efPr0ENdct2Thwata+kzKCdJk6C4oEAIwe1QonOHgBLO4QsG8a6qgEi5vwJ6KkBur
         8uDylPR77JnJBurnn2w409mZPa6auhol+nIqnZfPx0QSKs2au2lQtyDChn/NYuokRm
         7ByLd6Gh5V1yA==
Date:   Tue, 11 Sep 2018 08:05:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: Regression in next with apps hanging with vm_fault_t
Message-ID: <20180911080503.62cb4699@canb.auug.org.au>
In-Reply-To: <CAFqt6zaRFW+bwVmWbMQ9ni9VJzsa1QMPRLFDCE6X0yQbvbPukw@mail.gmail.com>
References: <20180910182143.GW5662@atomide.com>
        <CAFqt6zaRFW+bwVmWbMQ9ni9VJzsa1QMPRLFDCE6X0yQbvbPukw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j5Iubq945/9ZLGrDVNVsQoS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j5Iubq945/9ZLGrDVNVsQoS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 11 Sep 2018 00:17:45 +0530 Souptick Joarder <jrdr.linux@gmail.com> =
wrote:
>
> On Mon, Sep 10, 2018 at 11:51 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > I'm seeing a regression with Linux next with commit 7b6ec2ae877a
> > ("fs: convert return type int to vm_fault_t") where apps can just
> > hang.
> >
> > The reproducable test case I have is to remove a distro package
> > and then add it back where adding the package back just hangs and
> > the package file seems corrupted.
> >
> > This is with ext4 rootfs on MMC, NFSroot does not have this
> > issue. Any ideas? =20
>=20
> This is a bad commit and there is a plan to remove it from all the tree.
> Not sure why it is still showing in linux-next tree.

OK, I have removed that commit (and the following fix patch) from
linux-next today (in case Andrew doesn't get around to it).

--=20
Cheers,
Stephen Rothwell

--Sig_/j5Iubq945/9ZLGrDVNVsQoS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluW6o8ACgkQAVBC80lX
0GxEtQgAgBLbg5+wsTC2pFbW0hOcgejD6qzAgavjbt8PFo7NQK6AWMjoZ3rbiYmK
cNss9cL/umRagvqVUnPJSrr7u7TAdzuRiYJ3ib5rtxRgbRDDSvnX+01JQRSu+GWA
xkEPe779xSmz8n3VYgOgDeg4/dWfprpoyGsDW4yaS+p8qL9D+Q38NCvSmMFr0enO
/wHlRYqfZp3N6ukGl58Ym9nM1RKMlBAGrSAwMw0XsyxU93xprUzAu5a6dt94ZzyS
yaHSy5KHRO/vyu3bZjehZAwB9LoxWwAnvfPoXm/5s5CLg4XCpMpLBAiSYFa+8Xi4
vKak8NAJ7FRHM0pmbKUcfCCi44dibA==
=iTSf
-----END PGP SIGNATURE-----

--Sig_/j5Iubq945/9ZLGrDVNVsQoS--
