Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeDLMsp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:48:45 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:54055 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDLMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:48:44 -0400
X-Google-Smtp-Source: AIpwx4/vJpWuYTBlSfjxgICYFnlGhZ7mDNzo7bzf01VfVz1QehxWi/Z6PJA+uaiovRFgHvIVBZUocQ==
X-ME-Sender: <xms:qFXPWjyK2Yb8WjLPPMCG6aHQRSWN5FIzg4wzCLs5BEELlrvNAd6Cpg>
Date: Thu, 12 Apr 2018 20:52:50 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] memory-model: fix cheat sheet typo
Message-ID: <20180412125250.to46vdgztwa2jsbq@tardis>
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
 <20180409184258.GP3948@linux.vnet.ibm.com>
 <20180410203214.GA19606@linux.vnet.ibm.com>
 <8cbda122-6aa3-365b-fd09-52dca0644cbd@redhat.com>
 <20180410213434.GC3948@linux.vnet.ibm.com>
 <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
 <20180411161956.GQ3948@linux.vnet.ibm.com>
 <20180411163157.GQ4082@hirez.programming.kicks-ass.net>
 <70348608-e695-1977-d34e-d7d66b07ad25@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ywkyqeufzin4r2cq"
Content-Disposition: inline
In-Reply-To: <70348608-e695-1977-d34e-d7d66b07ad25@redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ywkyqeufzin4r2cq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 07:06:36PM +0200, Paolo Bonzini wrote:
> On 11/04/2018 18:31, Peter Zijlstra wrote:
> >>>                                    Prior Operation   Subsequent Opera=
tion
> >>>                                    ---------------   ----------------=
-----
> >>>                                    R  W  RMW  SV     R  W  DR  DW  RM=
W  SV
> >>>                                    -  -  ---  --     -  -  --  --  --=
-  --
> >>> smp_store_mb()                     Y  Y    Y   Y      Y  Y   Y   Y   =
Y   Y
> > I'm not sure about that, the generic version of that reads:
> >=20
> > include/asm-generic/barrier.h:#define __smp_store_mb(var, value)
> >     do { WRITE_ONCE(var, value); __smp_mb(); } while (0)
> >=20
> > Which doesn't not have an smp_mb() before, so it doesn't actually order
> > prior; or I'm failing to read the table wrong.
>=20
> You're not, even better reason to document it. :)  I was going from
> memory for the x86 version.
>=20
> I'll start tomorrow on fixes to the current document, while we discuss
> the split format and what to do about cumulativity and propagation.
>=20

Besides, since smp_store_mb() is a store, so there is no DR or DW for
the subsequent operations I think, because dependencies come from a read
rather than a write.

Regards,
Boqun

> Paolo

--ywkyqeufzin4r2cq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrPVp8ACgkQSXnow7UH
+rjYGQf+Lvi6SFWCKieeCBR3ik5XNzFmsa9xrBbuUFyGdSWf0AkcmePu7wlMqk+x
Y6w64jqe4sof5/A41KRW35ZDddXFhtpz5lMSzPoDOT7aIiA+MIAlEA6bL6iC0Ecd
a2qlEFrrjPEgtjJ9yFHoYO6YC9dKijgAqqEa0MKQMznKlY6hfJcxIZL9+LDvncfk
UovWxIPWuxnn57eDkcwJkaEGv09rxe9ZJsudzyLRF32oT0KyBMtkG4e7L19ER1pF
dQ9eLlY7ElXTfV1OYhGe+SotJ9+GF4FLkoWKDhtxNQXtwkKeMh0bTd+Bq9TJ8rgn
P2inAQtWlBW0yqzYJ3mZ8fr4AhOxVw==
=dhHW
-----END PGP SIGNATURE-----

--ywkyqeufzin4r2cq--
