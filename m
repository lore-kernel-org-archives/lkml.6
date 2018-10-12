Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6ADC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962E62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqIFSLUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962E62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeJLSNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:13:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37207 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeJLSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:13:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so12887917wrd.4;
        Fri, 12 Oct 2018 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fPDxcroJciIMsvfFT+WvfSSZGRz40ykKSUracXzD23Y=;
        b=dqIFSLUjkJDFGfPIgZkmQBCwM8kEXq6NKnTbWTDm6aAYo0uQeU3tF1pwEm+EzWRr+V
         irxU+MhlM0Pu1BJn/oN3AyX6GTLmbFk9tri4OqIGipwkZMTtgdaXDADFTeFnnwLudt52
         n3qt98gr7qbwk9zbnZ5w9ioaIUBgc+6AHmvYCT8gNFzxqUkGMMETyb0gUmGIAePJZjVP
         jLxmlj/ygZYrfSXLLmtfVkzgIlxpBKPpGe6V5sicYryd1qVkWS+kNJ6olEkdM9c0BT53
         sCyRMCYTZADaCjHu/q7GzqdCwzl6dsT+QJi9i1dTw6mdlcYB56v/VnkHN2rA/hT1NaHN
         dQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fPDxcroJciIMsvfFT+WvfSSZGRz40ykKSUracXzD23Y=;
        b=QjgizwEqATFrG43PfMz1WHay62VIPuqK5TORdR0tcIlzw2BBXsYWLUeGHkRSKR3aJM
         y4zEUJTI3jud0kcOmDYAfjrNO2OEKDsyF/2VpiRRqT3d84SMRqu0QVrc19EK5ZQx+ZQT
         ueoN1h7M6sYP2M/aoR8OHJJpkVECGUIFSqlSW6yVYmOemu7+bqdh+lpKbdbPzBHw5k+C
         KjOiFFeD00Guq0SD2A7I4mMnZFIY7Mw+EZvlirNMFHkSjzPo0qpm+Uw2qxlmD2WZgl2x
         VJsne/FJYiP5GqNh9s2sLXEyL727trTbPp6ILoMsCCSF7T2U+ytAfHRryeV7JACl4T3X
         rvIw==
X-Gm-Message-State: ABuFfohxvxA8T+QD8k7xhfJ3hRVUZnMEjxu2Hw4ut0LGHRvbyopbquhz
        265oJWTs0DBQt280MEVcuxw=
X-Google-Smtp-Source: ACcGV63S61DkjUKnutYPOSb34zVjavbTjZzNkDDVOTY37UfcPpm6CDzvOmoTNoM1o2OLE3U0MnLZbw==
X-Received: by 2002:a5d:620b:: with SMTP id y11-v6mr4788024wru.105.1539340912279;
        Fri, 12 Oct 2018 03:41:52 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id a1-v6sm818238wrt.79.2018.10.12.03.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:41:51 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:41:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 14/24] pwm: jz4740: Drop dependency on MACH_INGENIC,
 use COMPILE_TEST
Message-ID: <20181012104150.GH9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-15-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-15-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:25PM +0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
>=20
> On other architectures, this driver can still be built, thanks to
> COMPILE_TEST. This is used by automated tools to find bugs, for
> instance.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: No change
>    =20
>      v7: No change
>=20
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAem4ACgkQ3SOs138+
s6G1TRAAux8060Bb39lvD0m2DyAcY+wj728JjVVoR4ewIrMKra16L/zRXspBZiK5
NE29yVOUrXx3h/C0/JD5zNTx7b6LajBoTYJ48FS2UVh3u04rky6MLHCyH97SnIA7
WKt+PWrDi5pXZ5ooh6tNURClbe5iETYuVjjXudUFjVtNC0ptAEaY9PvX7HrlcB0R
Eu1OUbp0k/RBhktlJJPkX/K/NqpBhncHo1GqHa2SRKf7+xkLia3V2SrszJC4q/g/
EtLjaOrsOjHkcolpePxX9Gc1V52Jpy6yDuB/TSmsAAkZGLbUBDZWh5VH21XJlbBZ
EDC28EJRnPDp3L6i9S2Kpy2anUNFblez+DAYY+takC3q/B+pKs/z4crRI9EwcVBA
AQFDwWbovRGB0Ery54rZSUYIOBKclO1hlBbMYROpd7bsadsA/PE4VtjGjrlkSJhz
GDF3anIdsvB5h23zZySwW3rOAKr8hGehlrWWu9tPCxacnKLZavMOHOThSDG2St9v
60glgFNZCH86gcJ47HOgg3pr+xejpvwF9s85dN378nNIqxiMEPiF6rrvELG+YzFp
Tv89gFw+06At4es9Gh+BlTqwYoiNGuIakwJHKoczVXCKxRThMiLkrjzhpomgh28y
x9DLbMSigzYstEPL1Q/VlRZGEYWRRa/vCWqu9Y0RMSSxnmMSLkc=
=ywfF
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
