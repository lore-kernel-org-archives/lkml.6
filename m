Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5286ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCEE20847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HFmzp5G2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCEE20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeKAIZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:25:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40211 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbeKAIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:25:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id b9-v6so8001513pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QsgtK2KcAu1SqI8hvYQHpMgsIrF5s7BBx7vuD3U3i7Y=;
        b=HFmzp5G25u92One6Rs7yVN7mG0Hoz72Xxp9N+9gOxX8DRYxZWkNfDmD0UcqPmMwUre
         zuKH2tVR1dmKc1DLOaoXLsULWeRbOb3izRuR5dJE+hvMLhgko5J65JYbsytEDt6cxLW2
         h64TaTYHov1fy3VdDWF7gfunx3yDpeO+kfpJAwTDti8SfPN5N8G8r0WshvkfvIP8OI0f
         AUIbzRPf7ODlcvo7tgBV1tchpgSutnjMRM1H+ai5m9EClMJkh5jbYRxvvdmhe/2G2Uh9
         h40GFRV1Q/wbC3NL4T0nqZfhmiisZ+SynnLC96G9P9tx/lEqfb2B/Krca60cbQ4KvQuN
         qlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QsgtK2KcAu1SqI8hvYQHpMgsIrF5s7BBx7vuD3U3i7Y=;
        b=Ob/s7yrs6A9p7xLDc01B2kT4q+UCwznCaTjUpua1p78MKzubAkTip97HVbC9T7iN98
         WY7wShM5xAzxPvMGtVINkuJDE6o9WzxuYNcoFytYxYqVVJu6B9dMTTK/5PCmWTYiiq2j
         BeJMpTHrX2HtNEdvaIRStLdZFFF4zXCl08pyovtuX9QEtFP+wNu/mQYRGmyhQaqo6yAX
         ls8BSV2E74aLj3RAjY5USAP4355JddgP4BRucX1R8D7GL/cgginC/D6m283/RdNFRa8Q
         Ard9OqF4jfGgufvFmTF5bfTp7McjY5FdRjwES7A5eWjgqNILmLCTfoQtbsL/cLi56/Ur
         xHaA==
X-Gm-Message-State: AGRZ1gJaCpqI8ruhUdIVii3kS76pR0AndTrtCAJYhCG5WYG+W6FmX+Id
        u2qcFIBohqgJ8luzDeGAWaTCeQ==
X-Google-Smtp-Source: AJdET5cHLjGuYUCd3Ly+kUOflpMLNEF53qsFJGsZNhNtgVG9/+y3GrzwrdyCD/PjYmvyq5SHKxyZdQ==
X-Received: by 2002:a17:902:45a5:: with SMTP id n34-v6mr5357458pld.341.1541028334967;
        Wed, 31 Oct 2018 16:25:34 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id m7-v6sm34458798pgq.59.2018.10.31.16.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 16:25:33 -0700 (PDT)
Date:   Wed, 31 Oct 2018 16:25:31 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        bleung@chromium.org, gregkh@linuxfoundation.org
Cc:     bleung@google.com, bleung@chromium.org
Subject: [GIT PULL] chrome-platform updates for v4.20
Message-ID: <20181031232531.GA195672@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please take a look at changes for chrome-platform for v4.20.

Note that there is another move from lee's to mine that we did as an IB.

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/tag-chrome-platform-for-v4.20

for you to fetch changes up to bc3f4b5c60db2a835e68bfdce23b6ae75df7e295:

  platform/chrome: chromeos_tbmc - Remove unneeded const (2018-10-09 22:40:=
12 -0700)

----------------------------------------------------------------
chrome-platform for v4.20

* Move mfd/cros_ec_lpc* includes to drivers/platform from mfd
* Adding a new interrupt path for cros_ec_lpc

----------------------------------------------------------------
Benson Leung (1):
      Merge remote-tracking branch 'origin/ib-chrome-platform-mfd-move-cros=
_ec_lpc' into working-branch-for-4.20

Emil Karlson (1):
      mfd: cros-ec: copy the whole event in get_next_event_xfer

Enric Balletbo i Serra (2):
      platform/chrome: Move mfd/cros_ec_lpc* includes to drivers/platform.
      mfd: cros_ec: Fix and improve kerneldoc comments.

Enrico Granata (1):
      platform/chrome: Add a new interrupt path for cros_ec_lpc

Nathan Chancellor (1):
      platform/chrome: chromeos_tbmc - Remove unneeded const

 drivers/mfd/cros_ec_dev.h                          |  13 +-
 drivers/platform/chrome/chromeos_tbmc.c            |   2 +-
 drivers/platform/chrome/cros_ec_lpc.c              |  18 +-
 drivers/platform/chrome/cros_ec_lpc_mec.c          |   3 +-
 .../platform/chrome}/cros_ec_lpc_mec.h             |   6 +-
 drivers/platform/chrome/cros_ec_lpc_reg.c          |   3 +-
 .../platform/chrome}/cros_ec_lpc_reg.h             |   6 +-
 drivers/platform/chrome/cros_ec_proto.c            |   2 +-
 include/linux/mfd/cros_ec.h                        | 214 ++++++++-------
 include/linux/mfd/cros_ec_commands.h               | 295 +++++++++++++----=
----
 10 files changed, 338 insertions(+), 224 deletions(-)
 rename {include/linux/mfd =3D> drivers/platform/chrome}/cros_ec_lpc_mec.h =
(96%)
 rename {include/linux/mfd =3D> drivers/platform/chrome}/cros_ec_lpc_reg.h =
(94%)


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

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlvaOesACgkQHwn1ewov
5lgA/xAAub+0N+UgZ+AIg074OHxbyK6YEIIThhlFeotQ/5JKSLUOrsLQZhjdh3cD
jlxcVnSbuot7sQizZ3mhrI+AtFI5PWikiO/Ns14hAC1yL7UG7jgAfuc6D177GpwA
R5C9Fs+CWTIi+C6Gm6sMrb6on/rLCXcCwzHT+83hK6O4n8di4PR5eDWfQzS0O/7h
Is5VOehKJfY+8bT7Zu/+uL6V0dfNmLNKPImGZE2N+/27+uVJUHR36qWT03oLG2ZL
obHgMPAo9Y4QN7f7bi/GXOyMo4ozNAyjpa4hDrDT2StW+ep7ZYR/vJWl9fU+Qa5e
g9SEf7qcNCdZZ9XjUlSkod9Cvu5c5Ub81YJlw12carPyObLYw4jCdeAYcOvePWtu
+8OA8kbJlLvD9x5b2j8sf0lzrMgVYzdos5vDByjOrAYNhB+pifVyEUSSMgYe1qGB
qfdYw0iNNe1o+cKUF1vYYZ+FJvxLTr/aZcOmEhkV0Yf72dpw8EL9UegLMaO6duQt
q07Xvqo8BP2mrSN5gC8GLNI8N7cJXvTv9w8MrdGH+gf+59jUQGi8qirSvRg+UGTE
sguXJWHAXwERV6/I4JB9WdgrWXiFqS9D2EZRF1De3P5cbQQ2o+Q5ad6gf1AfBkNO
5/N+43xntx01cAWD2/kvS248lhuaHWikCXz0Q3aqvUQ6e+4Y7/M=
=c4PY
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
