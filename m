Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A6DC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 04:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FF720685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 04:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="IB+GQ21D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FF720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeI3LPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 07:15:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37739 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbeI3LPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 07:15:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id x26-v6so6906056pfn.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 21:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=922pySRZe5JhjSawkiH1m+slesrd+ZHijV4YinQ0qzU=;
        b=IB+GQ21DOiGYkY6Smpqxg/yZylTxTKd1eEaTz9KyIv4ogEMNxhK1FASbdmN4JpdRBX
         prow4KQrK7wtaTI+I+5Fpco7wPd+zlYRiXOWMlnms74cfalZ4hO84Hv5a/aSSclGYo8H
         eHjCeFwN8WcKYRglfCLywezeUpBQnCV0VVHxWNSsXWEIS1WIW/Uu0OL5DKutvPePtQE9
         ycqWNfT8sxomZm4glLBv5nvdi7ZQbWBj6EIASORT98T+FPWKenGSKJJD2MB6u2UUCIot
         Fl1fUs8V1Ob203o/aQNfTMWzGrBDQ57g2gpTY2Qu3FOY9VEbpy4X5UJV1eLcrAa8Essn
         RpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=922pySRZe5JhjSawkiH1m+slesrd+ZHijV4YinQ0qzU=;
        b=Z0d7mXczUQPzAx/0S0kwIIwduN7Y1WkA+wPvLeeD5D2/r+zloiP0AU5XlP4NmACj2+
         bhyJXB0+W2PMkLePqP4M18mtqOsV+ugXtdPc3rU8CJhMeAdhR3sJACMHDuYaYRRXFb9e
         iORx0+aEAqZdztan20uonsdamOuwa5rhEnwd09tJ1RTCsvW2VH8glkrQLvo1sTj4zfa0
         WHPDOEvLLO3cQavQbskWnLDWAUI4erHx9Si/l7tZtwseWP+TRB0N0luOrnoA87PgufGi
         qb241bMKtpvo9NiBCU6Hp9k6rRgygfj6iwuWjidalQJElIYFW/CHaRP2JlxjpJBIrlqF
         3fcw==
X-Gm-Message-State: ABuFfojl9UKU+JYVS5mZyCs0vyg4ie9aKlqlz9m34Mftcx4JSAAAlsb7
        XMeyhNYNUS5ng/TjUIEcxHyuHg==
X-Google-Smtp-Source: ACcGV62fZ1cH4xvq6gvK2KsOmR4oLid63mPUNa8E0JOr87uOG0/Q+yIHjZe/lf7FjRKZDIbQj9YFnA==
X-Received: by 2002:a62:85cb:: with SMTP id m72-v6mr5571969pfk.173.1538282662858;
        Sat, 29 Sep 2018 21:44:22 -0700 (PDT)
Received: from ryuk (pa49-199-129-238.pa.vic.optusnet.com.au. [49.199.129.238])
        by smtp.gmail.com with ESMTPSA id s195-v6sm16661204pgs.76.2018.09.29.21.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 21:44:21 -0700 (PDT)
Date:   Sun, 30 Sep 2018 14:44:11 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Message-ID: <20180930044411.orcuw7xok4szqzzo@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929143814.yfo6rud7dkyb5ip4@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="olyw2qotbhbwue5q"
Content-Disposition: inline
In-Reply-To: <20180929143814.yfo6rud7dkyb5ip4@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--olyw2qotbhbwue5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-09-29, Christian Brauner <christian@brauner.io> wrote:
> > Currently I've only enabled these for openat(2) and the stat(2) family.
> > I would hope we could enable it for basically every *at(2) syscall --
> > but many of them appear to not have a @flags argument and thus we'll
> > need to add several new syscalls to do this. I'm more than happy to send
> > those patches, but I'd prefer to know that this preliminary work is
> > acceptable before doing a bunch of copy-paste to add new sets of *at(2)
> > syscalls.
>=20
> We should really make sure that we can't make due with openat() alone
> before adding a bunch of new syscalls. So there's no need to rush into
> this. :)

Yeah, I think that we could (mostly) make do with openat(2). We might
need to have renameat(2) and a few others, but if we had more support
for AT_EMPTY_PATH you should be able to just O_PATH|O_{BENEATH,XDEV,...}
and then operate on the O_PATH fd.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--olyw2qotbhbwue5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluwVJsACgkQnhiqJn3b
jbR0AA//VbHHrVwS/hgpTdN1okuZDNZ5MgjStZWgSjTWaEpyL8G2YwAmKes3x5MS
nfvOGCx32EeDIXhcjNzSjkDQIMGRHNwPTTqzymFzY/OmVgYj1ECdDrpQrFtF3msM
501KZ507tvbJti4hZq0EZF6Jbq3py+fXzGqpCWGBv4VWoPsHPt+/KoTf6enleZQJ
6hiM4anCKveDNTE+BQ20fsTbs1V0x7A9ykVq2hNQECmiWJvOHgUdzddBIdOM95Vb
13k7G3Wf/YcaS2kp1cUVtLcfFocqKGPLcuPrdXAjkekfYth0KwDX0ViBKt5LbUKb
l4XpiFZ0MlFOY04zdIGRYGyP8s6Vse/GpdukmnSTL68ALRDR5/4G5okrbSILmvFh
YJr+QF+b/H+yg51LdYi/o2YZqcwPrYJAdUzbWvxz68nLA3YdOeXCEOvES/q8ebDZ
03Rt7v1UhTSg2QdZvax4MAdlhUe2IJKw0/vC18uyCqwTPRpE+yxM7Ux2P1RpMp2t
eDC6zH7sGdAN7iGewJqEWmD+EE6FYlaP0Fd1IjNgg6qeETprfNzk5orJPzwxvMdu
zGrxuAGmagi+6t18ZSKq7Gsaq8ZpZ1wXfgaC5cRzDEQigy1s105NepC0/wbBhVFU
5g7ykyPiCuOSN+E4ifsbWCUUemKUNb8FmZwx1XIArYE5UDbY9Q0=
=oJlG
-----END PGP SIGNATURE-----

--olyw2qotbhbwue5q--
