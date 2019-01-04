Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DA6C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD8720874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRErTYGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfADOxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:53:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46225 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfADOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:53:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so17586204pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 06:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ohmKh9TORqXTDujYuHISsK9wpAuh98a0GLz6TCJs+Xk=;
        b=WRErTYGp1gaDNckPWRc02/IKg8xeBwkhxoj0h3ui0TJU/X82ivrIuvgPFNSPBnzVCo
         9vaD3jPDsd4pzV4T9zV0Svn/gdx2FRTviEBm9OdkWzFKAuBl88COoCKevfDIzdcGKds5
         vUHOVoqwrQs/UbQ5GMwGzamAiEX3onlXx+OzWlERuesZxE//2soUcUkDk2SWAFyMnpTS
         cyLQ/jbaRs0Bi7bHxgSGF9kj6mpLU9IZrlstg0zNg5Pr7dBxfmQlpK77QGyMpnjOeVlp
         kM/ChmNWl6BylpDGyLHuFiSBySk57P1KAnPeR93HfJsbV+Wh7Joo2BWrNa3vfVzDfMd0
         6KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ohmKh9TORqXTDujYuHISsK9wpAuh98a0GLz6TCJs+Xk=;
        b=YwHNXwPQAS9Z4Cjn/smrCX/gQ6ADtxIQjIlXM+IpO2XSGJo+Tn5YnYY6K4d288ZiGK
         zdw9BuE5GD2Kf2ig2nCBw173dNOBECapOkJXTO95CGBvLqQxorQKMFgXP7g1iDk7g4kI
         rLFz+nn0f7cwbdrIN8qillNHITVZjtW6rxh2+apTgnpuxejsuWnQcCVNUxpNxygLs75w
         K37zkgaIU6GP1fxTqd8NRbfD3J1y6wx3/sL6mvjk3nhsaTqw3Yym+YlGNYLOuE81tZdS
         gXIFmfX96bdZp4TDazlkUj5n7CVcTB6xtFUZonYfC/u3WPeAnL4v7/X6Ob7JM6VHM3zJ
         M/EA==
X-Gm-Message-State: AJcUukckuDt1m7Rs1702uPFlhbp1gjkvJxuqKvgKzekTjjA1AsvZ5fa9
        /0ezUwPZ+bnYu2bGmnH4v9h4zg==
X-Google-Smtp-Source: AFSGD/XP1gJwtcXDztVSXO+VDcdYJslZtLeIQQQkqqwhrIcFOz3mvsYZA6ITi6g+9JmTrmayuwF+pQ==
X-Received: by 2002:a62:5003:: with SMTP id e3mr54154512pfb.23.1546613594216;
        Fri, 04 Jan 2019 06:53:14 -0800 (PST)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id h134sm117360503pfe.27.2019.01.04.06.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 06:53:12 -0800 (PST)
Date:   Fri, 4 Jan 2019 06:53:10 -0800
From:   Benson Leung <bleung@google.com>
To:     bleung@chromium.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com
Cc:     bleung@google.com
Subject: [GIT PULL] chrome-platform updates for v4.21
Message-ID: <20190104145310.GA83219@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Happy new year. Sorry for the late in the window pull request, but here are
the updates for chrome-platform.

Mainly a maintainership change, and a pair of patches from Brian to fixup
wakeup handling for one kind of EC event.


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/tag-chrome-platform-for-v4.21

for you to fetch changes up to cdd6a4a0e2ec590c30ad0e965fa08bf37461cadb:

  MAINTAINERS: add maintainers for ChromeOS EC sub-drivers (2019-01-03 12:2=
6:43 -0800)

----------------------------------------------------------------
chrome platform changes for v4.21

Changes for EC_MKBP_EVENT_SENSOR_FIFO handling.
Also, maintainership changes. Olofj out, Enric balletbo in.

----------------------------------------------------------------
Benson Leung (1):
      MAINTAINERS: platform/chrome: Add Enric as a maintainer

Brian Norris (2):
      platform/chrome: straighten out cros_ec_get_{next,host}_event() error=
 codes
      platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup

Enric Balletbo i Serra (1):
      MAINTAINERS: add maintainers for ChromeOS EC sub-drivers

Olof Johansson (1):
      MAINTAINERS: platform/chrome: remove myself as maintainer

 MAINTAINERS                             | 11 ++++++++++-
 drivers/platform/chrome/cros_ec_proto.c | 22 +++++++++++++++++-----
 include/linux/mfd/cros_ec.h             |  6 ++++--
 3 files changed, 31 insertions(+), 8 deletions(-)

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

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlwvc1YACgkQHwn1ewov
5li3FBAAovx7nw5nMVh/J+YzJ2V3MDn7ZEtUYKIZOIE7MLvUJPIrH4ArhrCIhdBS
9EDflTPlrkSxdpApLiD5fZZ6UPKpvmqRnRGqE8ACiejbV/0qAg7dx0EBTMUBAQXx
HxTRiti1YdMaDz5//78qT7N0CcQ1/cKFEvSZ8BXKLCBvHLzcwD9ZnOePxvek3qT8
Kgs2t1bznwMEyiW3zIqWhcZUmSdJpr7Xq1KMfr6UtOo3CkzzoaBZL1JXBBDuOVDk
hwgOSTjHi9Z4ayz+FPj7V/r1aX/Dd4wRClXuY7PbdJ9NZ4WXRcloiJAvTzrbyqZd
yVwyB3+JRRk/29vNnhB2t4EpyYMBcGXtEn+/wZPrLto4/dgbUEAyN/s0I8/PglVn
axvP4PMHnYPLLQBJLcM/4LawInlA1MRMyBw42onp6VmplfLpPGgkmuG1E8XUpOLH
r2BAC96xJF+ymjnIJEvNexdRC4hMIh665kCx3P0N5ub35ZhNJs7CZTHqJXB+I4F8
6Nvea2Tw0H8XDA96Z2EXY5+YOcH8zEIvP/Y2D6Dp0KvH2P27nsX+72HvcP8VvP6w
dJPzawwHJGNVzlJRA3/FxIODfv2Rj0ShBvtM2kI32XmKyEEMzf9pM49JhIC9u+TL
o9zmljzDFfaikAHLfvV0pVGQfVY5mimCtdmbocI/DaMbMwU3Zo4=
=8yRV
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
