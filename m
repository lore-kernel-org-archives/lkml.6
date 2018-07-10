Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C32C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595D2208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wZSsEn68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595D2208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934619AbeGJQU1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934422AbeGJQUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:20:25 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADFFA208EB;
        Tue, 10 Jul 2018 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531239624;
        bh=a7Qx6W8D3y7c5MVXumVsBKb/twwrY8uyrBZxs+MTdOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wZSsEn683FT+XKixTFBJBgAF8sJHi5sC9WFSlEUWA3bnmXdzOL4tu1oxfOJI5AHk9
         0tQEuPLZzXe6X+R6ra+qFG9Nt9qNddjsfBS8qiVWxe+OzVt0VCe8XpifQqQndXwbIB
         mrwrsdDXg8sMyt9BtCMSgdoAvV2nAg24+sYEIa5Y=
Date:   Tue, 10 Jul 2018 19:20:20 +0300
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
Message-ID: <20180710162020.GJ3014@mtr-leonro.mtl.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <20180627074421.GF32348@dhcp22.suse.cz>
 <20180709122908.GJ22049@dhcp22.suse.cz>
 <20180710134040.GG3014@mtr-leonro.mtl.com>
 <20180710141410.GP14284@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0EphSjNCSB1asamE"
Content-Disposition: inline
In-Reply-To: <20180710141410.GP14284@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0EphSjNCSB1asamE
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

I didn't have a chance to test it because it applies on our rdma-next, but
fails to compile.

Thanks

>
> Thanks for your review!
> --
> Michal Hocko
> SUSE Labs
>

--0EphSjNCSB1asamE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbRNzEAAoJEORje4g2clinTRAP/3xbJ66iDSwdQCcVd+3SPmwJ
NYt2S+UqK7m5inKXFtDVKC9BNIb6WKX5gVPyLMKfr6d+Ru6XVd/TmavJyDTHbBzC
B5a13HTOqAMPLoRdcU/HqN0yHWXsRtekZ5jnnxLt+mXVq+34Vk6MNFO2OL8opaeP
1Dznd0rY8jrA9Y3Z6gXBkog9xIFE5h7NouLdApinAqoP8D4/M1quGSGsmSqlkY0z
NHviSlRW8/cRSgSeS5SQEyj3jz6gsZCYRWwskONf+VWy848aAoessVXzNVgtuLbR
4eIkAHhb1DTPdIPIZyzxrQ4e7QCaFOb/AFAt6K0E2YmTgmnntKLrpXf76p8GIXFW
xmxji8Z6R+/124cH67/+GpgSvAFSoqyHsjv8IJkB8XPsLnfN4vqxH6U0U7lO4Z5l
Pex8wMFs55GgrDsI99dEczCglFesam5u9RRnHLGY1nYYofDoNKTbWiKEAAIQJK7R
P0fCVmW921et6rtnsPOIM40O/94vJPLP0Wam76GXSCtQFw22xK90XCIvrYLuZIcs
q7nDB6HzfKUL0Ai1KAhhcqzn785E9xtAxLy6CilgmB4nTqXhaP5cM5RZZiD86jEr
N8GMXABgUjwgwxV4AFHGY2qeawlN+l2yLNl6r05KNyKTWWyhM2rt0HNnRkLRP51G
xxL8y7wxClLAZl6dTXFz
=ETz1
-----END PGP SIGNATURE-----

--0EphSjNCSB1asamE--
