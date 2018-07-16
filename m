Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F69ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE42E208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUgq0cnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE42E208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeGPIZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbeGPIZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:25:42 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC76208E9;
        Mon, 16 Jul 2018 07:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531727973;
        bh=ByOgweLHyFK2hG+QtMGwx8iQqvGjGryIKlunfOGZb9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUgq0cnjJvNy7H92+2QbW/339iLt/WPS7H0pHdNlIyMl5NfBjUNDoFxHZk52mUx1q
         Eo8d05JxEQSJddEV2Kvwbg1Q4XMQLUnkn8Xs8ems//YgcBUfubl1x0t1N6hxEcnmFJ
         KHXZfzlM3zoooBoYojIPtXcI+HuNjf7REqbCcwrk=
Date:   Mon, 16 Jul 2018 10:59:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180716075929.GF3152@mtr-leonro.mtl.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <20180627074421.GF32348@dhcp22.suse.cz>
 <20180709122908.GJ22049@dhcp22.suse.cz>
 <20180710134040.GG3014@mtr-leonro.mtl.com>
 <20180710141410.GP14284@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <20180710141410.GP14284@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 10, 2018 at 04:14:10PM +0200, Michal Hocko wrote:
> On Tue 10-07-18 16:40:40, Leon Romanovsky wrote:
> > On Mon, Jul 09, 2018 at 02:29:08PM +0200, Michal Hocko wrote:
> > > On Wed 27-06-18 09:44:21, Michal Hocko wrote:
> > > > This is the v2 of RFC based on the feedback I've received so far. The
> > > > code even compiles as a bonus ;) I haven't runtime tested it yet, mostly
> > > > because I have no idea how.
> > > >
> > > > Any further feedback is highly appreciated of course.
> > >
> > > Any other feedback before I post this as non-RFC?
> >
> > From mlx5 perspective, who is primary user of umem_odp.c your change looks ok.
>
> Can I assume your Acked-by?
>
> Thanks for your review!

For mlx and umem_odp pieces,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

Thanks

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbTFBhAAoJEORje4g2clinrPEQAM3K+7WNo+Ro9U49mpUc8xr/
MGGxTsfNW12jUSp6FCTQU6e53hUr+Xkr7HLA9V2PRM848OAOjQlBUKgCGQ4Mb1hQ
jaWFDf5PTXMiSwutJGhqJXuaYkFyLiR6oE0hdGoaPFRQ6TDkWeqXmP7MDOvJe9ml
Ea4dAgif8LEjYjGNOCUGJ6Ur89jJmf4D6EFcWhHyin7XejnD3z4vX0VcRbVwY8tl
H7w7S/TRXNE9gGUTid8i6eC81IG+p+xOaG0JhLcf95F0/sz7Y2gwWUzHWUScrn7A
m7mLXJf+hMGM6oVYxE224xTUbKkVXfYjYLzY9BZ7NB9ycKdi6aDL4diB2w+83acB
SplvTEfXKFVQtSKVyo24NoxEIscZyIHrJu0BaE8d002tvAcE2uiSmgUbQ/grXooe
8Fl8vyau1974/hx4bP6/Fclol25CUtqCatVw+x4vysEqferddvmFW0xOTzUorpTP
bI7zb9Ozs3icZ90Hhxk1jBe1Jmw8XIPGTCv06yDQOufFHxi2UnL2qKVxIrPLh/s5
xkJzguy/TxXk210mWnbWmpmytgKNsUQSMmYqyUEfxtzWlRHYWD3Z6KVUAsPsuy8J
b/fCbYfHzCTP2X4Vm4eoYTxI7YzByBnyIK/eAz1eKVlYbJb8yXx0bqzRbmn6gizc
jWDNXsZCJJ8q58BpwivZ
=YBIL
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
