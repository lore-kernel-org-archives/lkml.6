Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeBWMhA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:37:00 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43211 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBWMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:36:58 -0500
X-Google-Smtp-Source: AG47ELtwWlvVjmyi5pq5ncqbuUYuKresJjCwNMSORsDFThyOlAh1asovlsWxd5IrF0yr1nfvYJbqcQ==
X-ME-Sender: <xms:6AqQWnueiMs5lCf5gZF_QuyceGHc025o6qTEjPEmDsR7UdaG5mbIoA>
Date: Fri, 23 Feb 2018 20:40:23 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 15/17] lockdep: Reduce the size of
 lock_list
Message-ID: <20180223124023.kdl6pkitu2nhgv4z@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-16-boqun.feng@gmail.com>
 <20180223113843.GY25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ux5zkvmskhc7amk"
Content-Disposition: inline
In-Reply-To: <20180223113843.GY25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ux5zkvmskhc7amk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 12:38:43PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 03:09:02PM +0800, Boqun Feng wrote:
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index a1f91f8680bd..3fce8dbf5091 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -186,11 +186,11 @@ struct lock_list {
> >  	struct list_head		entry;
> >  	struct lock_class		*class;
> >  	struct stack_trace		trace;
> > -	int				distance;
> > +	u16				distance;
> >  	/* bitmap of different dependencies from head to this */
> > -	u16				dep;
> > +	u8				dep;
> >  	/* used by BFS to record whether this is picked as a recursive read */
> > -	u16				is_rr;
> > +	bool				is_rr;
>=20
> Don't use bool, use u8 if you want a single byte. sizeof(_Bool) is part
> of the architecture ABI and can be up to 4 bytes (well really anything,
> but I've not seen it bigger than 4 bytes for any sane implementation).

Got it, thanks!

Regards,
Boqun

--6ux5zkvmskhc7amk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqQC7QACgkQSXnow7UH
+rhFGwf+Jv+A+TnlEzw1zjBEJM2acomOjUr6R08H+7yF+99YSdLFHuwpos1VgXOo
zj9kzDR4+Gx4d+C+CLvN7zaY/XVPzPcTeGFPqTqXbtuJLZ5HkBUrpIXU8zOCW389
c9KIs+F22LWVlvOSQkD0tLUfy8h7TwvLN3YqIRj26d0AW+PZcern+7GmxSgsSZfH
P/9w8FGY+CfgyoAWq83bUwmjYBqQL1Fw7A3TXxGNqpbuBvO82ZHcAhP6FZHYt6r+
hCAuDK6LUzix5jyDrMgUf0y2n7Z3ENyKQDiTSuoSXsFEXsIyCQB+M00KmIr/TYY5
qPEVbDn6GOPWOGh/bVb85GrY1kFBBg==
=jDsH
-----END PGP SIGNATURE-----

--6ux5zkvmskhc7amk--
