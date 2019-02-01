Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D1E218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCx6Y4P2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfBAOQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:16:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39312 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfBAOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:16:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so7262165wra.6;
        Fri, 01 Feb 2019 06:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fVaZFKg++NeNrMZVkI0W7XH7LrO1VASa709jqyqbx/o=;
        b=hCx6Y4P2GBrHlAi9Smn19UHX24DKVu8MjhHZhlWjMS8cL01L9cuiDkrL751NF/OOE8
         iOjGtN2h7crpcwR3795Ug0RE/v/D/HTy+3EYEfyC8CKaMvVeS2PbyeTce9muyLxP0BLY
         WEyQlLM7fsiUFNxPgFnrf+AVoR6sIPd6ft7CiHbi2gC448Smc0gfRctgP5ORJHusi4Au
         jtfwoRQosfRVKYmQqIghhYK5AVh9kZeekp5dTSOGwyIzxv3J+cPSyPwIySFtC3KuklNY
         9uzaShkTkFqI+cbAzHEEP49j+qoV2WWVBW21kk5sNXeCaZrvXBjJGosnprazNrajin23
         kacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVaZFKg++NeNrMZVkI0W7XH7LrO1VASa709jqyqbx/o=;
        b=E4X/xhOErDuop3GYnQh/kFGn44+RmO0LSM4wcvh4l4oPFa70uv3XcVMkP7eE/kEKcv
         tAG80UxkFUxs+WCK3+Mp2ZP4q/Bpj+mmgmsrVB/WJXyGj4OGPzEMIwf2NUPlkRpAX5zK
         aoa2+9TpWxTF4iuqrmqjngqNY71EsrQdwdsNGulsngtfUdneTyiWJ5mf4oJghGMGjS8l
         HiIIdQlgM+u+vZ2WZgNRqHJhxT3XXHAjnFoiEHe6vXGlCE6IO9JAudO64VJPngIKSotD
         5+byC6T9wtJdQQUdR+RI8vR6JUIQmF2TgxQj1jdUkjzEpYn3ZbjU5ATeuzYkdWg52dvL
         rTgQ==
X-Gm-Message-State: AHQUAubL1c7VY30m3y6VhDCVVb1RtY9ikRYTm2tKiOCASoT40FMlsDDZ
        hEdDnjQhnt/LE/tnzYxOFiM=
X-Google-Smtp-Source: AHgI3IYwdmo6OrgBhjxoldMZymNTPgJR901U1eXUPQnIiYNDmwLElg3mok087vGaTltSUDJ90T1AWA==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr2030441wrr.155.1549030589412;
        Fri, 01 Feb 2019 06:16:29 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t12sm6121817wrr.65.2019.02.01.06.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 06:16:28 -0800 (PST)
Date:   Fri, 1 Feb 2019 15:16:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        Dmitry Osipenko <digetx@gmail.com>,
        Emil Goode <emil.fsw@goode.io>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] host1x: cdma: use completion instead of semaphore
Message-ID: <20190201141627.GA14499@ulmo>
References: <20181210215119.1903413-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20181210215119.1903413-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 10:51:04PM +0100, Arnd Bergmann wrote:
> In this usage, the two are completely equivalent, but the
> completion documents better what is going on, and we generally
> try to avoid semaphores these days.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/host1x/cdma.c | 6 +++---
>  drivers/gpu/host1x/cdma.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxUVLsACgkQ3SOs138+
s6HJrg/8DUV/2aBHeJcobK+v1R27eKQxU2eO6ogjuYEqCg79mGygwLuNgF01sZcZ
TZu+XrXmIXecnfDkFqtNXx3hM4SnMznXijz98TEzFhFRFuqoYd4f5F0QIUVioeYN
BrBjK9mcJy4HR4jpkSvWSXPd9QwQyRvnwHrJKQGUr2O/0ygaGbOyjwUViDVgNx5x
hX/wB5eoGrZ6jFtoQ9U/jOhrIR7Uvu+jKMDGuwL/f1Shzgz2IEI5Wqm85VvmfyAC
8/Pl4trl9kD1cJOlT6NvJhlFKc/fRTlfRJEh5A2Hg2F9XBCAJdNr4BDDspU0+ZNI
HTmqJYgEs3CmADvNWOEpB9WOCnhBxgXWaeTLOYYoQgo9JPK6F0lHs33kakTDdiSc
Zb9mnlJeTIrqa2Zd5VD7adCK0eQ5OQVxCNckU73+dA+I3/dbBsvKh3gTtAlZiNA3
4hcXmBmRhnUjNYAML57QCaQvkrGkfHr2HU/T1EWIdwuAAucyAy15CuT+K/LMEbgX
4eDWQPborhV078etJSuUPiSNZr08G+YQ0I/QBtwYbK+x3X7Y+p5z3prUUSmY08ag
lsqoPC8C5xOk0ESbOEVzh5GRO2qIkoXnHZ4QHLDGfY85jSkiITTi0+oDjW9RNP6R
aTDTu4IkJfqzSL6WciEZfKHCeeL7Jsm3cNUzFXoJq2QaNpepbt4=
=refY
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
