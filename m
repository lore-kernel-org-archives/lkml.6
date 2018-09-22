Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CB8ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5B52154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="QdoYAkfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5B52154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeIVTPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:15:04 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44611 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeIVTPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:15:04 -0400
Received: by mail-oi0-f65.google.com with SMTP id l82-v6so13631389oih.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HNcNyBwY7fIjxicUVA71G5eX+eUJKh7I+daABSk6rzM=;
        b=QdoYAkfdAgrZ5WFUpIjSdUg0+dBEIN+5GML9vdfJtdjMORsMqRVbGIeSMq91YsyxQg
         LDnnrpoQL22vLVllWCTXDvu1n5T0wwfKCQTKzzxKliMaABaz+X9Wzyctf0IKI3zjFTjP
         imv/elHB1sf0jiIvD5q6Qk2lNzYyIN/xlFMIGy0i0itzKSZ0mKWWku+YkGGoMIgXFuUD
         X1Hb7VySOG5GPaBa5vjnxkSruWLYb1SPj/iOxy1gllMPX5yXCpc15hpBe4+hLPw6Gv6v
         N+lM7YghES56wG+hPxdHbj+B//3vTXJl4FkHJucAlaCe1Pd+VQxnC9CPjorK6ma4Lm0Y
         nGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HNcNyBwY7fIjxicUVA71G5eX+eUJKh7I+daABSk6rzM=;
        b=Wfsl310sO6r34n0bC6ScP08xO79VV7YunruQT9PmKZ2rGWntxZD9GnNvg9wJFc97xU
         o/ZLA4FEVnHOrrOkYXIXPYoBARso0CefuSiCEiSSbbT7InLgkuW95lvreBfhQw8JD2qU
         9TJjkJlTllNcvCCdN0VjL5J8u4f1pPnTec2Jzvmunjo1NIqPl4xXwCESDEg4v78xzl6W
         /gxUHNV5hlMvcbtrL89euUyPRP3iKPZlUHXsYOqhK6r4cnZKIuHhHr9azbB3wOFFB9t6
         1CZ4MJOyYCelraNu3n37ESqABACmJ0hPLjY9OHXh1S2UQ0vQB7H9Bj9h4iVtgGOobqv+
         HC7w==
X-Gm-Message-State: APzg51B7+u94V2Ei+zgVyHDvgCm5wXcWa/Ecr79GIDgwxjL5BjJGvzA7
        Vu1JwehNFJTruBdIZdCx7xOAlw==
X-Google-Smtp-Source: ANB0Vdbje16rRbB0IC8Dmv/vU0qlbZBT1nVhYjfiTRGsZLJdLs4KMIGSlGnP+yZsMG80AYco2oP6xQ==
X-Received: by 2002:aca:48b:: with SMTP id 133-v6mr702895oie.28.1537622489166;
        Sat, 22 Sep 2018 06:21:29 -0700 (PDT)
Received: from brauner.io ([172.56.7.23])
        by smtp.gmail.com with ESMTPSA id 1-v6sm9924931oir.19.2018.09.22.06.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 06:21:28 -0700 (PDT)
Date:   Sat, 22 Sep 2018 15:21:09 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
Message-ID: <20180922132106.wfa6xaxwbu276qka@brauner.io>
References: <20180921155455.flkf5vdrm3vgn6do@brauner.io>
 <20180920151214.15484-6-mszeredi@redhat.com>
 <20180920151214.15484-1-mszeredi@redhat.com>
 <17157.1537542475@warthog.procyon.org.uk>
 <20311.1537548756@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wesq2zeaygxqgfat"
Content-Disposition: inline
In-Reply-To: <20311.1537548756@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wesq2zeaygxqgfat
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 05:52:36PM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
>=20
> > So from reading the patch I got the impression that superblock mount
> > options passed via fsconfig() are passed as strings like "ro" and are
> > translated into approriate objects (e.g. flags etc.) by the kernel.
>=20
> I'm having second throughts about that - at least for "ro": that one is
> particularly problematic as it governs how source devices are opened.  I'm
> kind of tempted to pass that as a flag to fsopen().
>=20
> What I'd like to do in btrfs, ext4, etc. is open blockdevs as I get the
> parameters that enumerate them - but I have to hold the looked-up paths t=
ill
> the validate/get_tree stage so that I know the final ro/rw state before I=
 can
> do the opening.
>=20
> > That seems like a future proof mechanism to extend mount options for
> > userspace without having to worry about exceeding any integer types in =
the
> > future. Maybe this would make sense for non-superblock options as well?=
 I
> > can see that this is less performant that checking flags and string par=
sing
> > is a thing that is not particularly nice but it would be one option to =
solve
> > the running out of flags problem.
>=20
> Al disliked the idea of setting up a separate context to define the mount
> options.

I hope thinking about mount flag exhaustion at this point is not too
hijacking this thread too much. But another option I was thinking about was=
 to
split the mount flags into different sets where the sets can be
differentiated by a command.

enum {
        MOUNT_ATTR_PROPAGATION =3D 1
        MOUNT_ATTR_SECURITY
        MOUNT_ATTR_FSTIME
}

Let's say split mount propagation flags into a set identified by
MOUNT_ATTR_PROPAGATION:
#define MOUNT_ATTR_UNBINDABLE   (1<<0)  /* change to unbindable */
#define MOUNT_ATTR_PRIVATE      (1<<1)  /* change to private */
#define MOUNT_ATTR_SLAVE        (1<<2)  /* change to slave */
#define MOUNT_ATTR_SHARED       (1<<3)  /* change to shared */

and another set
MOUNT_ATTR_SECURITY:
#define MOUNT_ATTR_RDONLY        (1<<0) /* Mount read-only */
#define MOUNT_ATTR_NOSUID        (1<<1) /* Ignore suid and sgid bits */
#define MOUNT_ATTR_NODEV         (1<<2) /* Disallow access to device specia=
l files */
#define MOUNT_ATTR_NOEXEC        (1<<3) /* Disallow program execution */

and another set
MOUNT_ATTR_FSTIME:
#define MOUNT_ATTR_NOATIME      (1<<0)  /* Do not update access times. */
#define MOUNT_ATTR_NODIRATIME   (1<<1)  /* Do not update directory access t=
imes */

and so on...

So you could e.g. add another unsigned int cmd argument to
mount_setattr():

mount_setattr(int dfd, const char *path, unsigned int atflags,
              unsigned int attr_cmd,
	      unsigned int attr_values,
	      unsigned int attr_mask);

Then - similiar to fsconfig()'s FS_CONFIG_SET_{FLAG,STRING,...} - you
would pass:

/* set propagation */
mount_setattr(dfd, path, atflags,
              MOUNT_ATTR_PROPAGATION,
	      vals,
	      propagation_flagmask);

/* set security */
mount_setattr(dfd, path, atflags,
              MOUNT_ATTR_SECURITY,
	      vals,
	      security_flagmask);

/* set time */
mount_setattr(dfd, path, atflags,
              MOUNT_ATTR_FSTIME,
	      vals,
	      fstime_flagmask);

and then finally have an additional command like:

/* apply changes */
mount_setattr(dfd, path, atflags, MOUNT_ATTR_APPLY, vals, 0);

that applies all the properties.

In kernel you could then either have separate flags in the corresponding
structs of interest or bit arrays of arbitrary length or whatever.
Each of the flag setting commands before the MOUNT_ATTR_APPLY would then
perform verification whether the combination of flags makes sense and
immediately return back an error to userspace but only the
MOUNT_ATTR_APPLY call would actually commit the changes.

>=20
> > > 	mount_setattr(int dfd, const char *path, unsigned int atflags,
> > > 		      unsigned int attr_values,
> > > 		      unsigned int attr_mask);
> >=20
> > If we go with the flag arguments wouldn't it make sense to use a larger
> > integer type?
>=20
> You can't - at least not directly through syscall args.  They are 32-bit =
on a
> 32-bit system.

Ah, 32bit systems. I tend to forget that they exist. :)

>=20
> > > where atflags can potentially include AT_RECURSIVE.
> >=20
> > Very much in favor of having this operate recursively!
>=20
> It gets complicated with propagation.

Sure, I totally understand.

Christian

--wesq2zeaygxqgfat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAlumQcIACgkQjrBW1T7s
sS25/Q/+MAZYF2T2DmFh80HqUJ5f7dRCAWmohsOiKAU6TbYD87o0LEbRP9pDvLqe
cW7PeZbGhq++Ol2q4Ff14WiO/bFWKbtbQ7n5vCG1o05+5ikQSd81O8QslG0Nrn+v
zTsu+/TEAH5ZmFNVetiD/98mkWS9K3E8tmJTMTwXA0Tkkwyq9ezIOtoF+LQ6/e+A
DSwA+VlfNr23ijFFQ6ojTNAhGpngJfX0IOQeANYRNol69I4k9C96S2biAKfvV4xM
9MYiBTi0FAKlv6fTyDnPyG4DmSkF5db1g3RGjD/t7heLm4Nz/IFyvpm7ZJZTqBmo
6smkhX1W1UnPuu57yY1n/VqNjccp1XE5w+iPhTp5v+UoObbelV1p9ey6taRwNrmY
+hNQfBeA2ga7ZEn1uEN0mH77Y1Cg82Vj5mRwliP05wLpujlOeZM729zMKfumaxa7
UAyNQ+WwloKJAibX72usqM8Pmza1Us7YPcp/eXtKMenHiDgz5F3HBNBJQq1USGmm
UR3u+4jKUqS86kHzGR1OiTOgjZ+sP10EpQRL4gCSRprAZVRJ7E3hP9cb3KuGYGbR
RlGsdxZrRSYy13ymh6KIRjrKBOMeUzOMwMO3KVOg3hyPicpqU5thhAxS6+Urql7v
+IKqAJa6h3geiBXgDamz8CMHETNV/FN/VEh3iHZXaRGbWifkBzE=
=t3Po
-----END PGP SIGNATURE-----

--wesq2zeaygxqgfat--
