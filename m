Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F28C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4829920652
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pockg2Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4829920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHXHEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 03:04:53 -0400
Received: from ozlabs.org ([203.11.71.1]:38545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeHXHEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 03:04:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41xRfb1mr9z9rvt;
        Fri, 24 Aug 2018 13:32:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535081527;
        bh=33so2/QtVLntDhP9NLJybhtdzZ+xG7A4DKVGZL85pPw=;
        h=Date:From:To:Cc:Subject:From;
        b=Pockg2JfgA3gfmFMEW2fDezbZm4bPxfNUuL1nlLa3AZ7CVCm1g/6pFUIfDbXgVFvw
         gAGnjnG16ZTjOTmzJyWkTK2O4OpT8eRRm6wNQhPlBk43fBYqz9+62cwhTLE8L4l9yD
         dzobfrlwLCnUyGqUjOdaPJVBZJVSEmmIs/Luqc+U+941R2IZ3RFKRFrgNVHSkF3mLC
         0JkVZ2+jwI2gDSEMXULC7dp68Ik7FC9H47mr+Zyd6eh5vjvzwX7PQvhBYcDniydxWn
         Q2Ujo9UMa+zUxfWt8Ak6nPgimaoRc890saO9AoV5Cn5mEjv8K5XQ9MWrpqaVhklvZt
         bj03BS1PkW7Aw==
Date:   Fri, 24 Aug 2018 13:32:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warnings from the build of Linus' tree
Message-ID: <20180824133206.4218c2e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7Ue9y/.D5eOIfpLFvTcLwGl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7Ue9y/.D5eOIfpLFvTcLwGl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the origin tree, today's linux-next build (powerpc
allyesconfig) produced these warnings:

ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_selftes=
t_dynamic.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_kprobe_=
selftest.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_clock.o=
' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/ftrace.o' bei=
ng placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/ring_buffer.o=
' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/ring_buffer_b=
enchmark.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace.o' bein=
g placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_output.=
o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_seq.o' =
being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_stat.o'=
 being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_printk.=
o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/tracing_map.o=
' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_sched_s=
witch.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_functio=
ns.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_preempt=
irq.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_irqsoff=
.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_sched_w=
akeup.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_hwlat.o=
' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_nop.o' =
being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_stack.o=
' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_functio=
ns_graph.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/blktrace.o' b=
eing placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events.=
o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_export.=
o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_syscall=
s.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_event_p=
erf.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events_=
filter.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events_=
trigger.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_events_=
hist.o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/bpf_trace.o' =
being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_kprobe.=
o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/power-traces.=
o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/rpm-traces.o'=
 being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_kdb.o' =
being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_probe.o=
' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_uprobe.=
o' being placed in section `.data..LPBX1'
ld: warning: orphan section `.data..LPBX1' from `kernel/trace/trace_benchma=
rk.o' being placed in section `.data..LPBX1'

Maybe introduced by commit

  6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsystem")

I am guessing, but that is the only new thing that affects all of
kernel/trace ...

--=20
Cheers,
Stephen Rothwell

--Sig_/7Ue9y/.D5eOIfpLFvTcLwGl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt/fDYACgkQAVBC80lX
0GwN+wf+JQfeOPEEnz3/HVDDIEqBUwD3sEcnxHShGOIn5duTYJOYN6ed2ZvzE92g
SD3OUvfL1S0rVRKv71JCFpvoU/QBXTLrDtVcU/W/bTq/Rdsllo0zJJ4gzqs8CRKV
rWKWAWrqm4IDXDt6jUQjl2YyIWgJhpXc59rTsCEIq03quXUYvcAOhLxqb5336F66
1lN7/QjWXmfFyHC65MdBt/zVse0fJmrXM00tj1UYdF6hAljzWqZTO52dRIQlmObu
VpL/6sSIJJUdhmdh43hxDQuSOCJtKp1m/MGM5nlgxUcFZiorY0AjNKXF0rO8EPM8
8lo6Jv9gH9Z/9vNMht9R5oQ29127MA==
=oHvC
-----END PGP SIGNATURE-----

--Sig_/7Ue9y/.D5eOIfpLFvTcLwGl--
