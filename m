Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA4EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E072174B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="camr7Lxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E072174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeHHD3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:29:34 -0400
Received: from ozlabs.org ([203.11.71.1]:48277 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeHHD3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:29:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lYJn0sz1z9s4V;
        Wed,  8 Aug 2018 11:12:25 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533690745;
        bh=GA6M2+hINIWaVbN/sXCBEASmIt/43LJCpNAYz86BW/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=camr7LxhesFe8DPj6nAxpTlZLKUw9Lp7BMRf1PIVW1Ss1X40kH55YYT1QZqu8ZNDG
         SjEsFu+1xyjqcT3juwZ8W099A1OpUTFS1Rmh9kWwRLV9bAAQw05PleYigJIF5Wlu+B
         Aen2FQrqn55a8J7tkrxvJwjrTZCeOgfF/MIE9g+wnMGwNbLSzuUK2ctqgtjW9YMhXb
         8Jw/w9voXiMYVPF2PvM6W+qJwwS+hzY6vYwJwUo6Am9CiLAKFa2EvV63E9s3WcNtJU
         tizF83MbK1Mjv2xfRHIVt9EYFLTpqvjzwBB5RF8IBvE3CZhQc8sNYNEEBr0r8/vt5x
         HdIlnTFllLB5A==
Date:   Wed, 8 Aug 2018 11:12:24 +1000
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
Subject: Re: [PATCH RFC 00/10] Introduce lockless shrink_slab()
Message-ID: <20180808111224.52a451d9@canb.auug.org.au>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yFMBaxGy2JljibeAimkhX54"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yFMBaxGy2JljibeAimkhX54
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kirill,

On Tue, 07 Aug 2018 18:37:19 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrot=
e:
>
> After bitmaps of not-empty memcg shrinkers were implemented
> (see "[PATCH v9 00/17] Improve shrink_slab() scalability..."
> series, which is already in mm tree), all the evil in perf
> trace has moved from shrink_slab() to down_read_trylock().
> As reported by Shakeel Butt:
>=20
>      > I created 255 memcgs, 255 ext4 mounts and made each memcg create a
>      > file containing few KiBs on corresponding mount. Then in a separate
>      > memcg of 200 MiB limit ran a fork-bomb.
>      >
>      > I ran the "perf record -ag -- sleep 60" and below are the results:
>      > +  47.49%            fb.sh  [kernel.kallsyms]    [k] down_read_try=
lock
>      > +  30.72%            fb.sh  [kernel.kallsyms]    [k] up_read
>      > +   9.51%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_it=
er
>      > +   1.69%            fb.sh  [kernel.kallsyms]    [k] shrink_node_m=
emcg
>      > +   1.35%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_pr=
otected
>      > +   1.05%            fb.sh  [kernel.kallsyms]    [k] queued_spin_l=
ock_slowpath
>      > +   0.85%            fb.sh  [kernel.kallsyms]    [k] _raw_spin_lock
>      > +   0.78%            fb.sh  [kernel.kallsyms]    [k] lruvec_lru_si=
ze
>      > +   0.57%            fb.sh  [kernel.kallsyms]    [k] shrink_node
>      > +   0.54%            fb.sh  [kernel.kallsyms]    [k] queue_work_on
>      > +   0.46%            fb.sh  [kernel.kallsyms]    [k] shrink_slab_m=
emcg =20
>=20
> The patchset continues to improve shrink_slab() scalability and makes
> it lockless completely. Here are several steps for that:

So do you have any numbers for after theses changes?

--=20
Cheers,
Stephen Rothwell

--Sig_/yFMBaxGy2JljibeAimkhX54
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltqQ3gACgkQAVBC80lX
0GxavQf9EKFejil3+n6vL60fNlHSHDQnmX05ed6HsGTXza/1bbyxBdOOk6PkbbkR
Am2K5yPPUShKvsfwpy8pwJCzt8xxPcGSwtEg17G/JKGTEnd4zs8zEC8+z1RtZgzn
XtytDz87/XRfM9dX7thRhY2z6tUpNu5ZcuKOgJ912XJ8riurODEOb212V+vc/G9G
8g0Q4J1Pb99/sgoEljl+iQL5ZsFqCADCBaFwmYL0zLfNgs9zrUimflnNWOBQUYbQ
bzxrY5qbdaWRCmVh6f5FSrzXoxoOk+WJ+Ekoq//mTTceZWFuZdNvh9qXWy8S+dN2
KqisepOQ0+Dh+0GGXSanG+jFbPyFzg==
=26Fb
-----END PGP SIGNATURE-----

--Sig_/yFMBaxGy2JljibeAimkhX54--
