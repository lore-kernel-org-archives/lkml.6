Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D73AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DBB2154D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDB1lTD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DBB2154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeI0DKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:10:12 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:38451 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeI0DKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:10:12 -0400
Received: by mail-pg1-f180.google.com with SMTP id r77-v6so220443pgr.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=piYCxbwXbH8D25Ks3+yl8pNHQrimsEJAUReoLqAobxk=;
        b=vDB1lTD/VbNRS+sr5QfrvjKkmwdDFkLe4tjRf2X5tzy+0Qoew9VuO2dZQkypmxxi/Y
         i4evF6AAvO9JwiGaqLkqA/qn7mP343teHdQ+kHf9DUNTjFV3ILbHR+yNlUrTEepdYyp9
         K6hqbM1OdBX2Rln8Vpuap3eKkX4UPWrl+M8+OHzYZl9o1iKrSw1S52EkuuVTL+0QC5q2
         bHuYZGuj0UwO3YMtJ7k2Kb/pRnbeLshSz0mCcP+kkVefRoAuq9RN1XMzQ5xJ8q95ZeIf
         C8mDYMBU/ZnC/Z9mdArXIIyp7+DqsLQwsjcP8+zJDHfYi6TJGc9t32NZN+EwY7+jKH/j
         sczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=piYCxbwXbH8D25Ks3+yl8pNHQrimsEJAUReoLqAobxk=;
        b=mD90QQ8OUkhcqyDcKf1eNOy9LJM6nTKepofGtao4blfxpK9anLkzoguAjZfOogXZUl
         rxg/HWovBnvJlj4vXd33OGGlG/W3YH/2Qx4OOZhjWqtu1px9OXjqgaWLIl3De9xbAFzP
         zvsjte+QTymvKWEiLgpZxFerw/qkRExXQ18itkbHK0m6Qfsw49gu3AAnaXHNOUWumKrq
         bcoppdTpQTZyvt4F8DQWEZ+WQndSdNpe8NiUJScuwcIsIBeNsaopk5B7XbglZUQOc4OD
         ki2nqOIEsow+5dIkMU98e8QSYcNbLIgjrVW4lUDmdd/tDN0bbdYtvRSPWZipeiScFDfh
         0oAw==
X-Gm-Message-State: ABuFfoix6XzD8gCsA+PFDWRnfNn7c7FMVOAmhjfvSV1P6hPMKrDFW8HO
        0bMzy+wqDg0rR9XdGwv7nUdv7tcjFUY=
X-Google-Smtp-Source: ACcGV62ymw7aocZ+CUgrXz0bDnpYtnrB+JegQZ/L/FT5PnrRZZHJwV59Vu2cCUP41kuIW8wywANdFQ==
X-Received: by 2002:a62:b209:: with SMTP id x9-v6mr8060318pfe.148.1537995324396;
        Wed, 26 Sep 2018 13:55:24 -0700 (PDT)
Received: from gmail.com ([2605:e000:1117:c128:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id m26-v6sm39828pfi.102.2018.09.26.13.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:55:23 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:55:05 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     "\\0xDynamite" <dreamingforward@gmail.com>
Cc:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com,
        riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180926203355.rfmezs3lbmlcvv3x@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        "\\0xDynamite" <dreamingforward@gmail.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com, riel@surriel.com,
        ec429@cantab.net, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
References: <87zhwbj8xe.fsf@redhat.com>
 <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org>
 <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
 <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
 <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
 <CAMjeLr-j1XhZJgcvsP5z6SHCDmbUA=rMyfvQpX40qKBK+2ojbw@mail.gmail.com>
 <9be16b08-7aa9-d42e-24c0-f054af39b78a@petrovitsch.priv.at>
 <CAMjeLr_cx5+96NGedcYB-MjugA53_j+tksP0Na8W9GY-PAhoZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="prkrf3bxpnkwi76x"
Content-Disposition: inline
In-Reply-To: <CAMjeLr_cx5+96NGedcYB-MjugA53_j+tksP0Na8W9GY-PAhoZA@mail.gmail.com>
User-Agent: NeoMutt/20180716-423-e60b71
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--prkrf3bxpnkwi76x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 26, 2018 at 02:34:07PM -0500, \0xDynamite wrote:
> >> You confuse the issue.  My definition included "intended for the
> >> public".  But it isn't clear that open source code is intended for the
> >> public -- it is intended for those who code or wish to.
>=20
> > Well, then I have to repeat myself: Signed-off source code (in form of
> > patches) in a well-known programming language for a (nowadays)
> > well-known GPLv2 licensed project mailed on "everyone can subscribe"
> > mailinglists, (thus) to be found in several $SEARCH_ENGINE-indexed
> > mailinglist archives, if accepted to be found in lots of publicly
> > accessible git repos can be not intended to be published?
>=20
> You did it again.  You changed words.  I said intended for the public,
> and you ended your sentence with "intended to be published".
>=20
> Like it or not, both the law and English grammar have ambiguities.
> People put up with them because they share a common intuition (in a
> lot of cases) of what each other means.
>=20
> If you share a birthday card with your personal love note inscribed
> and the birthday girl sends it around to everyone at the party, have
> you been violated?  She might argue:  how did you expect it to remain
> private if you knew there were several people invited to the birthday
> party?

English does have oddities, agreed.  However, open source code is
definitely intended for the public as well.

If I post an ad targeted at dog owners in my local town hall, it
doesn't mean it's not intended for the public. Even though it is
only for dog owners (or those who wish to be), it is still
available freely to the general public.

--=20
Cheers,
Joey Pabalinas

--prkrf3bxpnkwi76x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlur8igACgkQruvLfWhy
VBnSxxAAkAFBvqH8mpjjJFdGLncgGa3YAAkn7QN10pjJHsWqWUq+38g1rGZ1JzRw
FraIKnGce447X2ew0wJEY4VriyumtJGGLMC8Q3YXL+Rva0qypB4XTVNr1Ck2zQDK
4/F6C8A+4QwHz8byIQq6/ysTnl7NMDiBIq0l2822q6/4K+mlz0kyxsCB+tlrk/oV
uzYexTVmF8MPWepYrqw/9Y8P9HmmWjEMMJ3q8MgB+9TwWjG5o0Ossy0elVk0nlR1
Y+u24T1td+eNROBqt1Lcxvne7gtUx9zfBInQObO1bA3SBeI9uP4tC8fsWp4W2YkS
LGCdBHZuF6IGLn9Vc9OHKexsG1Gd3HOb78ceAb3e/jww8p9q8+WDYP230NtFsR1Z
lrNAZm99KkyxVKZGuJDlJwaAin/ZnlnuuBwYPF3gm5kSEtkhxMDeIT92wD6YXKti
dBYPzHZb5f9EAalJ8ed/EoHsi0Tmwt7ud6DdPeiLtisiSz4HhBwcHPHa8C2huZJU
Jlwp+xfbN4AA6pvQ4DM7nXdPlohSl9rzjVhwUe4wweGDmXGZLKeHTlYDLjGeuW2B
FsQNS1cOJgf1F1Lz+4xY53AsaeXfgmyvHCAFZtqopN9giW4HcZSk0EHRNqooQ7IK
uc0h1kVnIAV+Da5yQp+QcxomsTsUITHj3jgkIhk7UDgjbhgu+v8=
=9Ugf
-----END PGP SIGNATURE-----

--prkrf3bxpnkwi76x--
