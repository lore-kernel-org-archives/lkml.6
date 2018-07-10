Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2141FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29852089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="d6UzgYzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29852089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750865AbeGJEFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 00:05:21 -0400
Received: from ozlabs.org ([203.11.71.1]:56389 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbeGJEFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 00:05:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41PpWX6Rmyz9rxs;
        Tue, 10 Jul 2018 14:05:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531195513;
        bh=LJ/erIaSXqda3vbme+iloh3jQLqj9InUAQsttMqZuYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d6UzgYzidAA1kt8akNOjOA7Tz5VhlqiQcuFpUy+bdAFVh3Vla7+tLCv77FXk41LC/
         fgJdmUSand2UKmOpJEMzIcgmijqSQK+B4aumqfZWQbr2bbrlXKkNMkbHWYohHRCDJQ
         vGGYPz4bi9IyG/AyW3pwvN69E296KUxT8JXJPefFbzCt/o6Qn9R87xseIOOHMUoQuh
         7HBNoSJGO5IkxQ/932BX4DX44KDye8n9keVozZ2gzbAeWjl+WQgh1PEkjmwFYKbaMs
         B93BkzbM8FwFpajohwzfsbbYv9J/mxiGz4lD96o4Sw2yZG5HNgxTJ1DNgReqR3hGeU
         j8/N8iDGPswZA==
Date:   Tue, 10 Jul 2018 14:05:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: linux-next: build warnings after merge of the rdma tree
Message-ID: <20180710140512.53d67d40@canb.auug.org.au>
In-Reply-To: <20180710034157.GA17400@mellanox.com>
References: <20180710113342.605e53e8@canb.auug.org.au>
        <20180710034157.GA17400@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AXPEU1Cs7but9NPo_7FPSCJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AXPEU1Cs7but9NPo_7FPSCJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Mon, 9 Jul 2018 21:41:57 -0600 Jason Gunthorpe <jgg@mellanox.com> wrote:
>=20
> What compiler is producing these? I got nothing from 0-day build
> service or my local gcc-7..

The x86 compiler is a v7.3.1 cross compiler hosted on PowerPC LE and
built from sources.

> They are false positives and I guess we need to put the
> uninitialized_var back that was hiding them.

Rats.  :-(

> Also curious that the powerpc compiler gets a different set..

The powerpc builds are done with:

$ gcc --version
gcc (Debian 7.3.0-21) 7.3.0

--=20
Cheers,
Stephen Rothwell

--Sig_/AXPEU1Cs7but9NPo_7FPSCJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltEMHgACgkQAVBC80lX
0GzmKAf/TQ3jI1F/1ppuDloSvl/wgPT7Nibra2HbZlIMH9o8td31xB4GGw7TcqIp
hVjnMsAL385tLSIWvztmM9qdIsmDWQAOeJus4Sdsx4vqO4DhXvA7EHa9bu3P8S4O
DsVmrQPAWF9/N1QEFEcVVZh84mBP6zgyY/hzsmbq2JahN5JWHdkz4/oixcaQhQbQ
TEG+uo+xtmHyLXE2s5pLaTsfYQ87BGCxwr+ASn+X44BcIVI4hTfoS0fTqDDIG9bT
sCciBRYE016sXuxpgQWWBGt7D1K9Db0mHs/PWcVtXBQ+2VlJXi4dcxiih3zuxzaA
aW4TEPVrNwzHxtXD+dVuQ/P0IiRHhA==
=Du4I
-----END PGP SIGNATURE-----

--Sig_/AXPEU1Cs7but9NPo_7FPSCJ--
