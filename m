Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8ADC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D5121717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8jhxvaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D5121717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeHCHjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 03:39:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39657 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeHCHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 03:39:13 -0400
Received: by mail-qt0-f194.google.com with SMTP id q12-v6so4973419qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 22:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VArV8aFYMVpeL53ZcToIbgMBHqmMvtgBhYvsuoKK+Q8=;
        b=I8jhxvaYwFwQzIZuMBA38NnbLXMCGarTT8XGgoTyQTlioXzvzvF2hZC7TNDRmeWuRi
         DRlmYlEXyTPvLy767ZU0/Zx6jjWxCIirFARO5906wh020AkE8j1mTJ6+xprUUU63XDS4
         2/IMc+yfIMtnUSPhpJhXCWG2CHfm5ZaoUV5F7Wz+ZF+8S6dvvZO0SICaaKWreTRr1pdy
         Mvv7lPfSMm1TKuGBzAIS3vpxvVztoz7jmb9x6eSKey7XtmTLzIDM+bYws2eYAZ6xGa5A
         VjRpiOmiDJa9ws1nfDIEtwcB+zufnzHxrHMdQzPf5YyvTWgOibbeRRpcXRl8tXr87BAv
         ph0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VArV8aFYMVpeL53ZcToIbgMBHqmMvtgBhYvsuoKK+Q8=;
        b=T7SY7xo2yLKxchOgqnj56KD4AulN4OR59FrU1dkiU79LN97ppXghAUHq3/L0th5WXh
         fDGNsE8p6VG8mGBRUNCL3DnZ23CPOYTyAwRhQwF/qTvhV0aUMlqVb1atNCUFU1LrSUKu
         R9pxGg0tnmQ3nfWXTyx0G9LgFK6BxoCux5d38oX6VWtGSsbtD9ZfCKznRRSH6qrijnn1
         H486iQr4LRbesKJxVB9CR15nMSpgg0WqnBfAwwyCNoRvDJ2sdkr4394G83S3tJXkMSUw
         mqeyCY/7zoyGHhyzXaJwLlmLabc+cIJ6+R83Iju3h/DfvsQchmh52KeyUZK+LeAXpqP3
         poJw==
X-Gm-Message-State: AOUpUlGvWnSOD73nkJJOE0+0GeOckBClsQuJZD/hG6vWs4cYO6BkUcCE
        ddMRJYWUg839gAFNzBREL27A6mOKb/EtD61yFVQ=
X-Google-Smtp-Source: AAOMgpeyF+GV4tLkGHmiczRhqyQZt6mpfT8l0KvmQF4cEfgb1ITaZ685NeLcm10wL9e+H1shAnLGXGZlnA0XAAiyKtw=
X-Received: by 2002:a0c:afb8:: with SMTP id s53-v6mr2260324qvc.164.1533275075443;
 Thu, 02 Aug 2018 22:44:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3666:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 22:44:35 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 3 Aug 2018 15:44:35 +1000
Message-ID: <CAPM=9txGDwx1GWbcb=L8Bao1UEaRSdwtg9Kd43Fc70W0PcPy5w@mail.gmail.com>
Subject: [git pull] drm fixes for 4.18-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Nothing too major at this late stage,

adv7511: reset fix
vc4: scaling fix
two atomic core fixes
and one legacy core error handling fix.

I had a bunch of driver fixes from hdlcd but I think I'll leave them
for -next at this point.

Thanks,
Dave.

drm-fixes-2018-08-03:
adv7511 fix, atomic fix, core error path fix
The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-08-03

for you to fetch changes up to 51973dc079a9e1e082ae647ee3804f324a258eee:

  Merge tag 'drm-misc-fixes-2018-07-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2018-08-01
08:54:35 +1000)

----------------------------------------------------------------
adv7511 fix, atomic fix, core error path fix

----------------------------------------------------------------
Boris Brezillon (3):
      drm/atomic: Check old_plane_state->crtc in drm_atomic_helper_async_check()
      drm/atomic: Initialize variables in
drm_atomic_helper_async_check() to make gcc happy
      drm/vc4: Reset ->{x, y}_scaling[1] when dealing with uniplanar formats

Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2018-07-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Nicholas Mc Guire (1):
      drm: re-enable error handling

Sean Paul (1):
      drm/bridge: adv7511: Reset registers on hotplug

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 12 ++++++++++++
 drivers/gpu/drm/drm_atomic_helper.c          |  8 +++++---
 drivers/gpu/drm/drm_context.c                |  2 +-
 drivers/gpu/drm/vc4/vc4_plane.c              |  3 +++
 4 files changed, 21 insertions(+), 4 deletions(-)
