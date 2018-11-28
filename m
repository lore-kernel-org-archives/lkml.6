Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F723C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD842086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt1cgnh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD842086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeK2GvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:51:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34728 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbeK2GvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:51:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so27583893wrw.1;
        Wed, 28 Nov 2018 11:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rm+3IFMRZZUjNCit1zkPfdGXuetxBmlWPZQyJ1wRWHk=;
        b=Qt1cgnh4OR97x39+ajm5+RuQyODgllRU18xuQc2dhZi3O9n2RQPhxYN1hf9j4+ppKJ
         llysWR8ccAFQycOQaqcV/ytaTVwxgq5eYcNxgt6ioIcUSitwRx7idACSDXslM87zzA7T
         fM02fQR+e1GO+Sji5Qxdf9MXOPVo1DCp0SWwi6p4DJQu5lD0x7xlymemdyo/HyrNhqNd
         ffhCweTpOkP0PAUhzwQF7yqA54ACP18Q4VwcL7qvWrHnlH6p5GJuN3jYXLQR4IYZZsVC
         NGmErfu1vKi04rzPLoIjRihtcrFrAFENxxHNMiIWVMt3SAKlWllq0AbW4Hdg+P8ZdR8A
         4XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rm+3IFMRZZUjNCit1zkPfdGXuetxBmlWPZQyJ1wRWHk=;
        b=YCePOqlnHjjJwTqyT24ban/l6EODdCDtEtrUknUFoLz+kKQGuYJRJzPYiN1O63Gskj
         tHUuHAOk/0Icyz/oQE8/uDJgZNKAMUbKzDysFOpdfZtazU+gJACm2HQwXaATUjuoarRQ
         sPa7rM8AsFoqMhtqKe+X8CzKKm1EIv2UE7Tug2An+5jV/wrZL4nsBPaL4TAVXHhIOFKf
         ba0qWwZbs2mbDbnAeir0eU9gnGuXQdu7NUNxeHEeWNP6cqg/iIhHWfpBTP3i+TShQCxk
         WLs4ULCWx83GLV/bzYRew+dp4/7v5HxhyS5raF1sAEzUsg9qCLibkIGZ7M9QMgV2dwgz
         jmbw==
X-Gm-Message-State: AA+aEWZGAL3zao73yPRqethQbsb1deiNY0if7UV/dL7+vgeFfsp93FJB
        lN5P/yhQ/zFKKnrrr2felj4=
X-Google-Smtp-Source: AFSGD/UkCUiUlMj89XMEIAdOCsfIzCvCoT0snDcdG9zlSLETYLxK7yZbH2UjX1nbbNagc8klFC/6oQ==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr7415172wrv.188.1543434498134;
        Wed, 28 Nov 2018 11:48:18 -0800 (PST)
Received: from localhost (p200300E41F128C00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f12:8c00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id m80sm3996503wmd.35.2018.11.28.11.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 11:48:17 -0800 (PST)
Date:   Wed, 28 Nov 2018 20:48:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v4 18/21] rtc: tegra: Switch to use %ptR
Message-ID: <20181128194825.GA23039@mithrandir>
References: <20181128190537.14074-1-andriy.shevchenko@linux.intel.com>
 <20181128190537.14074-19-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20181128190537.14074-19-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 09:05:34PM +0200, Andy Shevchenko wrote:
> Use %ptR instead of open coded variant to print content of
> struct rtc_time in human readable format.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/rtc/rtc-tegra.c | 30 +++---------------------------
>  1 file changed, 3 insertions(+), 27 deletions(-)

This changes the format of the date and time, but I think it's better to
have the standard format than the existing one. Also, the time is only
printed in debug messages, so nobody should be relying on that specific
format anyway.

Acked-by: Thierry Reding <treding@nvidia.com>

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+8P4ACgkQ3SOs138+
s6HFqBAAuEVQizdaCbOGmTPoYqQEpRPkzsPDyjvKzfCMKI3voJHl6JhT+6IlN8kq
Q5m/9IoxRSPmmaDa5LSDeWczgZttUe9nHNkMlgDYJmETEy2ydp5N8faX6XuL73b6
CivJfiRIfmRWt0n79stFvTqyZYJllIyIzonj0WjflH0QVXww1mk0XoNiXxOszcsP
D64f2RpdWnTSoULJ+EJlRWuNP8k8K/opFrDGTVsE0vUcsHoklJ0rz230+1FjPzQI
ZwqJKMWYBeh3R0oPbIdq6GXQsMQDNvI414FDuu1gfYhXSIwAmn7G3csk8TpY4K1Z
/Lhi37dz/uOVRhqlYchwhQasbjoioNR4pm9tEAswmAqCuOnBmVz/+sFtJ1Kp3Y0E
1F429hjJNIV96V6Z30a1cb82m3g3RndDqvYEN7J/TQvT1eXEsISsOMecU0PGgYAS
RDIYRxjNQfYAAmqYTAmH/Yabpl8/uGb4hX/hl9JoO05TMf1rM5pvzqXBeiu7wwvc
aRtZCbyaoO5eyIze+AJaI6f4Uzxfvemd2eWABtaZTPfJIvTn8wMujnIWu/f6JQIT
Sgx5RSGoSUqNQbieqmxHTWngNhEjJ24btSZ08LGQjoYYLHFY/yxyT3cjwmM7hJfA
eUoSD+YQj2QDM/zUSjT1VxCOQKiROkU4gMqWYJ1Osbe+zn27PrU=
=KJfS
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
