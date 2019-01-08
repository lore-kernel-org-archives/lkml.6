Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02C2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kR85Gsa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfAHHY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:24:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44883 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHHY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:24:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so2494763lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 23:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hgDGhfvXFmRibkMt/6N6NWlkENugEthtdl6iWMh04F0=;
        b=kR85Gsa0QOn+Ah/jCKzcPH3V51vtB6YDoNHiqp/ASaWBtKGAJw3vZotCZ0tMm23YFe
         OZbxgaVbIEPDDS9EPTUrjidqioCvcPI9jH0KCVWY4kCXPR/zOu5oAoF4i+mPHvWiAb0W
         2BtGncwqDCknfTrMfGqSVnm9l7By7Uh3/Lm0/pTXudTi24waWuQ5k9tsO90HhFkVdlCX
         GQ5Ae7FfNpVu9NBvuZ/oGUoUzM5Any4CmI9/iNndPB9qfg0OsQOJmqijcSp0d5oQ/mph
         wZTi2tdpASB4CxlNfySKRKcXS4Tb6Za4XpYaMqCOug106tnnjUpAn2PByYffJSwDpY7v
         AGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hgDGhfvXFmRibkMt/6N6NWlkENugEthtdl6iWMh04F0=;
        b=GXaeJJwzCgN3ofUC5gw8+fF3YaOBCht0PIQqq9/IMwDbzAGc8+76q3F35jo3QYGIJ/
         lnB48bV08qeLFi011ISJiKTwTbSsUsMuTvbiDJ/kv8cO1V10GEVoBs6D/Okr2E8AcGV9
         KZJkXYbgzHDNtvnS9nyvG+FoSKqjVRsRtHcp4A8URhUMsNh+PL2a7nNwEI44kvzaXQw/
         dExxvT3ZOGppMAkcY7dFAN/DpK87OaDsyzGD94hIkjRoOxjpK+JujywcTUTyThlrIgkD
         M8hsAzRJiMIiGLKTwri8ssRfuwbMn5m1x+o4T0hY8jsXtz8z6YSuldJLTTQcTx6lCIXB
         XUZw==
X-Gm-Message-State: AJcUukdIm2Sb0v/YZb/t2+8Ug6ZI4CjMFKqRBSN/r0lpOcQbzCKgXNRH
        f2rqaFgibOfcQBnxrxdY5z4=
X-Google-Smtp-Source: ALg8bN7xa8WSrec5u4RfZ5hWFdh87n/1gTvkPEEAFpifymHNFBfJgdJ9WueEBx4M86jKdWq5Xx18GA==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr389811ljj.108.1546932266964;
        Mon, 07 Jan 2019 23:24:26 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id t144sm12858447lff.53.2019.01.07.23.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 23:24:26 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Ivan Mironov <mironov.ivan@gmail.com>
Subject: [PATCH v2 0/2] Fix SDL 1.2 on emulated fbdev devices (broken in kernels >=4.19)
Date:   Tue,  8 Jan 2019 12:23:51 +0500
Message-Id: <20190108072353.28078-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Originally this issue was brought up on linux.org.ru forum by user
saahriktu, he is on Cc. He discovered that commit db05c48197759
("drm: fb-helper: Reject all pixel format changing requests") breaks
support of SDL1 programs, like various old games and emulators of old
game consoles. First patch contains fix for that commit.

I tried to reproduce the same issue in a VM under qemu, and found yet
another part of kernel code which prevents SDL1 apps from running
normally. Second patch in this series fixes this problem.

Also, it seems that at least in some cases both problems could be
circumvented by adding appropriate modes into /etc/fb.modes. But without
examining the kernel code it is not clear which values are correct. I am
not sure that such circumvention covers all possible cases, and it is
definitely far from any user-friendliness.

First patch in this series fixes a clear regression. Second patch is
optional, please read commit message carefully before applying it.

Changes in v2:
- Added "Cc: stable" to the second patch.
- Proposed by Daniel Vetter: always use current depth (fb->format->depth)
  in a case of zero pixel format values and do not perform any guessing.

Changes in v1:
- Added "Cc: stable" to the patch which fixes known regression.
- Added more information and detailed reproduction steps in commit
  messages.

Changes in v0:
- RFC patch series introduced.

Ivan Mironov (2):
  drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2
  drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

 drivers/gpu/drm/drm_fb_helper.c | 149 ++++++++++++++++++++------------
 1 file changed, 95 insertions(+), 54 deletions(-)

-- 
2.20.1

