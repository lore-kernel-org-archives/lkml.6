Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFF1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859CA20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOxeWw1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBFUHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:07:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBFUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:07:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so3582863pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fvoRjHtp2ZDx8AaDNNFo+8WaVqC9+LLb8UneKNHNkHM=;
        b=BOxeWw1p1GgzWwtCFbYjaAoQ/5jXx3RkyK4bwmRUHUhUjjsqXvQBHRpPWvmWZVNoXu
         W8jInisNOpivZToYUhtN/R4QMlpumYUviDMonmHgxdrMH97yjQY1cvPpgDt/Ok16EEgi
         cnxORZL20MxLgSAD7rDnEXJM0+unn8/UX3UyGJGcKk/JzGuTJXl/G10fUvaq459XNvgR
         fVp0lonj89puTr3yQhLDA1ROHJ4bs2FoL9rlMqoFlSuPPVCwZ8w7ix2Wl1dY4+vsQuDZ
         4b+8qq3MPvE/wWt1XLAK6qzsHGIcejJqesG37/+TpFAitEk1Qg8eVMc2HcExdoX5RQOr
         6xHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fvoRjHtp2ZDx8AaDNNFo+8WaVqC9+LLb8UneKNHNkHM=;
        b=GzUmuIUjF00I7tyJU1fMIINMFOhLQ8g8JiL6tLDT/2Lmn4i6eL1JgdjPA3sTdtzJo4
         0jPEBA8tCBWiKxvOOgNpi1aNg7HZMhzpNwnwoMsHfy+ozUA+5zdQwn2R9ssjKYcxQh9s
         uF/TSKcl1Tukl94WLTKYRbBNRqFtZJeRg4CBOxRYQJ+z4yEk/QO+DQhlWbBOXdEkO8+J
         eDOP56ajTyhajAB6j/rAjf+OVnnJKashcL1rd4jbAKFScdU7+/nmGXuHT4lFar0kcLgt
         3BuyQL8HYiYTkqbNdjCtBdrEnQhbB6/hHIQMNntEAh5lxu1EV8J1uvbnGlWSsqI36XDh
         DsuA==
X-Gm-Message-State: AHQUAuZr4RUSLt2wsE5tVzB4w2s3f7xKQh3/dV6rZHczwyte9XO75cKy
        g4XJgZFolUr0ZgCTygtMgmHXHw==
X-Google-Smtp-Source: AHgI3IbB54knvj2Et0TqJP9Jnx2CCXfpsf1ciVnNM+OlOjpQKNUDN1JhFR8J7ONx/AqQu2/HHwgJnw==
X-Received: by 2002:a63:2586:: with SMTP id l128mr11405333pgl.104.1549483652479;
        Wed, 06 Feb 2019 12:07:32 -0800 (PST)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id r80sm11941000pfa.111.2019.02.06.12.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 12:07:31 -0800 (PST)
Date:   Wed, 6 Feb 2019 12:07:29 -0800
From:   Benson Leung <bleung@google.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org
Subject: Re: [GIT PULL] Immutable branch between MFD and Platform due for the
 v5.1 merge window
Message-ID: <20190206200729.GB120245@google.com>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
 <20190201081938.GC783@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <20190201081938.GC783@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Fri, Feb 01, 2019 at 08:19:38AM +0000, Lee Jones wrote:
> Enjoy!
>=20
> The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602=
fd:
>=20
>   Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-platfo=
rm-v5.1
>=20
> for you to fetch changes up to fd68bd0f5d4c2090c95f84e27b05d0836bcd6c0c:
>=20
>   platform/chrome: cros_ec_lightbar: Instantiate only if the EC has a lig=
htbar (2019-02-01 08:09:27 +0000)
>=20

Looks good. Applied to chrome-platform-5.1.

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

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlxbPoEACgkQHwn1ewov
5lhfhBAAgr970Lx2BigblychrHK5A5dMXc+15IwUZ5xLQIVdxWWE5VSycGAW/yln
rO17OUD4RmO+lp/3vJAJ1MmvQ7jnmC2eUmyXbYIrhDXG+B/LFEvHfuDKYOTgipz3
ee1gGmn2beDjxBP6T4gx6UK1abDLH7ebhMHtRbr13UCFsO+A2O6qtwOB2X12OeRw
+Rkrc1Vdsp4KU7tkozBR3HlciZvU+9PLTB80dAvIdBzmCSG/Bj1T7oGG05HKdm/a
ZcMnKUYlEJtpXqtWtesRwdXNeCunxThyosHqO5ks5nxHOW5d9yo2q0KVFrQRZuXC
z6vztlavOpwHlwum0QOJC1IYbB4JhkQ/KASY4lecaT2358pbVC8SRNek1jf6kXaG
YaxioqrzsWO2kbYfUnUXciqCFoRmPO5rHsVn3cJKjgUkEdsv2pPN46cWA5KMlN44
22pwbNVf9KqohQZ9oDBcZT0YD/dtzaBef16beLrFJ69mMo6sdAW0SQ6ZnVIa3B+T
HwYZUr9FsfhIHkQVO7zZ/kRn70LqR001+BNqLztkfQZ3Xf6Z49xKl3dwyOLak/6z
Bg90NEUPsJeIp1u+0VlQFxdVcHP66a8OBeEQij3BNFWpSjo3tJMm/Rh+J1Mp7GvH
DaUy8UeUkbndzheIEb+4eV9brQKni/6V41QYQXQSibGDSWZjSnE=
=+cfB
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
