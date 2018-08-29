Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41143C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E9E205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E9E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeH2W2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:28:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32983 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbeH2W2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:28:34 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fv5EN-0006iH-VE; Wed, 29 Aug 2018 19:30:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fv5EI-0001CW-Pi; Wed, 29 Aug 2018 19:30:10 +0100
Message-ID: <b66f7e94b2f2a8c6ac86c26dc6951cde943367fb.camel@decadent.org.uk>
Subject: Re: [PATCH] locking/lockdep: Delete unnecesary #include
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Date:   Wed, 29 Aug 2018 19:30:10 +0100
In-Reply-To: <20180829094951.2d88cb75@gandalf.local.home>
References: <20180828203315.GD18030@decadent.org.uk>
         <20180829093121.GQ24124@hirez.programming.kicks-ass.net>
         <20180829094951.2d88cb75@gandalf.local.home>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-y/lCKIxHuGm/98QFdaeq"
User-Agent: Evolution 3.29.92-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y/lCKIxHuGm/98QFdaeq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-29 at 09:49 -0400, Steven Rostedt wrote:
> On Wed, 29 Aug 2018 11:31:21 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > On Tue, Aug 28, 2018 at 09:33:15PM +0100, Ben Hutchings wrote:
> > > Commit c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and =
u
> > > nify their usage") added the inclusion of <trace/events/preemptirq.h>=
.
> > > liblockdep doesn't have a stub version of that header so now fails to
> > > build.
> > >=20
> > > However, commit bff1b208a5d1 ("tracing: Partial revert of "tracing:
> > > Centralize preemptirq tracepoints and unify their usage"") removed th=
e
> > > use of functions declared in that header.  So delete the #include.
> > >=20
> > > Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints ..."=
)
> > > Fixes: bff1b208a5d1 ("tracing: Partial revert of "tracing: Centralize=
 ...") =20
> >=20
> > There's no actual breakage because of this extra include, is there?
>=20
> I believe the user tool in tools/lib/lockdep fails because of it.
> Although, I just tried building it myself, and it fails because of
> nmi.h header file.

Sasha already sent fixes to fix that and another missing definition,
but they haven't been applied.

Ben.

--=20
Ben Hutchings
For every complex problem
there is a solution that is simple, neat, and wrong.



--=-y/lCKIxHuGm/98QFdaeq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAluG5jIACgkQ57/I7JWG
EQndIBAApDq2PoQbpHqtc4tGRCnSzPFYHpVeBE/N718kSRH3cbYp7jHXiv02llWp
PA9MWd43AoYAYe/V7pr6KQIkRmi5opIKbr85Yu8wCv2e3LloLtt+nKadVEq9vFH7
nxsogt7l8jtyMYYi3eKQtJv4/guWCuGzNwuzbtkNCXtqDL2rmJNOJpyT879UdmzB
0ja9D0hpooR5pnq1JeW0maDT7b9Qr7CxngynqS1MPo8c9ZLIaEexyK+CzVcJjF7M
iLnpn2KATsxZjFtCMqovCJFJHw+3N1qaTqHZseHLlwSmbdWnVCroSDSsxUUJH1p5
x/M+3Gfnppvin7lmmOvKJjf1UIzWw/ilo3bOxv0iDpB8+ITjjHzJjHXlSJV8CwT/
w6+rRezPJPHXxG5Lq25+1IfeTb2NGaxMnh2qsNqeionWjYLo+IEnnShNdNdMCgm+
HNwsFih0THpoYNSepxLApl/Uu4RGlmkSn6KNpQz6daa+hW7N7On0RVe34eacX/Bv
XpUUnFxHSq+Mne4vvlL020XI5Yzgw1yoHmqrXs0q5Ynz7tb/RtH5/qHkalhtzVAZ
pVc1fYoXJeRf87CsXoz0UiiWxPZWF3/0KjWqIt9VTnvF3PC/qw1tB9i7vOHXf0fl
cCmJURAm2osFfNQPcIDo041skuNlfh4/9iKYN/lOJfG2EQ7EWoo=
=zCir
-----END PGP SIGNATURE-----

--=-y/lCKIxHuGm/98QFdaeq--
