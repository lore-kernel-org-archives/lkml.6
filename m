Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA9EECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A338B206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tl+Pfz9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A338B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391614AbeIVF4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:56:40 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:36104 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVF4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:56:39 -0400
Received: by mail-pg1-f181.google.com with SMTP id d1-v6so6730544pgo.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 17:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fz3nGYl5sC7hZp04DG6jgvMDK2RPL7JDHXMoKZNlAsw=;
        b=tl+Pfz9WOrzksESMLkwKk4vk2lEDTWBxBLl0Xt4HBH+XwuUhVMDMbhRkyaOxj+kCwV
         2tAYvwaKK73W3RejorEJYKSuy6dvGui5t48+n22ruLluKOoELB0wcqsFAIw+axjUZ2J4
         nClzz2lJNm+eMy3V9w1OhOsQ/+CoLm1HswxOkP6doMF7cKzD1nYaIE1BZqBprWsRrVc5
         rPFrhXuppxSFoYVcie63i0WnOA02jyzTT0AaxitlMrBlyH7EA3xIkG/j73gN713Wj2Sd
         w0efzQss3BirCQvCsBqfDrchc3gzXxDl8UZBl6hXxrY8KysYF6XaJGiS7SJKF0QeLgxB
         bjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fz3nGYl5sC7hZp04DG6jgvMDK2RPL7JDHXMoKZNlAsw=;
        b=YzjIOVX+1irhGRtt3xNizfx7vox6AuLafhbj20cAxI52DF1zy/NsM7YYNaHHwhqCQ7
         64Fni2Rxu4wUJV1IoL43KkdUAJnGk5xhazzh4uKm2hFxBlOdAFfRKXIvBxLHjR07x+tI
         6PM3fF4gtKttuvcAOFDrWiCpU06NswJhnyWHdFSC+yoz8N57QiJvQl3GOxN00G2tBISA
         q9V8nV2iDsKfS9UdDX88R/pft19h9QC5ibUDdgLUa58QawFKoBBdJ32yvnGXkJ2+d8Hy
         4L0kaojf8uW+WxY7YO1nLxyfiOXS/bK8WgJPKKQSiz799mW6OyTjSfWPb9pU5lQVSwha
         6xvg==
X-Gm-Message-State: ABuFfoi7DQSPynwHvV6WLYLRvW3yQGPo8kMgswUFg11PV5G5KmXLfBex
        OsEzEAzyy1zf6bpNtEmuekCGhvis7/A=
X-Google-Smtp-Source: ACcGV60Nxe7xNyZPdWJfWnrmdtTv/tHR/0Iyy4eryXfdWl87AXIBQ3Aa1+oIzYqSt0Dc2E2g0rLTKg==
X-Received: by 2002:a65:62d8:: with SMTP id m24-v6mr57374pgv.307.1537574725459;
        Fri, 21 Sep 2018 17:05:25 -0700 (PDT)
Received: from gmail.com ([2605:e000:1117:c128:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id h132-v6sm39076998pfc.100.2018.09.21.17.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 17:05:24 -0700 (PDT)
Date:   Fri, 21 Sep 2018 14:05:21 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>, dreamingforward@gmail.com,
        fche@redhat.com, riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180922000521.u373eysq6dogcdfo@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, dreamingforward@gmail.com,
        fche@redhat.com, riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>, Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com>
 <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org>
 <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qfcfhobx2fxp6tl2"
Content-Disposition: inline
In-Reply-To: <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qfcfhobx2fxp6tl2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 07:31:05PM -0400, jonsmirl@gmail.com wrote:
> On Fri, Sep 21, 2018 at 7:17 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > People can decide who they want to respond to, but I'm going to gently
> > suggest that before people think about responding to a particular
> > e-mail, that they do a quick check using "git log --author=3Dxyzzy@exam=
ple.com"
> > then decide how much someone appears to be a member of the community
> > before deciding how and whether their thoughts are relevant.
>=20
> How does this part apply to email addresses used to commit code?
>=20
> * Publishing others=E2=80=99 private information, such as a physical or e=
lectronic
> address, without explicit permission
>=20
> It appears to me that this would conflict with the GPL since the GPL
> granted the right to distribute (or even print it in a book) Linux and
> Linux contains email addresses.  This also seems contradictory with
> the Reply button I used to send this email.

I don't really think email addresses used in patches which are sent,
voluntarily, to a public mailing list are something you can sanely
consider "private information".

> How do you reconcile working on a public project while keeping email
> address secret?

This is a little more delicate, and I admit that I can't really
think of any real solutions for this part...

--=20
Cheers,
Joey Pabalinas

--qfcfhobx2fxp6tl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlulh0EACgkQruvLfWhy
VBk3Fg//VUt7lOPXvzyEBsPANfdke1JQaIBXNAXJnanSf7Ri2kpb7rUtYe8BIa0+
dwJatk9B4Iax1fIobPYrM+GS146QUjGg+L/f6wAnkLxbpvfLoJHIj2hVUznRd0T5
s7pQ8aSxpVj7m9q0W1OnQjsMAEqpevwp26uPcdWyBGnTcFFBAcIg4zR7c19ZKeto
W3/bTIvU6UN6njYvnLC+VcImQ8SwjeLotJqM4YExBgcoiR58Ery34lAz9PNlDUA1
grjszbETecO+zvAuETE7CvGiHNvIJJdr50va+6omOuOOu4rRsXTKYtqEolIeJdhN
kNHqarkbclZezh8GeXsqGP1oTlWEmNk6HSKMmR+dncCYp1APSANXSzBtmUGdE6Zs
7rdHU7zZNqftJRj/+n0YNpste9TPB1b1iQwQDpOdnGud6gGzZhla5//UUdy1Pqql
/DbguIyH/nrF7MVNsFS8R87IDgcBV9DZgLW5KToIKA+rccRKJ2Q9dWeWyjm7W5pt
AYhqSzmx5t+uGn6ARRzFLeU43htWlllQaGd34r0Voso4Ec2XIkazeuIdBSIZyPtc
A7n5V4GWsOout2sh6lmzWrVYucd8iD8EholcWKKnBG+BTKDFWRvDytQ8bfFRSpEi
wt4huCy77Yjzb42bcTRRHQ18UM7WWDy51zq3aCZL/8CQEZVLNQE=
=hYUi
-----END PGP SIGNATURE-----

--qfcfhobx2fxp6tl2--
