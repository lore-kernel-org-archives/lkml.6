Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AF7C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E1124D6F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GFAFT3U7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E1124D6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967459AbeF1X7D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:59:03 -0400
Received: from ozlabs.org ([203.11.71.1]:60855 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936219AbeF1X7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:59:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41GxZX0bxVz9s0n;
        Fri, 29 Jun 2018 09:58:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530230340;
        bh=JPdZZW9II2DKuPTJU7uanoe+YUeVltdtKVDwIWpGhnc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GFAFT3U7IUhhW8dZxL4j4NPTurFyVw02wuKhU/vKawa8/9Zn2LxEKAmj8q5tJjSZW
         B1THuYBGfG5t/FicZJt5VbUP9eAN3yaATZpsJcnRWhTtXxpDZEyYeXT04+503KpiG9
         xKvZ24rlyDEJsn7PZL/H39ms4zu3EPPFdP05DQqWnKRpm63GUhj7wWuc4L/FMrYCZP
         kPBACcnQnesxTyPH0bV2hdPPNH9jce/k4TXCmT3pL46DVnwOKSgQvr30lvKhwDyzGm
         uwmQrCC5kgWB+0VlxHAg5VWstm4O4w3Bvee1IZsd4ZIsi+at7Y+kb1Yqu74pmTKuWh
         I1gyJkYUryy3g==
Date:   Fri, 29 Jun 2018 09:58:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the btrfs-kdave tree
Message-ID: <20180629095858.655ae88f@canb.auug.org.au>
In-Reply-To: <20180628161102.GJ2287@suse.cz>
References: <20180627085936.4f9cc4f2@canb.auug.org.au>
        <20180628161102.GJ2287@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nI2ElGffOETyszhKHdSp_Ti"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nI2ElGffOETyszhKHdSp_Ti
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, 28 Jun 2018 18:11:03 +0200 David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jun 27, 2018 at 08:59:36AM +1000, Stephen Rothwell wrote:
> > After merging the btrfs-kdave tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >=20
> > fs/btrfs/print-tree.c: In function 'print_extent_item':
> > fs/btrfs/print-tree.c:56:3: error: implicit declaration of function 'bt=
rfs_print_v0_err'; did you mean 'btrfs_print_tree'? [-Werror=3Dimplicit-fun=
ction-declaration]
> >    btrfs_print_v0_err(eb->fs_info);
> >    ^~~~~~~~~~~~~~~~~~
> >    btrfs_print_tree =20
>=20
> Should be fixed in today's branch.

Sorry, still broken.  I fetched your tree only about 5 minutes ago.

--=20
Cheers,
Stephen Rothwell

--Sig_/nI2ElGffOETyszhKHdSp_Ti
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls1dkIACgkQAVBC80lX
0GxQXAf/YfufiSebI9R2qYp/QA0I67edCMf19zdig0If3eJCDE+3piD8HDTVFfHs
AqO1NoFFnhAOBTyEjMMQBl9rvVMfhvNYc4OncuFu4aDooe99S5nXw73d7C9pEysn
tfzmZndJ+GrfwS9ai1v2MklmLfnlHtq0deq3LwD4s+jU2/AAXClDN6G90fsxSnvA
N6YHphWir89r5IPN8Qd3SU1xUT/GCVZ8KKl3vWclIF13U63Q+580clBXBy88LDx5
jZz+X3U948pAKGkaipvhOQ/SCuqTLQo6jgILClj/zi9hQvsO6J3lFJng6JG+5VBC
IqeEYw3na0+2/18+yA9JHGyKk1YEWQ==
=1SJz
-----END PGP SIGNATURE-----

--Sig_/nI2ElGffOETyszhKHdSp_Ti--
