Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D33C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F8E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F8E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeKBGSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:18:41 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:24558 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbeKBGSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:18:41 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 30ECBA115B;
        Thu,  1 Nov 2018 22:13:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id iRXQw8hSIF5u; Thu,  1 Nov 2018 22:13:56 +0100 (CET)
Date:   Fri, 2 Nov 2018 08:13:43 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-ID: <20181101211343.yooxwqfnoloprb5h@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
 <20181101083551.3805-2-cyphar@cyphar.com>
 <20181102002039.8f22c10fa47cae75fa709165@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ywyssjdmzzy34rtq"
Content-Disposition: inline
In-Reply-To: <20181102002039.8f22c10fa47cae75fa709165@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ywyssjdmzzy34rtq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-02, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> Please split the test case as an independent patch.

Will do. Should the Documentation/ change also be a separate patch?

> > new file mode 100644
> > index 000000000000..03146c6a1a3c
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace=
=2Etc
> > @@ -0,0 +1,25 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# description: Kretprobe dynamic event with a stacktrace
> > +
> > +[ -f kprobe_events ] || exit_unsupported # this is configurable
> > +
> > +echo 0 > events/enable
> > +echo 1 > options/stacktrace
> > +
> > +echo 'r:teststackprobe sched_fork $retval' > kprobe_events
> > +grep teststackprobe kprobe_events
> > +test -d events/kprobes/teststackprobe
>=20
> Hmm, what happen if we have 2 or more kretprobes on same stack?
> It seems you just save stack in pre_handler, but that stack can already
> includes another kretprobe's trampline address...

Yeah, you're quite right...

My first instinct was to do something awful like iterate over the set of
"kretprobe_instance"s with ->task =3D=3D current, and then correct
kretprobe_trampoline entries using ->ret_addr. (I think this would be
correct because each task can only be in one context at once, and in
order to get to a particular kretprobe all of your caller kretprobes
were inserted before you and any sibling or later kretprobe_instances
will have been removed. But I might be insanely wrong on this front.)

However (as I noted in the other thread), there is a problem where
kretprobe_trampoline actually stops the unwinder in its tracks and thus
you only get the first kretprobe_trampoline. This is something I'm going
to look into some more (despite not having made progress on it last
time) since now it's something that actually needs to be fixed (and
as I mentioned in the other thread, show_stack() actually works on x86
in this context unlike the other stack_trace users).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ywyssjdmzzy34rtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvbbIcACgkQSnvnv3De
m5+H3g//U3dUHafkMVldC9z5E7aA1ljh+ZbM/PA/HhWq6BaNUkibEKu4/M4TYi6g
FGphK06koWBePb0HkeqEQ7gspO1FPxwRUwn/DJNAM3yR+VLIZftkwwjQadFpKMVX
T3TTYFf4ogUMeqQPRBld3cVK23ILeiokik02tRcN2Tq1dP3vish0TgH4Z38Rbiql
LSbFhRz62GJ99yXrUlgoircGDFKCrCCJBTd7JuN4XXZk4PHJfpsmp9aQQMWY5u2Z
IjgNQt4nuArS7eloy8WtlyYNsOhGwf7eyqEsAc1jwcYCMRq1C2zth6vDg3cIk7+K
G1s3ZX40jE8a7/w7H09dp0PLgHHuXWZChKdyvTzWmXyEiKKjm+wNBF5dGiELPoqX
+K94Mp9LLbOFOCg7yCZDHaal67xktu9o5G8zmpaVNSFfrgLSSiXXh6mNcqSJ4psI
CdRSU51NlRtf9cXhsHKZ8s2FMW1bH2q6GVR9cEazCIDdLHDrbDD6PfvpK7NBPiru
NlZ9U4GKrm2e/SQJrfMOzukI2ftqmjJzRvD/bytNvDjVn3k2hu3gb+1XFm2VzZaK
FaOJFXhQWr0oP+yT4hoTAiPWquXcYA4trlhy88WqKkNMPzB0hhHSr9VVediVfyYH
AnBW1Q8Uv9GaKyBe5LIkaMth3u36Cf5ustLvjfweVYkHak9Obaw=
=BZZ/
-----END PGP SIGNATURE-----

--ywyssjdmzzy34rtq--
