Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77552C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4362089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="A4LVEaZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4362089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJAWyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:54:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42017 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJAWyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:54:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so9196980pgq.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+0/cIyeIYSxF5DWY1Mpjn0TGWOrtNVlJe41E+AtmYPg=;
        b=A4LVEaZJGIL/gz7KDm9BJSkbsSVxhKH2qGbadSWnWSSHRmcSKVHubxRaM0D0NdK3OY
         VHfcxjHPZIMLLBZmMTaE3FvXKKA5fbmNzOnHecAe3d2Cquc4dc49TVXU2PF26C8ywlE5
         Ex5hVOgQN7YDlDR4aZtqtaTd4b21tWN73fC2KTng0a+Ca/xbot+S15Q2Hk2GgIRE3tGj
         C5LYuenwg+NixT/UJOcWe4vmx0qb+zi5wGfP7pqhPVpohhAJb19J9OLVDnw4iZtkkMa7
         KfsnVHm6vItSUzoic/5kmLC9Wg7prDCqkRco4CRQRdqSgbFw4Uy101zns4izH9Ro68u7
         owZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+0/cIyeIYSxF5DWY1Mpjn0TGWOrtNVlJe41E+AtmYPg=;
        b=hkqPZquvhjj0R8GKE9sJs08Znx9HVOys+cFv/RYlyZ2btfjSnX0WOyVsDoQyR06rr4
         I/leCvIdxGKNGGPr+YvaAPIK+G6zglvgUSA4nx1Nf/zG3gYgoy59F4uSdIYNVPaGWXZX
         76Iapi/827Z1Ccus3muIyYBOAHvJNaKZMgK5qPh+f7yId7v66ui7XrG3diSDRKKNk4Ew
         Nkfy+mmKoJRA/5w3TUpsWruWXQlBvy3tz5K8PZUUvetxvOi7A5J1nD70lFU3+/FI7GCx
         YBtlJxM+yfdx8VLxoaP/4YBjT1NwXMyKFWweQi2oVpcXaejGHW60rOPepfItEyJOf/NS
         xrEg==
X-Gm-Message-State: ABuFfojGfvQUPUiixBDhIeXPh+NkwWKWqmwUyYkJ6ohICraXKZ3wfqiu
        mVUocmndctOdB7HEKe1LdzTUDQ==
X-Google-Smtp-Source: ACcGV61jBnC5V7Uo9UPXii5drwVDic5T3GjNLgBmJfBEG0O0vtWVxzr/lBxoCnSKVzs7oHR83anzwg==
X-Received: by 2002:a62:d110:: with SMTP id z16-v6mr10351000pfg.229.1538410545920;
        Mon, 01 Oct 2018 09:15:45 -0700 (PDT)
Received: from ryuk ([220.240.25.129])
        by smtp.gmail.com with ESMTPSA id v63-v6sm13501746pgd.69.2018.10.01.09.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 09:15:45 -0700 (PDT)
Date:   Tue, 2 Oct 2018 02:15:35 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "dev@opencontainers.org" <dev@opencontainers.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Message-ID: <20181001161535.3zslyuk6vmnpioy6@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <1f1d699b1c8d472495a5b07199c31a6e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tkgbkhns2ox2cxtl"
Content-Disposition: inline
In-Reply-To: <1f1d699b1c8d472495a5b07199c31a6e@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tkgbkhns2ox2cxtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-01, David Laight <David.Laight@ACULAB.COM> wrote:
> > The need for some sort of control over VFS's path resolution (to avoid
> > malicious paths resulting in inadvertent breakouts) has been a very
> > long-standing desire of many userspace applications. This patchset is a
> > revival of Al Viro's old AT_NO_JUMPS[1] patchset with a few additions.
> >=20
> > The most obvious change is that AT_NO_JUMPS has been split as dicussed
> > in the original thread, along with a further split of AT_NO_PROCLINKS
> > which means that each individual property of AT_NO_JUMPS is now a
> > separate flag:
> >=20
> >   * Path-based escapes from the starting-point using "/" or ".." are
> >     blocked by AT_BENEATH.
>=20
> You may need to allow absolute paths that refer to items inside
> the controlled area.
> (Even if done by a textual replacement based on the expected name
> of the base directory.)

This is sort of what AT_THIS_ROOT does. I didn't want to include it for
AT_BENEATH because it would be just as contentious as AT_THIS_ROOT
currently is. :P

> >   * Mountpoint crossings are blocked by AT_XDEV.
>=20
> You might want a mountpoint flag that allows crossing into the mounted
> filesystem (you may need to get out in order to do pwd()).

Like a mount flag? I'm not sure how I feel about that. The intention is
to allow for a process to have control over how path lookups are
handled, and tying it to a mount flag means that it's no longer entirely
up to the process.

> >   * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
> > 	correctly it actually blocks any user of nd_jump_link() because it
> > 	allows out-of-VFS path resolution manipulation).
>=20
> Or 'fix' the /proc/$pid/fd/$fd code to open the actual vnode rather than
> being a symlink (although this might still let you get a directory vnode).
> FWIW this is what NetBSD does - you can link the open file back into
> the filesystem!

Isn't this how it works currently? The /proc/$pid/fd/$fd "symlinks" are
actually references to the underlying file (they can even escape a
pivot_root()) -- you can re-open them or do any number of other dodgy
things through /proc with them (we definitely abuse this in container
runtimes -- and I'm sure plenty of other people do as well).

> > AT_NO_JUMPS is now effectively (AT_BENEATH|AT_XDEV|AT_NO_PROCLINKS). At
> > Linus' suggestion in the original thread, I've also implemented
> > AT_NO_SYMLINKS which just denies _all_ symlink resolution (including
> > "proclink" resolution).
>=20
> What about allowing 'trivial' symlinks?

The use-case of AT_NO_SYMLINKS that Linus pitched[1] is that git wants
to have a unique name for every object and so allowing trivial symlinks
is a no-go. I assume "trivial" here means "no-'..' components"?

> > Currently I've only enabled these for openat(2) and the stat(2) family.
> > I would hope we could enable it for basically every *at(2) syscall --
> > but many of them appear to not have a @flags argument and thus we'll
> > need to add several new syscalls to do this. I'm more than happy to send
> > those patches, but I'd prefer to know that this preliminary work is
> > acceptable before doing a bunch of copy-paste to add new sets of *at(2)
> > syscalls.
>=20
> If you make the flags a property of the directory vnode (perhaps as
> well as any syscall flags), and make it inherited by vnode lookup then
> it can be used to stop library functions (or entire binaries) using
> blocked paths.
> You'd then only need to add an fcntl() call to set the flags (but never
> clear them) to get the restriction applied to every lookup.

This seems like it might be useful, but it could always be done as a
follow-up patch by just setting LOOKUP_BLAH if the dirfd has the flag
set. I'm also a little bit concerned that (because fd flags are set on
the 'struct file') if you start sharing fds then you can no longer use
the lookup scoping for security (a racing process could remove the
flags while the management process resolves through it).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--tkgbkhns2ox2cxtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluySCQACgkQnhiqJn3b
jbSEtw/6AwhPlE+oc9qbkVD8npOGl9uQlu0U1PxHMaS4GCGKNw/uWaVh/moBhNLX
7+yO64FzrhGvJUoXFlKQRrNhz3Zjy2K9RrNK4klXcWE0ySLTYLEIIPAANio8Z4JM
hExnTJ3qZbWd9iQAFNXCRNbhA1hJxmK5DhVxoEdE5ynniq5HznZO9ryuFpC2MjBM
nxtrwHVS6ClIz9RAwGQdoVoU+CLMR4x91j6SuOKE+i3ENEsPxlDTJtBMJy8SO926
M6Sb2+eLJLPcvwC6ZutppLK3D6iFAFf6pNSIwG3at8ZJ/Cx5oiiVXJ7SSrwx42n1
Ua+QKlnJKsdiTGnnuIHqC2+6HzWKqwHUq/8HV4Jh0Wujdm+NRfXyn/ielj+AXFX5
l3jrD4pirPUkR/moRM5aC45Eh9963eOsXCrMh9nU4s4oonwVG9EL6aUHcOeE+zeU
ZXn0dBQBSENIn3hXMyegAdrADoyji1bbiJ9uD+s37QlgaMUf+OM2bOkBgMM/brPb
4jCmvyVOHJ1UPHTee5vG7Q1tAtvJFO1oBzTVHgXXFcHK3iczZlHdP4NvZujEest8
y6/nrY+Dw6ybdmJTh2vjGsPi4fVjEGwv9Wsz9fv5TO1zZaxtPIFuP60wN7X2krzB
5hhkf4pa58BsSq0ms3gSVsIDYEWinY8BW712icAg3qxtYVo1vuE=
=yx/P
-----END PGP SIGNATURE-----

--tkgbkhns2ox2cxtl--
