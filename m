Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8462C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560E220854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM2pQMyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560E220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJEFqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:46:08 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:40049 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJEFqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:46:08 -0400
Received: by mail-qt1-f172.google.com with SMTP id b4-v6so3824881qtc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=XsbPcEyEJjcO4uITc8Dq3kksV84DDqEE7Up8Qjxbiu0=;
        b=PM2pQMyRsImTqI3Hmz6KlljMoJNC7Ym3wpv3kJElFkQ4yqIpGpAMUswWNu6+xa2Qya
         w1jHpHT/Ls71nf4HhIDhjc3EEjX+tVa4uygkQVEJIpLZGSboaMk4Hi3gZ8du+/zCZrO2
         0euH6BPeAwGjd11DAxaqCJXBoism/wKONRci6kUAa4+dtgzsF44WeP1WKke338AsJXj8
         Kd/8F0UMPfzddIaKMCieZUuJwTlHVtogt89IN8BOsVW3BdjviCmcsdm15TDCrIpL4bD8
         VOddEkNSwvIeSx/dh83E9NmUvshkXQIdVlP2w9l8TIjCOr5S+NwqV6m1VZd9I37amItt
         /W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=XsbPcEyEJjcO4uITc8Dq3kksV84DDqEE7Up8Qjxbiu0=;
        b=r80fm+P38zGub7Txgr6kMfHGa4kGahe+s2Y71APBcFcKCqtrPy6U83WKz3pnCRR8lN
         XgsydBTOcIklrgpjHhHFZJ44c9rIfE3jMXu4b5CxGehNCGKJqyjiIxcYaW/m8+lmfWZG
         1EHfGkSMrkG8Q8COWBRXO3hJ8WctZj7kfn+tqbgW5BmurSBcNnM5Y+oVPVyZddwI9Flx
         KX0sMNarihjqeLSoa0NWVApSkY+srfUsTXfMvvUrMJMelEyqx9YwkzhalNMoBFMTArA9
         UUtWSeNjyVwGJkldgK2cf3CE7Hn2y1+6jPIbgEnOL3pt8h2evz3JKzIvHjmKk/8Hty5k
         +TiA==
X-Gm-Message-State: ABuFfoixEZAyHB23R4wTsTRMpmzJz9eW4+4qcd0iU+SmfVNCNq2bCpN4
        IDY7hFplHfis3nDdvWOmSjOK3nPeQSHWMNX9TG8=
X-Google-Smtp-Source: ACcGV62iFbu6MTFInjlyEYAWbD/V0UsWB4g9w66VyGzK+t/1NeFf6Mbw89UVjRHBO/hPGHrYMqFGepDJzyScTHFygoE=
X-Received: by 2002:ac8:65cd:: with SMTP id t13-v6mr4018128qto.260.1538693430601;
 Thu, 04 Oct 2018 15:50:30 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 5 Oct 2018 08:50:19 +1000
Message-ID: <CAPM=9tyQkPpELE8C6Fcg7icLNO0b_vsWRMDJgyy_5NCveNuEjQ@mail.gmail.com>
Subject: [git pull] drm fixes for 4.19-rc7 (part 2)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Greg,

I was meant to take today off so sent the pull yesterday, but some
more stuff came in and I'd rather not sit on it,

Two fixes for amdgpu:
one corrects a use of process->mm
one fix for display code race condition that can result in a crash

Two core fixes:
One for a use-after-free in the leasing code
One for a cma/fbdev crash.

Thanks,
Dave.

drm-fixes-2018-10-05:
amdgpu and two core fixes
The following changes since commit d8938c981f58ee344687b7910a611ac345960045=
:

  Merge branch 'drm-tda9950-fixes' of
git://git.armlinux.org.uk/~rmk/linux-arm into drm-fixes (2018-10-04
10:32:14 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-10-05

for you to fetch changes up to bdf800c6fdf5674999bc0228d5040cc0ae218fa8:

  Merge branch 'drm-fixes-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2018-10-05
08:39:35 +1000)

----------------------------------------------------------------
amdgpu and two core fixes

----------------------------------------------------------------
Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2018-10-04' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Felix Kuehling (1):
      drm/amdkfd: Fix incorrect use of process->mm

Jann Horn (1):
      drm: fix use-after-free read in drm_mode_create_lease_ioctl()

Noralf Tr=C3=B8nnes (1):
      drm/cma-helper: Fix crash in fbdev error path

Shirish S (1):
      drm/amd/display: Signal hw_done() after waiting for flip_done()

 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 37 +++++++++++++++++-=
----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 10 ++++--
 drivers/gpu/drm/drm_client.c                       | 35 ++++++++++++++----=
--
 drivers/gpu/drm/drm_fb_cma_helper.c                |  4 ++-
 drivers/gpu/drm/drm_fb_helper.c                    |  4 ++-
 drivers/gpu/drm/drm_lease.c                        |  6 ++--
 include/drm/drm_client.h                           |  5 +--
 7 files changed, 75 insertions(+), 26 deletions(-)
