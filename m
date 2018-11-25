Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A87FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA2320881
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA2320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeKYNA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 08:00:57 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:52294 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYNA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 08:00:57 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 40C3372CC61;
        Sun, 25 Nov 2018 05:10:59 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 27F857CD0D5; Sun, 25 Nov 2018 05:10:59 +0300 (MSK)
Date:   Sun, 25 Nov 2018 05:10:59 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        strace-devel@lists.strace.io
Subject: Re: [PATCH RESEND v3 1/3] ptrace: pass type of a syscall-stop in
 ptrace_message
Message-ID: <20181125021059.GA1190@altlinux.org>
References: <20181125022150.46258a20@akathisia>
 <20181125022227.55e8caf7@akathisia>
 <20181125015402.glcaw3kghcu4pr22@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20181125015402.glcaw3kghcu4pr22@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 24, 2018 at 03:54:02PM -1000, Joey Pabalinas wrote:
> On Sun, Nov 25, 2018 at 02:22:27AM +0100, Elvira Khabirova wrote:
> > Define two constants, PTRACE_EVENTMSG_SYSCALL_ENTRY and
> > PTRACE_EVENTMSG_SYSCALL_EXIT, and place them in ptrace_message
> > for the duration of syscall-stops.
> > This way ptracers can distinguish syscall-enter-stops
> > from syscall-exit-stops using PTRACE_GETEVENTMSG request.
>=20
> Is there an advantage to using two constants instead of a single
> sys_exit bit (set/unset for syscall-exit-stop/syscall-enter-stop)?

Given that without this patch the value returned by PTRACE_GETEVENTMSG
during syscall stop is undefined, we need two different ptrace_message
values that cannot be set by other ptrace events to enable reliable
identification of syscall-enter-stop and syscall-exit-stop in userspace:
if we make PTRACE_GETEVENTMSG return 0 or any other value routinely set by
other ptrace events, it would be hard for userspace to find out whether
the kernel implements new semantics or not.


--=20
ldv

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb+gSyAAoJEAVFT+BVnCUI7msP/03Hw0MVgHwFtPiI1I454dg7
cG5xi8aZUwHZM/8tWCiAPtk02ttpXDZR+ReQGMmoRdEBsuvdnhTImGHgU08PjNo/
hR+vTW3cB8hajPBQr2o7+lN2sqRaH/cbaBOdLA31bUz5BNJCrDEASUX64AG8hV5i
yk8DeoHLfw9Ub34PtDz3yJWudSc7irQfBGidpiKmskabRNeaZWKumtTUx36jkOg0
oeYrdOVPEawE7nkE9LlmkzUiidZzaj1gd/ObkazJ/NyCPC7GvS4IEzSu59178NlG
SMiui9AMQkX/3g6S4hY3DQrice4fdYyi6NNnBXhjoePUOjlwYTw7BSA0yNAYSoat
mnMEds03GuaF5T7S5Okdny7ywROMjkj3i+kH3qXupszUPyY3tlHRsqerSQ/xfKoY
+lIVYNxrHseIMfIV+3tHP6R4CxYoaUdxSmYcL29un46KUh8E89p3UHEbHivSeHYV
qccEUnjy5FFwYu6TxFLhIBtCcMnNHZK+IEm/PwlX7sac5/5NE3cLBiMG6oYjGRcg
YzXg3p62Rtrpsd9sVsEtB2fg3wDjsPQIsZSDnksVPYOFwsx+fIOJE8zTcKw1eiW+
W7i4enyWZht6MlIzAoaj4VfVqJ4GM5ZKi/vCyGuIApK/AOZHwPHBhlVotrGcXVq6
o4kgKmniuyFHhcF4armo
=SNPL
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
