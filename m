Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeC0SCw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:02:52 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58060 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbeC0SCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:02:46 -0400
Message-ID: <1522173764.6308.68.camel@surriel.com>
Subject: Re: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
From: Rik van Riel <riel@surriel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Date: Tue, 27 Mar 2018 14:02:44 -0400
In-Reply-To: <CAJZ5v0ikayycQs1m2rTa8WRLZ5sQ5q2SQVZkDuuy6GOE=dJFQQ@mail.gmail.com>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan>
         <20180314120450.GT4043@hirez.programming.kicks-ass.net>
         <1521736338.6308.24.camel@surriel.com>
         <CAJZ5v0ikayycQs1m2rTa8WRLZ5sQ5q2SQVZkDuuy6GOE=dJFQQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BfUJF2gQDtd4aLQ+F17L"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BfUJF2gQDtd4aLQ+F17L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-03-27 at 18:42 +0200, Rafael J. Wysocki wrote:
> On Thu, Mar 22, 2018 at 5:32 PM, Rik van Riel <riel@surriel.com>
> wrote:
> > On Wed, 2018-03-14 at 13:04 +0100, Peter Zijlstra wrote:
> >=20
> > > On x86 we don't have to use that time_check_counter thing,
> > > sched_clock()
> > > is really cheap, not sure if it makes sense on other platforms.
> >=20
> > Are you sure? I saw a 5-10% increase in CPU use,
> > for a constant query rate to a memcache style
> > workload, with v3 of this patch.
>=20
> I think I know what's going on.

I ran my tests wrong, and the script never propagated
errors back to me. Sigh.

However, the poll_idle() that reads the TSC at a
reduced rate seems to perform better than the one
that reads the TSC every time it goes around the
loop.

The size of the idle loop seems to make a slight
difference, too. Having just one cpu_relax() in
the entire loop seems to be better than having
them all over the place.

--=20
All Rights Reversed.
--=-BfUJF2gQDtd4aLQ+F17L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlq6h0QACgkQznnekoTE
3oME5AgAi3WYDS8MgnYZmMKp/5vQNLI1ekkX+ns8s77eviDHTbjI7EgEiQvl0f8f
hKEzbAhpnfWAga/s8nFfufxi/C+obSeycEWKusWObvuwqMVm9EmCTktzcEpJYR2F
RHN9QAP58i0yikrWSR8uLT1bDMB6+7Fj9qHumXR+Of/umiY032xG9JxwICI5HVSt
mqDrCHT1rig/DNMh9rftO96IFdXIrqQhLwLAivEHbPXxh+Ir9lKw8yjFeXfZo0+U
j2aDsv7L9TLdpsYE0jwBINqV4FdHB06i/V6/xckuyHUO2+y7uw2B420r3ahCbOrR
ApXRiUbjIS4+RNZJtbudzUDpFmiiqA==
=1Az3
-----END PGP SIGNATURE-----

--=-BfUJF2gQDtd4aLQ+F17L--
