Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F0FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3764920881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6qN2Mxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3764920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeGJBYt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:24:49 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46853 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeGJBYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:24:42 -0400
Received: by mail-qt0-f195.google.com with SMTP id d4-v6so1562446qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 18:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/kMeYmYKnyq4dH2OE1db7M+zC95vvQGZvkfYzHhTdW0=;
        b=b6qN2MxwOctKPhImxNIg9ayDDhfei6nDRUaNRCmLun2Oo5RHdk1AUjd4gJXKkQNKvX
         rtAMej0Yqfl93g0RwD9bMV+UNmk66i7WQvQTyqLuTUUZoHpPfh5mBt+w90kxmMm4HINC
         X7BRyBqy2WzbdbQnF8pBsOiXKxD3z6jG9Tg+mGgwr6Zgxb9aslAbLQ9Z5Y5PAAgHSf5x
         DTqq74idkrk07ESY1LqTHrIgsDskbER1Xg1EGymp9jvkOvqlfbVU+Ltl2/OUoOItG4zD
         YV3Fi5kfGi4tPvomt4NHomoCwzbru5gJdq2aIo7pApaR0Ifgsq17AJcKskBi1BnxTACJ
         vfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/kMeYmYKnyq4dH2OE1db7M+zC95vvQGZvkfYzHhTdW0=;
        b=uL0Xe5WVamoEjcj426SIKR62PEQcwKJmuAVl47XY//xkCyheTwTpMDqD0E5PGVFLgW
         5e67MjzQnNRu84rKH+nJSZhe2kvqxBfC/AbuDZ7s5HhjdPBvQ5wELQL+bZPdMCXPfK3W
         05/In9zjtzGXJfT6QvoKqJ0cDN113HlgWFyK5bE3/IaIrzi0pxu0lwTub3MjTrsTD7Hi
         97GyDbXa0YuJAuYiYGggwsx94rMb/vBHdvx2ik4W7cmZwW+KxPD5cy1cgDAZwHW+M1Fz
         uNao2TfnZSz7l8RGoGBfhcsU7DCwXozXs9W9QCXdREuuakyjg2Od5HrRVyX5ART1VY5m
         O07A==
X-Gm-Message-State: APt69E1O3aGZG9vqBAf2CdICShJ7IJyAzx9XUIIT2Bi2eaSuQvdeLk58
        FQT1s/jKXbF+yYb+lEuOSuyiSW5/3GQwwZ8FSjU=
X-Google-Smtp-Source: AAOMgpemdxZ7icTX4jdz1G5hDtZBkxuiTfxCd2/F53Y1sDfhzIxpm30LI3/q77YPMMegDK4Iwyve0vWolUjhypXdrPo=
X-Received: by 2002:ac8:38ac:: with SMTP id f41-v6mr21263319qtc.190.1531185881385;
 Mon, 09 Jul 2018 18:24:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3666:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 18:24:40 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 10 Jul 2018 11:24:40 +1000
Message-ID: <CAPM=9tyKzg4JFMqZgQ+fForTGz1C5FuTZ8cc0e=7wPGttEWKNQ@mail.gmail.com>
Subject: [git pull] drm fixes for 4.18-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

School holidays here, and I'm not sure if I'll be inclined to work
until next week, (I might and if so there might be another fixes), but
thought it best to just dequeue the bits I had now. Otherwise the rest
of the fixes for rc5 might arrive just before rc5 or just after.

This just contains some etnaviv fixes and a MAINTAINERS update for the
new drm tree locations.

Dave.

drm-fixes-2018-07-10:
etnaviv fixes and MAINTAINERS patch
The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:

  Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-07-10

for you to fetch changes up to dc81aab1be9fac2e11f31fe7538a50705eba08cf:

  MAINTAINERS: update drm tree (2018-07-10 10:59:58 +1000)

----------------------------------------------------------------
etnaviv fixes and MAINTAINERS patch

----------------------------------------------------------------
Daniel Vetter (1):
      MAINTAINERS: update drm tree

Dave Airlie (1):
      Merge branch 'etnaviv/fixes' of
https://git.pengutronix.de/git/lst/linux into drm-fixes

Fabio Estevam (2):
      drm/etnaviv: Check for platform_device_register_simple() failure
      drm/etnaviv: Fix driver unregistering

Lucas Stach (1):
      drm/etnaviv: bring back progress check in job timeout handler

 MAINTAINERS                             |  4 ++--
 drivers/gpu/drm/etnaviv/etnaviv_drv.c   | 24 ++++++++++++++++++++----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h   |  3 +++
 drivers/gpu/drm/etnaviv/etnaviv_sched.c | 24 ++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 6 deletions(-)
