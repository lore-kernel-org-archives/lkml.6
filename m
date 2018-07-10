Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAAEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F245020881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwGXrcDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F245020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbeGJNkq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933145AbeGJNko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:40:44 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDC920881;
        Tue, 10 Jul 2018 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531230043;
        bh=pZsOBVVpbTt/WfSdK6un4tF1Xc5X6KDpzQHDkV6453M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwGXrcDH0bRLY5wQxAxaz4HW9vysOBOZrPNvG8/3wITXNkBfCIlMOSb+EVzTD/JeL
         VAe8B3V2i1T3Z8anWJhJBl6Vk7gZkJCHvbdBCJo7kz+3kpTu2E2w5WVZ3VBDJJ3OUf
         ro39ZOFH/5Z6dTqTjk/FfI1wjTu9AeXALDH3VWeU=
Date:   Tue, 10 Jul 2018 16:40:40 +0300
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
Message-ID: <20180710134040.GG3014@mtr-leonro.mtl.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <20180627074421.GF32348@dhcp22.suse.cz>
 <20180709122908.GJ22049@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xugVLPVe/nLWwmIL"
Content-Disposition: inline
In-Reply-To: <20180709122908.GJ22049@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xugVLPVe/nLWwmIL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 02:29:08PM +0200, Michal Hocko wrote:
> On Wed 27-06-18 09:44:21, Michal Hocko wrote:
> > This is the v2 of RFC based on the feedback I've received so far. The
> > code even compiles as a bonus ;) I haven't runtime tested it yet, mostly
> > because I have no idea how.
> >
> > Any further feedback is highly appreciated of course.
>
> Any other feedback before I post this as non-RFC?

=46rom mlx5 perspective, who is primary user of umem_odp.c your change look=
s ok.

Thanks

--xugVLPVe/nLWwmIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbRLdYAAoJEORje4g2clinszcP/i1ZoA12tkJ+VFRkYqorF+9B
+Z2snjMkSjj9Nz8XeYAzlg1RSNNeiTtFsN7UKrr6X484ccyy7oT//Nj5gGcxyEo3
qzAxMgRyD+xTbV97YJEVXpo7T6euNyH2ajtBDVwHQo14A6ZK2SIETUh9ssJhCumQ
9rv/UBFiJ/PjODzYNulmHvhILOt5QQc0UxoC1ApoGddv5bj5eaQeQ1xIBigZ1lZp
HCr53Z4NZ2WXiwMpHomBcD+Z2ZD2lRPUVWKsUYn8mU7iLzYGWOE3h8Ca0lEK74On
MAxdJT2ywBGWQ7XaIDEmWPs2xsV18qDKaUj6T/b0V6LD8T6DNrwyrjCUOZg8K08I
SdoWhHm1JADzOzPDDh2aHBpkPC9oIlWYGnFgGra87G+wXmwvegYIi3wady1d7VzI
RHSDQzcRiZqhGivXZPCqffXicAC3/PTWaLB2v1sm9LK+s8DoUcxW67RPDQmvB2Jj
cgqDTLvw+ikvXAhHhI4wfqE3ITAg6sOgQIxo+395/30Y1/sHprvEQDcc1jVm5avw
ueFriLICm7Kb0pYY/fUH6JxxbqIGEFW8oLC0hqalbMsIKLabWTHbEWmbCLkKj1c0
z0B2Vo0GLbEKRBwtbelQP9KQcPCG4x0OKMnZQ8jfiDsWPmTXYOu7108rKOf98a6N
gnaRbmsYcsnBMQtUAzSx
=Dfrg
-----END PGP SIGNATURE-----

--xugVLPVe/nLWwmIL--
