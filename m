Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C62AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033D1206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="iKU/M473"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033D1206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeI2WDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:03:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41148 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeI2WDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:03:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so6267133pfi.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=13+qSKrScUwSq+apl1xSa2gItT0zDT0glFguf69s//U=;
        b=iKU/M473fgUo7rrnVBUdtxnrZsXtYmDA6zApjElwaRmRxuF4HfaSigE34jMhHr2SR/
         iUf7tGf0svuwt5panvx7RTidK9TDKcIBL0XD2angbYBkPfN7MX097mHcEKw04hw5sCBl
         8dM/4Xp+fDlwYc+gYVyJ36EADbvmtPwc2vwTvisHz4zkJHS6gNf4lmZB1NSKar3wkdwt
         nVQOOX26Wqp5PHsbmeyGLiGGTuwd3k+K7i7r7vI8X1A32BgxbCNd0pK+Z+0n8jWgxSYx
         p5lGjJ2c/Z0yhovVgyIkEVFtASuzC2NYt5gJFz7B9pFWoAO4UwBE/dci97+9GbYx0llH
         fKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=13+qSKrScUwSq+apl1xSa2gItT0zDT0glFguf69s//U=;
        b=aarJiY9vvHt1Nfdviu+XJhnjeVvjxSz5Dn2rj5FqxK46CGGgPS57XL2UYza0x/SK/e
         ZRvW1OinWDuZ9Y0t2DtP1WZ0guiTVe+rkpaMJL9YoQPAYeWfgdiRgcejC2O1IjcL9Gab
         0ezLWlqAdZKFOvtey/PPXpYCBKRUFRgU8FKdvM3+ejb0v9GbgTmEjFSV5r7v+Rp3CQ89
         NTCfALmNaUWZv9yChYMurnTfcBgEXTSeLL+C2BAipmiSWX9RxKSUsDKg0fAw2AAtiu9I
         /ALbRU43tpLX5YiJBnvC4mrJort4+GLCgA+F09Rf9eJYJQgapeSsS9AvAOILpxFUMfY9
         XQhQ==
X-Gm-Message-State: ABuFfoiluBU0XOBUiYSKTb19XnvPw4EeetMjxKzuTkhnIJ+TsRKH7VOX
        gFOJa5tVz4/uoe7gyZY/CfAWUMaGPByMXQ==
X-Google-Smtp-Source: ACcGV61mFUZ8iflDRCIjYdmNbX2sOGGaRMeRSgKUXEULM9yjf+9cwjyhZe0qJZZrKwtKtWrPW9nfWw==
X-Received: by 2002:a17:902:b212:: with SMTP id t18-v6mr3762610plr.136.1538235280525;
        Sat, 29 Sep 2018 08:34:40 -0700 (PDT)
Received: from ryuk (pa49-199-213-175.pa.vic.optusnet.com.au. [49.199.213.175])
        by smtp.gmail.com with ESMTPSA id 16-v6sm10490690pfv.33.2018.09.29.08.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 08:34:39 -0700 (PDT)
Date:   Sun, 30 Sep 2018 01:34:30 +1000
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
Subject: Re: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20180929152754.rbh37oluivbywdja@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929103453.12025-2-cyphar@cyphar.com>
 <20180929144845.4nglr3sf3jyzosfz@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4urhvw3vy4zr33u"
Content-Disposition: inline
In-Reply-To: <20180929144845.4nglr3sf3jyzosfz@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4urhvw3vy4zr33u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-09-29, Christian Brauner <christian@brauner.io> wrote:
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Christian Brauner <christian@brauner.io>
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> Not to be a stickler about protocol but given that this is based heavily
> on ideas from prior patchsets and suggestions as you mentioned it might
> make sense to cite them as links and also maybe add some Suggested-by
> lines for some of the authors for the sake of posterity. :)

Oops -- yup, I will fix that up.

> [1]: https://lwn.net/Articles/721443/
> [2]: https://lwn.net/Articles/723057/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--p4urhvw3vy4zr33u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluvm4YACgkQnhiqJn3b
jbRVuw/9EgcWsNeK8k0ILlm2J0+yTei8nqAn3kRgmI1Gu6r5NTzK+ZDn2lsRbn/g
tBiyVspNAtnHhTLdweYqGveWbp9QF7ZM/iQGQPyU9i6u4JUThiFO43plGZ3a13SQ
FjhKGgbAxlenk0fJ1nUngjP5pcXGOTPtNu7iQbXMITefSC/S+0RJ2HvjBkR5tD7z
I7A8yQ4yoQxeu4jXJzk5sGRcABiL4m0X3B3CYRM0nbbejVDMcG4bK/kUy999FfI0
aYIhAGEWAMzjgROXaj737byJGbVJtqih5qy/ACpIdPFhLZOZo4gF2QlU8z6Rxfk2
8/1wahOf7YzOJrVvQHfVsZIX06g5mPTosstWr90AoGm8D0LyreRZUJpR6PA9R+08
Ozn32/BoidlnlNuOALythUGzaSb8QTQOPY7tBsGNDA+Y3vJLBBjmbqmp/bTpukmu
7zCyuQEtUJnuaRdMqttTGxy4NonH3pHE5LDfnYtyedvW9u0jZ5wwGceclXzBM8Ge
/UGTa7VPrv4P3n0GqGVGxmN5kb/eiVwI1YneNe+q2GzCV6lAcDabMBZPI1Z7r9SI
Jk73gpD4FLTwdnm2L9uZwC5R66FmEeo6tVj1GG0wKtnQGUamBUINqVZWUQrc3T+k
8S8nTJvdG69l1VO3GyyFGaFhyOEqu3D5b6hpR5f4zFNTXgUxcVY=
=KoTi
-----END PGP SIGNATURE-----

--p4urhvw3vy4zr33u--
