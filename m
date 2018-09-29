Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C8DC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD6920879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="s1bH6hkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD6920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeI2WO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:14:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39550 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbeI2WO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:14:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so6290899pff.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z15+FW4F9UKJIHjZBstqTm7xfEGYHoJPwVvvHCy4b5c=;
        b=s1bH6hkC0C1gD6giwClpueR2auQgZW5j4wzaBG0v5hz5esl0wyvaAp6o5dXeqs/JnL
         WAUei+Unb1eB4p5YrmS1+u9LBanstLMuUz31Iq117ZgsUqjr8DJO+uPl/X7LLvkEdDvB
         P0VSbGWlzn2D3NAcsKdaMrtJGQKdeL64JOnGmTNrbWIE0uSumdcOMqzrmFAn3ejY7Zlw
         GFN0SbUi+x3LJRPnSl5FMotRs04YZB3hQaenVuMGxXPA23INU3ocR4/NEgZbJ7jy9ZXh
         yHP+EreFCjIjyfeEhOt3JxYOs1ebzg6QXAw++49pwgIoDmrKiipVGLpBC4t8b20USanb
         /ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z15+FW4F9UKJIHjZBstqTm7xfEGYHoJPwVvvHCy4b5c=;
        b=WCe2cHTv3+zDKRBIbO3klqtkjYJqWmXjTZgo9OcBx5cLxSnZw/Qq0krkl8mZleJwI7
         PCqDqEdTcxkmNtjNBkHyYUgOs+UD+tWBFFlDHGyS/6RuGDgbxxUo5FNQMDjfWH7fy00Q
         3tJh1vVsXuwh+ISPnRaUDvo0yl0K26wP6zJgVJsAkYuIeszeN5GGnQTuY8x4FSMS7BNw
         YLEBwSln+HLE/SgA/JYeUB6ivTCDJi+SLrXrRNA9Qwm2JyRcYs73iUJERUC4MJ/REFdj
         etK3wzu76pMfa1iV2mZWhSCmh32KFWJLumdVwqDYE37BPKo3WxhrBnHNnzCubapfCen4
         5J/g==
X-Gm-Message-State: ABuFfojj7BRjttgATbhkD4DxxCKwLQXJUfdm/U3k+O00ua3Djr81k6cq
        Tgzlc+LMfiQgPrrILYvpmE6DsQ==
X-Google-Smtp-Source: ACcGV61m+JCHgdmtiHTNkbVgAZbwyCUqgtdtTAL4t2Irz4gzOsGFW1Me66G8osP0AND8aWfKPFNFLg==
X-Received: by 2002:a63:5ec5:: with SMTP id s188-v6mr3346868pgb.126.1538235962829;
        Sat, 29 Sep 2018 08:46:02 -0700 (PDT)
Received: from ryuk (pa49-199-213-175.pa.vic.optusnet.com.au. [49.199.213.175])
        by smtp.gmail.com with ESMTPSA id y1-v6sm12723328pfy.89.2018.09.29.08.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 08:46:02 -0700 (PDT)
Date:   Sun, 30 Sep 2018 01:45:51 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Message-ID: <20180929154551.jsi6dt3xjxdxoqeh@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qwzrg5udmfedjzky"
Content-Disposition: inline
In-Reply-To: <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qwzrg5udmfedjzky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-09-29, Andy Lutomirski <luto@amacapital.net> wrote:
> > The most obvious change is that AT_NO_JUMPS has been split as dicussed
> > in the original thread, along with a further split of AT_NO_PROCLINKS
> > which means that each individual property of AT_NO_JUMPS is now a
> > separate flag:
> >=20
> >  * Path-based escapes from the starting-point using "/" or ".." are
> >    blocked by AT_BENEATH.
>=20
> Seems useful.
>=20
> >  * Mountpoint crossings are blocked by AT_XDEV.
>=20
> Seems useful.
>=20
> >  * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
> >    correctly it actually blocks any user of nd_jump_link() because it
> >    allows out-of-VFS path resolution manipulation).
> >=20
>=20
> So how do I disable following symlinks? ISTM the most natural way
> would be to have AT_NO_SYMLINKS, and to have that flag disable proc
> links.

So, this patchset has both AT_NO_SYMLINKS and AT_NO_PROCLINKS.

* AT_NO_SYMLINKS blocks *all* symlinks (which is something Linus requested
  in the original thread[2] -- apparently this is something that would
  be useful to git even if wouldn't violate AT_BENEATH). This implies
  AT_NO_PROCLINKS.

* AT_NO_PROCLINKS only blocks procfs-style "symlinks" (filesystem
  "symlinks" that call nd_jump_link() themselves -- currently only
  procfs and nsfs).

The reason why we need AT_NO_PROCLINKS is that "proclinks"[*] allow for
breaking-out of nd->root without a trivial way of detecting it (since
the filesystem can manipulate nd->path almost arbitrarily outside of the
control of VFS). Al Viro's original patchset[1] also blocked these but
it was all included within AT_NO_JUMPS.

Requiring you to block *all* symlinks in order to block "proclinks"
seems to be a bit overkill to me (especially if consider that
AT_THIS_ROOT|AT_NO_PROCLINKS is definitely a usecase most container
runtimes would be _very_ interested in -- while AT_NO_SYMLINKS will
cause issues with most distribution images).

[*]: Sorry for the awful naming, I'm not sure what the correct name is
	 (I've called them "super symlinks" in the past) -- if you have a
	 better name please let me know!

[1]: https://lwn.net/Articles/721443/
[2]: https://marc.info/?l=3Dlinux-kernel&m=3D149394765324531&w=3D2

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qwzrg5udmfedjzky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluvnisACgkQnhiqJn3b
jbRV4Q//Yv0XqDT57HQ7f6MoWyB/2CXJ7ato/sBw45GjHWhxXQeE+7YX1j3Dos0b
YCGutLWMFaLFV4lezrHWqKMwEn1ZvntEdaqufQyTIr8i/2sCdRXQbQvX3t1Rb48e
6FPyzXMzPJNxq7MOo6ELsuhJbX3u2S46gCkBsDRpkSqxoGsd8M7pY4+zmtVmtBoH
kvHFHsyiHbOlRaDUhwx4KPEmYM14bUWgTYSa4jH+yQrI6gLGbuGMlcWd5izj2gUh
L0OFFnUSXh5wPa1XBbyuMseutfA9vLUSf7ixeEcaA91v4kRj2s2eLonwFDyy85PB
+MlxYbWGmpNH2dICexMklhgjnHXEqWfFZzWQIPFoeaDi1o9JS+14wvL5oEUaHt2S
dGtAjASgwo/T6lwuvkZcvIm52JGNT7br37tHuxqZsIUa5jTk3QqKK3FjNKneOVvA
qKpq7baRP+83b7szJI8P5giKqZd6dCJl3VT7vr5dIu2J3icAVP6t+rOZXvFazlT9
9osRnYfb1h36OgpJt0kbiPIDHKeyYTbDJHklVE039KNhBvk4tMD/vsTi/h+Daey1
tCsvRAd7OiphkO/agltEcQh6LG/0mGAL0Ded2jh4halv1frFXmBdp/jcezbPGEMz
/rb8svqBRkp+xbfqLvpbNOLYS+j4plv3SAvsSnNOcckWfnbxAnM=
=MTjA
-----END PGP SIGNATURE-----

--qwzrg5udmfedjzky--
