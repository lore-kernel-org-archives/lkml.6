Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853E8208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853E8208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965273AbeFRPC6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:02:58 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:32994 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964900AbeFRPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:02:54 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w5IF2r0O016998
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:02:53 -0400
Received: from mail-qt0-f197.google.com (mail-qt0-f197.google.com [209.85.216.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w5IF2mW9007880
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:02:53 -0400
Received: by mail-qt0-f197.google.com with SMTP id a10-v6so14240493qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=gTngdsnTIWkpwQrxeB+eUkUpfINsJa5xPAcnZ/o1vzg=;
        b=du4lN+4/VVV3U3HeNvo2+2yXkVnVPnt/WwPZbf8InM2h4fgT8t3ypLyVIFLb2bQ7Qu
         TuuZO1hDbNfxekDnhpGkBXhzdX1WCrwxQnAZVhW86psxS5BGoQGdcUSDSA4MYvJf/AOW
         V3IB9QUaokAyK68Xla3P/tcyJsBqA/5NL9BUOWoutR/e5G0Gd2iEZtsBOPwQjQmIcCmP
         mAAnEZ04Clwy+Kz4nSzc4oP6C1gKBjPlfjl5z9tzyf6PVfcn7AT27HXdOVQHKlKqKyY5
         Q5qAxbu96CClZUfcthgvDgan1Rc+Oj3poJeh9A9p3bYgs9DTKMwgVJPtWEcULhKPIeOE
         1Nkg==
X-Gm-Message-State: APt69E0cb1k/yJ+JErNC4KdazTqopOUMenaZxPKVYiFV00L69AINSoTK
        Yuy9P/LPPQu9xEBziHfUHcOEndgD0cZSPO4r8nRF/8+wIaOPh20xr/gCnX585O1K52yTIdH80kw
        HAV5UKcN9Erf9vBAT6bIMk+eVdQ0DfYwYOu4=
X-Received: by 2002:a37:99c3:: with SMTP id b186-v6mr10453403qke.261.1529334168537;
        Mon, 18 Jun 2018 08:02:48 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKJKhGEdVzQGK3tcpVb/UsceUSefpHBBpl9+8T3W/bL+AB7ZJiwYTTu1jfEAPY/rkugcGKyhsg==
X-Received: by 2002:a37:99c3:: with SMTP id b186-v6mr10453384qke.261.1529334168281;
        Mon, 18 Jun 2018 08:02:48 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2607:b400:24:0:3d62:c4f9:2f6a:b486])
        by smtp.gmail.com with ESMTPSA id t6-v6sm9250085qtn.86.2018.06.18.08.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 08:02:46 -0700 (PDT)
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: 4.14.(44->48) IPv6 RA issue?
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1529334166_20151P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Jun 2018 11:02:46 -0400
Message-ID: <35958.1529334166@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1529334166_20151P
Content-Type: text/plain; charset=us-ascii

So I'm trying to troubleshoot an issue on an OpenWRT/Lede based
router, where IPv6 connectivity totally fails. I've bisected it down to:

git log --oneline 187da94808a634477b5e5a69109ea0c566dfa64b..73d8a6ab7668173d70adbed45b61be5256c505e
73d8a6ab7668 (refs/bisect/bad) base-files: fix UCI config parsing and callback handling
e52f3e9b1376 kernel: bump 4.14 to 4.14.48
7590c3c58f5e (HEAD) scripts: Replace obsolete POSIX tmpnam in slugimage.pl with File::Temp function
987900f2de76 hostapd: properly build hostapd-only SSL variants

and am pretty sure that it's the kernel bump (works with a 4.14.44 kernel,
breaks with 4.14.48) as the other 3 commits don't go anywhere near IPv6 handling.

Symptoms:
With a good kernel, 'ip -6 neigh' reports:

ip -6 neigh
2601:5c0:c001:4341:2116:22ff:b17b:7cd6 dev wlan1 lladdr bc:85:56:1f:4f:6d REACHABLE
fe80::201:5cff:fe6f:1a46 dev eth1 lladdr 00:01:5c:6f:1a:46 router REACHABLE
fe80::9325:3b21:5021:fbd8 dev eth0 lladdr b8:27:eb:f7:0b:20 REACHABLE
fe80::2d9:d1ff:fed9:51a3 dev eth0 lladdr 00:d9:d1:d9:51:a3 REACHABLE

With a bad one, I get:

ip -6 neigh
fe80::be85:56ff:fe1f:4f6d dev wlan1 lladdr bc:85:56:1f:4f:6d STALE
fe80::2d9:d1ff:fed9:51a3 dev eth0 lladdr 00:d9:d1:d9:51:a3 STALE
fe80::9325:3b21:5021:fbd8 dev eth0 lladdr b8:27:eb:f7:0b:20 DELAY
2601:5c0:c001:4341:2116:22ff:b17b:7cd6 dev wlan1 lladdr bc:85:56:1f:4f:6d REACHABLE
fe80::201:5cff:fe6f:1a46 dev eth1  INCOMPLETE

Note that eth1 is the uplink towards my ISP.  I've pointed a 'tcpdump -n -i eth1 ip6'
at it, and see plenty of RA packets come in, but neighbor discovery never completes.
Looking at the Changelogs for .45->.50 don't show any smoking-gun patches.

This ring any bells, before I delve deeper into it?

--==_Exmh_1529334166_20151P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWyfJlo0DS38y7CIcAQJqRAf+Iy4OXUxuBVdMttqWqg8n4FMRa7fxLASq
LYTDD/3tgv8K25J5JquZxQxbAymUGaka1y2GAgLGKaujllOU/Hu4rVFJ+b0DW443
tYC4D56XR7kE45tGG1qnqg9GaTxie2XrXdi5rFGaGXgkoKHTzOUN7FC4aoki1TIa
1vbee9iCatuuQQe1mjwRaZIytptek7pXbj5cBhAgzGLLqDkBfrzJC0EBLtUs8l/k
zKslRjFhIG3wVpDvk8gYxE+jpNkUdoDijrnflkFkmc5cs8ol74aLaNvCZfIhcoUm
Ik/BU7rOdy04XaGaX7QAf/aUhS5hFWJYuHrDxAu2cq5Ap6kfw7Taiw==
=fa0F
-----END PGP SIGNATURE-----

--==_Exmh_1529334166_20151P--
