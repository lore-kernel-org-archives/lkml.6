Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F226C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FF621839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4nUhHI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeLPTxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:53:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46553 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeLPTxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:53:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so5062033ply.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 11:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZDfnIYctEqxRMwzhSszUskWr+1+tQzBqfWGHwebVw14=;
        b=R4nUhHI9OefX8/llxxgxwew0Ruf59l7W5EUihmevGeUQb4P1dI7l3wqX3BjXOx39NY
         dGrkNkBELEJFljONmd1YXEnM7GRZAfEa3sIRa4e7rY5MElXTqgXcrpOn+S56v85I5x3X
         Y0bENZGmEnsuvybODc3MeglA4j9CmGMNtn02aUbo2Qn9imbTkCwTTfZJyp0XjmzbjXgy
         sW7Bad+QX5WRiISyoi42Bq7hc1NzUXU9v9KguFhJ65xzPTLRy84pWtWSRrJv0nQCvL46
         cLbo86esLoMeq5P4u2+jHjZj8y8uxcH2TCxYuKps/2dDdhNV+YrrRulKRt8a8CxICYQv
         5CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZDfnIYctEqxRMwzhSszUskWr+1+tQzBqfWGHwebVw14=;
        b=oDBTo1Of4PC6ZK0ITVZESKagpJ67XgWpzcP3hUnxJlEjaK9VtZ/jZaLLsRVf3P1mjY
         7BH65yicDCexPJkds+cxd5wQ+wn8f12OU3XnwM9iwA7jwIaRvNzE4rQ7Yaf35n2Oakfz
         jVypT3+Nyw2Zk34cQ+9I5uJLyaRKAcqPhJh9jeEsaA1VszURal0PyttLnOOHRdx4hJWL
         i7lM7PeSLOxLCWWVsWoOUaxILLq51XJzHBiXf+x64sYSM7jOyDL/P+eOmRLRB+dYdP0I
         8a+2IWbhj5eunA2inLJjiH7NbAKM1761CHnTnyGga3nNKmkEQWq8Jl3SEnABgfgCv/Vi
         wqPQ==
X-Gm-Message-State: AA+aEWantWP9cDiHGsLBIcPC1GrO9odIkVRwDL5JLm4aLQN4bSJ9W9nA
        5Rq92DMru+XQ5QHAPnUKBLfEseD6
X-Google-Smtp-Source: AFSGD/V82FCPelHZ7Xg7jWPbMomPcFr/1RwzuIhNp1nBjJf8fFh02dcV0+jHyaEcDDlofNGHdoT1Eg==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr10491955pls.230.1544990027273;
        Sun, 16 Dec 2018 11:53:47 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id x12sm11856295pgr.55.2018.12.16.11.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 11:53:46 -0800 (PST)
Date:   Sun, 16 Dec 2018 09:53:43 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] LKML Archive in Maildir Format
Message-ID: <20181216195343.idnt2y5y5wjky5gu@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
 <20181216194649.GA7732@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzphf3hwzqdjxeaq"
Content-Disposition: inline
In-Reply-To: <20181216194649.GA7732@pure.paranoia.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qzphf3hwzqdjxeaq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 16, 2018 at 02:46:49PM -0500, Konstantin Ryabitsev wrote:
> On Sun, Dec 16, 2018 at 09:06:39AM -1000, Joey Pabalinas wrote:
> > I spent a lot of time trying to find an LKML archive in Maildir format
> > that I could use for local searches with nutmuch or something, but all
> > the links I was able to find were all dead.
> >=20
> > I ended up just compiling one myself and I currently host it at:
> >=20
> > https://alyptik.org/lkml.tar.xz
>=20
> You seem to have duplicated a lot of effort that has already been done
> to compile the archive on lore.kernel.org.

Absolutely correct, haha.

>=20
> > It's possible I'm the only weirdo who finds this kind of thing useful, =
but
> > I figured I should share it just in case I'm not.
>=20
> The maildir format is kind of terrible for LKML, because having millions
> of messages in a single directory is very hard on the underlying FS. If
> you break it up into multiple folders, then it becomes difficult to
> search. This is the main reason why we have chosen to go with the
> public-inbox format, which solves both of these problems and allows for
> a very efficient archive updating and replication using git.
>=20
> > It's about 1.1 million files, I was wondering if anyone had an idea of a
> > better way to host this? I've tried Github and GitLab, but they don't
> > appreciate repos with that many files, hah.
>=20
> Like I said, you seem to be going down the road we've already tried and
> rejected. :)

Yes, I had a strong suspicion I might be the only crazy person who prefers =
this
kind of format :)

My only comment on the public-mailbox choice is that the documentation
is very sparse and erratic. Myself and a couple other people just
couldn't figure out how to convert that format to Maildir or some other
format you could feed into a reader like neomutt.

Do you have any advice on how to convert those public-inbox files
correctly?

--=20
Cheers,
Joey Pabalinas

--qzphf3hwzqdjxeaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwWrUYACgkQ2rGdfm9D
tVK2AA//UtRqe1x6D0rrKt0VvWWDxnIuk79bqae/yyW4c4DW34bbOvsK+PboKj1M
KrX8qLqqrpmPNd2bfGTTeL+5fBbc26VPatid3FLMW9YLX3ADSQ8cHSvOMUPP7lgy
uDcyIqdn8grKlnZcLNSQB5QdbN0cD96AGcjGdOtUbzEVbaSIVePcgg1fTU2rF3/q
qm7Kv+i0qAaX2s+0xSaTPI8XGSKMVWlpi8nrsyJ7TViLDreKs+xnpiloAU+eugkC
nPO/D2WSCimH3SyRoUwSESNWzX7vNJSpVBvPY3evpsa4P2jTF8vbJ32nFdW0FeEW
Ko1Tl+Y2MLYdW+Gu3035DYfvXU1JLTyrSrb0jyQAE2ckEEfkwngk1/WmVL8EWOaM
mvJlQQZf2SqOJWMk3tJWLmG9IDkFHkFTfKU8famMN18orowlkYromcHMXu+TBWsG
ljQhPmsFuIQoMy8zV6klxZtl0hhwFeHgqyE4hRauzORluGurCFyFo96fqXoON+cH
5G3j8tuqR4fGcRPen0zOJg4kB3wnufQE5HOBpO64foOLLP8Uk1g+hXjDqN95aUT+
ZFSnN7CHlk0MgH0YKl3f8DvJTkBoySYQJO9fWYJhcFxqQbzDqqR5G7yGRzoodzkK
Er6yZad0rEAIZ3A9rrWL/M/3Ccyz8HLrjGtwr5cJ0iNjeJ1U8EU=
=SRwz
-----END PGP SIGNATURE-----

--qzphf3hwzqdjxeaq--
