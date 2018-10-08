Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6033C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5352D20834
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dLQwR3+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5352D20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJHKPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:15:53 -0400
Received: from ozlabs.org ([203.11.71.1]:44765 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHKPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 06:15:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T4y64cM5z9sCV;
        Mon,  8 Oct 2018 14:06:22 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538967982;
        bh=HKQGBz+jOQBRGFxjxHTsarh7LoogVnytYyIT2/3aXhQ=;
        h=Date:From:To:Cc:Subject:From;
        b=dLQwR3+dvhP7+AN2vC1PgHz8LORdF573aaJKn2gNIT2NMNDepBBmvLvUYIH590QxR
         ETOpP641nZhFBRw8JEEwXeuhy2RGjWrrX40cUcXSyNSN7jDYrs8O7fRgLo1AAKRUDS
         /jQtZ1U9Hxg6pD9ElAXZ9uefAp2BtOGd9l4zjVyM8SbPqAdIBEuG9D6WgT8/xmXra+
         e9HbE9OI4TnfyELLlr9VAe9znElRKb01PlbiO5e44VD80DsTxFX6KJVu2l6zGWHj7e
         FGP72enkPmCfzJhPSTxW1zID5JBfaqJQDHIvuIFNL+ihdsNxCAmIveNSbWFxsC1Y/f
         64U8suZ78ANSw==
Date:   Mon, 8 Oct 2018 14:06:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: linux-next: build failure after merge of the irqchip tree
Message-ID: <20181008140621.3c5e5c93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w2NLYbw_8geH6UWII=jnrYi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w2NLYbw_8geH6UWII=jnrYi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marc,

After merging the irqchip tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from drivers/irqchip/irq-madera.c:21:
include/linux/irqchip/irq-madera.h: In function 'madera_get_irq_mapping':
include/linux/irqchip/irq-madera.h:99:37: error: 'struct madera' has no mem=
ber named 'irq_data'; did you mean 'irq_dev'?
  return regmap_irq_get_virq(madera->irq_data, irq);
                                     ^~~~~~~~
                                     irq_dev
drivers/irqchip/irq-madera.c: In function 'madera_irq_probe':
drivers/irqchip/irq-madera.c:217:34: error: 'struct madera' has no member n=
amed 'irq_data'; did you mean 'irq_dev'?
       &madera_irq_chip, &madera->irq_data);
                                  ^~~~~~~~
                                  irq_dev
drivers/irqchip/irq-madera.c: In function 'madera_irq_remove':
drivers/irqchip/irq-madera.c:238:43: error: 'struct madera' has no member n=
amed 'irq_data'; did you mean 'irq_dev'?
  regmap_del_irq_chip(madera->irq, madera->irq_data);
                                           ^~~~~~~~
                                           irq_dev

Caused by commit

  b817ff5c9509 ("irqchip: Add driver for Cirrus Logic Madera codecs")

I have used the irqchip tree from next-20181005 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/w2NLYbw_8geH6UWII=jnrYi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu6ya0ACgkQAVBC80lX
0GwXMAgAloRbbdGQEVhzl7uEaRPp75ftvZV9P56kNUMbdDPf/BgCc8wyoqmv9BwD
m5RRVJJ9Nc2uCccHG0JLpCMQ9DJgg9EKkhapdc6by16SivG3o9ZJRBUoRAYAWiNb
xxe0zz7zIPwaYVPy3UAgZnECiT0UjRQqUjT0GdDKi0yQXIMqEEr2yOEa0BHxh90p
5GgibkUNLnci5ZRLTePUgwjaXQcSkeRFK1bl/g+SsO2pmmAXnA5rbVEk07NfRFUJ
SBHYDYM2VvvEOOYXE/Z9Y8V7kJyQAnc0/eEvWlA9OeoDBTGkO9YzS54aQBookTk9
B2Fs/McQf7yEmNjFZXlU/Lnj+miurQ==
=CtKm
-----END PGP SIGNATURE-----

--Sig_/w2NLYbw_8geH6UWII=jnrYi--
