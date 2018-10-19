Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80877ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313DC21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb41G2bD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313DC21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJSNDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:03:48 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45557 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeJSNDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:03:48 -0400
Received: by mail-qt1-f170.google.com with SMTP id e10-v6so36993198qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 21:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XfKiwIcusmyybiuGqWHfRw2YW44uN5ht5bJxIJ2cGyw=;
        b=nb41G2bD7MFQIcGiFTR/1wM3MF8IvClde0ssDS/10JiQv0M43FWoHbiVPHSamkt8i/
         I+Cs8BSTphqvXTXkJhkIT+CsSE79JJmIC7Pov4nMnXLX16+db+2nL3By9SEfVDYpU4e6
         V+JNNbw9Zm3rspkhbqkKrhK8eJEypZw6RJ0lHvCFIQ9NHyzJkleITThYUkK9OkqmUahd
         gdmCOQvB8V20XofARGfOdR5urijjXr/TyImmMquBK/yTeAOmp2YuQCP3Zkic4XBKuNxP
         ChJRyh+Kx8/FSZ0yhukWs72lcpcggW08UfvT/Pnc2lsF3KZkoJrVFl/nH1zAqCUvcA2l
         XRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XfKiwIcusmyybiuGqWHfRw2YW44uN5ht5bJxIJ2cGyw=;
        b=mghNIOGFVX7LABw8dJLWZifBlLq3KrK7wDDzFuKHp9Z8TjqeKadmgxD4DXKJTK7mmb
         vn6RV/XMqkKapR68wVrQrRyflTHg3+qP3dxd3LTOMQ3viILhcdiw4Ob9seSsaP3OVQsn
         AfVHSKKXbL36NnZpu7CiHc+AgnBTxZPdXLrkfl/2MFKKdblT9yfLlWvtvTeE++AbTz+I
         kfhvyIh/PpFNZkG6q0/0kBAP7bUnHIsyVfqgYZX6JRuc2+9pUOZPivDBWfRCI/4/pDKv
         hlGkclKrwIIVvsUl+dsJH/BHDpEWPWNqtXxqwr/wEkUkUmIZcU1nL6urgm3vVDCb3whe
         aIWQ==
X-Gm-Message-State: ABuFfogfnzr/ur2lNe3hyUH3CPcEqpqkhR3eG5hv/T/6hWMco6kxU2GP
        GU6rOt6RvHFpa4jPcaxy+4xfazJv3MVw0e1FIp9aGs+/
X-Google-Smtp-Source: ACcGV63ttRGfcUZKmwzcmKXTv0A3sVjTjVZJbEe03UImf2Lj1jKIH62Ii9rnAl1A7yznJ2hpZ5bnMns7wJu0a5n9RNE=
X-Received: by 2002:ac8:1739:: with SMTP id w54-v6mr31372263qtj.76.1539925164109;
 Thu, 18 Oct 2018 21:59:24 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 19 Oct 2018 14:59:11 +1000
Message-ID: <CAPM=9txsa9pSu0QaL3rWfSViRBkY3GB2Hm8=_SDp_TTiwsP_pQ@mail.gmail.com>
Subject: [git pull] drm fixes for 4.19 final
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Just a last set of misc core fixes for final.

4 fixes, one use after free, one fb integration fix, one EDID fix, and
one laptop panel quirk,

Thanks,
Dave.

drm-fixes-2018-10-19:
drm: one set of misc fixes for final release
The following changes since commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e:

  Linux 4.19-rc8 (2018-10-15 07:20:24 +0200)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-10-19

for you to fetch changes up to f8e6e1b6f0ae3bb91cdcd08213d36a0ce6e98535:

  Merge tag 'drm-misc-fixes-2018-10-18' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2018-10-19
13:52:03 +1000)

----------------------------------------------------------------
drm: one set of misc fixes for final release

----------------------------------------------------------------
Clint Taylor (1):
      drm/edid: VSDB yCBCr420 Deep Color mode bit definitions

Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2018-10-18' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Eugeniy Paltsev (1):
      drm: fb-helper: Reject all pixel format changing requests

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for BOE panel in HP Pavilion 15-n233sl

Tomi Valkeinen (1):
      drm: fix use of freed memory in drm_mode_setcrtc

 drivers/gpu/drm/drm_crtc.c      | 10 +++--
 drivers/gpu/drm/drm_edid.c      |  5 ++-
 drivers/gpu/drm/drm_fb_helper.c | 91 ++++++++++++-----------------------------
 include/drm/drm_edid.h          |  6 +--
 4 files changed, 40 insertions(+), 72 deletions(-)
