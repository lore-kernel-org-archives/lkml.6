Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pbbAMI8NGVvFdQAAmS7hNA
	; Thu, 07 Jun 2018 10:59:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4E7A5608C1; Thu,  7 Jun 2018 10:59:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="sMbBKVeh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3779360115;
	Thu,  7 Jun 2018 10:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3779360115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeFGK7q (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:59:46 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:41446 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932502AbeFGK7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:59:44 -0400
Received: by mail-wr0-f176.google.com with SMTP id h10-v6so9594801wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:to:cc:from:subject:openpgp:autocrypt:message-id:date
         :user-agent:mime-version;
        bh=Zuthas2uhb2dJseHjGySc9j4VoktOyI7B1hjknOvVZY=;
        b=sMbBKVehEkuerrRqyfCDxeCv7Soxf4HVHxgPFp9/KKtu5fUey6PN4KdwvjnZ0EPE29
         r+TMfB3D30for+e7JpMYuDkvea8wzapNPWQC0EasJIFTOUcI9Atz/kHgoIzgKbB8ncIn
         6hUam7EkPhsGtwA3ax8KE8Ea2PS+bsMSOEQhzhaaBO1U0o69JeuVV/CCPg9fGIp5EIoV
         dgk/QlYzed4rxo6csfGOGij20ysZ+tDO9Yz48nih4S+SbAhTQ2v/6atq5loNRh6mLlg2
         +eY/UBgiTeD6HJht7aorzPRo3GnipFzO1CJp8RXoNnNmB5kGa67ztzNcOpsL9OhviOXw
         1X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:from:subject:openpgp:autocrypt
         :message-id:date:user-agent:mime-version;
        bh=Zuthas2uhb2dJseHjGySc9j4VoktOyI7B1hjknOvVZY=;
        b=fZ+acYaMQZjSfsMD88mZZMOn/B+wk0QOzcgt5sD/dqJ4CptJSZG8Mvab6nuOD/r8xS
         MxG2KN5086cj36CsXr9osRxUeR7J59LD1wKKQUNkl7svZNoG2grjuoAR5ozjXT8AnC9U
         +tnW6/Z/5xD06NOLxY1jFMTw+LTWGrHnBcXiFkkXQ4i3DE1qqXuMKzhGnKuYdyyqvOdd
         DdQ3Tw2xDcEB4XHT7z9BBEKkEe4lMNRMj2ju1q+YlCBg9ntjeVBI/8zM+s3LPeHu/cf+
         Jgg6LgZLg6ep0PjsobzsrfXevAo88asdtaq32d7TxS+9/ES+huzraGDYPARzw9byn5Ek
         LJgw==
X-Gm-Message-State: APt69E35CAUw29DxXjLjQtpaxRWXOKE+gT4DVFisT1aA0dC9f7fMADwU
        tj9Z177bPCN2evE1KUn9k0EvzkI1
X-Google-Smtp-Source: ADUXVKKffN8EKIO6+CgvpqogJIPACMbeAiBiwCkWssPxSNsiiUVF/xsv6zjbqwYSqxYvHt2p/N94GQ==
X-Received: by 2002:a5d:408f:: with SMTP id o15-v6mr1167081wrp.133.1528369183225;
        Thu, 07 Jun 2018 03:59:43 -0700 (PDT)
Received: from [64.233.167.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id y186-v6sm2243179wmd.38.2018.06.07.03.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 03:59:42 -0700 (PDT)
Reply-To: monstr@monstr.eu
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.18-rc1
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <8775f7f3-6fe7-3726-27dc-da650916442f@monstr.eu>
Date: Thu, 7 Jun 2018 12:59:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HWO9sRxYGWOFUd6fj06WDIJ0qEtyW3na2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HWO9sRxYGWOFUd6fj06WDIJ0qEtyW3na2
Content-Type: multipart/mixed; boundary="OImUsn1gaJ0n0wqwYF2EOPqMQyx3c7eZu";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <8775f7f3-6fe7-3726-27dc-da650916442f@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.18-rc1

--OImUsn1gaJ0n0wqwYF2EOPqMQyx3c7eZu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

please pull the following patches to your tree.

Thanks,
Michal


The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd7=
1e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v4.18-rc1

for you to fetch changes up to a7a9e2f0410ddf9ec7491fca0c91fcb4c5c30cbb:

  microblaze: dts: replace 'linux,stdout-path' with 'stdout-path'
(2018-04-23 12:49:01 +0200)

----------------------------------------------------------------
Microblaze patches for 4.18-rc1

- Fix simpleImage format generation
- Remove earlyprintk support and replace it by earlycon

----------------------------------------------------------------
Michal Simek (1):
      microblaze: Fix simpleImage format generation

Rob Herring (3):
      microblaze: remove unnecessary prom.h includes
      microblaze: remove redundant early_printk support
      microblaze: dts: replace 'linux,stdout-path' with 'stdout-path'

 arch/microblaze/Kconfig.debug         |   8 --------
 arch/microblaze/boot/Makefile         |  10 ++++++----
 arch/microblaze/boot/dts/system.dts   |   2 +-
 arch/microblaze/include/asm/cpuinfo.h |   2 +-
 arch/microblaze/include/asm/pci.h     |   1 -
 arch/microblaze/include/asm/prom.h    |  27 -------------------------
 arch/microblaze/include/asm/setup.h   |   5 -----
 arch/microblaze/kernel/Makefile       |   1 -
 arch/microblaze/kernel/early_printk.c | 184
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
---------------------
 arch/microblaze/kernel/misc.S         |  35
--------------------------------
 arch/microblaze/kernel/platform.c     |   1 -
 arch/microblaze/kernel/prom.c         |  82
-------------------------------------------------------------------------=
-
 arch/microblaze/kernel/setup.c        |  17 ++++------------
 arch/microblaze/pci/indirect_pci.c    |   1 -
 14 files changed, 12 insertions(+), 364 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/prom.h
 delete mode 100644 arch/microblaze/kernel/early_printk.c


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--OImUsn1gaJ0n0wqwYF2EOPqMQyx3c7eZu--

--HWO9sRxYGWOFUd6fj06WDIJ0qEtyW3na2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlsZEBkACgkQykllyylKDCE7MACeImMbOq79j/TEnzygD9Si6xL4
SvEAnAos3N9wt7Vv9wZ2+dzTpTf+9aD8
=3/Gx
-----END PGP SIGNATURE-----

--HWO9sRxYGWOFUd6fj06WDIJ0qEtyW3na2--
