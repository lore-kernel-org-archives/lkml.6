Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47671C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F228020652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uoz1LmNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F228020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeFTX0j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:26:39 -0400
Received: from ozlabs.org ([203.11.71.1]:43419 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932224AbeFTX0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:26:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41B1Dn3Bppz9s3R;
        Thu, 21 Jun 2018 09:26:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529537196;
        bh=DnWTDaY434yf2CqINcWVG+MShEh4faHoUG5SSzMoE8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uoz1LmNUwM0d+yuejQ+VcNlWNW9QCpXp3lGZCce8vSqcua0uYzBebNJ3OyP96N0cP
         8BFiEZr9LejK5v+332sPSnVWxaF//IqmBkG8AYRQOnzA82b6xNLBjdUaGwf/lnNPXh
         D3W4G84Wa6uSDAvUHybwxJ6fxWXJxIjxvZ81yiYOfxODKYaVz/2zYVgjzYwVncTlxh
         ObyqIwfESFLGoIFmfDjAJ1CBYdEoy6Elv5yCKzKkFr34+xtjTsFJ8wrR8/ucoshUpc
         9w7SJZYw7eYVuO3wWvRN0nOwxsNaJsKoLqcyVFOS5hdfDbAItU/g+C7AmHArKcT7Jx
         Vp2p0uEecRC9Q==
Date:   Thu, 21 Jun 2018 09:26:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chris Mason <clm@fb.com>
Cc:     Josef Bacik <jbacik@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>, Tejun Heo <tj@kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Message-ID: <20180621092607.3e13e43f@canb.auug.org.au>
In-Reply-To: <0CA8215A-6529-40B1-90FB-A5902EA47549@fb.com>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180131095446.443670dc@canb.auug.org.au>
        <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180201092551.759f32be@canb.auug.org.au>
        <20180314101704.51aaae7f@canb.auug.org.au>
        <20180403122919.3c503f74@canb.auug.org.au>
        <20180618133817.6faba27e@canb.auug.org.au>
        <0CA8215A-6529-40B1-90FB-A5902EA47549@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/faqi5hVO4SfNG7GmwxJOv+N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/faqi5hVO4SfNG7GmwxJOv+N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Mon, 18 Jun 2018 14:05:32 -0400 Chris Mason <clm@fb.com> wrote:
>
> Really sorry for the hassle, the f2fs subject line got this filtered=20
> into a different inbox. Tejun and Josef are working out these btrfs=20

Ah, that explains it.

> cgroup fixes, so I've pushed v4.17 to my -next tree for now.

Thanks.

> Dave has been doing the Btrfs merge window for some time, so focusing=20
> linux-next on his tree is a better fit.  But either way, I've fixed my=20
> my email filters so you're back at the top where you belong.

I'll just leave things as they are for now.

--=20
Cheers,
Stephen Rothwell

--Sig_/faqi5hVO4SfNG7GmwxJOv+N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsq4o8ACgkQAVBC80lX
0GwOIAf7B2AmazbsG5Ctu22dUEGqQ6KxhsTUOzKwTCvApkP5GfQ2GfuOFSmhNSm0
87wyUeXxd/AIxyAOLrR8aQhz+gm1U4ZxhEm+QwFkr0ORtOHj9+4iZ5myQrsdel8t
ErJRYRZ6AbXDv1s6QyTkALK2+E60q8Je071H1t5i2PhFQ1lNSBs5imrOhf2kqV66
2V08vDOjSdxJr9Gj8lPeuy5I7zzW/xH0yWSWgwS0X6mB9T5Y2Rs0msKP1lWhS0nH
9JmgJ+QQGVXyZ8bBZEBL/2LhSOOvQoRRf2Y9vLg9eMimZf9Czb3DIlhtxAN3dfvb
cbgQSvAnCPHgOqekOBWgmdYJIRW0sQ==
=RwbE
-----END PGP SIGNATURE-----

--Sig_/faqi5hVO4SfNG7GmwxJOv+N--
