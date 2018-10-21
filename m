Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE8ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5152420843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5152420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJURzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:55:22 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:31008 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeJURzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:55:22 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 79E2E4B84D;
        Sun, 21 Oct 2018 11:41:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id Dec6Eflflgx6; Sun, 21 Oct 2018 11:41:37 +0200 (CEST)
Date:   Sun, 21 Oct 2018 20:41:33 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Robert Richter <rric@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>
Cc:     linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: Re: [RFC] Merging ftrace_stack, perf_callchain, oprofile->backtrace
 and stack_trace
Message-ID: <20181021094133.nvqhs73khwx2xe4a@ryuk>
References: <20181021093106.mhjpb2rnx6kstjki@ryuk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ustoeia7qk475mn7"
Content-Disposition: inline
In-Reply-To: <20181021093106.mhjpb2rnx6kstjki@ryuk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ustoeia7qk475mn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-21, Aleksa Sarai <cyphar@cyphar.com> wrote:
> However, in working on this patch, I've noticed that there appear to be
> several different implementations of "get the stack trace from this
> pt_regs" which all appear quite similar. Namely:
>=20
>   * struct ftrace_stack;

Sorry, I made a mistake here. ftrace_stack *does* use stack_trace under
the hood, and so it can be easily modified to use the saved kretprobe
stack. The only issue is with perf_callchain_entry (which affects
bpf_get_stack).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ustoeia7qk475mn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvMSc0ACgkQnhiqJn3b
jbTuphAAkiKfKR9J5ssmyXI+RCDaxUD/54cJIy8sN2E45o2FnQZ7MOzLS8dNk4OK
ZNsYcOM8/TkA/rsrDfFqdqk6dfzFRbRwu3kAxDqDwmGVEmMWaRUZ/tpvijpEXYYI
KJ+U1hT8rd6yRL+QaGqswi0PylEMm8yo/PnGGyb7cVj8Exc7GKeg2dast5DE3kTE
X82Az5h5SHDHGrE/o59WW7vhpHETeDdf1Qb7acVPa5X+4S/nE/ss5mvlBWiSa9Xx
Sw/32ZCwKpflcXsM+KLrj7nGuJXA9T2pir5Q60dwihwjFMzOx+AR4+zGF9Co/AB8
jcr8aYHNuUnbDrzh1ZHeKLFXzwoq4kMQq7YmkIq6JDuj3f+X8qpLY0BLnnO2PMmd
DyRkGDQja7EWGQP2yUfBZYILe1HkE8EH0LF0bpWcS38DcpXTjG8hGxMPqgxVIiBa
0ejPKwT3yJNON9ngg7ja5XebDLC5Y8IXFNm2lcq1miglJSt8zC1MZCCgBw/Mx6y8
cO9joIIoUlKc+2pRWRJ5tVeYu4jM3G7S+PRg5Voh/yxs1+InlMw7QskuSZwBg9lM
ivtySt6Uih43/JfYd0NP4ICYUPVcc4/CBugGbXu+rqHXRJZli8zaVpRAXn6T/r+A
rgO8FclHNE9aDd8dACHXxUaoZ8yKweaKQfAVeSWbu/Hg8EbyJzs=
=+R3e
-----END PGP SIGNATURE-----

--ustoeia7qk475mn7--
