Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6555ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F35820C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F35820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeIYAEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:04:50 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36182 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeIYAEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:04:50 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g4VAd-0002gC-6H; Mon, 24 Sep 2018 14:01:19 -0400
Message-ID: <5f8367291b1a0e870b1bd2919194b15f61d6fddd.camel@surriel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
From:   Rik van Riel <riel@surriel.com>
To:     "Jan H." =?ISO-8859-1?Q?Sch=F6nherr?= <jschoenh@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Date:   Mon, 24 Sep 2018 14:01:18 -0400
In-Reply-To: <a65adb0a-b62c-ca28-6a00-7684d67ff851@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
         <20180914111251.GC24106@hirez.programming.kicks-ass.net>
         <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
         <1e3c2ab11320c1c2f320f9e24ac0d31625bd60e6.camel@surriel.com>
         <a65adb0a-b62c-ca28-6a00-7684d67ff851@amazon.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lAlz0Y7VLTUe2CFpVSTJ"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lAlz0Y7VLTUe2CFpVSTJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-09-24 at 17:23 +0200, Jan H. Sch=C3=B6nherr wrote:
> On 09/18/2018 04:40 PM, Rik van Riel wrote:
> > On Fri, 2018-09-14 at 18:25 +0200, Jan H. Sch=C3=B6nherr wrote:
> > > On 09/14/2018 01:12 PM, Peter Zijlstra wrote:
> > > > On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Sch=C3=B6nherr
> > > > wrote:
> > > > >=20
> > > > > B) Why would I want this?
> > > > >    [one quoted use case from the original e-mail]
> >=20
> > What are the other use cases, and what kind of performance
> > numbers do you have to show examples of workloads where
> > coscheduling provides a performance benefit?
>=20
> For further use cases (still an incomplete list) let me redirect you
> to the
> unabridged Section B of the original e-mail:
>    https://lkml.org/lkml/2018/9/7/1521
>=20
> If you want me to, I can go into more detail and make the list from
> that
> e-mail more complete.
>=20
>=20
> Note, that many coscheduling use cases are not primarily about
> performance.
>=20
> Sure, there are the resource contention use cases, which are barely
> about
> anything else. See, e.g., [1] for a survey with further pointers to
> the
> potential performance gains. Realizing those use cases would require
> either
> a user space component driving this, or another kernel component
> performing
> a function similar to the current auto-grouping with some more
> complexity
> depending on the desired level of sophistication. This extra
> component is
> out of my scope. But I see a coscheduler like this as an enabler for
> practical applications of these kind of use cases.

Sounds like a co-scheduling system would need the
following elements:
1) Identify groups of runnable tasks to run together.
2) Identify hardware that needs to be co-scheduled
   (for L1TF reasons, POWER7/8 restrictions, etc).
3) Pack task groups into the system in a way that
   allows maximum utilization by co-scheduled tasks.
4) Leave some CPU time for regular time sliced tasks.
5) In some cases, leave some CPU time idle on purpose.

Step 1 would have to be reevaluated periodically, as
tasks (eg. VCPUs) wake up and go to sleep.

I suspect this may be much better done as its own
scheduler class, instead of shoehorned into CFS.

I like the idea of having some co-scheduling functionality
in Linux, but I absolutely abhor the idea of making CFS
even more complicated than it already is.

The current code is already incredibly hard to debug
or improve.

Are you getting much out of CFS with your current code?

It appears that your patches are fighting CFS as much as
they are leveraging it, but admittedly I only looked at
them briefly.

--=20
All Rights Reversed.

--=-lAlz0Y7VLTUe2CFpVSTJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlupJm4ACgkQznnekoTE
3oPDiggArCJZp+PTEhxvBrfgJSRR1iaD8908pX8fUT0AqigKITIwlkflHkkgc+PI
Tv4GCGsLkaMheATAtzXxtOpdx+Y6Gn8lyFrBsGzZD/N/F0I+tt1i/szVf2YfHVw6
sWGuQbbnaGSoeSTzoDWbaigwnB08BzHjXkmpqmVXEraJpuepzj2/PXFKuWeB2tLX
kNy9Og7EAVkP0LRlHUG6pKD4gZMHDSUJiIFZr9z76QAXbmz+kom3o6Tqf/vz+KvP
ElHorFkN4ZTy59YOlITrl9tmHpGa6l2+t+1v3LZcSlwmY+2fETkENSmmoKRSLFKv
qsExu2zF6JxaBy2WLuQbJzc5PoUb7w==
=yiwU
-----END PGP SIGNATURE-----

--=-lAlz0Y7VLTUe2CFpVSTJ--

