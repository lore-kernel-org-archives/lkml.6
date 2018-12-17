Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB7FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F21C2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPbD3A1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbeLQJuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:50:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38947 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732057AbeLQJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:50:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so11552800wra.6;
        Mon, 17 Dec 2018 01:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bx9Et6w1SjqEYzEub4nYhtUsrAopCcmsc6kn8bgGJAw=;
        b=pPbD3A1ZlHJL4EUblstD9CysdrB9FsoVJXYJASw/ObhC0HTpmNS1eciC1ag4f8RygJ
         x3jlCvPysx7USRt3DggNm6jIfV0HjppREZiFG8QWJhlUJLI5ss4AjeGgHvv/9OrhywFI
         mBJ2/+5YVccAxIMUayceeo4+Pi0yUHQJAoK81A1MppV+ZbMIybSV1/ixTVqjipl168Q0
         ov15WUqmxKNY3oZeSWfE4z1eE6KVJNeVFz81uMgKYhcySdIRuKBh0PXR0TVWmGQlmimX
         2hBIiYpOm1SD7hSoFh1+YyiMMFhBdVqRaGnshPxzMLLeCKLUNqm7mUJmJX9o9xdakbMu
         CMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bx9Et6w1SjqEYzEub4nYhtUsrAopCcmsc6kn8bgGJAw=;
        b=IMbs7WRMhlUPujhqhl307LO3Io/IU/Qh4iN5snxElEfMROhigF/dOzw7k7qgw2+PBW
         0Wm2aw2uXJeSVpvAPztiIFvvj8EmHbQkRS/7AA45SaR12VLP/FfcOlXXimAtwN2/YO6J
         6mamsiL4IoFpvfCKYug7846yURDZEblqkR1SOkATDqCqZVUnB56yIYPfl0do3X1HB/CY
         AoiAKBeGXPiiU2gEUQB5JjSFyV9uva8jXueERpt5ibd8FP7mx5OpgJQSNsnDvnUPbBMc
         mH87AJx40mcM2BZ+MC6+jR7GbsW7bkzpUMz8tT/hA5sLqj0lWRNJcYdVtxcKI7T1IY5j
         DgiQ==
X-Gm-Message-State: AA+aEWbkx4LlkuLGfqPpg8Lcv4u0s9GbZcgzgnfClMzGWRTn9l+k9g5l
        cKHpeeh3dBoUrQvrElk2Li8=
X-Google-Smtp-Source: AFSGD/VJgzIqv3XUllIhkHhlvp+X2YqTbgS/sNeAmzAMwjqfKwXQK6UfT1VGqoUSMO15ntCpF4JtRA==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr9839277wrq.225.1545040208092;
        Mon, 17 Dec 2018 01:50:08 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y34sm34297562wrd.68.2018.12.17.01.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 01:50:06 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:50:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andreas Bombe <andreas.bombe@gmail.com>
Cc:     Andreas Henriksson <andreas@fatal.se>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpluskal@suse.com,
        base-system@gentoo.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181217095004.c6c6itvyfp7cf3ta@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <20181002081654.jxesr3kj62snzez5@pali>
 <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
 <20181012091941.o22srnhse4kzqjhf@fatal.se>
 <20181114113341.yx2wlzqku5yh3k4h@pali>
 <CAPXf_qN66-Mi+o+9ENGqCDe-_2tHaf9uM3moRcCGNvmxwH3ExQ@mail.gmail.com>
 <20181206083828.4bp3oypkto2ngobu@pali>
 <20181212135736.xtb57r2eatqsgenb@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x3uqxugdvepbex5v"
Content-Disposition: inline
In-Reply-To: <20181212135736.xtb57r2eatqsgenb@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x3uqxugdvepbex5v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 12 December 2018 14:57:36 Pali Roh=C3=A1r wrote:
> On Thursday 06 December 2018 09:38:28 Pali Roh=C3=A1r wrote:
> > On Thursday 06 December 2018 01:53:02 Andreas Bombe wrote:
> > > Pali Roh=C3=A1r <pali.rohar@gmail.com> schrieb am Mi., 14. Nov. 2018 =
um
> > > 12:33 Uhr:
> > >=20
> > > > And... has somebody else time to look at those pending patches and =
do
> > > > some initial review? I would really appreciate if somebody look and
> > > > comment them.
> > > >
> > > > There are 14 open pull requests:
> > > > https://github.com/dosfstools/dosfstools/pulls
> > >=20
> > >=20
> > > I'll spend time on this again. It would help if you could make a list=
 of
> > > higher priority PRs you would like see being looked at first.
> >=20
> > So.. here is some list:
> >=20
> > https://github.com/dosfstools/dosfstools/pull/92
> > https://github.com/dosfstools/dosfstools/pull/93
> > https://github.com/dosfstools/dosfstools/pull/94
> > https://github.com/dosfstools/dosfstools/pull/101
> > https://github.com/dosfstools/dosfstools/pull/104
> > https://github.com/dosfstools/dosfstools/pull/84
>=20
> Maybe you can start with Year 2038 problem in PR 94:
> https://github.com/dosfstools/dosfstools/pull/94

Thanks for review of #94! As next you can take #92 from list.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--x3uqxugdvepbex5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXBdxSgAKCRCL8Mk9A+RD
Uu/TAKC3lxIwK06YX7LUd8E8Eidc8HFxtgCcDbigpf+TOKTL8s1SoUscPEYBep0=
=79uQ
-----END PGP SIGNATURE-----

--x3uqxugdvepbex5v--
