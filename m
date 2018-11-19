Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A53C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA0020851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA0020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbeKTGrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:47:23 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:21428 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbeKTGrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:47:23 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BF039A23EE;
        Mon, 19 Nov 2018 21:22:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id lRsbVGwNnT88; Mon, 19 Nov 2018 21:21:59 +0100 (CET)
Date:   Tue, 20 Nov 2018 07:21:47 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
Message-ID: <20181119202147.ciihjtjwvuqsjkl5@yavin>
References: <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org>
 <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAJwJo6aXQUtciO7kPSENoajV6JUqUGJxCh_0yPf5D8GfbLegzA@mail.gmail.com>
 <CAKOZueu78Urbc-Vt--ZntGAG_i-LrNsPjGmRi7F8zuTUQ=iHug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w4qs7hshq6b2wwkx"
Content-Disposition: inline
In-Reply-To: <CAKOZueu78Urbc-Vt--ZntGAG_i-LrNsPjGmRi7F8zuTUQ=iHug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w4qs7hshq6b2wwkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-19, Daniel Colascione <dancol@google.com> wrote:
> > I wonder how fast it would be holding a pid with another open()ed fd.
> > And then you need to read comm (or how you filter whom to kill).
> > It seems to me that procfs will be even slower with this safe-way.
> > But I might misunderstand the idea, excuses.
> >
> > So, I just wanted to gently remind about procfs with netlink socket[1].
>=20
> We discussed netlink was extensively on the thread about
> /proc/pid/kill. For numerous reasons, it's not suitable for
> fundamental process management. We really need an FD-based interface
> to processes, just like we have FD-based interfaces to other resource
> types. We need something consistent and reliable, not an abuse of a
> monitoring interface.

Another significant problem with using netlink for something like this
is that (as its name suggest) it's tied to network namespaces and not
pid namespaces so you wouldn't reasonably be able to use the API inside
a container. Using an fd side-steps the problem somewhat (though this
just gave me an idea -- I will add it to the other thread).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--w4qs7hshq6b2wwkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvzG1sACgkQSnvnv3De
m5/o3w//QtToPt6YGjGxEwBs6Xy/JH/aPOJuTGxlgjIqAPfQlv58hS027yma2liy
MsHd/8Ifp2BvwzqeFdE8E9u96/TxeC95kmF9InaIG8mNfUa3rPYQrm1rBIMJ4JGn
X2JXntY8s+YGiO3FwJ/r0CDEIzNNWevaNBN3z8oWKYlJ0FsYQhF6i523MgSuiMqP
fVDyroRdWoFWKc0XenbWh2OKwM2rxjVfNg6QYabm/b7YNBfOqZI9SskYDCu7xRkD
ZE1kfO/nHORskwhJ+06ArwboyhnLThAcgGEdJ3dw7ujio10s0xuJvZ+wHYktsA2a
fEcnIFzshktG6Tpjqh0mYopLFskQceSXuJLjkZsOSOamzH3LI312EPfCQGOO/xBx
83KhHHXbZg1K0gxQGfImGlR9G0H0M12S9JPZ/lThQ2NLUgmYRgN2PLFi8vfxqSFO
0FerWJrVJbGfuHb/qA9GWytrbfoMfgL2lyAGtnZWOWQXysT34zVHPWsxcgF0pmTc
wbGYKmjxt3YEg74hoUgFJldpl56zDvflwFtZcJusimMA/ELIPKi3QBcVuW2mtYkr
1YC6DCsdSYzLZmLDViU+xP5SamPd/pAJH/l26p4yXwkW47Drd+gGTt+mRLLqxVxQ
ZZAnUMSetE/S+Yk4Wv0YxdXnEKIEfKd4HRvMfQ1gkYcXMXc0NZo=
=y5gr
-----END PGP SIGNATURE-----

--w4qs7hshq6b2wwkx--
