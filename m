Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C6BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7F92086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvIPeX5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7F92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJJL5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:57:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41462 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJJL5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:57:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so1960313pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qgArAnc+vmsRiTtfhKANyIcmqRSMV8gbvt8TZ3KImLk=;
        b=kvIPeX5eGBLxauF96zrsVGxawz9LEv2MWLS5wND7O5zKIQQp+DiXxEOX3UateyV9Y8
         p+S/l9tJ14yVgpw2RNXK9H6XK5mviZqVewGqO3jpJVX2Gkd4eRe8ODN8muuGlJFNsXH1
         IO0/CnzTBoHTlDdRB70WSaFsdyPQUUzK+DXvl17kSv6uAINxhNtmXpFR5Mh19OwCBbXU
         XGuuYiYSlHq9cz9/Ajq780472KYUBpb1TZXdY8obCNoGva9A+5w0zEtC9bR/1j9Fk8DL
         TxRXQYUIZhEtxmrWVSNi3hwutJbyu/idYz2krSUR+2Rmg9NiUjEvXLhE/KEIfytrlJZT
         78FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qgArAnc+vmsRiTtfhKANyIcmqRSMV8gbvt8TZ3KImLk=;
        b=A63AlHA06Sj+nw/t4gvSIJK4BeXmqdSwVxnhrkkfpXgBOGmbb9f3kgeWvF59uCjUd0
         oEeCo3ut7CHslwKq7WdmV5MfcBcaMD/yrtsmQzHWCxnOSrpVdKp5FTWCKtigcrNjku7Y
         P7It96uIJH2WQxR06bhFop9kJtyub16pNJOv5GBReaJuzU7i0jWgViZDH1vEYfteqViW
         bLEykV0yvHHu5pbGX0PqUAE5SQM3OoABVgMBL7dAGagjEwXTkQv0uX2FS8thFF8YvxYK
         +u00TWbzzTzTI/IZK1Zl7hu2Nzn0NoLIzgK+FZJ3sUxk4ZQh8ALEimHv5331L9fk3PUb
         BR1w==
X-Gm-Message-State: ABuFfojfLVaO4oUqx0zTOz4UM3dXPbY8JxSqXUFZMCgOMUY0HROkXCCp
        eooxr5kMKQRiKOud2+TFj1CZPUScZRc=
X-Google-Smtp-Source: ACcGV60wVPHicSZBxz4kqyK3uZzmexkUsHvMDICsY3EQ9v4PnhaQAGUz+wVmM42D5lQ9h5fLEPL8rQ==
X-Received: by 2002:a62:968a:: with SMTP id s10-v6mr32778628pfk.191.1539146254271;
        Tue, 09 Oct 2018 21:37:34 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id b14-v6sm25124740pgn.49.2018.10.09.21.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 21:37:32 -0700 (PDT)
Date:   Tue, 9 Oct 2018 21:37:30 -0700
From:   Benson Leung <bleung@google.com>
To:     bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, enric.balletbo@collabora.com
Subject: [GIT PULL] IB between mfd and platform/chrome for move of lpc driver
Message-ID: <20181010043730.GA145747@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Sorry for the super late reply to your email before. I wanted to make sure
this wasn't dropped so we could get this into v4.20.

Thanks,
Benson

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/tag-ib-chrome-platform-mfd-move-cros_ec_lpc

for you to fetch changes up to e2bbf91cad09118d7500f1fdaaa83d7741d30395:

  mfd: cros_ec: Fix and improve kerneldoc comments. (2018-09-07 15:56:37 +0=
800)

----------------------------------------------------------------
IB between mfd and chrome platform for move of lpc drivers

----------------------------------------------------------------
Enric Balletbo i Serra (2):
      platform/chrome: Move mfd/cros_ec_lpc* includes to drivers/platform.
      mfd: cros_ec: Fix and improve kerneldoc comments.

 drivers/mfd/cros_ec_dev.h                          |  13 +-
 drivers/platform/chrome/cros_ec_lpc.c              |   3 +-
 drivers/platform/chrome/cros_ec_lpc_mec.c          |   3 +-
 .../platform/chrome}/cros_ec_lpc_mec.h             |   6 +-
 drivers/platform/chrome/cros_ec_lpc_reg.c          |   3 +-
 .../platform/chrome}/cros_ec_lpc_reg.h             |   6 +-
 include/linux/mfd/cros_ec.h                        | 214 ++++++++-------
 include/linux/mfd/cros_ec_commands.h               | 295 +++++++++++++----=
----
 8 files changed, 322 insertions(+), 221 deletions(-)
 rename {include/linux/mfd =3D> drivers/platform/chrome}/cros_ec_lpc_mec.h =
(96%)
 rename {include/linux/mfd =3D> drivers/platform/chrome}/cros_ec_lpc_reg.h =
(94%)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlu9ggoACgkQHwn1ewov
5lgUtw/+NMLcnB6qwCUMoOPGvPLauF2aBi9QtjX9oQqWKbWfaOoZjMx+87HIjQe3
3f0YSPBVQB7HgNwWj92/1LLJC9yba/vfHB1tjrhDTumGk4XKB7mDk7Gb6IY6NMs9
l10+x110v6MhLRSFplhef0uXRliImvMUyFkU3EQetR2Sow6FnTn4u6pZ2c9/csOY
ZcHIJzwGEYgTatixSEE4c9Fo/JWSbDFat6JlW3qKA8QoQC32lZlXiAAoC488fUd/
3vh2p9kQbZHGJRWrLmXpifroadM5azNAZbV0dm7qBd5g6M7MzVahSexwbPXVCEcM
sUlGhAdrUmpTfWXnukI3cAptMhgbCtWObvTsuUhL57YPCwNgH76lb9uYsYKVvEBh
/EyBkyYSNS65wyEqMsn2Iflbi3JnB7h9p1fXEn9WaXBNXt5fYVeCbQJmTb/rWcG/
o/8rwV96EE/HUb1wmL/TxeN0d5kygz6VOOjZfvF397Lr5bCQz0522iuYMMKHwoJW
yuE3sHKseJp93fsu77VlwUsHv4kccWmMJN2m7u2S6GXqjLVIvJAzUrrW2RFye5bT
RBEhUcA+7tzE8gPjAJatWpihqITTdox0z+DZifOOXxo/HI9J5ZAAoUqj28AxhvhU
asZdcRqYKM+LqxzZobH972BsD8ERUnFcl2xa7xOuoAVW+bGSn7A=
=sPNJ
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
