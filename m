Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E438C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9952208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="E6EGK0iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9952208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeJAQXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:23:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38167 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbeJAQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:23:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so8812846pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H+CRHjBeLe7oglpOjOfhaMKGGAiaVfjejKCFkJQtpSE=;
        b=E6EGK0iqRSOq90giHOCK1NWafNHG2tJXFJ3hdywA6mPHo62mchDQAnmPOKpk1G9utv
         DG7KTOrnz0gQuubBmkBKrUNGpnF9NLpXRidQIcCxV+maw292/eeK5RoMX6g0IkgRu/M6
         XfQb7HJo+6ivHLN9TV8z6+Z9PdC8rQgdrbVqFXsdqcsJ2O6tG26Y7vUnNss3UzwF40Yv
         RrBocXFt00WR+8aoWYpEum2xezqILdwVCXuPFUe4FILnK4CNgTirirhiZxRXbppCh9Dp
         /n0B8QWjg7FJ3DRADChrH3TEK6x4889rhs6W/h0cetdUg23HcrSPWzION5EIwxaPLNlF
         ihDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+CRHjBeLe7oglpOjOfhaMKGGAiaVfjejKCFkJQtpSE=;
        b=S9RNXQDkdwOliPlnpNAdo38Ps+zRphWzNeyCAM06haJ4FR+/rQJFI2lYnoZ1nEj8yE
         HLa8G79I3xySLl7Ltl1PZN7va/GLk3RHd6wQWGKmP9I7HMoTzqfLWDWqUIaezY+dkg5x
         T+byqBRCsoF2pTR/LImLkHYKOqJtAs0ktNBalQusiqP7B184Y02GcwJUShNF4sB9oB2r
         Z+XBVG5i6ZViMOG8xM0CvRu0ob1fTC6X7MRpR3KFLSXe4RaE4vSrI/UBUJlpzoBdb+Lj
         Gw/8V3oAhGSUFGXA0FldrG7dI2tQF0BqWcv1HBKd8oM7h5mpFco10ne412vfsSnMR/JV
         YPIA==
X-Gm-Message-State: ABuFfojEBFsxoUMJ3W91jfJGoQqwDT4YBAfvviFudRw1NEpSub0T1xew
        BBzFaWWMqYl5t6Cyf/zoTj+bkA==
X-Google-Smtp-Source: ACcGV61AWIuKHT48jU885UkoXkIZC7Xqdfzj1y7Eh/Vvtmv7X6ry2qFf/nmgMLH+366L7PIZo1kZ4A==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6-v6mr10770284pls.226.1538387213956;
        Mon, 01 Oct 2018 02:46:53 -0700 (PDT)
Received: from ryuk (pa49-195-75-230.pa.nsw.optusnet.com.au. [49.195.75.230])
        by smtp.gmail.com with ESMTPSA id 189-v6sm17652410pfe.121.2018.10.01.02.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 02:46:52 -0700 (PDT)
Date:   Mon, 1 Oct 2018 19:46:40 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path
 resolution
Message-ID: <20181001090809.6t7ydq7gk2bwbout@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929131534.24472-1-cyphar@cyphar.com>
 <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
 <F0E08B90-F10B-4897-913D-CA18E99A987D@amacapital.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3rw33qkti4zr7rb4"
Content-Disposition: inline
In-Reply-To: <F0E08B90-F10B-4897-913D-CA18E99A987D@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3rw33qkti4zr7rb4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-09-29, Andy Lutomirski <luto@amacapital.net> wrote:
> >> On Sat, Sep 29, 2018 at 4:29 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >> The primary motivation for the need for this flag is container runtimes
> >> which have to interact with malicious root filesystems in the host
> >> namespaces. One of the first requirements for a container runtime to be
> >> secure against a malicious rootfs is that they correctly scope symlinks
> >> (that is, they should be scoped as though they are chroot(2)ed into the
> >> container's rootfs) and ".."-style paths. The already-existing AT_XDEV
> >> and AT_NO_PROCLINKS help defend against other potential attacks in a
> >> malicious rootfs scenario.
> >=20
> > So, I really like the concept for patch 1 of this series (but haven't
> > read the code yet); but I dislike this patch because of its footgun
> > potential.
> >=20
>=20
> The code could do it differently: do the path walk and then, before
> accepting the result, walk back up and make sure the result is under
> the starting point.
>=20
> This is *not* a full solution, though, since a walk above the root gas
> side effects on timing, various caches, and possibly network traffic,
> so it=E2=80=99s open to Spectre-like attacks in which a malicious contain=
er
> could use a runtime-initiated AT_THIS_ROOT to infer the existence of
> directories outside the container.

I think that one way to solve this problem might be to have more strict
checks on nd->root in follow_dotdot(). The problem here (as far as I can
tell) is that ".." could end up skipping past the root because of a
rename, however walking *down* into a path shouldn't be a problem (even
absolute symlinks shouldn't be a problem because they will nd_jump_root
and will land back in the root).

However, I'm not entirely sure what happens to nd->root if it gets
renamed -- can you still safely do checks against it (we'd need to do
some sort of is_descendant() check on the current path before we handle
".." in follow_dotdot).

That way, we wouldn't shouldn't have the spectre-like attack problem
(since the attack would be halted at the ".." stage -- before the path
walk can proceed into host paths). Would this be sufficient or is there
a more serious issue I'm missing?

> But what=E2=80=99s the container usecase?  Any sane container is based on
> pivot_root or similar, so the runtime can just do the walk in the
> container context. IOW I=E2=80=99m a bit confused as to the exact intende=
d use
> of the whole series. Can you elaborate?

I went into this in my response to Jann.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3rw33qkti4zr7rb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlux7QAACgkQnhiqJn3b
jbSivg/9FPpKpSI/3NIGc0Xsz57u4GP6sltPO39Uc26c9Mj829m60Mj1g5Ht+lnx
nUpjcHp/TGM6gbjDVXrH6k3NZur63m31FLOBMB7AIz3HlPK3Nk269md4ej4OFI94
ouW4mMtEmFaLjVQbrf/ozT5pepVqLprWCzsGj5mOCb7uZ/yqOSG6qBKNAYYJUzQ2
yBsHKTIYGkaQ0tPOzPzO+d3EyRSIh2GZTkcXPkzreEdtlpm44A545siHNQoFihOT
EcDExHHRcYNPusLJvErSTm82TamFHZetq6UdUmUGbt3PJaswZmVWVkwyOplu24ly
79MjLzFg6+afW/jvKKmKYjBlsL00Uf5HbsAaUZuiIJox3eLilCEGQUO87CK9o9q3
dSsfFpRm1uWQPn7P+6TXvEpiHKQVW8zIghLoL1uFr60R/RRXHRrKnWZSnhZNpe7P
q9BoosKfzOW6zXCOnuQksvqxC8+I1BueJasO88UJmYJb7nK+RrEYegZJ5+u0jY1L
qTyjltatxnBgfimoeIxOe6DcHOwSAyNZ14YImXuDGDFVaXTs/hoxraLDUV9Yzup9
/ym3ys+YZQWLGi5Zyfk8DS/RuZX4AfCLFVtm1fFBHHBIE2kpa9xNmFhDhQgd2VbV
mfqYV7yKyqKWCpFwLFEIsXCl7BY2cntpPe3VajLGKG/EXdPYlSE=
=Pymu
-----END PGP SIGNATURE-----

--3rw33qkti4zr7rb4--
