Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD27C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8047204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="0gqaI+7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8047204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeJAWnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:43:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46991 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJAWnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:43:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id a5-v6so1226915pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YZTPZOesbYMxuSc+kS6QFWusaC5AEJK1lCFZDsFfBOg=;
        b=0gqaI+7nhwSpxzVEjfpw1RpqBnH0cilUWWTV5JvcFvO6LRfDznlOkckuqyH6FK/02O
         oFPT1Hm5O8sAYNtBJJxTVj5DJBAAsMEjVyrTrAWYOil44h6hoHzq+TBFqdjgQCb1b3y6
         pTycsRMQMWHNUeuiNQ6K6EecQSECydCjhcvJdSOjabJL2idpNPiOzrqILY6OmWUopbg4
         SfEUIDK66S7ArG0jvqw4w0Ow5r3qTeVBi7XGyzLAuC8Uo/+ZutZ0hX36sWmVKE8E/XtP
         PVF77i4eQeAEH5YYFEdVi4cI4mWrBY+Mfiy+/vNwZAtqpe1+60uNj7TQ90r+tm8M983d
         Y1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZTPZOesbYMxuSc+kS6QFWusaC5AEJK1lCFZDsFfBOg=;
        b=Pff/STIcc6eHYkl5+qHMFxqX02n7ntkze3WVmVzzo+NBxXyxh7os5stdxTYDuIpD5R
         b+yciJzdGPGNc1G4zKh0KiDX5U6/DBknC7Cs8HE44/8QteS2k7HkTDSlI+++KZ/6yc+d
         6nbVYwSwFUT8G9W2vYQLfjOT5YPVXijJLuEpyOD9jhhnGDDZL1uQujKtVtUby430IeVe
         KJCsAUJ6pX57XoKOb2pgZtrGmP8MFhHhOdiqS40QHb8rYQVzx+OjfDeGTYmtFx0/6pXY
         SaHs5KQXFi+X98VnFaw4f9XMW/1Y9Dplt9oLCLkT5aUxKEK440GfG7wMiQaz31m/KBKv
         nISQ==
X-Gm-Message-State: ABuFfoh4sIKsTd8559JcFH8Uu2Ck6I2zozYgzAjg1LAlXRRfsh6VlB+c
        f89rzYbhfOfb+o/BpgeV3HNLNg==
X-Google-Smtp-Source: ACcGV62qIcGXIhdJvFYWhXFMkKr4Oh/9FigDhUtK2zjByRA4hChAynoWgM/du2x+zS2TC04BNwELcg==
X-Received: by 2002:a63:2f81:: with SMTP id v123-v6mr10550874pgv.223.1538409887728;
        Mon, 01 Oct 2018 09:04:47 -0700 (PDT)
Received: from ryuk ([220.240.25.129])
        by smtp.gmail.com with ESMTPSA id z25-v6sm22134870pfl.58.2018.10.01.09.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 09:04:46 -0700 (PDT)
Date:   Tue, 2 Oct 2018 02:04:31 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181001160431.emb6b2hf32b754cl@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929103453.12025-2-cyphar@cyphar.com>
 <CAG48ez17EQuJQAZUg5hDFXhkjnnVFh39=aD+j0FBdsoTONSGEA@mail.gmail.com>
 <20181001130038.s5ztphs3pl2zt3ut@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l5774zw5ogijx4tv"
Content-Disposition: inline
In-Reply-To: <20181001130038.s5ztphs3pl2zt3ut@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l5774zw5ogijx4tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-01, Christian Brauner <christian@brauner.io> wrote:
> On Mon, Oct 01, 2018 at 02:28:03PM +0200, Jann Horn wrote:
> > On Sat, Sep 29, 2018 at 4:28 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > * AT_BENEATH: Disallow ".." or absolute paths (either in the path or
> > >   found during symlink resolution) to escape the starting point of na=
me
> > >   resolution, though ".." is permitted in cases like "foo/../bar".
> > >   Relative symlinks are still allowed (as long as they don't escape t=
he
> > >   starting point).
> >=20
> > As I said on the other thread, I would strongly prefer an API that
> > behaves along the lines of David Drysdale's old patch
> > https://lore.kernel.org/lkml/1439458366-8223-2-git-send-email-drysdale@=
google.com/
> > : Forbid any use of "..". This would also be more straightforward to
> > implement safely. If that doesn't work for you, I would like it if you
> > could at least make that an option. I would like it if this API could
> > mitigate straightforward directory traversal bugs such as
> > https://bugs.chromium.org/p/project-zero/issues/detail?id=3D1583, where
> > a confused deputy attempts to access a path like
> > "/mnt/media_rw/../../data" while intending to access a directory under
> > "/mnt/media_rw".
>=20
> Oh, the semantics for this changed in this patchset, hah. I was still on
> vacation so didn't get to look at it before it was sent out. From prior
> discussion I remember that the original intention actual was what you
> argue for. And the patchset should be as tight as possible. Having
> special cases where ".." is allowed just sounds like an invitation for
> userspace to get it wrong.
> Aleksa, did you have a specific use-case in mind that made you change
> this or was it already present in an earlier iteration of the patchset
> by someone else?

Al's original patchset allowed "..". A quick survey of my machine shows
that there are 100k symlinks that contain ".." (~37% of all symlinks on
my machine). This indicates to me that you would be restricting a large
amount of reasonable resolutions because of this restriction.

I posted a proposed way to protect against ".." shenanigans. If it's
turns out this is not possible, I'm okay with disallowing ".." (assuming
Al is also okay with that).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--l5774zw5ogijx4tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluyRY8ACgkQnhiqJn3b
jbQVKxAAmkBystPEfvPnjFxU6M2/bymYFbq5HrT6vKRRHrHGTJVo0WLeYXKCMjFq
7QYyfBoOdoMqYoPSCHM59qknyQFhiRHD66JJdF5tdf8k5wfg/aXAFfWh9pJFN85U
8uX3FI+d60svpeMmtxoTQrtpyvsWknxWBNEWl+HM7rtc5LNkOhXB6AgBpxRnLp6O
3lCzADIXPbOD5NuNhTlgDqvmbmJVOKgFv8ngdm055u2yGSR+B1GDaaqpNt4AS0rC
ev7LktJ4T1yPHpty4GOpJNLka4BgetpOTUa6Iqs+zv4Uuf/zawNxP7O8NKtcgaXC
jkMKUFcFwiNcYKt8BcZgQAtHyK8hbJcakmef3ZDq+05bwZ1/k1LisDRwgA0evHRS
iqSnKFlB6uhRc/H6cYwc185b9lKDhUntId2vzRKYnXaF3fi+92YW2nZ/51PFSq6M
PPauYn4BB9poMHQM8tnDelHraJ2btsd7+WduMlUtzcSimuUv/84CY7sNJiOuyYm9
qhxsNi2MSxMit0/LKzit/o73jfp68h8UAfl3Z592i1jPRXLo85jt3NByZWRM/qOm
4U20HegNdtbrkJpYjzDNT+8fZhtq73LfBgpaU7xqSFEX+PMqj8RM4H/af429rhqU
BZ5M9yovvFgwKsr6rLkoDAgbFnUl4CWjufzhGFStPJmy1iBfGpk=
=imiF
-----END PGP SIGNATURE-----

--l5774zw5ogijx4tv--
