Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933252AbeBVQbC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:31:02 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53512 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbeBVQbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:31:01 -0500
X-Google-Smtp-Source: AH8x224scwErQYYYy+gh41eYwXMciqVQbmpWSz1WqOmFSHsrwcKJlTYGB8kd+ry06QzWw+e1K2FBdQ==
X-ME-Sender: <xms:QfCOWiF3Os260mjHWvnUPbvZM2H-RP24q0PDjYJ7oQC92OISgaQxYA>
Date: Fri, 23 Feb 2018 00:34:26 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to
 work with multiple kinds of dependencies
Message-ID: <20180222163426.fcfq6ubq25ipxhfb@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-6-boqun.feng@gmail.com>
 <20180222142614.GR25201@hirez.programming.kicks-ass.net>
 <20180222151210.jwxjchywk4jfecyf@tardis>
 <20180222160811.GT25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="teayzfysboz73akb"
Content-Disposition: inline
In-Reply-To: <20180222160811.GT25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--teayzfysboz73akb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 05:08:11PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 11:12:10PM +0800, Boqun Feng wrote:
> > On Thu, Feb 22, 2018 at 03:26:14PM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 22, 2018 at 03:08:52PM +0800, Boqun Feng wrote:
> > > > Now we have four kinds of dependencies in the dependency graph, and=
 not
> > > > all the pathes carry strong dependencies, for example:
> > > >=20
> > > > 	Given lock A, B, C, if we have:
> > > >=20
> > > > 	CPU1			CPU2
> > > > 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > 	write_lock(A);		read_lock(B);
> > > > 	read_lock(B);		write_lock(C);
> > > >=20
> > > > 	then we have dependencies A--(NR)-->B, and B--(RN)-->C, (NR and
> > > > 	RN are to indicate the dependency kind), A actually doesn't have
> > > > 	strong dependency to C(IOW, C doesn't depend on A), to see this,
> > > > 	let's say we have a third CPU3 doing:
> > > >=20
> > > > 	CPU3:
> > > > 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > 	write_lock(C);
> > > > 	write_lock(A);
> > > >=20
> > > > 	, this is not a deadlock. However if we change the read_lock()
> > > > 	on CPU2 to a write_lock(), it's a deadlock then.
> > > >=20
> > > > 	So A --(NR)--> B --(RN)--> C is not a strong dependency path but
> > > > 	A --(NR)--> B --(NN)-->C is a strong dependency path.
> > >=20
> > > I'm not really satisfied with the above reasoning. I don't disagree, =
but
> > > if possible it would be nice to have something a little more solid.
> > >=20
> >=20
> > What do you mean by "solid"? You mean "A --(NR)--> B --(NN)-->C" is too
> > abstract, and want something like the below instead:
>=20
> The above description mostly leaves it as an exercise to the reader to
> 'proof' ignoring *R -> R* is both safe and complete while that is the
> main argument.
>=20

OK, so I have some 'proof' in patch #16. I could move that proof in the
commit log or merge that patch with this one?

Regards,
Boqun

--teayzfysboz73akb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqO8Q4ACgkQSXnow7UH
+rgVwgf+LRmoCdppTtUO5/xOARdx4mEcWipD9wS6C9aXQNA+w2s20O7IsAj5bFL+
KvdI9c9lQsL4CDbu0kcfa9WkvlGtTLvVxmx9f4hghJBOWTeOckHKpSuKkc4fmhcA
uoIePgIzjwRddutY0Fy/VkqRj/6gJiQ7fzL8bCJ+xQfnt1bulzq7jIkvyfKDzU30
g7axpUpZZ5WwaZaXRdUeFr3ZIJitJo7b2p9apN5TB0Ue34hPS0qoOVdeOdFth8rJ
+tMsIunU+4OoD/+mQ/2BnWiZEI4tMQqc8VgAsupSTVo/n5APvCqAj+0klTz0Cb9l
MMvBpTvU5T5wvpo3Jl7gBRL8wyNNUA==
=mUwR
-----END PGP SIGNATURE-----

--teayzfysboz73akb--
