Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95E1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942D92081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942D92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeJaWhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:37:32 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:59502 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbeJaWhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:37:32 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id CEB95A1047;
        Wed, 31 Oct 2018 14:39:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 2PmreqW_Gst6; Wed, 31 Oct 2018 14:39:24 +0100 (CET)
Date:   Thu, 1 Nov 2018 00:39:12 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20181031133912.3j5tryq2vyhkdn4d@yavin>
References: <20181026132210.12569-1-cyphar@cyphar.com>
 <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
 <20181031090317.4e211fdd@vmware.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="si2rvs2mjjmh3fgx"
Content-Disposition: inline
In-Reply-To: <20181031090317.4e211fdd@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--si2rvs2mjjmh3fgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-31, Steven Rostedt <rostedt@goodmis.org> wrote:
> > Anyway, until that merge happens, this patch looks good to avoid
> > this issue for generic solution (e.g. for the arch which doesn't
> > supports retstack).
>=20
> I think its time to come up with an algorithm that makes function graph
> work with multiple users, and have kretprobes be able to hook into it
> just like kprobes hooks into function tracer.
>=20
> I have some ideas on how to get this done, and will try to have an RFC
> patch set ready by plumbers.

Should I continue working on this patchset?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--si2rvs2mjjmh3fgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvZsIAACgkQSnvnv3De
m599Ew//WQYMTifoaqa/qaOqV6wu3+yszJP6u1jF05x99Q8k8qjmV7I89BzVQeef
vwJNOXo8u4PliULh+E3oKW+vSeuWKWBa21SS+K0/w6x4Xcr/VuNoj5aQh3m245+8
VylMwqgAkEuNQAv1SVOaNcKZ0BUd3cKlFAJ13WYdxj5vPckG/ZNExsMDuLF8aeTD
iMDO4j/n6DmyIg2MUJuKqd476WfluuRkm8H/52y+pvevkcqN7oIturhsx3GUay75
eaRK5TNcfouo/IJj5h9DlakK24qu6uk3IKaRpomeklKEmJEzNrsYlt4K2VlQy+1a
lbxHHDvp7Q6o21pzCX1qwUucmwEKL9PesoWLlb+140zuVkDCBhmo8ZMCOAHaU1ss
HQVqIms6MglVdzBCRwVA6hPvA2P+A+ohRv90g+EaGJaSOAcI1/xDndD2Yi61ZvO1
TObh2ZCOMEpaiuPayyCm1SbwDkNGjJuWo34JXfY4paLBRamL49FpF4rZZHoFLQ/m
o6W71UcuBlsF5vh1zqLWu5LtRIf5C6gsCGPgIG8QSgy9kAQWIPyBzmvFuwV/hM8K
z5UMif93u+jz8MpPhCZGIwMu/r035NceduSY4pwGwc+j916iOGaQnYKgWlz3TSG9
vJlZWYfyfv8PcSKJUKwOMCIBfWn2ljZJKMxGXLaxTyxUZKZ2M4o=
=SZlv
-----END PGP SIGNATURE-----

--si2rvs2mjjmh3fgx--
