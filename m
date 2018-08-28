Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B600EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3D32084D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3D32084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeH2A0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:26:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39095 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727166AbeH2A0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:26:43 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fukfr-0006mz-L3; Tue, 28 Aug 2018 21:33:16 +0100
Date:   Tue, 28 Aug 2018 21:33:15 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <alexander.levin@verizon.com>
Message-ID: <20180828203315.GD18030@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] locking/lockdep: Delete unnecesary #include
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Commit c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and u
nify their usage") added the inclusion of <trace/events/preemptirq.h>.
liblockdep doesn't have a stub version of that header so now fails to
build.

However, commit bff1b208a5d1 ("tracing: Partial revert of "tracing:
Centralize preemptirq tracepoints and unify their usage"") removed the
use of functions declared in that header.  So delete the #include.

Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints ...")
Fixes: bff1b208a5d1 ("tracing: Partial revert of "tracing: Centralize ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/locking/lockdep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e406c5fdb41e..dd13f865ad40 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -55,7 +55,6 @@
=20
 #include "lockdep_internals.h"
=20
-#include <trace/events/preemptirq.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
=20

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW4Wxi+e/yOyVhhEJAQqaOxAAk8cd4AXEBMpLbgMQPNMMTEUcyFZ5P8ih
2YULL3kR8SX2yqmOK2OMhY6VUbSEklPwaSSC+k6wUCps3wdE+LlqqkchfpQhmR/A
Z8XFO5QEx31F9dG4HOOogBNcye/q/F+NjcNftvNxeWp5IbPxsXhAC/G3t0bX2ClD
0NWzb/Z/vAmgRiRwoWhob3GgwfA8xC5t6NbU6XqHEgqfhsiA2etHqoyX/UcEqpqF
Um8NgV2tH8pGi4l9JyLHWsVujPqQGfQL6BeRDI7vYrIKovDBMU74Z1xeZehQeX2S
InzTckEstpGm3uFsZmCX2QjBE6S9a5+P4eXxYWjrMApMXIiuaxqWHbPKGehJNUgX
Qv1XDs4lZJ7ap/nrc0ZKxI1XLeXgTYOT5dwzfb2N3QKFAs1l0U07uZ8F/gVyWjpt
4OCg8D3gC9YoLeqWTEWU6Daee92hBBfQUl2PJwIgqwePa3Kp1ZJoNo21pRoZjyMG
BGvM5NXHOo+fTIgqhfJAf59Nlx8+E2ODRUqVXtjCcBlH51SOLlh6vgsgl83RPP5K
K+DNXg2fX77L0A22ynTam4ZiqdMddkNiiKAZ8HfY7gNAYPIMzDJtvUUD0nj2otvc
4fz0WaaCqZ8R9/P9Ve60yW1Fha0b1B6ggJTHI/v0U+0Q6rBrm2993LVN5KGkdW/H
Yj03AXy12kY=
=9bK3
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
