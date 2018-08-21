Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8772C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576F920C09
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="BQb4hI10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576F920C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeHUJuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:50:18 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55663 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:50:18 -0400
Received: by mail-wm0-f47.google.com with SMTP id f21-v6so1751781wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:to:cc:from:subject:openpgp:autocrypt:message-id:date
         :user-agent:mime-version;
        bh=7QhkcoqFnVdYgwWCkNu+bX3FTksDkl0Zik3UTDo3Nt0=;
        b=BQb4hI10uwx5CZAdhoJEdyDXjUjwLoHslulf0foB0ZiJfu9M8Bo8yv5MXldYCuswj+
         lnE6h9Oe/LPCbKlBtUesGHdhZIsnBGK5/mPcE44DgzJEvFMP6Ti1KS/JCYOMrCTgDoST
         J+GNhEKIpNFYVW7LqPE0nmCjNEHQujDcj7JlVhX6t5gNrFRiYEFem9SRHBV7I/GvPixi
         vuuiG6eneSZ9+ZYuF4//Ssgs3tEqzs2ah5C6TjeCLrM9wyZzWcPoPDMCRIGeatCr7eF5
         4mskqTrDLOvJcCL8yzoRtHgmuulp2E4d/WhJZTmsYv/C6S2/mKAtBXA9JWNeF6hYfqM4
         EF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:from:subject:openpgp:autocrypt
         :message-id:date:user-agent:mime-version;
        bh=7QhkcoqFnVdYgwWCkNu+bX3FTksDkl0Zik3UTDo3Nt0=;
        b=tbJ4s6fF8VUSRTJT+n80eIXsv7n2ncvPxr8rtR8ad8fZpzvdPezUG19UznWZ1lXjZL
         IC9cZ35rcQkYaBVDvuQxfY5GJfZcOsHKSeQyBGswOKxMTJ2J/qId0LF+tNlpG/kpgdpa
         J/YqeCTttdTKo1UxrQNwMzESXRfaVBR44k9sLYLTqPZu9nZQmif2wQF3XAjpA1zpzUoD
         Kar2J9S1Ex97W5BXwYz+vkedQAXbwLDu2W0nfSzI0pnEul3eQAZ1QVKkAD1UaoFJ+EzQ
         uIzZEVhFf8S/VNyACluybPFTU0C//moXo9QQhJiAuopp2m1rKzEHkEL1TudJuGcwxFyo
         RlvQ==
X-Gm-Message-State: AOUpUlFGV98q224VKYolN45pVUD7Oz97hwaHEqBdGiP8/AK3yy/jaQUf
        YoBfrJd/XHK/M+387mxHhnE8DJGGTgEU+w==
X-Google-Smtp-Source: AA+uWPxLjwlnSVrcjyFgAfvpoTCXsDR+qfJGjufgJNX359MIFb84CvCUwcprL4Rt4OnK0o764cO4CQ==
X-Received: by 2002:a1c:6d94:: with SMTP id b20-v6mr28059586wmi.28.1534833088192;
        Mon, 20 Aug 2018 23:31:28 -0700 (PDT)
Received: from [74.125.140.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id 204-v6sm3487833wmh.25.2018.08.20.23.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 23:31:27 -0700 (PDT)
Reply-To: monstr@monstr.eu
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.19-rc1
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <07a2d6dc-ac22-28b8-c8fa-75ddfa71ba4b@monstr.eu>
Date:   Tue, 21 Aug 2018 08:31:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pyFIbTHNm45fdMBgW6LwgAIwgJHQA3qn8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pyFIbTHNm45fdMBgW6LwgAIwgJHQA3qn8
Content-Type: multipart/mixed; boundary="4J6hy46X4OFm80UOOBeLI6O0BrgCbZP3X";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <07a2d6dc-ac22-28b8-c8fa-75ddfa71ba4b@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.19-rc1

--4J6hy46X4OFm80UOOBeLI6O0BrgCbZP3X
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

please pull the following patches to your tree.

Thanks,
Michal


The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb60=
63:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v4.19-rc1

for you to fetch changes up to c4347b05440f4d72f8084c82c86d16863f69c8a2:

  microblaze/PCI: Remove stale pcibios_align_resource() comment
(2018-08-21 08:23:30 +0200)

----------------------------------------------------------------
Microblaze patches for 4.19-rc1

- use generic noncoherent direct mapping
- use LDFLAGS instead of LD
- pci error path fix
- remove incorrect comments

----------------------------------------------------------------
Christoph Hellwig (2):
      microblaze: use generic dma_noncoherent_ops
      microblaze: remove consistent_sync and consistent_sync_page

Lorenzo Pieralisi (1):
      microblaze/PCI: Remove stale pcibios_align_resource() comment

Masahiro Yamada (2):
      microblaze: add endianness options to LDFLAGS instead of LD
      microblaze: delete wrong comment about machine_early_init

Nicholas Mc Guire (1):
      microblaze: warn if of_iomap() failed

 arch/microblaze/Kconfig                   |   4 ++++
 arch/microblaze/Makefile                  |   4 ++--
 arch/microblaze/include/asm/Kbuild        |   1 +
 arch/microblaze/include/asm/dma-mapping.h |  28
----------------------------
 arch/microblaze/include/asm/pgtable.h     |   5 -----
 arch/microblaze/kernel/dma.c              | 144
++++++++++++-------------------------------------------------------------=
-----------------------------------------------------------------------
 arch/microblaze/kernel/head.S             |   5 -----
 arch/microblaze/mm/consistent.c           |  54
+++++-------------------------------------------------
 arch/microblaze/pci/pci-common.c          |  13 -------------
 arch/microblaze/pci/xilinx_pci.c          |   1 +
 10 files changed, 25 insertions(+), 234 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/dma-mapping.h

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--4J6hy46X4OFm80UOOBeLI6O0BrgCbZP3X--

--pyFIbTHNm45fdMBgW6LwgAIwgJHQA3qn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlt7sbsACgkQykllyylKDCETAwCgjkNKqF3j5QgZMBsCrJnM+YE8
IJ4AoIgF0FaQTOfUtZ9SMzZcKY5U9k3y
=YSsq
-----END PGP SIGNATURE-----

--pyFIbTHNm45fdMBgW6LwgAIwgJHQA3qn8--
