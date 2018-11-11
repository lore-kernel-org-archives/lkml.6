Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752C9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E9820871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E9820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbeKLFuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:50:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53607 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbeKLFsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:33 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A73E8806E4; Sun, 11 Nov 2018 20:59:01 +0100 (CET)
Date:   Sun, 11 Nov 2018 20:59:03 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        zwisler@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com,
        bvanassche@acm.org
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
Message-ID: <20181111195903.GA9726@amd>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
 <20181111193208.GB8332@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20181111193208.GB8332@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-11-11 11:32:08, Greg KH wrote:
> On Thu, Nov 08, 2018 at 10:06:50AM -0800, Alexander Duyck wrote:
> > Introduce four new variants of the async_schedule_ functions that allow
> > scheduling on a specific NUMA node.
> >=20
> > The first two functions are async_schedule_near and
> > async_schedule_near_domain end up mapping to async_schedule and
> > async_schedule_domain, but provide NUMA node specific functionality. Th=
ey
> > replace the original functions which were moved to inline function
> > definitions that call the new functions while passing NUMA_NO_NODE.
> >=20
> > The second two functions are async_schedule_dev and
> > async_schedule_dev_domain which provide NUMA specific functionality when
> > passing a device as the data member and that device has a NUMA node oth=
er
> > than NUMA_NO_NODE.
> >=20
> > The main motivation behind this is to address the need to be able to
> > schedule device specific init work on specific NUMA nodes in order to
> > improve performance of memory initialization.
> >=20
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
>=20
> No one else from Intel has reviewed/verified this code at all?
>=20
> Please take advantages of the resources you have that most people do
> not, get reviewes from your coworkers please before you send this out
> again, as they can give you valuable help before the community has to
> review the code...

We always said to companies we want to see code as soon as
possible. You don't have to review their code, but discouraging the
posting seems wrong.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoigcACgkQMOfwapXb+vLM7QCeK4Ud2W9el0ctGnoUF0SqZWOD
CbQAn0a0OEUsAiEHnhPdInZmB2mwYHnI
=Q2CO
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
