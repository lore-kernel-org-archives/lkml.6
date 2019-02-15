Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F652C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2315222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550250112;
	bh=pp+wmEv3ANp/fDK4HXKIUnVQx1QFxRC3pyodGuUqlmU=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=zuohQUfaBRBju6t3GrBtPIZy3EALddk8a4rh/oX2d3h2DPILEhY3vJA6M9SbkZeM+
	 514kjVvN8ecrDh+nlEvvqA2HgrwDcec4EFhayFL5iWeIEj8EKnb90uk847bi+rvbfU
	 AlrGw2ybNvMgAV+YTYiWle7dEVPlod9+RYOm98zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbfBORBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:01:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfBORBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:01:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF2C21924;
        Fri, 15 Feb 2019 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550250109;
        bh=pp+wmEv3ANp/fDK4HXKIUnVQx1QFxRC3pyodGuUqlmU=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=RF0EEMvQmDCsUkoxsDC8plKYznJyXMPNXzqs6Pid5tsmWNr8j+/KVCdvjlri/ZrK4
         8U776fU1ew6ulhVbo9ph/KEBHGYhEa+qeMkDYKp98LvkWAjCCulX3Yvz4SQgLaUHSz
         GI46s1eQ3787JVMyZ6ZFtJAymuUO6Z9QlDNXkNh8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <9e86b95eb8c9e3c0454d3aeebac15e354298c815.camel@baylibre.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
Message-ID: <155025010824.115909.1113764424081649980@swboyd.mtv.corp.google.com>
References: <20190129061021.94775-1-sboyd@kernel.org> <20190129061021.94775-3-sboyd@kernel.org> <e303573aefeaf6a7e3a4b1d820e801354ff900b4.camel@baylibre.com> <154879654428.136743.10048771201181501034@swboyd.mtv.corp.google.com> <ff76dcdb4ceb3209619e5348ed7b575a8ae9df8d.camel@baylibre.com> <154888381385.169292.12776041058756822056@swboyd.mtv.corp.google.com> <97c2375f41fe7dabc4d71f66c9808912eb0ce611.camel@baylibre.com> <154941131193.169292.7500057932043013834@swboyd.mtv.corp.google.com> <9e86b95eb8c9e3c0454d3aeebac15e354298c815.camel@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 09:01:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-02-13 01:16:18)
> On Tue, 2019-02-05 at 16:01 -0800, Stephen Boyd wrote:
> > >=20
> > > I really don't understand why you insist on keeping this special case=
 for
> > > num_parent =3D=3D 1, when we know it is not coherent.
> > >=20
> > > Considering, that I already proposed the fix, what is the effort here=
 ?
> > > If it is fixing the driver that rely this weird thing, I'd be happy t=
o do
> > > it.
> > >=20
> > >=20
> >=20
> > Ok. I'm happy to merge your patch to always call the .get_parent clk op
> > when num_parents > 0, but please fix all the drivers and analyze all the
> > implementations of .get_parent to make sure that they aren't broken by
> > the change in behavior. Furthermore, please add a debug/warning message
> > into the code when .get_parent returns a number outside of the range of
> > [0, num_parents) so that they can be converted to use .get_parent_hw
> > instead.
>=20
> Fair enough.
>=20
> >  Ideally there wouldn't be anything returning a parent index
> > outside the range of possible parents from .get_parent because this
> > analysis of drivers would find those implementations and migrate them to
> > .get_parent_hw instead.
> >=20
> > In parallel, I'd like to convert all drivers to use .get_parent_hw
> > instead of .get_parent and then remove the .get_parent clk op right
> > away.=20
>=20
> Fine by me. Of course step #1 is not required if you get this is in befor=
e.
> As long as things are coherent, I'm happy :)

Ok. So does it mean you want everything to be converted over the
.get_parent_hw and then all problems are solved? I think I can use
Coccinelle to convert the callers to pass the index straight into
clk_hw_get_parent_by_index(). I've also stacked a patch on top of this
series to make that API accept a negative index so I can directly chain
that call after the index is figured out.

>=20
> > I'll start a sweep of the users of clk_hw_get_parent_by_index() (I
> > see 50 calls in the tree right now) and see if I can convert them to
> > handle errors returned from that API, probably by just continuing and
> > ignoring errors. I'll start doing the same conversion for .round_rate
> > and .determine_rate so that we can get rid of that duplicate clk op as
> > well. Hopefully that's a mostly mechanical conversion.
>=20
> This would be nice !

Great! This isn't as easy to script, but it looks like I'll be bombing
the list with hundreds of patches soon.

>=20
> >=20
> > For now I'll move this patch to the end of this series so that it
> > doesn't hold things up otherwise.
>=20
> It could even be separate series ? with the migration you mentionned abov=
e ?
>=20

Yes that's fine to be a different series. I've reordered the patches now
so this patch comes last and I've also fixed up all callers of
clk_hw_get_parent_by_index() to handle the error case, with lots of
checks for IS_ERR_OR_NULL(). I've also made that API return an error now
and realized that this patch series needs to only do the fallback to the
'fallback' string when there isn't a direct pointer and when the DT
lookup fails with -ENOENT. We should assume that other errors mean that
something is wrong and the lookup actually failed vs. it being a DT
property that hasn't been implemented yet. Hopefully this is clearer
when I repost this series.

