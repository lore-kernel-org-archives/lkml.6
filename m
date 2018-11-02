Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A87DC6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E4E2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E4E2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeKBNnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 09:43:40 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38024 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbeKBNnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 09:43:39 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id A1D89A10B8;
        Fri,  2 Nov 2018 05:37:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id VWQ71GE0pgPJ; Fri,  2 Nov 2018 05:37:46 +0100 (CET)
Date:   Fri, 2 Nov 2018 15:37:33 +1100
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
Message-ID: <20181102043733.qqimup5vuevjua5w@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
 <20181101083551.3805-2-cyphar@cyphar.com>
 <20181102002039.8f22c10fa47cae75fa709165@kernel.org>
 <20181101211343.yooxwqfnoloprb5h@yavin>
 <20181102120441.d00af1b57e6a739d0e7c7a91@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nhrb2edcfxbijqhe"
Content-Disposition: inline
In-Reply-To: <20181102120441.d00af1b57e6a739d0e7c7a91@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nhrb2edcfxbijqhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-02, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Fri, 2 Nov 2018 08:13:43 +1100
> Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
> > On 2018-11-02, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > Please split the test case as an independent patch.
> >=20
> > Will do. Should the Documentation/ change also be a separate patch?
>=20
> I think the Documentation change can be coupled with code change
> if the change is small. But selftests is different, that can be
> backported soon for testing the stable kernels.
>=20
>=20
> > > > new file mode 100644
> > > > index 000000000000..03146c6a1a3c
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stackt=
race.tc
> > > > @@ -0,0 +1,25 @@
> > > > +#!/bin/sh
> > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > +# description: Kretprobe dynamic event with a stacktrace
> > > > +
> > > > +[ -f kprobe_events ] || exit_unsupported # this is configurable
> > > > +
> > > > +echo 0 > events/enable
> > > > +echo 1 > options/stacktrace
> > > > +
> > > > +echo 'r:teststackprobe sched_fork $retval' > kprobe_events
> > > > +grep teststackprobe kprobe_events
> > > > +test -d events/kprobes/teststackprobe
> > >=20
> > > Hmm, what happen if we have 2 or more kretprobes on same stack?
> > > It seems you just save stack in pre_handler, but that stack can alrea=
dy
> > > includes another kretprobe's trampline address...
> >=20
> > Yeah, you're quite right...
> >=20
> > My first instinct was to do something awful like iterate over the set of
> > "kretprobe_instance"s with ->task =3D=3D current, and then correct
> > kretprobe_trampoline entries using ->ret_addr. (I think this would be
> > correct because each task can only be in one context at once, and in
> > order to get to a particular kretprobe all of your caller kretprobes
> > were inserted before you and any sibling or later kretprobe_instances
> > will have been removed. But I might be insanely wrong on this front.)
>=20
> yeah, you are right.=20
>=20
> >=20
> > However (as I noted in the other thread), there is a problem where
> > kretprobe_trampoline actually stops the unwinder in its tracks and thus
> > you only get the first kretprobe_trampoline. This is something I'm going
> > to look into some more (despite not having made progress on it last
> > time) since now it's something that actually needs to be fixed (and
> > as I mentioned in the other thread, show_stack() actually works on x86
> > in this context unlike the other stack_trace users).
>=20
> I should read the unwinder code, but anyway, fixing it up in kretprobe
> handler context is not hard. Since each instance is on an hlist, so when
> we hit the kretprobe_trampoline, we can search it.

As in, find the stored stack and merge the two? Interesting idea, though
Steven has shot this down because of the associated cost (I was
considering making it a kprobe flag, but that felt far too dirty).

> However, the problem is the case where the out of kretprobe handler
> context. In that context we need to try to lock the hlist and search
> the list, which will be a costful operation.

I think the best solution would be to unify all of the kretprobe-like
things so that we don't need to handle non-kretprobe contexts for
basically the same underlying idea. If we wanted to do it like this.

I think a potentially better option would be to just fix the unwinder to
correctly handle kretprobes (like it handles ftrace today).

> On the other hand, func-graph tracer introduces a shadow return address
> stack for each task (thread), and when we hit its trampoline on the stack,
> we can easily search the entry from "current" task without locking the
> shadow stack (and we already did it). This may need to pay a cost (1 page)
> for each task, but smarter than kretprobe, which makes a system-wide=20
> hash-table and need to search from hlist which has return addresses
> of other context coexist.

Probably a silly question (I've been staring at the function_graph code
trying to understand how it handles return addresses -- and I'm really
struggling), is this what ->ret_stack (and ->curr_ret_stack) do?

Can you explain how the .retp handling works, because I'm really missing
how the core arch/ hooks know to pass the correct retp value.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nhrb2edcfxbijqhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvb1IkACgkQSnvnv3De
m5/VkA/+NS3/JN6MrtshS/7tlaWqTP+BVdil4b3jd4zgucfzGc9treoII3vk9beD
0l9LXqTvHOUK1JNi7DmiKUGvI729V15FERCjb6TanYKpln2aDeJOhUT/UyMo3LWO
2BjFZmoKlKXHEKS4wL4RE1TrmMGxw4RSdXrYpg3lC9MlHUpH8djgY7CcKrgM2ERa
503cfbcn7g5J5/PAF9wI0EDxzN8XzBTq4/ERX5X6OVYkX3Xz8I28ijAhq6PyCIbV
lmiMsSItpt5rMfA5dwXsJ0vPX3yLBTqGvtIsyVVETCV68sUBAUx4PSHHq4bAF+yY
fPRt8gNk8X7EYHcCkO+63QZQd/a65QPCdnfyOrtpRwwBR/qzHoOUl4cDj4zvURT5
5glcjr6ILHsLufF2RRHNYSrzSUX5q/DnQTki/z0iT7bKKGzooo9u4GGgJY6riosS
73+H/dl8lcs3nrJcQGUvjDAUzOtppH1+RwVW8K3aCWdgn+L8ElR+1EaLgKfn7f09
rtaPnoCGZbhhvMuA7psbjKYoINeKIhk77bVMhLBt+vRhMV61oDkfKE815H4lmsVe
Omv9eV0HhvVpDisBc5GWZWvXl/AWJV+PQ/TDMZ8QGWoRU5Z5Nehlih9d4JSfLdrI
fClbJP6OyU+rwp54fG9zb3QLX4KrvYZsNCH8vYXr7f4JxQXxJ1c=
=CA2v
-----END PGP SIGNATURE-----

--nhrb2edcfxbijqhe--
