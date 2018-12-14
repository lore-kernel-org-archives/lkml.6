Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC8AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABA52054F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="NJhomcch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABA52054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeLNHgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:36:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37085 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:36:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so3529600lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 23:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cdkHDS72Lx3kRWCN3iTYtLjij7R8E+qIfYJhOT1YICI=;
        b=NJhomcchcwXqP0PbH+rh+VMhTRrTuIf4dEmzujcCP90TvDAiUTmZB2eWZZBPVyccnS
         3rkr5g+ri4ixTELrLGnBAgw0Vc4cPiUQ/uK5QDjK/vZ4hZyCLVll+MUMd+VKq+TkECSk
         KJOe1U+maNK46z9vMddACohRFAUBrG3QN5DeI8jeRjc7IV291WUT+sRdQa9LJrff44cq
         nBX2byNagNfo9bchTfvrYf/V48fWSXRKuUZ18lqens0/F8ra3JN05XH7HPViQcKoQVEV
         Hfsrfk2mcwM2vPBV1+oAsRYT/GUbc10LrLZ9XCPgMZvRb5hGCNGZF65Vk8rhq2uZh0Le
         83mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cdkHDS72Lx3kRWCN3iTYtLjij7R8E+qIfYJhOT1YICI=;
        b=SUtmEcJpL9OMKRhImB7lp+dco9Fpbwahr4bfRltz3K+xdlDiDWXdXd4/PIpTzGnv51
         pv+M1PPR9hEkB/2Kse7AD7h5l5FPGgWwSS1BoST9++CtVGeQu3guwpQOJDNUe7SX6eQa
         PZFLTPpFZf8yrv2uqMfOtBvfCMvcvJGRpRUBYArcn2bYovjd4Dc/5wIQaaGhcnxKFwAv
         6BQ6w+M3c81si9THVGmlN9MUTG+nHlMTbXYZtsWmi7wUYuL/+/lkGd3eyfTG74251iFI
         0CZu6TI1wDaVJb29ZQjMkI+fg686ZnhRDilcNDsz8im6JzZpAGwDNwKwI4fpaEw14Qfz
         Hb3g==
X-Gm-Message-State: AA+aEWZPi/5uGT6ekCp0zwrE3qbiYuZ4a1vZAblpkb6h11YaE+7K/6Vn
        sj3CUBHzOsTOa3FhOhd8HF4b9w==
X-Google-Smtp-Source: AFSGD/UCpoQbByZvFGRra4VWK+UOMHokfbJQihLhm4YQEhCsu6gHYsi5vVyQaKCgeiks9Ocm3I1Ilg==
X-Received: by 2002:a19:200b:: with SMTP id g11mr1062893lfg.58.1544773009432;
        Thu, 13 Dec 2018 23:36:49 -0800 (PST)
Received: from icarus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id h85-v6sm715048ljf.68.2018.12.13.23.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 23:36:48 -0800 (PST)
Date:   Fri, 14 Dec 2018 08:36:46 +0100
From:   Henrik Austad <henrik@austad.us>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/17] Backport rt/deadline crash and the ardous story of
 FUTEX_UNLOCK_PI to 4.4
Message-ID: <20181214073646.77w2vxjiugjocur7@icarus.home.austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
 <20181109103531.GA9188@sisyphus.home.austad.us>
 <20181119112720.GA29334@sisyphus.home.austad.us>
 <20181214071826.GE31355@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zcwbmt6exdfx3sj6"
Content-Disposition: inline
In-Reply-To: <20181214071826.GE31355@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zcwbmt6exdfx3sj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 08:18:26AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 19, 2018 at 12:27:21PM +0100, Henrik Austad wrote:
> > On Fri, Nov 09, 2018 at 11:35:31AM +0100, Henrik Austad wrote:
> > > On Fri, Nov 09, 2018 at 11:07:28AM +0100, Henrik Austad wrote:
> > > > From: Henrik Austad <haustad@cisco.com>
> > > >=20
> > > > Short story:
> > >=20
> > > Sorry for the spam, it looks like I was not very specific in /which/=
=20
> > > version I targeted this to, as well as not providing a full Cc-list f=
or the=20
> > > cover-letter.
> >=20
> > Gentle prod. I realize this was sent out just before plumbers and that=
=20
> > people had pretty packed agendas, so a small nudge to gain a spot close=
r to=20
> > the top of the inbox :)
> >=20
> > This series has now been running on an arm64 system for 9 days without =
any=20
> > issues and pi_stress showed a dramatic improvement from ~30 seconds and=
 up=20
> > to several ours (it finally deadlocked at 3.9e9 inversions).
> >=20
> > I'd greatly appreciate if someone could give the list of patches a quic=
k=20
> > glance to verify that I got all the required patches and then if it cou=
ld=20
> > be added to 4.4.y.

Hi Greg,

> This is a really intrusive series of patches, and without some testing
> and verification by others, I am really reluctant to take these patches.

Yes I know, they are intrusive, and they touch core parts of the kernel in=
=20
interesting ways.

I completely agree with the need for testing, and I do not _expect_ these=
=20
pathces to be merged. It was a "this was useful for us, it is probably=20
useful for others" kind of series.

Perhaps it is not that many others out there using pi_futex shared between=
=20
a sched_rr thread and a sched_deadline thread, which is how you back=20
yourself into this corner.

> Why not just move to the 4.9.y tree, or better yet, 4.19.y to resolve
> this issue for your systems?

That would indeed be the best solution, but vendor will not update kernel=
=20
past 4.4 for this particular SoC, so we have no way of moving this to a=20
later kernel :(

Anyway, I'm happy to carry these in our local tree for our own use. If=20
something pops up in our internal testing requiring update to the series,=
=20
I'll send an update for others to see should they experience the same=20
issue. :)

Thanks for the reply!

--=20
Henrik Austad

--zcwbmt6exdfx3sj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ+nZyAsQSTlWuC1BnqTlVPq/jmWQUCXBNdigAKCRDqTlVPq/jm
WUj0AJ49y+fCNH3S5TVDbztlI08sp8qJwgCfTXo2BMZspup5mc8Pr1NdV3qoEO8=
=xt77
-----END PGP SIGNATURE-----

--zcwbmt6exdfx3sj6--
