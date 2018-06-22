Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAD2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6B123C29
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g37mt4+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6B123C29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934270AbeFVB46 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:56:58 -0400
Received: from ozlabs.org ([203.11.71.1]:33559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934184AbeFVB45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:56:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41BhWq3Bscz9s47;
        Fri, 22 Jun 2018 11:56:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529632615;
        bh=/9pRJH3gNelqFF9pzFSZMvf7WCgKCRGDKqYiNDwoG/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g37mt4+DjdM1hgk7qkHJ6EX9XblhubSKhy806mmxmecvCRezIrhcNKYZUIBJ2v7OK
         gxDtGAeMEtpxaE3AylnN8JV7eAwkgzM+zD4cPXwZVIFkEyrFFyQhJcMMoLrf8IOPpR
         SpiG9Irdt5QKmUEiuAs4NYaSJMRsEr3mE+voX6zTxtkN2nrYWyduKn7dKMIkQj9Njx
         m42WlWqx2eh1lJ8QxPCMTz4lfRX615Kr+GxKhvXmcd45yJnJgoqOeDpdOUDYqSvV88
         EkW4NiuTfFJ1P9bHOPg3wqQZ07udha91yHMYylU1GSxYLgaz+ZlHjGF3gWO/y4KZ5P
         bC7PzEGi+cYRA==
Date:   Fri, 22 Jun 2018 11:56:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: linux-next: manual merge of the tip tree with the vfs tree
Message-ID: <20180622115654.04cef951@canb.auug.org.au>
In-Reply-To: <20180622115346.1e9cc433@canb.auug.org.au>
References: <20180622115346.1e9cc433@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OWNquzA9DJZdnomFF/PgTEG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OWNquzA9DJZdnomFF/PgTEG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 22 Jun 2018 11:53:46 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> diff --cc arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> index 38a54f56ff40,7b4a09d81a30..000000000000
> --- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> @@@ -1270,9 -1861,16 +1842,15 @@@ static int rdt_get_tree(struct fs_conte
>   		rdtgroup_default.mon.mon_data_kn =3D kn_mondata;
>   	}
>  =20
> + 	ret =3D rdt_pseudo_lock_init();
> + 	if (ret) {
> + 		dentry =3D ERR_PTR(ret);

Actually I have removed the above line as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/OWNquzA9DJZdnomFF/PgTEG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlssV2cACgkQAVBC80lX
0GwK/Af9GKb4Sdcrjz20E8fA986ylWklsNrUoVQvw6qi+fgG6GNTEu9rCYXHUZ11
8UVxzXzZu54hIuaJSEUsureCpzvtP9gZ/zV//5l9C0rH3wNhVfQ8OWWRN686BfnJ
R626P2q+mFzdMX0ZIGD6fgoTFcZvu+XOrR/dPtjV5SwbdujmxFu6mgFwBFJnGOOI
dypRWz6/hFtd5QMazoXXZOIMaB3WUq9KGvPG4uoNHiQ90LQwXOFKX3bV+nqoXisU
RBhlfmHURUmyFf6yYb4PQOt9SqmzFg8tYBsu0brjTDrJwbf5yXrU6P0vFuBYCWZn
Bwlify6x7UlwCIs9WBgvJg4NQG6VtQ==
=iYIR
-----END PGP SIGNATURE-----

--Sig_/OWNquzA9DJZdnomFF/PgTEG--
