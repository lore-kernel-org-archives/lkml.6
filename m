Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6D2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C32E20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a5+aAgEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C32E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeIGE7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:59:00 -0400
Received: from ozlabs.org ([203.11.71.1]:33101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeIGE7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:59:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 425ylW5YBjz9s47;
        Fri,  7 Sep 2018 10:20:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536279655;
        bh=H9Vz1g2kremqZ1HNAh9cLrhLpns3eoFNxF5HngGu9Pw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a5+aAgEIbkuQ+1F5UVuDVTkR80DKUsdvVrk2pFF0a4JJ/2QHDnJp+wQGj4ooYwtqH
         p1Q1O4Wi4NUcb2Lvi5OZTD9MfVngamZSkBlvhNzw4bQOd/Wic0XBLO2tD5fuF3dnf9
         2s5uJNrTcDND1kI9uPFf8/MSWxk1iYuxVbPNyqq7/H9KEQHjXkuoi6vIG9BqVi/FBw
         tPgQ4wnz7MS9/YGE1CN6ppX6o7pPZKZW2m1yf3G/NvJvDO3iI7it2Pvi6cBZFehMZ1
         AUpSPMHJAoNmrqM1OEV1R7c3n3fQEL4rhcyweXJx0x2RNTWHUUYEIe9RsD9MlSRTgd
         g8wU2cf+Q8UJQ==
Date:   Fri, 7 Sep 2018 10:20:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20180907102055.001777b8@canb.auug.org.au>
In-Reply-To: <20180903094702.3e32d8f5@canb.auug.org.au>
References: <20180903094702.3e32d8f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o00y6DcKOPhLZD+oNbDYlQD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o00y6DcKOPhLZD+oNbDYlQD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 3 Sep 2018 09:47:02 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the net-next tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> In file included from drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function '__i40e_add_s=
tat_strings':
> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: funct=
ion '__i40e_add_stat_strings' can never be inlined because it uses variable=
 argument lists
>  static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_sta=
ts stats[],
>                     ^~~~~~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   8fd75c58a09a ("i40e: move ethtool stats boiler plate code to i40e_ethto=
ol_stats.h")
>=20
> It is not clear this patch has any value anyway as the moved functions
> are only used in the file they were moved from.
>=20
> I reverted that commit for today.
>=20
> The same problem would exist in drivers/net/ethernet/intel/i40evf (where
> a lot of code is duplicated from drivers/net/ethernet/intel/i40e) except
> that this function is not declared inline there.
> Luckily, i40e_ethtool_stats.h is only included my one file
> drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c, otherwise there
> would be multiple copies of __i40e_add_stat_strings().
>=20
> Surely there is some scope for factoring out some common code between
> these two drivers?

Ping?

--=20
Cheers,
Stephen Rothwell

--Sig_/o00y6DcKOPhLZD+oNbDYlQD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluRxGcACgkQAVBC80lX
0GyM5wf+PcEcOyz/jpNRyt5uTMeWLF8jfjH8roVMR1qLwg2/7nna+QGu4GX37qKx
LO6KqzAczCLiYqckpLv6t4szEFhZtMGEiY5dSBiGp46DgBt/Z61kJ1lcxSD+64lt
MmpCJ65z8LDuM/WdvhjOg7LhydcDLX8ialOl6migO/OC6ucYTowkJpmZcid6ywqu
f5ZkwzHGPVRjFYromfRIONjm4mY/eJmN0HNfDRdWe0mXB9h56qO7opJJgR+MhMwC
gdzFsF12E2QMoPUn0mI3ML/mbcdG2+9m5T/Smx5oV5326/Q+Nzbgb6QH7js7Q06e
GUmMHLPsDxi3SGnI+knh5Ei84HXmcQ==
=1tsM
-----END PGP SIGNATURE-----

--Sig_/o00y6DcKOPhLZD+oNbDYlQD--
