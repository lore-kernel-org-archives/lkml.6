Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B505CC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8289221479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZDXbqsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBKEqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 23:46:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36351 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBKEqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 23:46:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so4426340pgm.3;
        Sun, 10 Feb 2019 20:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TQaWtqfaua1Hjo0MyL7tHgbuxemTghT+fCzIyDHfzRw=;
        b=bZDXbqsLKn3mbNYHBviCP96zZCE/W7Wbkvw+1i+H2LuRozINF2omF33A6loxQufxht
         DI5Rop3UZrMFrDP78GzVmIzAsq3OTfA4M2vcRkcDWfx3tgy2VH0XnU1OveiK1tkqQNuS
         Q4+YIxI0H8UNJm4z7vjjI43mjEU6z6gcDnhgB6FysxstfudYK1MkVeYHPKz2jVjBpcKN
         eci0SQsy5KqcLjmcf4Yj+8NSGB89nr0WkX9s9mErR5Inqu2LBlhJRvOVmkpSTVZfmJms
         Qi5UtG+LdzRrbH7gwc7+sAoM15N1w4GgOzogtvqp0yIZDea14+QdjUWSLPUcUov7uqKR
         Up9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TQaWtqfaua1Hjo0MyL7tHgbuxemTghT+fCzIyDHfzRw=;
        b=V0AJqIuEFiRECXCklyD9SF3H8TMNMLONLUiq8+ZhQ1SNjBvw/WTPAw2eAIwjMjrUNa
         zfwTZtKKvPLIz40v1BEeERxB5DHgewW1mUefy7HzdnT0ZGBlE6yJLLht0b2sf44cocXw
         cIlR5gLO6migGQbc6GQTpXVvVDx7+2LgKmULvtKOIyjUxZfnTiI6X0f4umWaguWrlxOq
         8hJjJNjLIbZ77RDiY1b7DX2XKhBmul7puK099IApDjPCXJhwvlfk0r/X8tF2TlOouGHs
         pREjbjFgNJ+/9j2I7y9pVyAu5UT88NF3BYqsBH714ZEh4yBEXnTnIDyV6j59Io/IpPVp
         A+nw==
X-Gm-Message-State: AHQUAua3W20sc7Xv9QZj56oWwM14o7OkAakGqvwethVv86Fydq8ZZfL4
        uQrJ4n5IBionXyOo9EDM3IwCuahZ
X-Google-Smtp-Source: AHgI3IZtRKMDv9IlQ9nA92xLDcej9dhhYXm/I4yVK4FjcrUosqniiPAQdGZOAXRIABux7IbB2b2EKQ==
X-Received: by 2002:a63:5902:: with SMTP id n2mr21433740pgb.354.1549860379302;
        Sun, 10 Feb 2019 20:46:19 -0800 (PST)
Received: from localhost ([108.161.26.224])
        by smtp.gmail.com with ESMTPSA id t3sm13302137pfa.50.2019.02.10.20.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 20:46:18 -0800 (PST)
Date:   Sun, 10 Feb 2019 20:46:15 -0800
From:   Matt Turner <mattst88@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>, Meelis Roos <mroos@linux.ee>,
        Bob Tracy <rct@frus.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PULL] alpha.git
Message-ID: <20190211044615.GA30805@p50-ethernet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Linus,

Please pull a few changes for alpha, including a build fix, a fix for the Eiger
platform, and a fix for a tricky bug uncovered by the strace test suite that
has existed since at least 1997 (v2.1.32)!

Thanks,
Matt


The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

for you to fetch changes up to 491af60ffb848b59e82f7c9145833222e0bf27a5:

  alpha: fix page fault handling for r16-r18 targets (2019-02-10 20:42:23 -0800)

----------------------------------------------------------------
Bob Tracy (1):
      tools uapi: fix Alpha support

Meelis Roos (1):
      alpha: Fix Eiger NR_IRQS to 128

Sergei Trofimovich (1):
      alpha: fix page fault handling for r16-r18 targets

 arch/alpha/include/asm/irq.h         | 6 +++---
 arch/alpha/mm/fault.c                | 2 +-
 tools/include/uapi/asm/bitsperlong.h | 2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iNUEABYKAH0WIQSzlptPDvl9ch5jjr2cglpmBdQLvgUCXGD+FF8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjM5
NjlCNEYwRUY5N0Q3MjFFNjM4RUJEOUM4MjVBNjYwNUQ0MEJCRQAKCRCcglpmBdQL
vpblAQDdRyUGTMIZfZ+O5amIfyScCTqRakEu7WWpPrsDLFp0KAD7BAT+L63aYLKq
cV6/MO6IJjorFILxvulKs4iAj5E1ygM=
=0oVh
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
