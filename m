Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF68C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60BE205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60BE205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeKBFad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:30:33 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:15124 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbeKBFad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:30:33 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 4DB87A120F;
        Thu,  1 Nov 2018 21:26:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id rH7Tp5AMVQ-E; Thu,  1 Nov 2018 21:25:58 +0100 (CET)
Date:   Fri, 2 Nov 2018 07:25:47 +1100
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
Message-ID: <20181101202547.532oso56vk5c554c@yavin>
References: <20181026132210.12569-1-cyphar@cyphar.com>
 <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
 <20181031090317.4e211fdd@vmware.local.home>
 <20181031133912.3j5tryq2vyhkdn4d@yavin>
 <20181101191347.74eadff4a5d1fab2d79d7efe@kernel.org>
 <20181101104948.bc7wk453bfryhhk7@yavin>
 <20181102000156.21304d571e756352b36d2bf2@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rkaotljwoqog63ky"
Content-Disposition: inline
In-Reply-To: <20181102000156.21304d571e756352b36d2bf2@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rkaotljwoqog63ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-02, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Thu, 1 Nov 2018 21:49:48 +1100
> Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
> > On 2018-11-01, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > > Anyway, until that merge happens, this patch looks good to avoid
> > > > > > this issue for generic solution (e.g. for the arch which doesn't
> > > > > > supports retstack).
> > > > >=20
> > > > > I think its time to come up with an algorithm that makes function=
 graph
> > > > > work with multiple users, and have kretprobes be able to hook int=
o it
> > > > > just like kprobes hooks into function tracer.
> > > > >=20
> > > > > I have some ideas on how to get this done, and will try to have a=
n RFC
> > > > > patch set ready by plumbers.
> > > >=20
> > > > Should I continue working on this patchset?
> > >=20
> > > Yes, until we finally introduce Steven's algorithm on all arch (yeah,=
 we still
> > > have some archs which don't support graph-tracer but supports kprobes=
),
> > > I think your patch is the best fix for this issue.
> >=20
> > Thanks, I just sent a v3.
> >=20
> > Though, even with Steven's hooking of kprobes I think you'd still need
> > to stash away the stack trace somewhere (or am I misunderstanding the
> > proposal?).
>=20
> Wait, I might miss something. kretprobe and func-graph tracer just swap t=
he
> return address on the stack but no change on other stuffs on the stack.
> In that case, if we can restore the stack, isn't it enough?

If stack traces works within the func-graph tracer context, then that
would be enough.

However, this is not currently the case in regular kretprobes -- the
issue isn't that kretprobe_trampoline is *on* the stack trace but rather
that the stack trace is *only* kretprobe_trampoline.

I spent several days (and got nowhere) trying to understand why the
stack unwinder cannot go past kretprobe_trampoline. You can see this if
you try to use bpftrace (which just runs bpf_get_stackid ->
perf_callchain_kernel):

  % bpftrace -e 'kretprobe:do_filp_open { @x =3D stack; }'
  Attaching 1 probe...
  ^C

  @x:
          kretprobe_trampoline+1

With my patch, you see the full stack trace you expect. It should be
noted the same problem exists when adding a kretprobe with ftrace's
kprobe_events and options/stacktrace.

Weirdly, after adding show_stack(NULL, NULL) from within a kretprobe
context you get an answer beyond kretprobe_trampoline (though it is
quite ugly and contains lots of information you don't see in
get_perf_callchain or save_stack_trace -- for some reason). I will take
a closer look at this.

But it seems to me that some aspect of the stack trace handling with
kretprobe_trampoline is broken. I wouldn't mind working on fixing this,
but it might require lots of architecture-specific work (and it should
be noted that ultimately we want to have an identical stack trace
between kprobes and kretprobe so that you can DTrace-style aggregate
them).

> And anyway, even if using func-graph tracer, stack unwinding works correc=
tly.
> I thought it means we don't need to backup whole the stack, doesn't it?

Currently, for kretprobes, the entire stack needs to be backed up
because the unwinder stops when it hits kretprobe_trampoline.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--rkaotljwoqog63ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvbYUsACgkQSnvnv3De
m5+vzBAA0ud2k6P3l6sFI3s8fuoUBba0k9Y1QLSEZgUizLfxbvfbjsKCGM9DY89t
FsmexKaI7uWca2/FNtSYFx5rFZDe39Rm831wcmY4SY5tKHfD0Yidg8gXgI61mBaf
4u7+7e6Gtg3L9VGf0d58yWSqXX3FI4iqDwdAycMd+E5Pu7eyboqmA8opVyFKe80F
FgejFC2fVmfiffjVeWqN3v3t7lij5cIiK/ph8BxyO9YclP9HcoyHLOZUQvM03Gvm
RSesG7UNmh7UdETBiWEFJEgNMJ0wW5Xu39R94+nO7AzjZoziozoF5MTkDj8dxAdB
VzzcPNFD/F9qyzYLWz131QKi9GcUD7k8L5xNqLMhTWbN1sS0YyBi6a8MqLrrMw9V
oyBaZwQiocmHgdX6Rw0p/4w9lX6b8VCQh9kCKcOOARaKI2hN7xtHnbDK1v5jPf2s
DksIkfRS82fitPk9qruaRIR2pXLH2laaWMKOkRYs9bEN9Ygfh+o2BRx6paydLW/b
yWqBdc4PqmXN1O+faOrl8BEpHl5xrC8iitYERNqQSPw40KP1BTzE3OFNQEgsP741
Fjxgx4Kt+olqxbJ06aZSILQB2HOldGSnEaBab3dfIE7SMnt3A9j+2INi4i2zTR6u
K1k+gJcEux5tiKrCwh+Thfw/StRIZP+Elu4uOuKzDKuSPbQIdCg=
=RXWz
-----END PGP SIGNATURE-----

--rkaotljwoqog63ky--
