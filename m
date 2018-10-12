Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D8FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF952086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbLQCpBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF952086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeJLSPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:15:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:15:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id g15-v6so12901362wru.9;
        Fri, 12 Oct 2018 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+MvIpKzcTAhwZa+2gA4ijL4Bg+X482ReRYyrDcy6zTw=;
        b=bbLQCpBX/Ce3u/WyUZRtcrafmQ5FCpl3hL8YaIR5JwXgNxqkRKMA8AyssokuqUL+m2
         a2SuxgSTyusKaW/q2gjACYvIF3eFb7ZfgaFSUiWpT35RRyBMb9DJua3p0VKO4fV7GRtk
         P5wgr11FZvE8qGLcmZgKnZWQ1j+RO6goIEe85pa9BOGI8+JyEvYXcBziVaKyX02bV6kt
         DBRpF9tVyaWMubz0Rxlm9jdrvWsvkV6VGv59KmtFr/y3cMZU5BLsZm66pfHsAWYDh9bE
         GR+1zbpZ38Si6Du6AWDqWw0ag//Ga+ToxYg6gZgetEASn+bTzM00QRjHwAXlaPFbB6si
         U9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+MvIpKzcTAhwZa+2gA4ijL4Bg+X482ReRYyrDcy6zTw=;
        b=gkXaSzf3nA0TEQ12hsSHfY7kRUcCFwYCnt3yJ5grsVIb6Os/9frcHlFZRsxGXmJHfP
         L/GtdQJVsLXxRq3tWG5vF0ptKpfHACI1mCYFtVMJnuhL5VCRP+mim1Z7eIqbsgI1MSeV
         DpvNIQA+hQv6yoX3MAOaeUoccbFL/q00gOGwAYBySLWLUncGjcp/I9HyI5pgEZKA5Mxa
         7rYR4ko699yHUqvWOBOPkJVs4jsP4TbN/JOtclSxLgebUh0Rqcwz4Nj4PFATaurF+p9O
         k8WnVn6deartKwhNBx0nzQI1B33hD5VHCQi3wIv+6KRmMB0NO2zJIsZiiUogHeSJeLbB
         +Ghg==
X-Gm-Message-State: ABuFfoiMcPLWUOkhYbqfmYYAm/S57RU4u7cowWn0qREQwzBSflTDs0QG
        oNpt0+aqDM/qpkD38/TZ4yM=
X-Google-Smtp-Source: ACcGV63yYY1cBT/RQapQt8J9P8I3lr83iCHHozSQXWYMa3eiJMvvxEAwuWYXqJ0hN6BFdBWN0cB4EQ==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18-v6mr5247537wru.80.1539340993866;
        Fri, 12 Oct 2018 03:43:13 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id v76-v6sm1236456wmd.32.2018.10.12.03.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:43:13 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:43:12 +0200
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
Subject: Re: [PATCH v7 16/24] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20181012104312.GJ9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-17-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-17-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:27PM +0200, Paul Cercueil wrote:
> The PWM in the JZ4725B works the same as in the JZ4740, except that it
> only has 6 channels available instead of 8.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: - Move of_device_id structure back at the bottom (less noise in
>            patch)
>          - Use device_get_match_data() instead of of_* variant
>    =20
>      v7: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAesAACgkQ3SOs138+
s6FK7g//XMqm9tY/j9ebBHkmvyejEcCSzNYK6TscB0/JcxIikY5BBEPT3Zu4yk5K
jvy11nwiuGXxqeoCCvrprgWlMskRbB0vfjaXbkbium0WtcDWECGAD2q0PQ61wT2Q
HwtIecyTHVHp5vTht3FuqhRW/ISdQo/h4aN54HiX3GTvFEPXIobrW/52smXWIGLw
BBE0fz2a94H3zVewmeiqwzViQAfBTT3FqKl13AH0iAfmfT3mjgxsPgnnCGmQo9gc
zt8cvqS9LAPy1cw07bFfiyPGVn3DL4KhlybPi2NTOn+zGKIMJeza0iYKpyh/PcGX
xMgk1VSLKNFQTITXllRnw69ad9QfW2hs3kHqy1W3oTaQe7VmXuUAS0LlFkX4WRG7
vhnwdCZVlGjpdzmt9IduRBUBhZuTkqNLdzF4WhoeQjEeohvmmvKFGjy5OwMw0F9Y
pDYjp0bfECwQNKynPVF+pPSw7B3nh1D97o5VGZGILYXYFIE5MlKOXqMVXpSd2HIj
NmjziYKpPZk6auyQlbdsijlZ/jra0RYGvLdi8bWBJVbpo4IqC9iFjtC4/9vJ0m+R
YLwQlJoZGqRKCVpwdQKDEEBx+4bQxdQcQJZrYueZXMCRIimzWC2H2cmxKpRWdjqw
mokR4lpnDhHpADP3A7wPVKCvMoJn39U1saRvscYMRxkH8cV1J9g=
=OX+r
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--
