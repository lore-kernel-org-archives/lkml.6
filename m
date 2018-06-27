Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DCCC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B1D263C6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="OEEfFX+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B1D263C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeF0Fbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:31:36 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:45029 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeF0Fbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:31:34 -0400
Received: by mail-wr0-f176.google.com with SMTP id p12-v6so610780wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:to:cc:from:subject:openpgp:autocrypt:message-id:date
         :user-agent:mime-version;
        bh=aeFWcPdy85ztmApKt1RP8V7p6IqoquD4KtQ5hH2MDQo=;
        b=OEEfFX+ZrebW6CBNQkqStS83/ETrihNho0ShC2Zrm9ZzjwtuuLjIv0XExaXIMx3irj
         FlpetHwM+EbJDohYZ4xTmghIq0lhluc9ZDclsliCk1AkIMzNXI12dwZ38GmNKY26CVqE
         58X/agHzjy7IFoE+395um1RWwM0HX9Boly//WtT0EvIWCjsWvNqXFRTWuMgx70tlhs6A
         zN9/E97vGya1jBku0qC6Tnz8sTgV7eobyUzEhXx3FiyiBkuYTGkg9ngRQ1Ps+LpbRor5
         Sa+37MR7fmD9cygYN3QCXaatW72eEqWe462Qa2SCAXvItoa12fvuB75VF+2a+FY0uu4K
         bg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:from:subject:openpgp:autocrypt
         :message-id:date:user-agent:mime-version;
        bh=aeFWcPdy85ztmApKt1RP8V7p6IqoquD4KtQ5hH2MDQo=;
        b=tNUxomenggDRnfwfD8wcyCdksvCBEWV2KmUSJNcs+v0Jq7FMn5/8pBfJvVrAXCbghN
         rK5z6T69wltPtP9Fdbgbg5TnbMTyoBZEXb/FViwoug6U8eYcorx0A310AT3x9zlD0b7b
         nX45/HBROnhln6jbdqwiTKNJEuwg1cw54J5TJWgUMSaeSBk6s1QYaFrecosb/X+OXBit
         s0NJ/CGKhlVr8I41Ng7CQg6QcGeu/rGKY3UlrBXgxGsHLXJCBqS9NZlOSYHpl6kfB0tN
         /m2QZkqm5H1UBNK5l8x5xw1h+nQPBGWY0Pgm/IbdDmsgZr6tRKbeWmJsAzUtJ2sFxDcE
         Qshg==
X-Gm-Message-State: APt69E1DlZm9MPPTJYjrkxIgaUe5qwBl+12FMjA97KjejmtdelEmbn96
        sqAEuKJdNPd6uWdonl0kLOOybg==
X-Google-Smtp-Source: AAOMgpePFtU4pjIAP8DKNfeqU03rRsxqEB75b8t6JqNeTL5nNhNq4bSIrec74Xz272Q/CCp0anf5oA==
X-Received: by 2002:adf:abf7:: with SMTP id s110-v6mr3886145wrc.101.1530077492860;
        Tue, 26 Jun 2018 22:31:32 -0700 (PDT)
Received: from [173.194.76.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id j131-v6sm5090794wmg.24.2018.06.26.22.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 22:31:31 -0700 (PDT)
Reply-To: monstr@monstr.eu
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.18-rc3
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <9f2a1244-d2ac-21d2-e2f0-8db8dd754971@monstr.eu>
Date:   Wed, 27 Jun 2018 07:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UnEx7kq3WGcwiMke4nvqkECEl4AxeFyLb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UnEx7kq3WGcwiMke4nvqkECEl4AxeFyLb
Content-Type: multipart/mixed; boundary="wum7u4mwabFm0tJ12EDsJ2xGRClNGLRXm";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
Message-ID: <9f2a1244-d2ac-21d2-e2f0-8db8dd754971@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.18-rc3

--wum7u4mwabFm0tJ12EDsJ2xGRClNGLRXm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull the following patches to your tree.

Thanks,
Michal


The following changes since commit f0dc7f9c6dd99891611fca5849cbc4c6965b69=
0e:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
(2018-06-10 19:25:23 -0700)

are available in the git repository at:


  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v4.18-rc3

for you to fetch changes up to 45df561a7ae2ca5080708cc2cf84a236f4d930ef:

  microblaze: consolidate GPIO reset handling (2018-06-21 13:57:39 +0200)=


----------------------------------------------------------------
Microblaze patches for 4.18-rc3

- Fix architecture gpio heart beat code
- Add new syscalls
- Remove unused xlnx,compound handling
- Remove platform.c

----------------------------------------------------------------
Michal Simek (2):
      microblaze: Remove architecture heart beat code
      microblaze: Add new syscalls io_pgetevents and rseq

Rob Herring (3):
      microblaze: heartbeat: fix missing prom.h include
      microblaze: remove unecessary of_platform_bus_probe call
      microblaze: consolidate GPIO reset handling

 arch/microblaze/Kconfig.debug             |  7 -------
 arch/microblaze/include/asm/setup.h       |  5 -----
 arch/microblaze/include/asm/unistd.h      |  2 +-
 arch/microblaze/include/uapi/asm/unistd.h |  2 ++
 arch/microblaze/kernel/Makefile           |  4 +---
 arch/microblaze/kernel/heartbeat.c        | 72
------------------------------------------------------------------------
 arch/microblaze/kernel/platform.c         | 29
-----------------------------
 arch/microblaze/kernel/reset.c            | 11 ++++++-----
 arch/microblaze/kernel/syscall_table.S    |  2 ++
 arch/microblaze/kernel/timer.c            |  7 -------
 10 files changed, 12 insertions(+), 129 deletions(-)
 delete mode 100644 arch/microblaze/kernel/heartbeat.c
 delete mode 100644 arch/microblaze/kernel/platform.c


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--wum7u4mwabFm0tJ12EDsJ2xGRClNGLRXm--

--UnEx7kq3WGcwiMke4nvqkECEl4AxeFyLb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlszIS4ACgkQykllyylKDCHsVQCgjI+510tMEUKwtWLjJI0d3rCL
Ze0An22gOsnoCyAxHsQA8ck36qolSnFo
=5/5t
-----END PGP SIGNATURE-----

--UnEx7kq3WGcwiMke4nvqkECEl4AxeFyLb--
