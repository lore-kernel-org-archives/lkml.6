Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA7ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992EC20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ+jh3Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992EC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbeJYWzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:55:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38786 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeJYWzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:55:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id b14-v6so1726564wmj.3;
        Thu, 25 Oct 2018 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OJBZFWdtGWaTAWIHK6Fi7V0lNhnM4eYIPZfpG5ZDcmg=;
        b=hJ+jh3Pk6B9mZFplvxT8gFqB/zypLhBOoTA7A8njhFhBAh9P6dNwg5GKsOYtQPnk6c
         Ep9Os3mn1EGc9s4sqe3zsreTy7gQDNHk9KcrpU6uab/77vaDDcR2ppTxGiSGh/ya25TO
         +9sfA6L1epkIMcSsSA3Jlk2k0LCJhB0MsDTcqDKsbe/OIcytuMF10FReaS88gd+RWJNZ
         AnvEK2b/vDdT6e/TlSFx5wCsJFg3rVddc8GIObBIQfFC7VsBmxQAgqV0f7YhBdXedyHF
         dVq0/PQSpSJI2EuskMluAVziNyHehnltNpNMD2Nia2BaLU93Bk2fxsYB0xTTzMqK52Rv
         HuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OJBZFWdtGWaTAWIHK6Fi7V0lNhnM4eYIPZfpG5ZDcmg=;
        b=JrxbniscR3ArUQu+kvFK/usR0bnUXZKplRndN7GFC+vUxr14jLAgfV/Kop14poOYrH
         iytpC48aMzlIh3RwUBG8Gk+3D5neAFgMLYtgb5iBNBWzCMYzpa7XjtwgTP5AUWHWO3eq
         SbgXv15shXP59ddmqKZ8W1bQj7NmAi1y6EchcTpbS8kmxstmBhbyyHSPw8yr2ojxz3+2
         yePjpEe7jBx2VInAPxIY6G7oJQhs1iQ17lVvE+/06Dmhun4/gYIH09+GS8GAnnwxXiK3
         6VRvXw6mnC2AtwlXS2BGkGy68P82wWQWrJ71eL+IMI0+026FabpHnk9Q6FYVtyP1tTVt
         iy+w==
X-Gm-Message-State: AGRZ1gLKeBXgb5p+cV2Rsq72TZ58hFlREnZrpBa5SQy+68EqY24fKfoU
        tw7AosLtAW9hh9bpSVMM30vIqeQL
X-Google-Smtp-Source: AJdET5dZUmOHBQ3lwpLfDK8L19C6AyCaw6iGO0w0F73C9tM9g+UbMc6vvwdYpUuzxSr5YLViOhaLyg==
X-Received: by 2002:a1c:5e07:: with SMTP id s7-v6mr2039136wmb.91.1540477326409;
        Thu, 25 Oct 2018 07:22:06 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id b71-v6sm1898518wma.13.2018.10.25.07.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:22:05 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:22:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] soc/tegra: pmc: Drop locking from
 tegra_powergate_is_powered()
Message-ID: <20181025142204.GC21521@ulmo>
References: <20181021183614.454-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <20181021183614.454-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:36:14PM +0300, Dmitry Osipenko wrote:
> This fixes splats like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> and machine (Tegra30) booted with SMP=3Dn or all secondary CPU's are put
> offline. Locking isn't needed because it protects atomic operation.
>=20
> # echo 0 | tee /sys/devices/system/cpu/cpu[1-3]/online
>=20
> BUG: sleeping function called from invalid context at kernel/locking/mute=
x.c:254
> in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C        4.18.0-next-201=
80821-00180-gc3ebb6544e44-dirty #823
> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [<c01134f4>] (unwind_backtrace) from [<c010db2c>] (show_stack+0x20/0x24)
> [<c010db2c>] (show_stack) from [<c0bd0f3c>] (dump_stack+0x94/0xa8)
> [<c0bd0f3c>] (dump_stack) from [<c0151df8>] (___might_sleep+0x13c/0x174)
> [<c0151df8>] (___might_sleep) from [<c0151ea0>] (__might_sleep+0x70/0xa8)
> [<c0151ea0>] (__might_sleep) from [<c0bec2b8>] (mutex_lock+0x2c/0x70)
> [<c0bec2b8>] (mutex_lock) from [<c0589844>] (tegra_powergate_is_powered+0=
x44/0xa8)
> [<c0589844>] (tegra_powergate_is_powered) from [<c0581a60>] (tegra30_cpu_=
rail_off_ready+0x30/0x74)
> [<c0581a60>] (tegra30_cpu_rail_off_ready) from [<c0122244>] (tegra30_idle=
_lp2+0xa0/0x108)
> [<c0122244>] (tegra30_idle_lp2) from [<c0853438>] (cpuidle_enter_state+0x=
140/0x540)
> [<c0853438>] (cpuidle_enter_state) from [<c08538a4>] (cpuidle_enter+0x40/=
0x4c)
> [<c08538a4>] (cpuidle_enter) from [<c01595e0>] (call_cpuidle+0x30/0x48)
> [<c01595e0>] (call_cpuidle) from [<c01599f8>] (do_idle+0x238/0x28c)
> [<c01599f8>] (do_idle) from [<c0159d28>] (cpu_startup_entry+0x28/0x2c)
> [<c0159d28>] (cpu_startup_entry) from [<c0be76c8>] (rest_init+0xd8/0xdc)
> [<c0be76c8>] (rest_init) from [<c1200f50>] (start_kernel+0x41c/0x430)
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/pmc.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-4.21/soc, thanks.

Thierry

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR0YwACgkQ3SOs138+
s6HvdxAAwH2jMQXr+gO5iAE+91oNZuJDEj80IO96BcrdHX5Q79Noe8rtRvoBBzJM
tdMQfpsIP6BYxTYL4914Jxs2ComlkUDR2uww571Zk6XSrkJ5PqAkC6ZKp7HHCjwM
JVdvgEpyj5ZkLfryTscnZOWHPkS0VUzO5kSgIV4/pisbUvRKLaJaOWXQwXNfTBqn
PyM5x4PyWyHl1BkSXCbGt1uRtMzgP6lKgZWKHs3lIJ2Cz96ATEO6SnC2ednS4B9T
hi0amZnYZzbhO3FWjXriyID6JWKFRHx7CjKXszWeII4jcOrQVnHPb505V4agzCe8
2/+EZmaqq4HPIWEfnYaaNKJDUHLbG/2wFCRO92SZYb4QlidUY3VMZ8nOr0IpY6E2
+COrYt/vIlhsYEpjs2HfNDZ1Kf2aAG4vFmhNuxmZ9kxNFVTDEMytkdhgYe+IdwR8
7l7pY6HaxKK9Gwgc1qjuFrTlhnr97XS/omPQpKhFu2KSnoZFwrk2cAJS6e7dhPvV
cJLeOX4KINMHAB4YwD7MUgF8+K6qDnUW6UeEZZ+Kh/DMX0tiP14Ei59goQKiCRUl
N/GvxalY9llCNK+MyoC2xcc5T391dJF17JJ7+qfryZrqMp+kUfwnhYOofeOeJ5kA
QJ7leXiP+paX5NtbGH2g+tdrik+KgmuoE1Edc+Dp9gFbqzaNwcQ=
=q2/Z
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
