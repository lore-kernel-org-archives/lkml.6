Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FSXGHufIGlt2RwAAmS7hNA
	; Fri, 08 Jun 2018 18:20:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 63395607A4; Fri,  8 Jun 2018 18:20:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujblgUQD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AC8B660275;
	Fri,  8 Jun 2018 18:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC8B660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeFHSUC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:20:02 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34139 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeFHSUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:20:00 -0400
Received: by mail-pg0-f68.google.com with SMTP id q4-v6so5694276pgr.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vs5iRt1VrW2/DX4LXyPEofd3+5kf1B5DMCidrSCfh1E=;
        b=ujblgUQDJC/Hsh8ovk/SRg5bLMP4IrzQg1S59zZFTeUBuVSi/VHeiunid/6YeYMouF
         iAyOuTd5sZ5alXSebfjjF4ZXS/jHKzQw6P/0sLcO/n/t+wp5cl8xyG1CP92IcYFGhBnZ
         OrylogGRGDjy1q9tH6XcDXrvK6P4YS4C8LyLuEBDGsHiVI1Lg3ywAevSkK7uJGxZ3pNi
         CC15lm5iwpxrWAoawbRhpKDmJ4dshVhFR/9VZu1GfIpUGfJG+IABiWqkMPf04BJKXaj6
         T/QPg9K2hzlKHw0aFn7jxoXdyzO7cEzKlz7hIVMsz+q+THfPUeExoX/Sc4xjKHMlssTS
         ZpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vs5iRt1VrW2/DX4LXyPEofd3+5kf1B5DMCidrSCfh1E=;
        b=ue+p5qem6dk1cJxnLkkMB3e0Ob1ULHqJOcNowH2LVtAZLnpoKB9IxI7tZE3wtsRCOp
         QO7APZIweuhoTkVcgwCgr1MpuERbv65oWOucabt8m4LEkvujkNqZqEyvV2Y/PCmGd/ud
         QeA5TW3QN3aA4CJDsAjve3sWbkr8zYIcezxQu04wAlxhiJaddgn7DLH03bai6XxNYoi2
         2+OSExeYpcwiRaI8J4UhoDAg8LZ06XHcKLwzmd7oBh9vixmYIeFlE5PYcKHLvP5/uBcF
         sYMEN4QiuxrsUGApxn17tpdWtCBnp35lXY6LTdT/XzvMyl+/Ub5RbuCeDwm0hyMyfH19
         O3ZA==
X-Gm-Message-State: APt69E0GSAL76mp9eRvTxyaWhJxL3qT1z3euA1VcOF0+9VRUsjdHSAFw
        03MYYOLbsUYzOkwq56xDOa37Kg==
X-Google-Smtp-Source: ADUXVKKTIDlrBCAYruwZUmGEZ+5uBHL+KSIqa6ZpfmaqXkwekmyDmHIOzIsCGp7H3TwMBEMI0BRarQ==
X-Received: by 2002:a62:f407:: with SMTP id r7-v6mr7053562pff.47.1528481999673;
        Fri, 08 Jun 2018 11:19:59 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:0:1000:1501:e4e8:e3c6:19f1:ae51])
        by smtp.gmail.com with ESMTPSA id r5-v6sm73943900pgp.81.2018.06.08.11.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 11:19:58 -0700 (PDT)
Date: Fri, 8 Jun 2018 11:19:56 -0700
From: Benson Leung <bleung@google.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Gwendal Grignou <gwendal@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cros_ec: remove unused __remove function
Message-ID: <20180608181956.GA110395@decatoncale.mtv.corp.google.com>
References: <20180608144834.3003465-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20180608144834.3003465-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Fri, Jun 08, 2018 at 04:48:06PM +0200, Arnd Bergmann wrote:
> This function is no longer called, so we get a harmless
> warning until it is removed as well:
>=20
> drivers/mfd/cros_ec_dev.c:265:13: error: '__remove' defined but not used =
[-Werror=3Dunused-function]
>=20
> Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")

Gwendal, in PATCH v2 of https://patchwork.kernel.org/patch/10439449/
you mentioned that you readded the __remove to avoid a warning when built
as a module. Can you explain what's going on?

Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsayMwACgkQHwn1ewov
5lhSoQ/+P+/xLWQgcMugSg+mU0KLOBdsgfYbfVVA3ya03Ymj0bfBQT4JxTbN2a82
WG14YCsDSiU+3KPDyGo9OAWTEZ4mkqaJtnxRtRjpVz/HgYnD8QfuEm0PpfVoJglJ
3yE7ClFt/g8DrxlMY5i0Lpl4/ZZVa1D8hkTcvUvdeTENItI17OnH27CWn2mVN3BU
F6XASvbTipNWGjebP4W9lYEOyU0vn9G0Jt+lUTXGJLPZfdArXR+0O1ziO0wN1JD7
FJDi6Fd9BZx1bIy9qqpK9kY1tSp57ZGzCCWFDDSZPhfXvG4QX0iWny6AhYbkS2SN
ztI3i4LiYYnKJOWEZWKHO1wO4+v2omFURzHcyKzi/p48mF46ikxLhLRl/K4ps731
GtMSM85apguL2WCygovgCI55Dlq50I2t3ma1lDESR6bCpSARhkvMvNnEu+djh6bb
4HNu1fr4bGfqSVT/UHwEQmvgns9oGB6CyRz8NhHFGRf/y2Bje7CPQPotepBqXAh/
1UG+ENgVMoLOfA4VeF/ZTLxiBcGWthlaG5lpeKi8mH7qqWBowg+A5BOnSbCd0a6Y
XtrFISZxATK28PL7dKGt+0n0xkj94LyByuZL6dI0C+6cCqYT+MolRfXu4WWj3Qt3
eCYbcp8mi3zI1VHtvvhIhiJ5/aWaWCbV4+bd4bxBX6FohLngwuk=
=ft7/
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
