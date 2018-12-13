Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C440C6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2426D20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2426D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeLMBtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:49:09 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:56698 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeLMBtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:49:08 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6D96E72CC6C;
        Thu, 13 Dec 2018 04:49:05 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 57FC795D2BE; Thu, 13 Dec 2018 04:49:05 +0300 (MSK)
Date:   Thu, 13 Dec 2018 04:49:05 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181213014905.GB26172@altlinux.org>
References: <20181206131946.2c47f556@vmware.local.home>
 <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
 <20181207151433.20bf0399@vmware.local.home>
 <20181208104423.GE5289@hirez.programming.kicks-ass.net>
 <20181208123805.1c158665@vmware.local.home>
 <20181210101818.GJ5289@hirez.programming.kicks-ass.net>
 <20181213003938.GD24195@altlinux.org>
 <20181212202639.1978ec88@vmware.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20181212202639.1978ec88@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 08:26:39PM -0500, Steven Rostedt wrote:
> On Thu, 13 Dec 2018 03:39:38 +0300, wrote:
>=20
> > btw, I didn't ask for the implementation to be ugly.
> > You don't have to introduce polling into the kernel if you don't want t=
o,
> > userspace is perfectly capable of invoking wait4(2) in a loop.
> > Just block the tracee, notify the tracer, and let it pick up the pieces.
>=20
> Note, there's been some discussion offlist to only have perf set a flag
> when it dropped an event and have the ptrace code do the heavy lifting
> of blocking the task and waking it back up. I think that would be a
> cleaner solution and wont muck with perf as badly.

Yes, if perf could be instructed to invoke something like
tracehook_report_syscall_entry/exit when it drops the event
of entering/exiting syscall, that should probably be enough
for the ptracer to do the recovery.


--=20
ldv

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcEbqRAAoJEAVFT+BVnCUI79AP/1cM+wELlUunfcd/zlCBzkRB
k9ETJAEe0CNdPmfzP1nSXIaoc5+oVgGBPtdfZpQQIdl8KmEoKmrpMf8AmY7iSaZ7
ASkjNMySCwmq1HqKPMm6um0XvrTw0AwGuKlzxu/LqqdzuqWVzfVFCkOp9gPME/sr
ysX2wsYrpsHZ2lSvEDhOI2ALTks3grE6pcAK7N2uRJAA+/M/2D+SyEMI7BrnTyRl
TictAt8Xygww9agkjoBJckXUXhpYwiV8vsRQSXLjYFpW28Okl1sfBWesRylSrP1h
37AY5U7AtHOPCpLP6omuBEB+eroztjLJ1RAH/SCBE0KPTROSbGHmHMVTpuT0pbnq
a+4mwlx7G/xaX626kocu/7ORoq5kSsfbseQpwyq9lfgxB2pYDP9KXgi1L4qmGO4M
ybIz87HrSDGruYP2kslU/BB6PYuVT+eBQAF+oLdkRXfwcKY5d+Q8RVfwEfXbceaM
98zIWR3EvCp2d4jj04oczJtBt7cidxqj0KfnKeiAR+hPlIVAuIGlFlAQGSANOPm0
5Jf4QRrqKr1HLtpDXfIHzJUz9DnlK3wqMdLS9PviEmAEii8F+r8nSusL6mwvhYLg
AtUEqFrtPJ+Qr9YPNFNC8y3hg0CcS8VSX/ziffwGy4fIa2jMywUV+sXjMzoanYvn
1lRjjAzSlksPvBPFCAKP
=XyxF
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
