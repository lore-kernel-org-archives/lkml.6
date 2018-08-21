Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5492EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93402151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Av5JowFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93402151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeHVAE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:04:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43422 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVAEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:04:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so7654081pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yTnjy7M1sSYxXrZPhMlrE75Ha/0sIk0aljINHihZ5q4=;
        b=Av5JowFn2ZRIUWYvVm6dtTdMoyOVDgk/gyLhSwrotJKt4q7Fla4d+8kNj363ppOezR
         4HkB6Dy3yGDrNn61F2cLd/gQf1Cv+xbkegboQ8jmvQL1GSl3Npb3xUtU2TaIgj1KZbit
         bBzkCG42ec9mLqYYcvWY4u6744asVFmXMZRQ7MDRxNqY0t/7Io2mvq+e2znLoJu9iRlf
         CgtArwwogveVxjb/5K6UeFVfFsuCSuIJh6Lz51/q9nLL3Kd0h9QOmL8gJ0qZ7Gc2nmXN
         6g/DP/3Tcj6DtjC9Tr2YZjU/Xz/upq1M4/QZbGRx3bXGXvc4l4eTKcCe6/GNsGQPAOey
         LkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yTnjy7M1sSYxXrZPhMlrE75Ha/0sIk0aljINHihZ5q4=;
        b=oig4YFu5MNjkiq/H2XfmVlE3n3pfPwgwiPNfN4akDXQT+rPvSzGZslUARbfBGAXF/v
         Gs7R1ome0XSmlvb/6pxbflz3yWpHYmR6HxpTMTNuvZja9mWUnHtZwgxTWtPdvhwyU/Au
         ZPH0zykl7BfxXkzfkOCp+o3a1pV3mvAgkWB8orSm0qb2sl/ymnkPtmUS97QbQzzf/QPv
         TldnNBXpScp5nM6xmDqrAoyCprr8GuEq3qjYo6bi7O0pvCy9hWqqJpK+Q6zPtrkLsXOt
         9Ol5U7mWKDK/J7NGUZIgThWSl2yRaoIoBvcvl++6qRXA/fbqOW6ii/kb4NKIE/dsj844
         yzcA==
X-Gm-Message-State: AOUpUlFCtQPP9IfS1QS8HBdlx9aQUwCpEcorRdeS69dTkk1mA+sCyTuZ
        94JkIudjgQ89FyBArxE5To2tZA==
X-Google-Smtp-Source: AA+uWPwvjd4JH/JXNoYx5dOf0moinVMJ351wzck8jQDO0r3MJikWc2V5Tn0G1b6ajl3imf/nBmVoAg==
X-Received: by 2002:a63:ea49:: with SMTP id l9-v6mr48760532pgk.427.1534884163826;
        Tue, 21 Aug 2018 13:42:43 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id u9-v6sm22293993pfi.104.2018.08.21.13.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 13:42:42 -0700 (PDT)
Date:   Tue, 21 Aug 2018 13:42:41 -0700
From:   Benson Leung <bleung@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [GIT PULL] chrome-platform updates for v4.19
Message-ID: <20180821204241.GA138502@decatoncale.mtv.corp.google.com>
References: <20180821185413.GA40305@decatoncale.mtv.corp.google.com>
 <CA+55aFz3HpWHezTKtN2LswehY8=nEaofczPFzPiKram+7DHbfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <CA+55aFz3HpWHezTKtN2LswehY8=nEaofczPFzPiKram+7DHbfQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 01:40:21PM -0700, Linus Torvalds wrote:
> On Tue, Aug 21, 2018 at 11:54 AM Benson Leung <bleung@google.com> wrote:
> >
> > Minor changes this time around for 4.19.
> >
> > cros_ec_i2c and cros_ec_spi drivers moved from mfd
> > to chrome platform.
>=20
> Actually, these all came through the mfd branch. Was that not
> expected? If Lee Jones is randomly pulling stuff from you that you
> don't expect him to upstream, that's a communication problem.
>=20

Yes, Lee and I coordinated an IB for these. This is expected.

> So the only actual new-to-me patch there is the SPDX identifier fix.
>=20

Yes, that's correct.

>                 Linus

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlt8eUEACgkQHwn1ewov
5liMfxAAgpNlN1NNDCvXnBuGuQZeLPW0yUM3Be4iB5yp9W/Z9WW+Nnb3pUIKskKo
4q+jgpNwYYINp7oudGy8ava2Gj177gXIr0a+BOi7Ven/fKWYBGAJ6BgI8FWfUY/L
b6UtZPiBNrXmA8bfTruQuMJdKnS3ePACOZ+ZAYMLKYfhthBFUzahWiIFoi+wAOfQ
bFtIonKPgd5ewfyhk5MJrMe0rzt1WQQwZQizuv9zESZ2/qyjZPXRAQSaTJJ3sFdy
i78FWcn6KW6AukjA/ogzHc3Nocif7H7wtiViiT7Cmw0TVcQCrugMvxZ5OgawhbVT
YzKCGNX24QRMkG5KTwVjPPA7OzAwnleYTKGYaiAHKTIfkUQx27nlAtcqCUls1fLR
+wqRQ/TPSBjzl5gXZekOv2lvjp0JJYRuJqnJotIWTfchdPHN4GSkZeGDHRMwXosS
R6eE+UD5a/gtUkrqa24fJbGRFiso2NFGX4xmrvSEGG4TQ8dJ9MhI8BMsb5SWaMmp
0SstEqIw++HcuVvqFMvqwk6K/wOqbxcX30ictUd6VVRPMI1wYuhDNhcSM14a4mMk
x16oNfTX5w5NcPofsVnmqPQ82yhMxaGDiVvGr/r9PKaxwXJC4OH9/8XosCvnfyfJ
VLTYrf97+1Nd1GikKTXZ+P/DomtGLbq1YA9B/7d7wFLhT+TjiVk=
=D8T9
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
