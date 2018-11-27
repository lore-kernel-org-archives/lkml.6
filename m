Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07618C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81E62086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81E62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeK0OpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:45:21 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:57970 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbeK0OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:45:21 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 395AC72CC59;
        Tue, 27 Nov 2018 06:48:50 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 1DBBE7CD0D7; Tue, 27 Nov 2018 06:48:49 +0300 (MSK)
Date:   Tue, 27 Nov 2018 06:48:49 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org, strace-devel@lists.strace.io,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/3] ptrace: pass type of a syscall-stop in
 ptrace_message
Message-ID: <20181127034849.GA4319@altlinux.org>
References: <20181125022150.46258a20@akathisia>
 <20181125022227.55e8caf7@akathisia>
 <20181126145643.GD1660@redhat.com>
 <20181127035357.0b381323@akathisia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20181127035357.0b381323@akathisia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 03:53:57AM +0100, Elvira Khabirova wrote:
> On Mon, 26 Nov 2018 15:56:43 +0100, Oleg Nesterov wrote:
> > On 11/25, Elvira Khabirova wrote:
> > >
> > > + * These values are stored in task->ptrace_message by tracehook_repo=
rt_syscall_*
> > > + * to describe current syscall-stop.
> > > + *
> > > + * Values for these constants are chosen so that they do not appear
> > > + * in task->ptrace_message by other means.
> > > + */
> > > +#define PTRACE_EVENTMSG_SYSCALL_ENTRY	0x80000000U
> > > +#define PTRACE_EVENTMSG_SYSCALL_EXIT	0x90000000U =20
> >=20
> > Stupid question, why not
> >=20
> > 	#define PTRACE_EVENT_SYSCALL_ENTRY	8
> > 	#define PTRACE_EVENT_SYSCALL_EXIT	9
> >=20
> > right after other PTRACE_EVENT_* constants?
>=20
> I thought about adding new events for syscall {entry,exit}.
> For tracers, using new events means setting new options and checking
> for new values after waitpid(). They will also have to switch from using
> PTRACE_SYSCALL to PTRACE_CONT.
> Right now (with this version of the patch) tracers can use
> PTRACE_GETEVENTMSG without doing any additional configuration.
> More importantly, adding these events would require much more complex
> modifications of kernel code than this patch does.

To be honest, we don't see any way of introducing PTRACE_EVENT_* support
in PTRACE_GET_SYSCALL_INFO without adding new fields to struct task_struct.

> The only benefit I see from adding these events instead of letting
> syscall-stops put a value in ptrace_message is an ability to subscribe
> to syscall entries, but not to exits, and vice-versa, and I don't think
> it is worth it.


--=20
ldv

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJb/L6hAAoJEAVFT+BVnCUIsHYQAO5hqEnDe+1q5233vA7ju+mg
Om/u/FfJyARRNmujrPZU8B8RR3nYUj7SdVgdq/AJd22eyL8Vs9RRTw8QjxNDrVGF
zCnPL+z63PokV+YK6ohoE/MdR0SWgfQZnP70tY9CdqQIYQh3OxQ0cu9e8ERe9KYS
R+AifBUolcTQgftUatw085lCG6hv1+wlas2hAT4JE+Tgq/2wTPPsFChPhYn8SJ30
S+KGWaVVDzLy5l3OJfgoWcV2DYaHEZmtSW18Xv2qeSZHlLzoAPWCUEiUfOhEFieE
s+Fmn/ZTvwmnYyxsrPYKFb0YfSTNPrvpdTecyOok/kqo0l4uMqxJ/7RzByIbHWSv
qBSBACnLozEUHupAK8XcrbGtoBjNl4Ae6uQ+1NRafUy1R06Bx7nqRhfMqkrrKae/
5sQTL0P5lCNXiEGP3Hu/SJoUJS5ZgKth8J7XcAuM/YeBC9SMTuNU9ShWgXWetqXT
55GYy/VKV4tM0a8sDFSGYN3As6Uuuj1ztGmElmkycCb1+/GiViarrc/ReTuxDT3H
JOocZNybF2kdg0GyuIYFf5/B/Zhn0W/dW2ShFRIoBKC0Anmnz2lY4WbT6ktDweRl
hSKSSVh5XEmTnJIlKrNHPZOyiBZRy8HPnGq9+VBEj8i7XT2Ee4sNcJ5S71MNzKUs
hmM8TRMvLedvYoEwHSZ9
=oNrp
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
