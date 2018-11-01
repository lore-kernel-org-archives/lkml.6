Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D5CC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13798205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13798205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeKATwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:52:38 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:55278 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbeKATwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:52:38 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9F63D4B6C5;
        Thu,  1 Nov 2018 11:50:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id vwuC7OzXJZOW; Thu,  1 Nov 2018 11:49:59 +0100 (CET)
Date:   Thu, 1 Nov 2018 21:49:48 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kretprobe: produce sane stack traces
Message-ID: <20181101104948.bc7wk453bfryhhk7@yavin>
References: <20181026132210.12569-1-cyphar@cyphar.com>
 <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
 <20181031090317.4e211fdd@vmware.local.home>
 <20181031133912.3j5tryq2vyhkdn4d@yavin>
 <20181101191347.74eadff4a5d1fab2d79d7efe@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mfvf6vzxsoivpjki"
Content-Disposition: inline
In-Reply-To: <20181101191347.74eadff4a5d1fab2d79d7efe@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mfvf6vzxsoivpjki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-01, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > Anyway, until that merge happens, this patch looks good to avoid
> > > > this issue for generic solution (e.g. for the arch which doesn't
> > > > supports retstack).
> > >=20
> > > I think its time to come up with an algorithm that makes function gra=
ph
> > > work with multiple users, and have kretprobes be able to hook into it
> > > just like kprobes hooks into function tracer.
> > >=20
> > > I have some ideas on how to get this done, and will try to have an RFC
> > > patch set ready by plumbers.
> >=20
> > Should I continue working on this patchset?
>=20
> Yes, until we finally introduce Steven's algorithm on all arch (yeah, we =
still
> have some archs which don't support graph-tracer but supports kprobes),
> I think your patch is the best fix for this issue.

Thanks, I just sent a v3.

Though, even with Steven's hooking of kprobes I think you'd still need
to stash away the stack trace somewhere (or am I misunderstanding the
proposal?).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--mfvf6vzxsoivpjki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlva2ksACgkQSnvnv3De
m5+IKA//fWlK5aWXmaK9C+YmWL1Q3IG+m4i6rzoV42tQO3bZkFWwomExK/zvk6p0
ojzzXTffRBApcmUGqGEZPVHI1evGwHx5Xb60yFSFYXeIJmp5soeZuQEjK+NVpMo+
onnd+yNNevsBgRd6wEM+RM19mu8RaoakdYKB3D9m020p7VSkpXY1nHHznKdxzm+O
xhD3ePM6ObgTPRVxy30FvtjNtf4RNaLKBBJfoflAnRsKsLaHCUt+yXISHaL0TpbR
FDpZ+p01AE5nOA6hjM33ekYM4/p0TQ4YRNtCQz5lxUALcdyngkzD14f3DvUyuKQl
wQRxe8S5LU3ePHeocLCvcVVZ3jgz9bxooeyRVTd4pjlSxrPn26lWMYBxN+U4LRoA
qhwkccS9vgqJwMfhPdvmI97iiMm2Y9bD5htZK80Tmb6bLNnnJR4kFiKYcIcpPcG2
Ml/qoYLdn0MXE+SEQ25Rao0ql8YZsiWXqyNMBWcJCWwIg2dJ1oldZGnajjGRL9wy
lly6v8RpS5tPBOnDvP4glazDj8mIXCCXbOj/3RnAvR6ci3PneWCKm2fA1kM1T5YK
HTnCSpkKkPySYhafQUF+CP/hiUuFQg4mo3opjbug8i9jhjNrj8ffUlzMFF2z1VDZ
SQMRu9KUCX+mC34h2yYuq8H/tVZ+exv4Xxm6m5UUR00Z9H3S6Y4=
=bD1t
-----END PGP SIGNATURE-----

--mfvf6vzxsoivpjki--
