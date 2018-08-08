Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35899C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82B721706
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="u+MLSEI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82B721706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeHHDZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:25:34 -0400
Received: from ozlabs.org ([203.11.71.1]:39809 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeHHDZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:25:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lYDD06Gfz9s7c;
        Wed,  8 Aug 2018 11:08:28 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533690508;
        bh=mkyEbUMdNLpRxlcL9jwEfnIGxZ7UEmGRVe+s/vO3D/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u+MLSEI/mrL4nHJs7oMVfVS1JvufsWVYrCaqhUwvhqB226hs5h6Ys1NVM7Qq3o8Sc
         Sr3+4p/0TidbIcNPsEhIVEKnZMi8G8IbIPtYHuFr4ghLELfujdE/HA0Xn8chNte/FL
         7U5amLr9wTK+6RHnPwy2F9ONaa5gZFHhUMBUkneu/scOSrdlXrgexO4egAj1ngp0us
         l2hoBCbNMiV+JV4U+1CJy1SqPL8n1cnKfOf01YIsunZTeQDYBlVtHRTgchrjfLKYat
         IplxrwSmyhyHmu4PtWoDzvmgB2XRWUfXNQ+n3fk+3LR9ma4+Xyf9LJ6WzNwGESYnX1
         sPR+sy0M5fxaA==
Date:   Wed, 8 Aug 2018 11:08:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, vdavydov.dev@gmail.com,
        mhocko@suse.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
Message-ID: <20180808110827.65631461@canb.auug.org.au>
In-Reply-To: <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
        <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//wODAd0V11DVLAu0Qy+Ta_s"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//wODAd0V11DVLAu0Qy+Ta_s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kirill,

On Tue, 07 Aug 2018 18:37:36 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrot=
e:
>
> This patch kills all CONFIG_SRCU defines and
> the code under !CONFIG_SRCU.
>=20
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

So what sort of overheads (in terms of code size and performance) are
we adding by having SRCU enabled where it used not to be?

--=20
Cheers,
Stephen Rothwell

--Sig_//wODAd0V11DVLAu0Qy+Ta_s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltqQosACgkQAVBC80lX
0GxHGwgAjVnIoT20e4JSYycGiEqHHa55yGjv5LKngiTucYPHmJ31bMFrkK3RVd7s
r6M6RVXSQVA21k/Vy8hPV0q+sHChA38xfCx0ZebSrsGfpzy3x/5lgGBUNLZmEoW1
bsYT5/XV6AUM1bWbmO+llnIC4LSL4dN+RMYngElcto8++M6E5YG+5YGCNs+wcrKu
Xg5jSShO/G2U0nRMENEeXexcMeRfShGpAeejrZScad23wkkx+TJ+O1lw1ln6afdv
c2PRz3pEYmWINiCjZNEwOz1NGsjmHh8IgWnfP3rNID4iq1Gw+3cxO5L+cfX9vCzv
jhofBYIo7A5Yf3dmGUvsKTqx7SsuLA==
=4lXj
-----END PGP SIGNATURE-----

--Sig_//wODAd0V11DVLAu0Qy+Ta_s--
