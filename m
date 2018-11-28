Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDC2206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiVZOBpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDC2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeK2KFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:05:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40891 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeK2KFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:05:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so5542448plq.7;
        Wed, 28 Nov 2018 15:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IKr+Z+Iok8xN3t2J9lHKWjGnfqWcVIPIth1dcXgECLc=;
        b=IiVZOBpFCYBbaKl87TZ8wS8gXFwJ7/ERgDYkiR8W4qRAtLXOZviFb3KpjV4bPUAVng
         O2Qr8yisPZdLe4VyGFdEcSfuN5IL76T61RxFZ1KDTqs6kXoXvmUSw24jZWySno3QjT1P
         DSwQtvNLlI71kKA4Erwf2NH6BVTbGxicIdVgrW/fwC1dOqIeumq5vxXVJywuD5W7fD8/
         nQ+WqRMgKIZZDcI6adVaKkge8YGdixPI+Z2R/NslRuqrL75dlb5i2DT6a7fS8x4N3iTx
         dFOQNsHmay6zNWOADzukt/M4WLkAZzftNunM88aJ7S/jpJEnJNgRxeyVw+EkCLGQCCDu
         rK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IKr+Z+Iok8xN3t2J9lHKWjGnfqWcVIPIth1dcXgECLc=;
        b=pox3qLQ1zCvdgccRm/VS7NlxIow4EzxZHRVDklsL0xUAJoz/Q6oRLN4u0JM7I6YkJf
         iM2xwrBqj7s/5NIf6sB7mGzuviXjah+1sAIGwD+tsRIZ/WCjBwPgHJgLdRr2YMFY8mtE
         TRYUa2g/8iVJDs+x6hZIwWQCslYdax2muI6ypvExxCE7D9EK6lyjxLlrlNHCAn3yF6eB
         1ySV2fw+v93nmU5EaLTCWqyUnZlMTCZkBcUWSs9cry5x+1Qiaqhuu5XnfQLc5t9yTTRn
         QE4l+m06ypxzGxAw/3ho2rBKtuSWIEs+Mke17qZxd4lxskE7PC5BEeUK5kEAkXrnvZym
         Q9Vw==
X-Gm-Message-State: AA+aEWZp+cFhQ2/P6b6EGZyziieVw0nJlMLCmm+/yI4nB1Gu7j4Xr6oU
        5Ve9YSXlgqfgZDzMicLPZvk=
X-Google-Smtp-Source: AFSGD/VmHDbIcGKrFVReOIiirAk/nKFLslVOu6nF9OAak1IipXJTDYKOuuioA8uOkRaA7Xdgwd0++w==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr37603746plr.245.1543446125382;
        Wed, 28 Nov 2018 15:02:05 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id i4sm11491484pfj.82.2018.11.28.15.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 15:02:04 -0800 (PST)
Date:   Wed, 28 Nov 2018 13:02:01 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181128230201.afprnrqyvrtzghh7@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Christian Brauner <christian@brauner.io>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181128214534.xxqoyy7mi5dw54kj@gmail.com>
 <20181128220545.fplqmbkfhxowx3lf@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="msgp3xujwmcofyiu"
Content-Disposition: inline
In-Reply-To: <20181128220545.fplqmbkfhxowx3lf@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--msgp3xujwmcofyiu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 11:05:49PM +0100, Christian Brauner wrote:
> On Wed, Nov 28, 2018 at 11:45:34AM -1000, Joey Pabalinas wrote:
> > On Mon, Nov 19, 2018 at 11:32:39AM +0100, Christian Brauner wrote:
> > > +	if (info) {
> > > +		ret =3D __copy_siginfo_from_user(sig, &kinfo, info);
> > > +		if (unlikely(ret))
> > > +			goto err;
> >=20
>=20
> I think you're misreading here. It jumps to:
>=20
> err:
>         fdput(f);
> 	return ret;
>=20
> and does propagate the error. This is also an old iteration of the patch.

Whoops, that I am. Sorry about that.

--=20
Cheers,
Joey Pabalinas

--msgp3xujwmcofyiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv/HmgACgkQ2rGdfm9D
tVLwnRAAoYNn3yu6ffNJq6EY2npo/FGJKvcOE5Oxu+fBJ6VOp5lOqfhr4ZIBohwa
KvQOJK4qv67GLUkzk7y+Tc5eYgIYgKWXp+pqGppmVPGatKOE0sJupMPC8SKyK69v
XEwJpfy640YsJlOyswiX3007jdOBIk1D21JECgbiCuoN2P5UxahZgUTdSBdbjHlx
fPx+JKcC221x2ar6KseYwUbfBB60Rie0+CkIL4GefFXqUlPYcLxxlpPabn2QsNje
lY6RtUGC7VB47vnPUVVzF9vooE9L8zpJazdQgL7HhbppXmHkFu5FYaN1aY94jgtk
2MfC2px/+ESuuiT0YdLOH0ReZT69r83kASHW5P1nDepS6I36BSSJfHXshXkaiXVc
HYrHAH6rCODCFkrEFCPjbBdtFIacJ6e0RpDaPddNec84jleRtZMMD4q/E8VgN3kT
gHv4PG09wXqkq8HLplLHo4XkKetgHz1SI09LnsU1IN3IilieXiu030e/kBP1c1UP
0gotXqxTWmyMQJPm24yXJsEwIFwLcu4paHu5oroSXrHU+pFmAoILjEqddbJMy6Mp
IZTCz3fIW6iBNqEcTOHovZPfNJD3PfZu1GEjGEDfYDfI+MPofUgp73uZq51E2EoL
dFHsxwcGFhhAIPwi8sLkjfSJjRSYynRU4VCOnU5X2MphsWDAptU=
=tCf2
-----END PGP SIGNATURE-----

--msgp3xujwmcofyiu--
