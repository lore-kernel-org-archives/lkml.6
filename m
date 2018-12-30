Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698CCC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 22:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301782081B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 22:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZEE28aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeL3WZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 17:25:26 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33911 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeL3WZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 17:25:25 -0500
Received: by mail-yw1-f67.google.com with SMTP id g75so10107629ywb.1;
        Sun, 30 Dec 2018 14:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5cKcfmJ20UK9CCVQ6E8lFHgopqsdOf7qXHzuf3MsKjk=;
        b=jZEE28awEXDEvvpl8+leq1fJV+YHYN+R3jqU2090Gj1Bu00rX940TaRqa1JUkynXk+
         o3772XeIf8ZsQJ732+Hiu+ooW8U24zUJoNcpAhf9K1nnSIxK26wzGYekpJPQjMlRhhKv
         3S5Tlzts4uNfhi13E9ZPwuGGO2KGPqTvhV2M7EJcFGtUdoBWswPc1LhN1IAC27MFFHTV
         tr9cxVBF4W10HZB7IxNOpn4Cz3KDL6Io80IK9xwlhVZcSfVGlwcngLJqTT1p9ryRktGo
         rKYBthb28XrlhNHaOks2lV6FqF/I4LNzuYbIDvWThEz/4MTCTRnmKWR31sB2OIYRVlxS
         GAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5cKcfmJ20UK9CCVQ6E8lFHgopqsdOf7qXHzuf3MsKjk=;
        b=MTX6kDX7FocJURJ7c5JJXCWHhn60hditQaDRQZGJoP10KMis5lCA1wCQEvAEXd+w7e
         q0wq9pFYdzetSZWmEm1+WwyK9QN02jJDsID+zvOSEi4OVDK7NwmMlWthwNpUuE4TzLIN
         J27g+DVh3DBqtwqLwB1PebjhyH3QlHYhU0OTKSXdtcC4bR2py16cHRn6Is5klB1dk3y9
         A7z5+nHFqQ+FHqbgJZGKm60wEYbFBG1aKryBNlvb+fjB2kwkGgJXB99vaYTRFiMV3VKj
         s3Nz6XacU9vHmOeve9gQLDBzt7pgeo/CThnVqDF3uosrVr5Tqplj1aEbrKENecMqlcCk
         ykHg==
X-Gm-Message-State: AA+aEWZy3k5+3PoMbAt2e8pFnGuAA5+JleiIMzaS4nPcgayqTPNUp7wQ
        wdnzuNN415O3ccis/AhlcTY=
X-Google-Smtp-Source: AFSGD/XkAKDmOajmthMnA45m8yLyt1A8Dne+V4DFTIC06A/zf1xtnhhaW0bkgULBZA5RZCexdjzjjw==
X-Received: by 2002:a81:7051:: with SMTP id l78mr34969178ywc.146.1546208724322;
        Sun, 30 Dec 2018 14:25:24 -0800 (PST)
Received: from localhost (208-104-164-138.rh4.cm.dyn.comporium.net. [208.104.164.138])
        by smtp.gmail.com with ESMTPSA id g7sm12718810ywe.16.2018.12.30.14.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 14:25:23 -0800 (PST)
Date:   Sun, 30 Dec 2018 17:25:19 -0500
From:   Matt Turner <mattst88@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PULL] alpha.git
Message-ID: <20181230222519.GA4195@p50>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Linus,

Please pull a few small changes for alpha as well as the new system call table
generation support from Firoz Khan.

Thanks,
Matt


The following changes since commit 9097a058d49e049925d8da72db07fffcee24efa0:

  Merge branch 'i2c/for-current' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2018-12-20 14:49:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

for you to fetch changes up to 1c3243f61fa7daea78de9866af2625f559ebf456:

  alpha: Remove some unused variables (2018-12-21 16:02:03 -0500)

----------------------------------------------------------------
Alexandre Belloni (1):
      alpha: rtc: simplify alpha_rtc_init

Colin Ian King (1):
      alpha: fix spelling mistake QSD_PORT_ACTUVE -> QSD_PORT_ACTIVE

Daniel Bristot de Oliveira (1):
      alpha: Fix a typo on ptrace.h

Firoz Khan (5):
      alpha: move __IGNORE* entries to non uapi header
      alpha: remove CONFIG_OSF4_COMPAT flag from syscall table
      alpha: add __NR_syscalls along with NR_SYSCALLS
      alpha: add system call table generation support
      alpha: generate uapi header and syscall table header files

Matt Turner (1):
      alpha: Remove some unused variables

 arch/alpha/Makefile                      |   3 +
 arch/alpha/include/asm/Kbuild            |   2 +-
 arch/alpha/include/asm/unistd.h          |  23 +-
 arch/alpha/include/uapi/asm/Kbuild       |   1 +
 arch/alpha/include/uapi/asm/ptrace.h     |   2 +-
 arch/alpha/include/uapi/asm/unistd.h     | 484 +--------------------------
 arch/alpha/kernel/core_wildfire.c        |   2 +-
 arch/alpha/kernel/osf_sys.c              |  12 +-
 arch/alpha/kernel/rtc.c                  |  22 +-
 arch/alpha/kernel/syscalls/Makefile      |  38 +++
 arch/alpha/kernel/syscalls/syscall.tbl   | 453 ++++++++++++++++++++++++++
 arch/alpha/kernel/syscalls/syscallhdr.sh |  36 ++
 arch/alpha/kernel/syscalls/syscalltbl.sh |  32 ++
 arch/alpha/kernel/systbls.S              | 542 +------------------------------
 14 files changed, 609 insertions(+), 1043 deletions(-)
 create mode 100644 arch/alpha/kernel/syscalls/Makefile
 create mode 100644 arch/alpha/kernel/syscalls/syscall.tbl
 create mode 100644 arch/alpha/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iNUEABYKAH0WIQSzlptPDvl9ch5jjr2cglpmBdQLvgUCXClFz18UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjM5
NjlCNEYwRUY5N0Q3MjFFNjM4RUJEOUM4MjVBNjYwNUQ0MEJCRQAKCRCcglpmBdQL
voRIAQCKGxM8wqW+zJQi1JX6N2jNEhP2fPh4Nekf5rtwheTBdAD/ZIszO3xxsqzb
khElq4SeErcRxYtJFZAXwAM2YMOdrwU=
=xXfP
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
