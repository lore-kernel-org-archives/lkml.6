Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A99C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F287C21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFTbFVo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F287C21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeIXQuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:50:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36251 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeIXQut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:50:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id y13-v6so4767205wmi.1;
        Mon, 24 Sep 2018 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rPy/h6PQKZ0El3n+Ts3gi1otqsJe0Ko3Dc3DUHPCg7k=;
        b=mFTbFVo4O8AG9SUhcBIaufO8jVffqrZT/cqVA1hzjJMwMMIyn+uiQPgvLavU/rB907
         h3EN5x4wLUlBqSHpM29EQFfNwyJVt4KLy6tYgIy2WPM4WvrkzIlMaGORhTtsLByMyF2W
         by/q/+TBdiPh4EPqx/xMxbaVtfaL014zykwnRXA+TB4cXGPvaEH1+LkbDa1RE0bG++P/
         PT9ff6/dpkN9LqCpEKAy3SKKvRI2P0qS197Q1lvtKJiYm7tOJ9ivrTz5AOOTLGQLkUdw
         YgETQ/V3gSYUlUhr+QizieqCjhK2JMD0UOii3aOoc8lxNTMRai1b6qInGlh+ge3ifvq1
         MtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rPy/h6PQKZ0El3n+Ts3gi1otqsJe0Ko3Dc3DUHPCg7k=;
        b=DT9yAp6sX2N2OQvCix0m8NNFh0aXeFT4jtG+zIrl40lCic3DaXqmFj4XEOgBRQNeaS
         UqZT4mnN6TOmJcQAy57wxZEackBb7n25iLbiBztHWJXF4MfzSzgKLwaR81IJxKKBAk4A
         d9vByJ4o6HWi9xtI2Hvtic17aXwdHfg/DpSAmaKbOlI3G5YEqnOsAc9AHprSXynSqQ07
         vsipU0mluTsQMEpwji/+ZZJvkc17dnxiZnswTNoM6f9aVGeBNNCIGES3HRR+bMmnwzJJ
         0qCslJeRBg8gUTnq++eWEuJmjr0BLKIOHrYH4IAc8oVdUhMLb/eFQ/X5i4M8hIkAOHCH
         mbRQ==
X-Gm-Message-State: ABuFfohBZB2HSVbM1HhInXPW1nHDnqiqtHd0wtIUfSDiAg067G6j58Lt
        UhtypHJVscfWWANWfDAsgHc=
X-Google-Smtp-Source: ACcGV60LVc9/oijJvEaYi/nlPTtzvN1vlSbufpLhSvJQieeNSQAgPzDFiMGmOleZLNdaQ2PUEB3p4w==
X-Received: by 2002:a1c:bb85:: with SMTP id l127-v6mr1516809wmf.156.1537786160182;
        Mon, 24 Sep 2018 03:49:20 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id o12-v6sm3408583wrj.58.2018.09.24.03.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:49:19 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:49:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/20] iommu/tegra: gart: Fix NULL pointer dereference
Message-ID: <20180924104918.GK21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-15-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-15-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:47AM +0300, Dmitry Osipenko wrote:
> Fix NULL pointer dereference on IOMMU domain destruction that happens
> because clients list is being iterated unsafely and its elements are
> getting deleted during the iteration.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowS4ACgkQ3SOs138+
s6Grfg//c9yfUiHhqdvAXDb1PLAB6NcalmJ+iGpEHaw6mo2Rd9rLP7dQOH4dPzR+
VSTWAoWcEj7SsneuIIejLqnjU9jrRoamhWhkiRwjJG2mVQUr/16En3I+7GgDpYg4
Omoru9USR+59HYYledJeued+SHdQOzXn6M/nMtMZkOoW9gUEeusSgwFlS831qndH
ksT9Q1eqtt/yLPXv4veqotexa14DOemfT/e26ONn3mghtewbx+0hsI85MI0JeyRa
2UQeZS8N2VttVgStHV8mqHp5gFn/CcWLzRPeBlCTgbHJUX2RKfy9dmN6SButNYom
n+64LrHzUZ+qZOpYpGMsb5d5DiTU2SJE9yoUsQ5i1m7a7+7LZCUE74griM+QXyk4
LRqiVtQ9+8pORu2PrjjOx1QSUXEhkMl2ZQ+/VnpOtpeRKp/ClaOHQuHdyxPZewMb
0gypg6OIYxr1aA7uC8NtfUC4QsLRilZpwvnqqqpO3imuV4RBhMpVrSZObTTyCkhx
v39X9S0pDxJ3OWMd68Xd53V1/Y33HWYo977JKJ6/+mu2GNhw4dJbipTldcz1AMBY
y6Wkhu89wOcWGZMVvCmhfOE2Jqmpn67zWxQEv4ZYVZBW0H4CKX8goDbJvRJM5qvb
Teme9+YYPKEb/kwpKpMuox/u4+h1MUhJFZXbsLkhgyXrxrEHNtU=
=ZzrS
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
