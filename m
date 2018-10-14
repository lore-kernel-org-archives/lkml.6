Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6994DC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238F520835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238F520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeJOBpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:45:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38120 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbeJOBpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:45:08 -0400
Received: from 188.29.164.50.threembb.co.uk ([188.29.164.50] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBkjV-0005hf-FS; Sun, 14 Oct 2018 19:03:17 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBkjO-0005aS-IZ; Sun, 14 Oct 2018 19:03:10 +0100
Message-ID: <b9d260e3461ed622110848858970c016054d622a.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 194/366] drivers: tty: Merge alloc_tty_struct and
 initialize_tty_struct
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun, 14 Oct 2018 19:03:06 +0100
In-Reply-To: <CAKwiHFisgkjvaU9gtTdv=XF+7vhQeQo9TSNLAcNU5_uqALohYQ@mail.gmail.com>
References: <lsq.1539530740.755408431@decadent.org.uk>
         <lsq.1539530741.287802176@decadent.org.uk>
         <CAKwiHFisgkjvaU9gtTdv=XF+7vhQeQo9TSNLAcNU5_uqALohYQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-rrz/p7jpAW9DNK1t1tQO"
User-Agent: Evolution 3.30.0-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 188.29.164.50
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rrz/p7jpAW9DNK1t1tQO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-10-14 at 19:22 +0200, Rasmus Villemoes wrote:
> IIRC, I messed up back then, so you'll need some followup as well, but I'=
m
> on my phone ATM.

I guess that's commit 07584d4a356e "drivers: tty: Fix use-after-free in
pty_common_install"?  I missed that but will add it now.

>  I assume you're taking this to make it easier to backport
> some actual fix?

This is required as preparation for commit 903f9db10f18 "tty: Don't
call panic() at tty_ldisc_init()".

Ben.

>=20
> On Sun, Oct 14, 2018, 17:39 Ben Hutchings <ben@decadent.org.uk> wrote:
>=20
> > 3.16.60-rc1 review patch.  If anyone has any objections, please let me
> > know.
> >=20
> > ------------------
> >=20
> > From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >=20
> > commit 2c964a2f4191f2229566895f1a0e85f8339f5dd1 upstream.
> >=20
> > The two functions alloc_tty_struct and initialize_tty_struct are
> > always called together. Merge them into alloc_tty_struct, updating its
> > prototype and the only two callers of these functions.
> >=20
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  drivers/tty/pty.c    | 19 +++++++++----------
> >  drivers/tty/tty_io.c | 37 +++++++++++++------------------------
> >  include/linux/tty.h  |  4 +---
> >  3 files changed, 23 insertions(+), 37 deletions(-)
> >=20
> > --- a/drivers/tty/pty.c
> > +++ b/drivers/tty/pty.c
> > @@ -319,7 +319,7 @@ done:
> >   *     pty_common_install              -       set up the pty pair
> >   *     @driver: the pty driver
> >   *     @tty: the tty being instantiated
> > - *     @bool: legacy, true if this is BSD style
> > + *     @legacy: true if this is BSD style
> >   *
> >   *     Perform the initial set up for the tty/pty pair. Called from th=
e
> >   *     tty layer when the port is first opened.
> > @@ -334,18 +334,17 @@ static int pty_common_install(struct tty
> >         int idx =3D tty->index;
> >         int retval =3D -ENOMEM;
> >=20
> > -       o_tty =3D alloc_tty_struct();
> > -       if (!o_tty)
> > -               goto err;
> >         ports[0] =3D kmalloc(sizeof **ports, GFP_KERNEL);
> >         ports[1] =3D kmalloc(sizeof **ports, GFP_KERNEL);
> >         if (!ports[0] || !ports[1])
> > -               goto err_free_tty;
> > +               goto err;
> >         if (!try_module_get(driver->other->owner)) {
> >                 /* This cannot in fact currently happen */
> > -               goto err_free_tty;
> > +               goto err;
> >         }
> > -       initialize_tty_struct(o_tty, driver->other, idx);
> > +       o_tty =3D alloc_tty_struct(driver->other, idx);
> > +       if (!o_tty)
> > +               goto err_put_module;
> >=20
> >         if (legacy) {
> >                 /* We always use new tty termios data so we can do this
> > @@ -390,12 +389,12 @@ err_free_termios:
> >                 tty_free_termios(tty);
> >  err_deinit_tty:
> >         deinitialize_tty_struct(o_tty);
> > +       free_tty_struct(o_tty);
> > +err_put_module:
> >         module_put(o_tty->driver->owner);
> > -err_free_tty:
> > +err:
> >         kfree(ports[0]);
> >         kfree(ports[1]);
> > -       free_tty_struct(o_tty);
> > -err:
> >         return retval;
> >  }
> >=20
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -157,20 +157,6 @@ static void __proc_set_tty(struct task_s
> >  static void proc_set_tty(struct task_struct *tsk, struct tty_struct *t=
ty);
> >=20
> >  /**
> > - *     alloc_tty_struct        -       allocate a tty object
> > - *
> > - *     Return a new empty tty structure. The data fields have not
> > - *     been initialized in any way but has been zeroed
> > - *
> > - *     Locking: none
> > - */
> > -
> > -struct tty_struct *alloc_tty_struct(void)
> > -{
> > -       return kzalloc(sizeof(struct tty_struct), GFP_KERNEL);
> > -}
> > -
> > -/**
> >   *     free_tty_struct         -       free a disused tty
> >   *     @tty: tty struct to free
> >   *
> > @@ -1455,12 +1441,11 @@ struct tty_struct *tty_init_dev(struct t
> >         if (!try_module_get(driver->owner))
> >                 return ERR_PTR(-ENODEV);
> >=20
> > -       tty =3D alloc_tty_struct();
> > +       tty =3D alloc_tty_struct(driver, idx);
> >         if (!tty) {
> >                 retval =3D -ENOMEM;
> >                 goto err_module_put;
> >         }
> > -       initialize_tty_struct(tty, driver, idx);
> >=20
> >         tty_lock(tty);
> >         retval =3D tty_driver_install_tty(driver, tty);
> > @@ -3034,19 +3019,21 @@ static struct device *tty_get_device(str
> >=20
> >=20
> >  /**
> > - *     initialize_tty_struct
> > - *     @tty: tty to initialize
> > + *     alloc_tty_struct
> >   *
> > - *     This subroutine initializes a tty structure that has been newly
> > - *     allocated.
> > + *     This subroutine allocates and initializes a tty structure.
> >   *
> > - *     Locking: none - tty in question must not be exposed at this poi=
nt
> > + *     Locking: none - tty in question is not exposed at this point
> >   */
> >=20
> > -void initialize_tty_struct(struct tty_struct *tty,
> > -               struct tty_driver *driver, int idx)
> > +struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx=
)
> >  {
> > -       memset(tty, 0, sizeof(struct tty_struct));
> > +       struct tty_struct *tty;
> > +
> > +       tty =3D kzalloc(sizeof(*tty), GFP_KERNEL);
> > +       if (!tty)
> > +               return NULL;
> > +
> >         kref_init(&tty->kref);
> >         tty->magic =3D TTY_MAGIC;
> >         tty_ldisc_init(tty);
> > @@ -3070,6 +3057,8 @@ void initialize_tty_struct(struct tty_st
> >         tty->index =3D idx;
> >         tty_line_name(driver, idx, tty->name);
> >         tty->dev =3D tty_get_device(tty);
> > +
> > +       return tty;
> >  }
> >=20
> >  /**
> > --- a/include/linux/tty.h
> > +++ b/include/linux/tty.h
> > @@ -477,13 +477,11 @@ extern int tty_mode_ioctl(struct tty_str
> >                         unsigned int cmd, unsigned long arg);
> >  extern int tty_perform_flush(struct tty_struct *tty, unsigned long arg=
);
> >  extern void tty_default_fops(struct file_operations *fops);
> > -extern struct tty_struct *alloc_tty_struct(void);
> > +extern struct tty_struct *alloc_tty_struct(struct tty_driver *driver, =
int
> > idx);
> >  extern int tty_alloc_file(struct file *file);
> >  extern void tty_add_file(struct tty_struct *tty, struct file *file);
> >  extern void tty_free_file(struct file *file);
> >  extern void free_tty_struct(struct tty_struct *tty);
> > -extern void initialize_tty_struct(struct tty_struct *tty,
> > -               struct tty_driver *driver, int idx);
> >  extern void deinitialize_tty_struct(struct tty_struct *tty);
> >  extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int
> > idx);
> >  extern int tty_release(struct inode *inode, struct file *filp);
> >=20
> >=20
--=20
Ben Hutchings
I haven't lost my mind; it's backed up on tape somewhere.


--=-rrz/p7jpAW9DNK1t1tQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvDhNoACgkQ57/I7JWG
EQkDXw//SYxuafg5qQBOw6trFdRXjsrvqq+2BPAUdUnzhKMwY67mXCdzB9/7Ko1G
GYlqMZpU/Od0H5ooPe4w25aem8HMl4hAD6w0h96lM/KTsIfDLRk3FmNFKn5jQrgv
ZyVkl1Ok03/ptm05Oh85Q6Bxw9IuqRAKrVo0KVnORMWO8OA/jXOYP7Pc3AXS3DuG
TMAVPEifvfzUtt3+ai4fMbZ39kcJp8+oHQbf+cU3GkiQJOnG8FS/FdXsT3Y1xpEa
nVPmIE5Y4n3HSCzokRSa+XK8UK9InW6rij5nFMcWVg1Cnt2ztgAeN9oOZAnkpLvx
T4s5QVfDgHIiQPoDneef4yRgG50iyxfl86J1io7x/fElYrZRXEBSLvCnYA2hcapS
YUCDZVY3LrYn/aJ1/9mJBnsiJIvgzZ/eISTXpI9mcjoTNJH41bIQ8jg+2pYeYbsL
leZZK52iyBYJWbqqY5Vhk/Y8ixZPKchuYGpuz5gSpfzJ3mnriUq/eOa0hGhNWDQI
lUAhYDTQRtZPVdTUbFg57Bd21K6Z/2iLQAUgggU2hIgSiMofitytWrtzbjuTXD2h
8/iWtyyMw4B9AfdtEulUzfyaWSQ06QNaBDaUSZ+eCzfvkdZl7/Cz/4T9aEImTc+l
pE8VOMGSDqDWXccBRCt2/XrMg49IaSW4GYgxPbT5YiFScqB6s38=
=R7Iy
-----END PGP SIGNATURE-----

--=-rrz/p7jpAW9DNK1t1tQO--
