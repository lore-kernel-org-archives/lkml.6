Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DBCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E6520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E6520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeKJAtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:49:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:59712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727735AbeKJAtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:49:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED769ADC3;
        Fri,  9 Nov 2018 15:08:40 +0000 (UTC)
Date:   Sat, 10 Nov 2018 02:10:22 +1100
From:   Aleksa Sarai <asarai@suse.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-ID: <20181109151022.xs7u3rvuy6uodilf@mikami>
References: <20181102050509.tw3dhvj5urudvtjl@yavin>
 <20181102065932.bdt4pubbrkvql4mp@yavin>
 <20181102091658.1bc979a4@gandalf.local.home>
 <20181103070253.ajrqzs5xu2vf5stu@yavin>
 <20181104115913.74l4yzecisvtt2j5@yavin>
 <20181106171501.59ccabbc@gandalf.local.home>
 <20181108074612.ldy6rozdpsdps6bf@yavin>
 <20181108080448.rggfn4zawi3por23@yavin>
 <20181108144437.l3proaovfqm5osnr@treble>
 <20181109162632.9a3694eea8ac8056302a8262@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6alkr35q2cz3bqlc"
Content-Disposition: inline
In-Reply-To: <20181109162632.9a3694eea8ac8056302a8262@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6alkr35q2cz3bqlc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-09, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Thu, 8 Nov 2018 08:44:37 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>=20
> > On Thu, Nov 08, 2018 at 07:04:48PM +1100, Aleksa Sarai wrote:
> > > On 2018-11-08, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > > I will attach what I have at the moment to hopefully explain what t=
he
> > > > issue I've found is (re-using the kretprobe architecture but with t=
he
> > > > shadow-stack idea).
> > >=20
> > > Here is the patch I have at the moment (it works, except for the
> > > question I have about how to handle the top-level pt_regs -- I've mar=
ked
> > > that code with XXX).
> > >=20
> > > --=20
> > > Aleksa Sarai
> > > Senior Software Engineer (Containers)
> > > SUSE Linux GmbH
> > > <https://www.cyphar.com/>
> > >=20
> > > --8<-----------------------------------------------------------------=
----
> > >=20
> > > Since the return address is modified by kretprobe, the various unwind=
ers
> > > can produce invalid and confusing stack traces. ftrace mostly solved
> > > this problem by teaching each unwinder how to find the original return
> > > address for stack trace purposes. This same technique can be applied =
to
> > > kretprobes by simply adding a pointer to where the return address was
> > > replaced in the stack, and then looking up the relevant
> > > kretprobe_instance when a stack trace is requested.
> > >=20
> > > [WIP: This is currently broken because the *first entry* will not be
> > >       overwritten since it looks like the stack pointer is different
> > >       when we are provided pt_regs. All other addresses are correctly
> > >       handled.]
> >=20
> > When you see this problem, what does regs->ip point to?  If it's
> > pointing to generated code, then we don't _currently_ have a way of
> > dealing with that.  If it's pointing to a real function, we can fix that
> > with unwind hints.
>=20
> As I replied, If the stackdump is called from kretprobe event, regs->ip
> always points trampoline function. Otherwise (maybe from kprobe event,
> or panic, BUG etc.) it always be the address which the event occurs.
>=20
> So fixing regs->ip is correct.

The problem is that the pointer to the *return address* is wrong
(kernel_stack_pointer() gives you a different result than the function
entry), it's not that regs->ip is wrong. And I'm sure that it's "wrong"
because it's not possible for "regs->ip =3D=3D kretprobe_trampoline" unless
you are in a stack frame that has been modified by the kretprobe core.

I will take a closer look at this over the weekend -- I posted the patch
to try to help explain what the underlying issue I was trying to solve
with this patch series is (and why I don't think the ftrace changes
proposed in the thread will completely fix them).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--6alkr35q2cz3bqlc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvlo14ACgkQnhiqJn3b
jbTFohAAmqHaX+MgJNK0L3U6VD3uhNMq/UR4ve2vQkqN10MrYbtE91AaJ4zNgoyK
3j5RcclN1gZKLDiMsmqEJBSnfqEhy9/X/vT8FUdAejrGWoYDKuON4J0RozV23zxh
qJIg2YVmLNPQK/LK8ksJDo2get97KmBbkFUArLysQLXI2ZUAVTsfYS3iKbvvK2eu
gICCO5G6t4LRAfh6bCydYVKUksJhqWms5Jb3XeydK+UHWQid5ZFKmbUB6kwD2+mq
3HjJqzYLuQOUwdsnJL5kBbGu4J9SKGF8I6FqoF8ud5Fk9YAv/3PzWpD6LrvGxGkf
Gp5yCqS9hg1eqnfFAE1wotOTIP/DHofHOutFx68ZMmjYjXXvesYJ4wSrHlOBLywS
8+jjh2dHymO1wcbt0rVf/ZHSoqAM0bxVSJv0FlnZkbKuoV/NtsUBp6a8VzxZ/N56
jAqpId07Et1bH6COZvyv/7b4bwhOrGGURYDMB/BOnZ7pnpIDr1OCltGJbMv3PWuT
FWPQ1AP1WRCDHdY15Q8l9mRfeFFFa65X3MwzZXYF6L3Z6MwkIgfSQS1G9yqDNg3+
7XKWGzmeGwgSRPDjLKUzph6dwIQzBpCJ1IgjgfCq/fL1cHy9DG6+icsnQDj3yhMz
KUKKMya6RDXtOfPhT9lsR7+1TWqSazk3+yVdYv4+W1rnWEZmVqc=
=o/gm
-----END PGP SIGNATURE-----

--6alkr35q2cz3bqlc--
