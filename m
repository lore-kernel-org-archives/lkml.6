Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E465C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650702086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVbPw3bA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650702086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeJLSMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:12:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51172 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJLSMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:12:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so11767035wmg.0;
        Fri, 12 Oct 2018 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wk+vNsLznpsQ2NbdI/5nVh3LcdRCwmJqVyrDgud0B9Q=;
        b=JVbPw3bAJh5hbOsWFNP0Ta/pfVsJuDaDQzvo4K9L8M7AUagC6TvYJ6cKVL4clxtp+a
         coOyullKRk1qoMbPqBd7rptTgRiOO9khNO39R73nGE+uJ9K99zjWqvs+BL7Wqkla8b/T
         XEMEU/rbsSTPkXIGI/qenefG+LRuOD9mXYsfEm0UjmiXGlBLTk9E2WC/hdIv0xDzZtOX
         GQuC7ZaRp9FhsqYVKxGlZTuYTb1rHRe0WooaBpBXVP59JpwR1vsV9l8y+tSbl7hryQOW
         0PgpRi93PDqjKlRok9Docoa6flHI7usUBqDMaE6Ah+RMOVvXyO322wPkZ3qmyc1zMoLV
         EQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wk+vNsLznpsQ2NbdI/5nVh3LcdRCwmJqVyrDgud0B9Q=;
        b=NYVenuUTgA6tp1vrN/W0NfoDEJzv8pk9R/GmjYhO2ATKiDmYnSdDH2nBRYgWRVvHCG
         RITW5ZEC8HHHDP0XYeQqQXewuYTWSVIPK6H4tY4+mtc9VTmGUeUOixER3pbo07tdP3qr
         vAj2hkF6wxo647R8E/TZADMaNJLhgLhb2WnSMUenfWI+TORd7+sKdX9WDGgiFTzuWyhG
         pMvskxtjWhdpv4omETeWBVZ/9fswoLhLHlvNjVWHJ/xtmJx1kNp5dFLUjIFA0Gc3VE5m
         okpNpyjMNszv6m01AblPpWReBK+nVWlTVIrmvso1cJatpwZOEg5dKAgcO0SaDjX792vv
         A7MA==
X-Gm-Message-State: ABuFfojy1UbLnjfp04j0QOUu7FFo+u0vz170lESSjnCWmmiskT5dQt3f
        +xwBimv+A0VhJeXmRE1ebmc=
X-Google-Smtp-Source: ACcGV62bp0wi0QYrsD9rhsK2/0pyaXXXT56A5UVO1KWQRvsnMhEbgK/JnzX4P273tjeDCXE1xGkwRw==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15-v6mr4786928wmb.1.1539340855134;
        Fri, 12 Oct 2018 03:40:55 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id m12sm886473wrx.75.2018.10.12.03.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:40:54 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:40:53 +0200
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
Subject: Re: [PATCH v7 13/24] pwm: jz4740: Allow selection of PWM channels 0
 and 1
Message-ID: <20181012104053.GG9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-14-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-14-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:24PM +0200, Paul Cercueil wrote:
> The TCU channels 0 and 1 were previously reserved for system tasks, and
> thus unavailable for PWM.
>=20
> This commit uses the newly introduced API functions of the ingenic-timer
> driver to request/release the TCU channels that should be used as PWM.
> This allows all the TCU channels to be used as PWM.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v6: New patch
>    =20
>      v7: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAejUACgkQ3SOs138+
s6FhYw/9FW8lZprZj6ntLye6m/IyGDHZalykPoLYefvS8bTuDn3qwMPId77gLA8m
t8XjWmPCnwAJlXJO6v4L9Ttix2VAGpApZ5fyIAK9pv9Q5XhwCVYVbgyrPOnz1at7
EsBxEwRNKMR79BkCA9JbT4eQy5tC/bpFadpItJxgRLyJAtTJX0kWa5piOvn3typ2
zPm3osA5C1Og8EIS8kk1SxlRP9+gOcollqUqkFDMsG+h82RAzWZqCMOU+c3kmyvr
v5EelQuSbw+H4Y6ZOZj6tEeIiyzUnedD07NbjRdkK33JUnE8xt33anbe5X/6P6e0
AhUlG4y8kqN0mxhkWgpgIrJh/VOEsjTj18gMCU4LFNBDzj1MLon0wukTaZ7mq4yg
lKMbQq0l+Il5Ii7JBKzz9LrbUzard4dVGDYQD2ChSQmLUTS5Yh0lAMzlYiIui+ja
/Hv5+KuxJnii1KcKenvxOgOlOyJMk6AmTfD57Wk/wM2wm3IotiV1TFhAUG8we//3
KAGPr83Uvpcx2oDhvcPplPK05TolV9W6b2QoxRaQfAcr4pEoSI3Fq7I4Mo1FvOT1
0k/zXI6YUADZY55+6B8b6oqMk+OM+lZxipHgtIQo3LmtI8JysGBzkpT+MTyQZSvI
/+neLH2EXccv9Ut5s5yYQw/uSq36oAO34Tu3zk+GsPx8XZB+Zqk=
=1+ye
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
