Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5EFC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1497D20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XK6K+NRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1497D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJ2IAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 04:00:11 -0400
Received: from ozlabs.org ([203.11.71.1]:35033 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeJ2IAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 04:00:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42jtpL3WRfz9s9m;
        Mon, 29 Oct 2018 10:14:02 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540768443;
        bh=EMxqFVxLSv2ooNCoZjJuWSL741YPRDsbX35WKCu18tA=;
        h=Date:From:To:Cc:Subject:From;
        b=XK6K+NRNzvGo2ANFUBsJzljLrhnZv85zKXx4Sh0V3/fnMRVO/qKefmf5CEhf2bJTj
         spjXQOWXQEWHosIG/Thbu2Q429ZCyhjLUT8qnjjLJKiCQB4pg2ZUF8GqMASRT6K6MV
         aAveI3bHsT6CbramcfuXRldMB4nWjJyHgbj7Ea+AQ353jnGf1yz+NPj8wkGN3KG83w
         WVfHWRz+JQ/kXBcWKq89bTFZ4XQVEuh32LiMCrXkIFokRSu3OOn7kmDHSd7YqJyY4h
         Ge69EFoYFx4oukjOElVKdWxeq+327UnDhu+8rGViVMQo9o+0UTpYgyVtY2pLvBxeyh
         /j+q++hQivFHQ==
Date:   Mon, 29 Oct 2018 10:14:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20181029101401.5687153e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d9nsqprRH15JcB7tgCezAl2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d9nsqprRH15JcB7tgCezAl2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  include/linux/platform_data/gpio-omap.h

between commit:

  b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm instead")

from Linus' tree and commit:

  26683316c92a ("ARM: OMAP1: ams-delta-fiq: Use <linux/platform_data/gpio-o=
map.h>")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/platform_data/gpio-omap.h
index 8485c6a9a383,ed071f76b642..000000000000
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@@ -205,4 -206,18 +208,6 @@@ struct omap_gpio_platform_data=20
  	int (*get_context_loss_count)(struct device *dev);
  };
 =20
 -#if IS_BUILTIN(CONFIG_GPIO_OMAP)
 -extern void omap2_gpio_prepare_for_idle(int off_mode);
 -extern void omap2_gpio_resume_after_idle(void);
 -#else
 -static inline void omap2_gpio_prepare_for_idle(int off_mode)
 -{
 -}
 -
 -static inline void omap2_gpio_resume_after_idle(void)
 -{
 -}
 -#endif
+ #endif /* __ASSEMBLER__ */
+=20
  #endif

--Sig_/d9nsqprRH15JcB7tgCezAl2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvWQrkACgkQAVBC80lX
0Gx+3wf+JWhRFq0AfMargiT/sYDUVLQj/oHH2GezYMG/YNaQ51kzFdZVoghK5RSu
vscPIRjTO8KepO4KyV+WXAff2EyaJshEL+tX821be/XLiVoNewqkXKLlW7A+zV67
ZjIJeD5ZNACNNBPPJJ8d/SG7yGyYIuoJMGE5SyGCkKALGyzoHXusPh+HacBHWbpU
OZRYXlaRXl1hJL72UYj4ERqxDtMk5hUyyQd/C0WwGuxY/OzbsqQIM/P2YB8POTrR
ytvwCWEspxgrKdWgdGVG/6haTMXax3iZrdgMPm/GYWWu1AwZA+KEmilo4OQ9PrKQ
PrEGM5eqeQhEPQZuH6Q93FIr5YaZ8A==
=fs1j
-----END PGP SIGNATURE-----

--Sig_/d9nsqprRH15JcB7tgCezAl2--
